#!/usr/bin/env bash

#
# Prepares the list of options to be used in autocomplete.
#
# @param bool $1
# Indicate '1' if you want the items to be prepared to be shown in color.
#
# @return void
shellNS_completion_namespace_prepare() {
  local colorNONE=""

  local colorNS=""
  local colorFN=""

  if [ "${1}" == "1" ]; then
    colorNONE="${SHELLNS_COLOR_NONE}"

    colorNS="${SHELLNS_COLOR_COMPLETIONS_NS}"
    colorFN="${SHELLNS_COLOR_COMPLETIONS_FN}"
  fi

  local strCommandChildOptions=""
  local -a arrCommandChildOptions=()
  IFS=' ' read -r -a arrCommandChildOptions <<< "${SHELLNS_CURRENTPROMPT_NAMESPACE_COMPLETIONS_LIST}"

  local intI=""
  local strOption=""
  for intI in "${!arrCommandChildOptions[@]}"; do
    strOption="${arrCommandChildOptions[${intI}]}"

    if [ "${strOption:0:1}" == "." ]; then
      strOption="${colorNS}${strOption:1}${colorNONE}"
    else
      strOption="${colorFN}${strOption}${colorNONE}"
    fi

    strCommandChildOptions+="${strOption} "
  done

  SHELLNS_CURRENTPROMPT_NAMESPACE_COMPLETIONS_LIST="${strCommandChildOptions:: -1}"
}