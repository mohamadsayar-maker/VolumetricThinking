#!/usr/bin/env bash
# Promote the tested staging file to the live site.  Usage: ./promote.sh "message"
set -e
cd "$(dirname "$0")"
[ -f test.html ] || { echo "no test.html"; exit 1; }
# strip the (TEST) build marker so the live copy reads a clean build
sed -E 's/build ([0-9]{8}-[0-9]{4}) \(TEST\)/build \1/; s/-test( -->)/\1/; s/content="([0-9-]+)-test"/content="\1"/' \
    test.html > index.html
cp index.html volthinking.html
./deploy.sh "${1:-Promote staging to live}"
