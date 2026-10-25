# workation-mobile

워케이션(가제) 모바일 앱 (Flutter).
LG U+ 유동/서비스인구 데이터를 기반으로 워케이션 지역·시기·동네를 추천하는 서비스의 모바일 클라이언트입니다.

## 관련 레포

- 백엔드: [workation-backend](https://github.com/TEAM-SKPJC/workation-backend)
- 웹: [workation-web](https://github.com/TEAM-SKPJC/workation-web) (React + Tailwind)

## 스택

| 항목 | 선택 |
| --- | --- |
| Flutter / Dart | 3.47 / 3.13 (stable) |
| 플랫폼 | Android, iOS |
| 패키지 ID | `com.skpjc.workation_mobile` |
| 디자인 | Material 3 (`useMaterial3: true`) |
| 린트 | flutter_lints |

인증·DB는 백엔드(workation-backend)가 담당합니다. 앱은 `API_BASE_URL` 로 백엔드 API만 호출합니다.

## 시작하기

```bash
flutter pub get
flutter run --dart-define=API_BASE_URL=http://localhost:8000
```

| 명령 | 설명 |
| --- | --- |
| `flutter analyze` | 정적 분석 |
| `flutter test` | 위젯 테스트 |

## 폴더 구조

```
lib/
  main.dart            진입점
  app/app.dart         MaterialApp, 테마·라우팅 연결
  core/
    theme/             AppColors, AppTheme (디자인 토큰 → ThemeData)
    network/           ApiConfig (--dart-define 으로 주입)
  features/<화면>/     화면 단위 (명세서 M-01~M-05 와 1:1), 예: features/home/
  shared/widgets/      공용 위젯
assets/
  images/, fonts/
```

## 디자인

- Material 패턴(AppBar, BottomNavigationBar)
- 디자인 토큰은 `lib/core/theme/app_theme.dart` 에 정의하며, `docs/디자인-원칙.md` 와 Figma Foundations 기준으로 교체 예정
