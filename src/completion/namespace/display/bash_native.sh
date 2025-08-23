#!/usr/bin/env bash

#
# Prepares the collection of options to be presented to the user.
#
# Populates the variable 'COMPREPLY'.
#
# @return void
shellNS_completion_namespace_display_bash_native() {
  shellNS_completion_namespace_prepare "0"
  local strCurrentWord="${COMP_WORDS[${COMP_CWORD}]}"
  COMPREPLY=($(compgen -W "${SHELLNS_CURRENTPROMPT_NAMESPACE_COMPLETIONS_LIST}" -- "${strCurrentWord}"))
}