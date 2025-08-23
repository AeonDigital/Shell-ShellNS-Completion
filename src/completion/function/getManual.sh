#!/usr/bin/env bash

#
# Retrieves the manual information for the selected function.
#
# @return void
shellNS_completion_function_getManual() {
  local intReturnCode=""
  local relativePathToFunctionManual="${SHELLNS_MAIN_PATH_TO_EXTRACTED_MANUALS}/${SHELLNS_CURRENTPROMPT_FUNCTION_MAINNS}/${SHELLNS_CURRENTPROMPT_FUNCTION_NAME}"
  if [ ! -d "${relativePathToFunctionManual}" ] || [ ! -f "${relativePathToFunctionManual}/raw/summary" ]; then

    local pathToFunctionManual="${SHELLNS_MAPP_FUNCTION_TO_MANUAL[${SHELLNS_CURRENTPROMPT_FUNCTION_NAME}]}"
    
    shellNS_manual_storage_update "${pathToFunctionManual}" "${relativePathToFunctionManual}" "${SHELLNS_CURRENTPROMPT_FUNCTION_NAME}"
    intReturnCode="$?"
    if [ "${intReturnCode}" != "0" ]; then 
      return "${intReturnCode}"; 
    fi
  fi

  
  declare -gA assocTMPManual
  shellNS_manual_storage_restore "${relativePathToFunctionManual}/raw" "assocTMPManual"
  intReturnCode="$?"

  if [ "${intReturnCode}" != "0" ]; then 
    return "${intReturnCode}"; 
  fi

  for key in "${!assocTMPManual[@]}"; do
    SHELLNS_CURRENTPROMPT_FUNCTIONS_MANUALS["${SHELLNS_CURRENTPROMPT_FUNCTION_NAME}_${key}"]="${assocTMPManual[${key}]}"
  done
  SHELLNS_CURRENTPROMPT_FUNCTIONS_MANUALS["${SHELLNS_CURRENTPROMPT_FUNCTION_NAME}"]="-"

}