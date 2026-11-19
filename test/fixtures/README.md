# test/fixtures

테스트가 정확한 값을 견주는 응답 JSON 입니다. `assets/mock/` 은 실서버 응답을 다시 받으면
(`tool/refresh_mock.sh`) 값이 바뀌므로, 값을 고정해야 하는 테스트는 이 폴더를 읽습니다.

| 파일 | 내용 |
| --- | --- |
| `regions_popular.json` | 인기 지역 12곳(Figma M-03 순위 계산용 수작업 값) |
| `regions/51820.json` | 고성군 상세(웹 W-03 픽스처) |
| `dongs/5115025000.json` | 주문진읍 동네 프로필(Figma M-04 수치) |
| `explore/pins_51150.json` | 강릉시 핀 21동 — 위젯 테스트의 `FakeExploreRepository` 가 읽음 |
| `explore/dong_5115025000.json` | 주문진읍 동 요약 — 위와 같음 |

수치는 시안 · 웹 픽스처에서 온 화면 확인용 값이고, 지역 · 동 코드와 이름은 실제와 같습니다.
