import 'dart:convert';
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

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) {
    lastRequest = options;
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

  test('200 응답이면 디코딩된 JSON 을 돌려주고 공통 헤더를 붙인다', () async {
    setUpWith((_) async => _json(200, {'items': []}));

    final data = await client.get('/api/regions/popular', query: {'month': 10});

    expect(data, {'items': []});
    expect(adapter.lastRequest!.path, '/api/regions/popular');
    expect(adapter.lastRequest!.queryParameters, {'month': 10});
    expect(
      adapter.lastRequest!.headers['X-Requested-With'],
      'workation-mobile',
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
