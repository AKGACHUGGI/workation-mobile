#!/usr/bin/env bash
# assets/mock 의 읽기 응답(지역 · 동네 · 지도)을 실제 백엔드 응답으로 다시 받습니다.
#
#   tool/refresh_mock.sh                          # http://localhost:8000, 2025-12
#   tool/refresh_mock.sh http://localhost:8000 2025-12
#
# 백엔드(workation-backend)를 먼저 띄워 둡니다. 지도 응답(/api/explore/*)은 Neo4j 도 필요합니다
# (workation-backend 의 scripts/explore-local.sh).
#
# 받는 것: regions_popular.json · regions/<시군구>.json · dongs/<행정동>.json ·
#          explore/pins_<시군구>.json · explore/dong_<행정동>.json
# 그대로 두는 것: community/ · me/ (서버에 샘플이 없어 손으로 만든 값)
set -euo pipefail

BASE="${1:-http://localhost:8000}"
MONTH="${2:-2025-12}"
OUT="$(cd "$(dirname "$0")/.." && pwd)/assets/mock"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

# 하나라도 실패하면 기존 파일을 건드리지 않도록 임시 폴더에 다 받은 뒤 옮깁니다.
get() { curl -fsS "$BASE$1" -o "$2"; }
ids() { python3 -c "import json,sys; print('\n'.join(x['id'] for x in json.load(open(sys.argv[1]))[sys.argv[2]]))" "$1" "$2"; }

mkdir -p "$TMP/regions" "$TMP/dongs" "$TMP/explore"
get "/api/regions/popular?month=$MONTH" "$TMP/regions_popular.json"

regions=0
dongs=0
for region in $(ids "$TMP/regions_popular.json" items); do
  get "/api/regions/$region?month=$MONTH" "$TMP/regions/$region.json"
  get "/api/explore/sigungu/$region/pins" "$TMP/explore/pins_$region.json"
  regions=$((regions + 1))
  for dong in $(ids "$TMP/regions/$region.json" dongs); do
    get "/api/dongs/$dong?month=$MONTH" "$TMP/dongs/$dong.json"
    get "/api/explore/dongs/$dong" "$TMP/explore/dong_$dong.json"
    dongs=$((dongs + 1))
  done
done

rm -rf "$OUT/regions" "$OUT/dongs" "$OUT/explore"
mv "$TMP/regions" "$TMP/dongs" "$TMP/explore" "$OUT/"
mv "$TMP/regions_popular.json" "$OUT/regions_popular.json"
echo "assets/mock: 시군구 ${regions}곳 · 행정동 ${dongs}곳 (${MONTH}, ${BASE})"
