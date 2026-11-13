# assets/mock

`USE_MOCK=true`(기본값)일 때 리포지토리가 읽는 응답 JSON 입니다. 모양은 실제 API 응답과 같습니다.

| 파일 | 대신하는 API | 출처 |
| --- | --- | --- |
| `regions_popular.json` | `GET /api/regions/popular?month=` | 웹 `src/mocks/popular` · `tier/sigungu-2025-10` 의 10월 값. 어느 달을 요청해도 이 값을 돌려줍니다 |
| `explore/pins_51150.json` | `GET /api/explore/sigungu/51150/pins` | 웹 `src/mocks/explore/pins.ts` 강릉시 21동 실측 |
| `explore/dong_5115025000.json` | `GET /api/explore/dongs/5115025000` | 웹 `src/mocks/explore/dong.ts` 주문진읍 (모바일이 쓰는 필드만) |

- 핀의 `types`(유형 4종 점수)는 아직 실제 응답에 없는 필드입니다(workation-backend #16). 주문진읍만 실측이고, 나머지 동은 1위 유형 점수만 실측이며 다른 세 유형 점수는 **화면 확인용으로 지어낸 값**입니다.
- 사진 경로(`assets/mock-photos/…`)의 파일은 커밋하지 않습니다. `assets/mock-photos/README.md` 를 봅니다.
