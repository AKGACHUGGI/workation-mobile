# assets/mock

`USE_MOCK=true`(기본값)일 때 리포지토리가 읽는 응답 JSON 입니다. 모양은 실제 API 응답과 같습니다.

| 파일 | 대신하는 API | 출처 |
| --- | --- | --- |
| `regions_popular.json` | `GET /api/regions/popular?month=` | 웹 `src/mocks/popular` · `tier/sigungu-2025-10` 의 10월 값. 어느 달을 요청해도 이 값을 돌려줍니다 |
| `regions/<시군구 코드>.json` (12곳) | `GET /api/regions/{id}?month=` | 웹 `src/mocks/region` 의 2025-10 출력 그대로(고성군 51820 은 수작업 픽스처, 나머지 11곳은 웹 생성기 값). 어느 달을 요청해도 이 값을 돌려줍니다 |
| `explore/pins_51150.json` | `GET /api/explore/sigungu/51150/pins` | 웹 `src/mocks/explore/pins.ts` 강릉시 21동 실측 |
| `explore/dong_5115025000.json` | `GET /api/explore/dongs/5115025000` | 웹 `src/mocks/explore/dong.ts` 주문진읍 (모바일이 쓰는 필드만) |

- 핀의 `types`(유형 4종 점수)는 아직 실제 응답에 없는 필드입니다(workation-backend #16). 주문진읍만 실측이고, 나머지 동은 1위 유형 점수만 실측이며 다른 세 유형 점수는 **화면 확인용으로 지어낸 값**입니다.
- 사진 경로(`assets/mock-photos/…`)의 파일은 커밋하지 않습니다. `assets/mock-photos/README.md` 를 봅니다.
- `POST /api/search/parse` 는 파일이 없습니다. `MockSearchRepository` 가 문장에서 낱말(월 숫자 · 조용/활기 · 바다/산/도시 · 한 달/2주 · 또래)을 찾아 조건을 만듭니다.
- 지역 상세의 사진은 `<코드>.jpg`, `<코드>-1.jpg` … `-4.jpg` 5장을 가리킵니다. 없는 장은 회색 상자로 나옵니다.

## assets/geo (지도 경계, mock 아님)

M-02 지도는 Google Maps 대신 이 경계를 `CustomPaint` 로 직접 그립니다(`lib/features/map/widgets/map_canvas.dart`).

| 파일 | 내용 | 출처 |
| --- | --- | --- |
| `geo/sigungu.json` | 시군구 12곳 경계 + 라벨 점. 속성 `dongCount`(행정동 수)와 `hint`(라벨 태그 문구, 동해안 5곳만 · Figma 문구)는 앱에서 더함 | 웹 `public/geo/sigungu.json` (좌표 소수 4자리로 줄임) |
| `geo/dongs_51150.json` | 강릉시 행정동 21곳 경계 | 웹 `public/geo/51150.json` (같은 정밀도). 다른 시군구는 파일이 없으면 동 경계 없이 그립니다 |

- 정읍시 코드가 점수 mock(`regions_popular.json`)은 `52140`, 경계 파일은 `52180` 이라 정읍시는 ⓪ 에서 색이 칠해지지 않습니다. 백엔드와 코드를 맞춰야 합니다.
