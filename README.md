# workation-mobile

[![CI](https://github.com/TEAM-SKPJC/workation-mobile/actions/workflows/ci.yml/badge.svg)](https://github.com/TEAM-SKPJC/workation-mobile/actions/workflows/ci.yml)

워케이션(가제) 모바일 앱. LG U+ 유동/서비스인구 데이터를 기반으로 워케이션 지역·시기·동네를 추천하는 서비스입니다.

- 백엔드: [workation-backend](https://github.com/TEAM-SKPJC/workation-backend)
- 웹: [workation-web](https://github.com/TEAM-SKPJC/workation-web) (React + Tailwind)
- 팀 문서: [workation-docs](https://github.com/TEAM-SKPJC/workation-docs) (명세서 · 디자인 원칙 · [협업 규칙](https://github.com/TEAM-SKPJC/workation-docs/blob/main/협업/협업-규칙.md))
- 디자인: [Figma 기업연계캡스톤](https://www.figma.com/design/QulBXJPP2qYhRhh8lGzT66)
- 개발 가이드: [docs/개발-가이드.md](docs/개발-가이드.md)

## 스택

| 영역 | 선택 | 버전 |
| --- | --- | --- |
| 프레임워크 | Flutter (stable) | 3.47 |
| 언어 | Dart | 3.13 (`sdk: ^3.13.3`) |
| 플랫폼 | Android / iOS | minSdk 24 (Android 7.0) / iOS 15.0 |
| 디자인 | Material 3 | `useMaterial3: true` |
| 린트 | flutter_lints | 6.x |
| 아이콘 | Material Icons, cupertino_icons | 1.0.8 |

| 식별자 | 값 |
| --- | --- |
| Dart 패키지명 | `workation_mobile` |
| Android applicationId | `com.skpjc.workation_mobile` |
| iOS Bundle ID | `com.skpjc.workationMobile` |

인증·DB는 백엔드가 담당합니다. 앱은 `API_BASE_URL` 로 백엔드 API만 호출하며 외부 SaaS SDK를 직접 들고 있지 않습니다.

## 빠른 시작

```bash
flutter pub get
flutter run --dart-define=API_BASE_URL=http://localhost:8000
```

Android 에뮬레이터에서 호스트 PC 의 로컬 서버에 붙을 때는 `http://10.0.2.2:8000` 을 씁니다.

## 명령

| 명령 | 설명 |
| --- | --- |
| `flutter run` | 디바이스/에뮬레이터에서 실행 (`r` 핫 리로드, `R` 핫 리스타트) |
| `flutter analyze` | 정적 분석 (lint) |
| `flutter test` | 위젯·단위 테스트 |
| `dart format .` | 포맷 |
| `flutter build apk --release` | Android 릴리즈 빌드 |
| `flutter build ipa --release` | iOS 릴리즈 빌드 (macOS + Xcode 필요) |

## 폴더 구조

```
lib/
  main.dart                  진입점 (runApp)
  app/app.dart               MaterialApp, 테마·초기 화면 연결
  core/
    theme/app_theme.dart     AppColors, AppTheme (디자인 토큰 → ThemeData)
    network/api_config.dart  ApiConfig (API_BASE_URL, --dart-define 주입)
  features/<화면>/           화면 단위 (명세서 M-01~M-05 와 1:1)
    home/home_screen.dart    M-01
  shared/widgets/            두 화면 이상에서 쓰는 공용 위젯
test/                        위젯 테스트
assets/
  images/                    pubspec 에 등록됨
  fonts/                     폰트 추가 시 pubspec fonts 섹션에 등록
docs/                        프로젝트 문서
```

## 환경 변수

Flutter 는 `.env` 파일 대신 컴파일 타임 상수(`--dart-define`)를 씁니다.

| 키 | 설명 | 기본값 |
| --- | --- | --- |
| `API_BASE_URL` | workation-backend 주소 | `http://localhost:8000` |

코드에서는 `ApiConfig.baseUrl` 로 읽습니다. 새 키를 추가하면 `lib/core/network/api_config.dart` 와 이 표를 함께 갱신합니다.

## 디자인

- 디자인 토큰은 Figma 01 Foundations 의 Tokens 컬렉션(Light)과 1:1 로 `lib/core/theme/` 에 있습니다.
  - `app_colors.dart` — `AppPalette`(원시 색), `AppSemantic`(의미 토큰), `AppSemanticColors`(ThemeExtension: grade·signal·chart·heat 등)
  - `app_dimens.dart` — `AppSpacing`(4px 단위), `AppRadius`(lg 8 · xl 14 · 2xl 20 · full), `AppShadows.cardFloat`
  - `app_text_styles.dart` — Figma 텍스트 스타일 20개 + Material `TextTheme` 매핑
  - `app_theme.dart` — `ColorScheme` 명시 매핑과 AppBar·Card·Chip·Button·Input·BottomNav·BottomSheet·Dialog 테마
- 서체는 `assets/fonts/` 에 번들(Noto Sans KR 400/500/700 OTF, Black Han Sans, Gaegu 400/700, 모두 OFL).
- 위젯에서 `Color(0xFF...)` 를 직접 쓰지 않고 `Theme.of(context).colorScheme`, `extension<AppSemanticColors>()`, `AppTextStyles` 를 사용합니다.
- 값 변경은 Figma → `디자인/디자인-원칙.md` → 이 파일들 순서로 반영합니다.
