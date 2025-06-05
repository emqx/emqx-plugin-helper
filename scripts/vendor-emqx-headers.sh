#!/usr/bin/env bash

### !!!! WARNING !!!!
### This is a helper script to vendor some of the headers from EMQX.
### It is not intended to always automaticaly and correctly generate the headers & types
### The generated files should be manually reviewed and updated.

set -exuo pipefail

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 EMQX_TAG"
    exit 1
fi

function fetch() {
    local src="$1"
    local output_file="$2"
    curl -s -o "${output_file}" "https://raw.githubusercontent.com/emqx/emqx/${emqx_tag}/apps/${src}"
}

function update_type_references() {
    local file="$1"

    ## Change emqx_types:foo_type() to emqx_plugin_helper_types:foo_type()
    perl -i -pe 's/\bemqx_types:(\w+)\(\)/emqx_plugin_helper_types:\1()/g' "${file}"

    ## Change
    ##  xxxx:type().
    ## to
    ##  term(). %% xxxx:type()
    local subst_to_term='s/\b(?!(?:emqx_plugin_helper_types|inet):)(\w+:\w+)\(\)(.*)/term()\2 %% \1()/g'
    perl -i -pe "${subst_to_term}" "${file}"
}

emqx_tag="$1"

header_files=(\
    emqx/include/emqx_hooks.hrl \
    emqx/include/emqx_mqtt.hrl \
    emqx/include/logger.hrl \
    emqx/include/types.hrl \
    emqx/include/emqx.hrl\
    emqx_utils/include/emqx_message.hrl\
)

# ensure dir
cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")/.."

for header in "${header_files[@]}"; do
    fetch "${header}" "include/${header##*/}"
done

fetch "emqx/src/emqx_types.erl" "src/emqx_plugin_helper_types.erl"


## Update the module name to correspond the file name
sed -i 's/-module(emqx_types)./-module(emqx_plugin_helper_types)./' "src/emqx_plugin_helper_types.erl"

## Update the type references in header files
for header in "${header_files[@]}"; do
    update_type_references "include/${header##*/}"
done

## Update the type references in the very type file
update_type_references "src/emqx_plugin_helper_types.erl"

## Include the vendored message.hrl
sed -i 's/-include_lib("emqx_utils\/include\/emqx_message.hrl")/-include("emqx_message.hrl")/' "include/emqx.hrl"
