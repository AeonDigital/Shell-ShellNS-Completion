#!/usr/bin/env bash

#
# Restores the events originally related to the indicated keys.
#
# @param string $1...
# Each parameter must be related to a key or set of keys whose event must be
# restored to the original function.
#
# Each key must be passed in single quotation marks and its main value must
# be enclosed in double quotation marks:
#
# ``` sh
# shellNS_completion_keybind_restore_key '"\e[A"' '"\e[B"'
# ```
#
#
# @return void
shellNS_completion_keybind_restore_key() {
  if [ "${#SHELLNS_KEYBIND_MAPPING_KEYS_TO_FUNCTION[@]}" -gt "0" ]; then
    local strEventKey=""
    local strEventKeyReg=""
    local strEventFunction=""

    for strEventKey in "$@"; do
      if [ "${strEventKey}" != "" ]; then
        strEventKeyReg=$(shellNS_completion_keybind_normalize_key "${strEventKey}")
        if [ "${SHELLNS_KEYBIND_MAPPING_KEYS_TO_FUNCTION["${strEventKeyReg}"]}" != "" ]; then
          strEventFunction="${SHELLNS_KEYBIND_MAPPING_KEYS_TO_FUNCTION["${strEventKeyReg}"]}"
          bind "${strEventKey}:${strEventFunction}"
        fi
      fi
    done
  fi
}