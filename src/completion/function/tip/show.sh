#!/usr/bin/env bash

#
# Shows the tooltip related to the current parameter.
#
# @return code
shellNS_completion_function_tip_show() {
  local intParamPos="${#SHELLNS_CURRENTPROMPT_FUNCTION_ARGUMENTS[@]}"
  local strParamPos="${intParamPos}"
  if [ "${intParamPos}" -lt "10" ]; then strParamPos="0${intParamPos}"; fi

  local strParamTip=""
  local strParamType="${SHELLNS_CURRENTPROMPT_FUNCTIONS_MANUALS["${SHELLNS_CURRENTPROMPT_FUNCTION_NAME}_param_${strParamPos}_type"]}"
  local strParamSummary="${SHELLNS_CURRENTPROMPT_FUNCTIONS_MANUALS["${SHELLNS_CURRENTPROMPT_FUNCTION_NAME}_param_${strParamPos}_summary"]}"
  if [ "${strParamType}" != "" ] && [ "${strParamSummary}" != "" ]; then
    strParamTip="${strParamType}\n${strParamSummary}"
    SHELLNS_CURRENTPROMPT_PARAM_TIP_COUNT_LINES=$(( $(IFS=$'\n'; set -- ${strParamTip}; echo $#) ))

    #
    # The command below performs the following actions:
    #   - \e7   : Saves the current cursor position and attributes
    #   - \n    : generates a new line (taking the cursor to the beginning of it)
    #   - \e[2K : Fully cleans the line
    #   -       : Print the filling tip.
    #   - \e8   : Restores the original cursor position
    echo -ne "\e7\n\e[2K${strParamTip}\e8"
  fi
}