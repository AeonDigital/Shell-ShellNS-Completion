#!/usr/bin/env bash

#
# Prototype for presenting the color options to the user.
# This option makes you lose autocomplete with the use of <tab>.
#
# @return void
shellNS_completion_namespace_display_color() {
  shellNS_completion_namespace_prepare "1"

  echo -e "\n${SHELLNS_CURRENTPROMPT_NAMESPACE_COMPLETIONS_LIST[@]}"
  PS1="${PS1@P}"
  echo -ne "${PS1}${COMP_LINE}"
}