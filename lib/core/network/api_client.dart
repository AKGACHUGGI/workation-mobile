import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show Supabase;

import 'api_config.dart';
import 'api_exception.dart';

/// 백엔드 호출 창구. 리포지토리는 Dio 를 직접 쓰지 않고 이 클래스를 씁니다.
///
/// - 경로는 웹과 같이 `/api/...` 로 시작합니다. 예: `get('/api/regions/popular')`
/// - 실패는 모두 [ApiException] 으로 바뀌어 던져집니다.
/// - 응답 본문은 디코딩된 JSON(Map · List) 그대로 돌려주고, 모델 변환은 리포지토리가 합니다.
class ApiClient {
  ApiClient(this._dio);

  final Dio _dio;

  Future<dynamic> get(String path, {Map<String, Object?>? query}) =>
      _send(path, () => _dio.get<dynamic>(path, queryParameters: query));

  Future<dynamic> post(String path, {Object? body}) =>
      _send(path, () => _dio.post<dynamic>(path, data: body));

  Future<dynamic> put(String path, {Object? body}) =>
      _send(path, () => _dio.put<dynamic>(path, data: body));

  Future<dynamic> patch(String path, {Object? body}) =>
      _send(path, () => _dio.patch<dynamic>(path, data: body));

  Future<dynamic> delete(String path) =>
      _send(path, () => _dio.delete<dynamic>(path));

  Future<dynamic> _send(
    String path,
    Future<Response<dynamic>> Function() request,
  ) async {
    try {
      final response = await request();
      return response.data;
    } on DioException catch (e) {
      throw ApiException.fromDio(e, path);
    }
  }
}

/// 지금 로그인 세션의 access token(Supabase JWT). 로그인하지 않았으면 null.
/// supabase_flutter 가 만료 전에 알아서 갱신하므로 요청마다 새로 읽습니다.
final accessTokenProvider = Provider<String? Function()>(
  (ref) => ApiConfig.authEnabled
      ? () => Supabase.instance.client.auth.currentSession?.accessToken
      : () => null,
);

/// 앱 전체에서 하나만 쓰는 Dio. 테스트에서는 override 합니다.
///
/// 세션이 있으면 모든 요청에 `Authorization: Bearer <token>` 을 붙입니다(웹 `api()` 와 같음).
final dioProvider = Provider<Dio>((ref) {
  final token = ref.watch(accessTokenProvider);
  final dio =
      Dio(
          BaseOptions(
            baseUrl: ApiConfig.baseUrl,
            connectTimeout: ApiConfig.connectTimeout,
            receiveTimeout: ApiConfig.receiveTimeout,
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ),
        )
        ..interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) {
              final t = token();
              if (t != null) options.headers['Authorization'] = 'Bearer $t';
              handler.next(options);
            },
          ),
        );
  ref.onDispose(dio.close);
  return dio;
});

final apiClientProvider = Provider<ApiClient>(
  (ref) => ApiClient(ref.watch(dioProvider)),
);
