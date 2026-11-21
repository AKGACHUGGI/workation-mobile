import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workation_mobile/core/network/api_client.dart';
import 'package:workation_mobile/core/network/api_exception.dart';

/// 네트워크 없이 정해진 응답을 돌려주는 어댑터.
class _FakeAdapter implements HttpClientAdapter {
  _FakeAdapter(this.respond);

  final Future<ResponseBody> Function(RequestOptions options) respond;
  RequestOptions? lastRequest;

  /// 마지막 요청의 본문(바이트 그대로)
  List<int> lastBody = const [];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    lastRequest = options;
    lastBody = [
      if (requestStream != null)
        await for (final chunk in requestStream) ...chunk,
    ];
    return respond(options);
  }

  @override
  void close({bool force = false}) {}
}

ResponseBody _json(int status, Object body) => ResponseBody.fromString(
  jsonEncode(body),
  status,
  headers: {
    Headers.contentTypeHeader: [Headers.jsonContentType],
  },
);

void main() {
  late _FakeAdapter adapter;
  late ProviderContainer container;
  late ApiClient client;

  void setUpWith(Future<ResponseBody> Function(RequestOptions) respond) {
    adapter = _FakeAdapter(respond);
    container = ProviderContainer();
    container.read(dioProvider).httpClientAdapter = adapter;
    client = container.read(apiClientProvider);
  }

  tearDown(() => container.dispose());

  test('200 응답이면 디코딩된 JSON 을 돌려준다', () async {
    setUpWith((_) async => _json(200, {'items': []}));

    final data = await client.get('/api/regions/popular', query: {'month': 10});

    expect(data, {'items': []});
    expect(adapter.lastRequest!.path, '/api/regions/popular');
    expect(adapter.lastRequest!.queryParameters, {'month': 10});
    // 로그인하지 않았으면 토큰을 붙이지 않는다. CSRF 헤더는 웹처럼 뺐다(Bearer 방식).
    expect(adapter.lastRequest!.headers['Authorization'], isNull);
    expect(adapter.lastRequest!.headers['X-Requested-With'], isNull);
  });

  test('로그인 세션이 있으면 요청마다 그때의 토큰을 Bearer 로 붙인다', () async {
    var token = 'jwt-1';
    adapter = _FakeAdapter((_) async => _json(200, {}));
    container = ProviderContainer(
      overrides: [accessTokenProvider.overrideWithValue(() => token)],
    );
    container.read(dioProvider).httpClientAdapter = adapter;
    client = container.read(apiClientProvider);

    await client.get('/api/me');
    expect(adapter.lastRequest!.headers['Authorization'], 'Bearer jwt-1');

    token = 'jwt-2'; // supabase 가 갱신한 토큰
    await client.get('/api/me');
    expect(adapter.lastRequest!.headers['Authorization'], 'Bearer jwt-2');
  });

  test('postMultipart 는 글자 칸과 파일을 multipart 로 보낸다(파일은 같은 이름으로 여러 장)', () async {
    final dir = Directory.systemTemp.createTempSync('upload_test');
    addTearDown(() => dir.deleteSync(recursive: true));
    final a = File('${dir.path}/a.jpg')..writeAsBytesSync([1, 2, 3]);
    final b = File('${dir.path}/b.png')..writeAsBytesSync([4, 5]);
    setUpWith((_) async => _json(201, {'id': '9'}));

    final data = await client.postMultipart(
      '/api/regions/51820/notes',
      fields: {'body': '본문', 'visitMonth': '2025-10'},
      fileField: 'photos',
      files: [
        (path: a.path, filename: 'a.jpg'),
        (path: b.path, filename: 'b.png'),
      ],
    );

    expect(data, {'id': '9'});
    final request = adapter.lastRequest!;
    expect(request.method, 'POST');
    expect(request.path, '/api/regions/51820/notes');
    // 기본 JSON 대신 multipart 로 나간다.
    expect(
      request.headers[Headers.contentTypeHeader],
      startsWith('multipart/form-data; boundary='),
    );
    final body = utf8.decode(adapter.lastBody, allowMalformed: true);
    expect(body, contains('name="body"'));
    expect(body, contains('본문'));
    expect(body, contains('name="visitMonth"'));
    expect(body, contains('2025-10'));
    expect('name="photos"; filename='.allMatches(body), hasLength(2));
    expect(body, contains('name="photos"; filename="a.jpg"'));
    expect(body, contains('name="photos"; filename="b.png"'));
  });

  test('서버 에러 본문의 code · message 를 ServerException 에 담는다', () async {
    setUpWith(
      (_) async => _json(400, {
        'error': {'code': 'INVALID_PHOTO', 'message': '2번째 사진이 10MB 를 넘어요.'},
      }),
    );
    await expectLater(
      client.post('/api/regions/51820/photos'),
      throwsA(
        isA<ServerException>()
            .having((e) => e.statusCode, 'statusCode', 400)
            .having((e) => e.code, 'code', 'INVALID_PHOTO')
            .having((e) => e.message, 'message', '2번째 사진이 10MB 를 넘어요.'),
      ),
    );

    // 본문이 그 모양이 아니면 비워 둔다.
    setUpWith((_) async => _json(500, ['엉뚱한 본문']));
    await expectLater(
      client.get('/api/me'),
      throwsA(
        isA<ServerException>()
            .having((e) => e.code, 'code', isNull)
            .having((e) => e.message, 'message', isNull),
      ),
    );
  });

  test('401 은 UnauthorizedException', () async {
    setUpWith((_) async => _json(401, {}));
    await expectLater(
      client.get('/api/me'),
      throwsA(
        isA<UnauthorizedException>().having((e) => e.path, 'path', '/api/me'),
      ),
    );
  });

  test('404 는 NotFoundException', () async {
    setUpWith((_) async => _json(404, {}));
    await expectLater(
      client.get('/api/regions/0'),
      throwsA(isA<NotFoundException>()),
    );
  });

  test('그 밖의 오류 상태는 상태 코드를 담은 ServerException', () async {
    setUpWith((_) async => _json(500, {}));
    await expectLater(
      client.post('/api/search/parse', body: {'q': '조용한 바다'}),
      throwsA(
        isA<ServerException>().having((e) => e.statusCode, 'statusCode', 500),
      ),
    );
  });

  test('연결 실패는 NetworkException', () async {
    setUpWith(
      (options) async => throw DioException.connectionError(
        requestOptions: options,
        reason: 'offline',
      ),
    );
    await expectLater(
      client.get('/api/regions/popular'),
      throwsA(isA<NetworkException>()),
    );
  });
}
