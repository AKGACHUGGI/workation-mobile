# mock-photos

Figma 시안 사진을 임시로 두는 폴더입니다. mock 응답의 `photoUrl` 이 `assets/mock-photos/<파일>` 을 가리킵니다 (웹 `public/mock-photos` 와 같은 규칙).

- 파일명: 시군구 코드 5자리 `.jpg` (예: `51820.jpg` 고성군). 행정동은 소속 시군구 사진을 씁니다.
- **사진 파일은 커밋하지 않습니다** (`.gitignore`). 저작권 확인 전에는 배포 빌드에 넣지 않습니다.
- 파일이 없으면 `AppPhoto` 가 회색 상자로 대신 그리므로 개발 · 테스트는 사진 없이도 돕니다.
- 시안 사진이 필요하면 Figma `02 Components > § Photos` 에서 내려받아 이 폴더에 둡니다.
