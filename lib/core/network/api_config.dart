/// 백엔드(workation-backend) 주소. 실행 시 --dart-define 으로 주입합니다.
///
/// flutter run --dart-define=API_BASE_URL=http://localhost:8000
abstract final class ApiConfig {
  static const baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:8000',
  );
}
