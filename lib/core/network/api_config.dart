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

  /// Supabase 프로젝트 주소. 로그인(Supabase Auth)에만 씁니다. 예: `https://<ref>.supabase.co`
  static const supabaseUrl = String.fromEnvironment('SUPABASE_URL');

  /// Supabase anon(publishable) 키. 공개 키라 앱에 들어가도 되지만, 값은 커밋하지 않고
  /// `--dart-define-from-file=env.json` 으로 넣습니다. service_role 키는 절대 넣지 않습니다.
  static const supabaseKey = String.fromEnvironment('SUPABASE_ANON_KEY');

  /// 실제 로그인을 쓸 수 있는지. mock 모드이거나 Supabase 값이 없으면 false 입니다.
  static const authEnabled = !useMock && supabaseUrl != '' && supabaseKey != '';

  /// OAuth 를 마치고 앱으로 돌아오는 딥링크. iOS Info.plist · Android 매니페스트의 스킴과,
  /// Supabase 대시보드 Authentication → URL Configuration 의 Redirect URLs 에 같은 값이 있어야 합니다.
  static const authRedirectUrl = 'com.skpjc.workationmobile://login-callback';

  /// Google Maps 키(Maps SDK for Android · iOS). 앱은 비어 있는지만 보고, 실제 키는
  /// Android `build.gradle.kts` · iOS `AppDelegate` 가 같은 dart-define 에서 읽어 SDK 에 넘깁니다.
  static const mapsApiKey = String.fromEnvironment('GOOGLE_MAPS_API_KEY');

  /// Google Maps 타일을 쓸지. 키가 없으면(테스트 포함) 경계를 직접 그린 지도로 대신합니다.
  static const mapsEnabled = mapsApiKey != '';

  static const connectTimeout = Duration(seconds: 10);

  /// 자연어 검색(LLM)은 응답에 수 초가 걸려 여유를 둡니다.
  static const receiveTimeout = Duration(seconds: 30);
}
