#!/usr/bin/env bash

#
# Register all events bind to their respective keys.
#
# @return void
shellNS_completion_keybind_register_original() {
  if [ "${#SHELLNS_KEYBIND_MAPPING_KEYS_TO_FUNCTION[@]}" == "0" ]; then
    local rawOriginalBind=$(bind -p)


    local rawLine=""
    local strEventKey=""
    local strEventFunction=""

    local strIgnoreNotBound="not bound"
    local strIgnoreSelfInsert="self-insert"
    local strIgnoreDigitArgument="digit-argument"
    local strIgnoreToLowerCaseVersion="do-lowercase-version"

    while IFS='' read -r rawLine || [[ -n "${rawLine}" ]]; do
      if [ "${rawLine}" != "" ] && [[ ! "${rawLine}" == *"${strIgnoreNotBound}"* ]] && [[ ! "${rawLine}" == *"${strIgnoreSelfInsert}"* ]] && [[ ! "${rawLine}" == *"${strIgnoreDigitArgument}"* ]] && [[ ! "${rawLine}" == *"${strIgnoreToLowerCaseVersion}"* ]]; then
        strEventKey=$(shellNS_completion_keybind_normalize_key "${rawLine%:*}")
        strEventFunction="${rawLine#*: }"

        SHELLNS_KEYBIND_MAPPING_KEYS_TO_FUNCTION["${strEventKey}"]="${strEventFunction}"
        SHELLNS_KEYBIND_MAPPING_FUNCTION_TO_KEYS["${strEventFunction}"]+="${strEventKey},"
      fi
    done <<< "${rawOriginalBind}"

    for strEventFunction in "${!SHELLNS_KEYBIND_MAPPING_FUNCTION_TO_KEYS[@]}"; do
      strEventKey="${SHELLNS_KEYBIND_MAPPING_FUNCTION_TO_KEYS["${strEventFunction}"]}"
      SHELLNS_KEYBIND_MAPPING_FUNCTION_TO_KEYS["${strEventFunction}"]="${strEventKey:: -1}"
    done
  fi
}