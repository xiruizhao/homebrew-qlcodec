#!/bin/sh
# requires: curl, jq, sha256sum, awk, sed (macOS)

if ! command -v curl || ! command -v jq; then
  exit 1
fi
version=$(curl -sL "https://api.github.com/repos/Oil3/QLCodec/releases" | jq -r '.[0].tag_name | split("-")[1]')
if grep -q "version \"${version}\"" Casks/qlcodec.rb; then
    exit 0
fi
DOWNLOAD_URL="https://github.com/Oil3/QLCodec/releases/download/QLC-${version}-universalBinary/QLCodec.${version}-.UniversalBinary.zip"
SHASUM=$(curl -sSL "$DOWNLOAD_URL" | sha256sum -b | awk '{print $1}')
sed -e "s/^  version .*/  version \"${version}\"/" -e "s/^  sha256 .*/  sha256 \"${SHASUM}\"/" -i '' Casks/qlcodec.rb
git config user.name github-actions
git config user.email github-actions@github.com
if [ "$1" = '-no-commit' ]; then
  exit 0
fi
git commit -am "QLCodec ${version}"
git push