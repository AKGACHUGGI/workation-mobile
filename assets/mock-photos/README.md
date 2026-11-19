# mock-photos

Figma 시안 사진을 임시로 두는 폴더입니다. 로그인 화면 배경(`51150.jpg`)과 손으로 만든 mock(`assets/mock/me/photos.json` · `community/poll_*.json`)이 `assets/mock-photos/<파일>` 을 가리킵니다. 지역 · 동네 사진은 mock 도 서버가 준 공개 주소를 씁니다.

- 파일명: 시군구 코드 5자리 `.jpg` (예: `51820.jpg` 고성군). 행정동은 소속 시군구 사진을 씁니다.
- **사진 파일은 커밋하지 않습니다** (`.gitignore`). 저작권 확인 전에는 배포 빌드에 넣지 않습니다.
- 파일이 없으면 `AppPhoto` 가 회색 상자로 대신 그리므로 개발 · 테스트는 사진 없이도 돕니다.
- 시안 사진이 필요하면 Figma `02 Components > § Photos` 에서 내려받아 이 폴더에 둡니다.
