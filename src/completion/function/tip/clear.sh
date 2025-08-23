#!/usr/bin/env bash

#
# Clears all lines written by the previous tip.
#
# @return code
shellNS_completion_function_tip_clear() {
  local intCount=""
  local strCleanLines=""

  strCleanLines="\e7" # save cursor position
  for ((intCount=0; intCount<SHELLNS_CURRENTPROMPT_PARAM_TIP_COUNT_LINES; intCount++)); do
    strCleanLines+="\n\e[2K"
  done
  strCleanLines+="\e8" # restore cursor position

  echo -ne "${strCleanLines}"
}