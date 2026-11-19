# assets/mock

`USE_MOCK=true`(기본값)일 때 리포지토리가 읽는 응답 JSON 입니다. 모양은 실제 API 응답과 같습니다.

| 파일 | 대신하는 API | 출처 |
| --- | --- | --- |
| `regions_popular.json` | `GET /api/regions/popular?month=` | **실서버 응답**(2025-12). 어느 달을 요청해도 이 값을 돌려줍니다 |
| `regions/<시군구 코드>.json` (12곳) | `GET /api/regions/{id}?month=` | **실서버 응답**(2025-12). 어느 달을 요청해도 이 값을 돌려줍니다 |
| `dongs/<행정동 코드>.json` (203곳) | `GET /api/dongs/{id}?month=` | **실서버 응답**(2025-12). 지역 상세의 동 목록에 나오는 모든 동. 어느 달을 요청해도 같은 값 |
| `explore/pins_<시군구 코드>.json` (12곳) | `GET /api/explore/sigungu/{id}/pins` | **실서버 응답** |
| `explore/dong_<행정동 코드>.json` (203곳) | `GET /api/explore/dongs/{id}` | **실서버 응답** |
| `community/notes_<id>.json` · `poll_<id>.json` | `GET /api/{regions\|dongs}/{id}/notes` · `/poll` | 손으로 만든 샘플(서버에 아직 팁 · 투표가 없음). 지역 51820, 동 5182025300 · 5115025000 만 있고 그 밖의 대상은 비어 있습니다. 팁 · 투표는 메모리에만 쌓입니다 |
| `me/favorites.json` · `tips.json` · `photos.json` · `summary.json` | `GET /api/me/favorites` · `/me/tips` · `/me/photos` · `/me/summary` | 손으로 만든 샘플(웹 `src/mocks/me/*` 의 초기 값). 즐겨찾기의 지역 · 동 코드와 점수는 위 실서버 응답과 맞춰 두었습니다. 쓰기(PUT · DELETE)는 메모리에만 반영됩니다 |

### 실서버 응답 다시 받기

**실서버 응답** 파일은 손으로 고치지 않습니다. 백엔드를 띄운 뒤 스크립트로 다시 받습니다.

```sh
# workation-backend 에서: scripts/explore-local.sh (Neo4j) · uv run python manage.py runserver
tool/refresh_mock.sh                               # http://localhost:8000, 2025-12
tool/refresh_mock.sh http://localhost:8000 2025-10 # 다른 달
```

- 시군구 · 행정동 목록은 서버가 주는 대로 따라갑니다(인기 지역 → 지역 상세의 동 목록).
- 값이 바뀌어도 테스트가 깨지지 않게, mock 을 읽는 테스트는 규칙(개수 · 범위 · 서로 맞는지)만 봅니다. 정확한 값을 견주는 테스트는 `test/fixtures/` 의 고정 응답을 읽습니다.
- 사진 주소는 서버가 준 공개 주소(`https://…r2.dev/…`)라 인터넷이 있어야 보입니다. 없으면 회색 상자로 나옵니다.
- `favoriteCount` 는 서버가 아직 0 으로 줍니다.
- `POST /api/search/parse` 는 파일이 없습니다. `MockSearchRepository` 가 문장에서 낱말(월 숫자 · 조용/활기 · 바다/산/도시 · 한 달/2주 · 또래)을 찾아 조건을 만듭니다.
- `me/photos.json` 과 `community/poll_*.json` 의 사진만 `assets/mock-photos/…` 를 가리킵니다(파일은 커밋하지 않음, `assets/mock-photos/README.md`).

## assets/geo (지도 경계, mock 아님)

M-02 지도의 시군구 · 행정동 면은 이 경계로 그립니다. Google Maps 키가 있으면 타일 위 폴리곤으로, 없으면 `CustomPaint` 로 직접 그립니다(`lib/features/map/widgets/map_canvas.dart`).

| 파일 | 내용 | 출처 |
| --- | --- | --- |
| `geo/sigungu.json` | 시군구 12곳 경계 + 라벨 점. 속성 `dongCount`(행정동 수)와 `hint`(라벨 태그 문구, 동해안 5곳만 · Figma 문구)는 앱에서 더함 | 웹 `public/geo/sigungu.json` (좌표 소수 4자리로 줄임) |
| `geo/dongs_51150.json` | 강릉시 행정동 21곳 경계 | 웹 `public/geo/51150.json` (같은 정밀도). 다른 시군구는 파일이 없으면 동 경계 없이 그립니다 |

