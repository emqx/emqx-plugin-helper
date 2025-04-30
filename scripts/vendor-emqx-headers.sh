#!/usr/bin/env bash

set -euo pipefail

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 EMQX_TAG"
    exit 1
fi

emqx_tag="$1"

header_files=(emqx.hrl emqx_hooks.hrl emqx_mqtt.hrl logger.hrl types.hrl)

# ensure dir
cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")/.."

for header in "${header_files[@]}"; do
    curl -s -o "include/${header}" "https://raw.githubusercontent.com/emqx/emqx/${emqx_tag}/apps/emqx/include/${header}"
done
