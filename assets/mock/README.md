# assets/mock

`USE_MOCK=true`(기본값)일 때 리포지토리가 읽는 응답 JSON 입니다. 모양은 실제 API 응답과 같습니다.

| 파일 | 대신하는 API | 출처 |
| --- | --- | --- |
| `regions_popular.json` | `GET /api/regions/popular?month=` | 웹 `src/mocks/popular` · `tier/sigungu-2025-10` 의 10월 값. 어느 달을 요청해도 이 값을 돌려줍니다 |
| `regions/<시군구 코드>.json` (12곳) | `GET /api/regions/{id}?month=` | 웹 `src/mocks/region` 의 2025-10 출력 그대로(고성군 51820 은 수작업 픽스처, 나머지 11곳은 웹 생성기 값). 어느 달을 요청해도 이 값을 돌려줍니다 |
| `explore/pins_51150.json` | `GET /api/explore/sigungu/51150/pins` | 웹 `src/mocks/explore/pins.ts` 강릉시 21동 실측 |
| `explore/dong_5115025000.json` | `GET /api/explore/dongs/5115025000` | 웹 `src/mocks/explore/dong.ts` 주문진읍 (모바일이 쓰는 필드만) |
| `dongs/<행정동 코드>.json` (67곳) | `GET /api/dongs/{id}?month=` | M-03b 동 목록에 나오는 12개 시군구의 모든 동. 웹 `src/mocks/dong` 의 곡선 규칙(코사인)으로 만든 값이고, 주문진읍(Figma 값) · 거진읍(웹 픽스처)만 실제 시안 수치. 나머지 지표는 동 코드로 정한 **화면 확인용 값**입니다. 어느 달을 요청해도 같은 값 |
| `community/notes_<id>.json` · `poll_<id>.json` | `GET /api/{regions\|dongs}/{id}/notes` · `/poll` | 지역 51820, 동 5182025300 · 5115025000 의 샘플. 그 밖의 대상은 비어 있고, 팁 · 투표는 메모리에만 쌓입니다 |

- 핀의 `types`(유형 4종 점수)는 아직 실제 응답에 없는 필드입니다(workation-backend #16). 주문진읍만 실측이고, 나머지 동은 1위 유형 점수만 실측이며 다른 세 유형 점수는 **화면 확인용으로 지어낸 값**입니다.
- 사진 경로(`assets/mock-photos/…`)의 파일은 커밋하지 않습니다. `assets/mock-photos/README.md` 를 봅니다.
- `POST /api/search/parse` 는 파일이 없습니다. `MockSearchRepository` 가 문장에서 낱말(월 숫자 · 조용/활기 · 바다/산/도시 · 한 달/2주 · 또래)을 찾아 조건을 만듭니다.
- 지역 상세의 사진은 `<코드>.jpg`, `<코드>-1.jpg` … `-4.jpg` 5장을 가리킵니다. 없는 장은 회색 상자로 나옵니다.
