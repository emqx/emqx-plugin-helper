#!/bin/bash

set -uo pipefail

if [ $# -ne 1 ]; then
    echo "Usage: $0 VERSION"
    exit 1
fi

version="$1"

bump2version_present=$(command -v bump2version || echo "false")
if [ "$bump2version_present" = "false" ]; then
    echo "Please install bump2version first: pip install bump2version"
    exit 1
fi

exec bump2version --new-version "$version" patch

