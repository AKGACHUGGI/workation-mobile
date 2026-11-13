/// 백엔드(workation-backend) 연결 설정. 값은 실행 시 --dart-define 으로 주입합니다.
///
/// flutter run --dart-define=API_BASE_URL=http://localhost:8000 --dart-define=USE_MOCK=false
abstract final class ApiConfig {
  /// 호스트까지만 둡니다. 경로는 웹과 같이 호출부에서 `/api/...` 로 붙입니다.
  static const baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:8000',
  );

  /// true 면 리포지토리가 실제 API 대신 `assets/mock/` 데이터를 씁니다.
  /// 백엔드 엔드포인트가 열리기 전까지 기본값은 true 입니다.
  static const useMock = bool.fromEnvironment('USE_MOCK', defaultValue: true);

  static const connectTimeout = Duration(seconds: 10);

  /// 자연어 검색(LLM)은 응답에 수 초가 걸려 여유를 둡니다.
  static const receiveTimeout = Duration(seconds: 30);
}
