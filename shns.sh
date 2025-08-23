#!/usr/bin/env bash

#
# Entrypoint for ShellNS functions.
#
# @return void
shns() {
  local -a arrPromptWords=("${SHELLNS_COMPLETION_EXECUTE_ON_ENTER_FUNCTION_NAME}" "$@")

  shellNS_completion_reset
  shellNS_completion_prompt_read "arrPromptWords"
  if [ "${SHELLNS_CURRENTPROMPT_FUNCTION_NAME}" != "" ]; then
    shellNS_completion_function_tip_clear
    echo -ne "\e[2K"

    "${SHELLNS_CURRENTPROMPT_FUNCTION_NAME}" "${SHELLNS_CURRENTPROMPT_FUNCTION_ARGUMENTS[@]}"
    shellNS_output_show
  fi
}
#
# Autocomplete for 'shns' commands.
#
# This autocomplete works by identifying which namespace the user is typing
# and offering options consistent with the next possible child objects.
#
# The last word in the namespace is the identifier of the function that will
# be invoked
#
# After the function name, if you need to pass some argument to it, you need
# to use '--' to start writing them
#
# @example
# ``` sh
# shns core validate is array -- "arrayname"
# ```
#
# @void
_shns() {
  shellNS_completion_keybind_register_original  

  shellNS_completion_reset
  shellNS_completion_prompt_read "COMP_WORDS"

  local execMode=""
  if [ "${SHELLNS_CURRENTPROMPT_IN_NAMESPACE}" == "1" ]; then
    if [ "${SHELLNS_CURRENTPROMPT_FUNCTION_NAME}" != "" ]; then
      execMode="function"
    else
      if [ "${SHELLNS_CURRENTPROMPT_NAMESPACE_COMPLETIONS_LIST}" != "" ]; then
        execMode="completions"
      fi
    fi
  else
    if [ "${SHELLNS_CURRENTPROMPT_FUNCTION_NAME}" != "" ]; then
      execMode="function"

      if [ "${#SHELLNS_CURRENTPROMPT_FUNCTION_ARGUMENTS[@]}" == "0" ]; then
        execMode="completions"
        SHELLNS_CURRENTPROMPT_NAMESPACE_COMPLETIONS_LIST="--"
      fi
    fi
  fi


  case "${execMode}" in
    "completions")
      shellNS_completion_keybind_arrows_bind
      local strCompletionsFunctionName="shellNS_completion_namespace_display_${SHELLNS_COMPLETION_TYPE}"
      "${strCompletionsFunctionName}"
      ;;

    "function")
      if [ "${SHELLNS_CURRENTPROMPT_FUNCTIONS_MANUALS["${SHELLNS_CURRENTPROMPT_FUNCTION_NAME}"]}" != "-" ]; then
        shellNS_completion_function_getManual 
      fi

      if [ "${SHELLNS_CURRENTPROMPT_FUNCTIONS_MANUALS["${SHELLNS_CURRENTPROMPT_FUNCTION_NAME}"]}" == "-" ]; then
        shellNS_completion_keybind_arrows_bind
        shellNS_completion_function_tip_clear
        shellNS_completion_function_tip_show
      fi
      ;;
  esac
}
#
# Mapping namespace to child objects.
#
# @return void
shellNS_register_completion_mapp_namespace_to_childs() {
  unset SHELLNS_COMPLETION_MAPP_NAMESPACE_TO_CHILDS
  declare -gA SHELLNS_COMPLETION_MAPP_NAMESPACE_TO_CHILDS

  local strFullNamespace=""
  local -a arrNamespaceParts=()
  local -A assocRootNamespaceParts
  local intNamespaceChildCommandNameIndex=""
  local strNamespaceChildCommandName=""

  local strNamespacePart=""
  local strFullNamespacePath=""
  local strLastNamespacePath=""
  local strNamespaceChilds=""


  for strFullNamespace in "${!SHELLNS_MAPP_NAMESPACE_TO_FUNCTION[@]}"; do
    arrNamespaceParts=()
    
    IFS='.' read -r -a arrNamespaceParts <<< "${strFullNamespace}"
    intNamespaceChildCommandNameIndex=$(( ${#arrNamespaceParts[@]} - 1 ))
    strNamespaceChildCommandName="${arrNamespaceParts["${intNamespaceChildCommandNameIndex}"]}"
    
    unset arrNamespaceParts["${intNamespaceChildCommandNameIndex}"]
    assocRootNamespaceParts[${arrNamespaceParts[0]}]=""

    #
    # Register all parent namespaces before their function
    strNamespacePart=""
    strFullNamespacePath=""
    strLastNamespacePath=""
    strNamespaceChilds=""

    for strNamespacePart in "${arrNamespaceParts[@]}"; do
      if [ "${strFullNamespacePath}" != "" ]; then
        strFullNamespacePath+="."
      fi
      strFullNamespacePath+="${strNamespacePart}"

      if [ "${SHELLNS_COMPLETION_MAPP_NAMESPACE_TO_CHILDS["${strFullNamespacePath}"]}" == "" ]; then
        SHELLNS_COMPLETION_MAPP_NAMESPACE_TO_CHILDS["${strFullNamespacePath}"]=" "
      fi

      if [ "${strLastNamespacePath}" != "" ]; then
        strNamespaceChilds="${SHELLNS_COMPLETION_MAPP_NAMESPACE_TO_CHILDS["${strLastNamespacePath}"]}"
        if [[ ! " ${strNamespaceChilds} " == *" ${strNamespacePart} "* ]]; then
          SHELLNS_COMPLETION_MAPP_NAMESPACE_TO_CHILDS["${strLastNamespacePath}"]+=" ${strNamespacePart} "
        fi
      fi

      strLastNamespacePath="${strFullNamespacePath}"
    done

    #
    # Register function with their full namespace path
    SHELLNS_COMPLETION_MAPP_NAMESPACE_TO_CHILDS["${strFullNamespacePath}"]+="${strNamespaceChildCommandName} "
  done

  SHELLNS_COMPLETION_MAPP_NAMESPACE_TO_CHILDS["${SHELLNS_COMPLETION_EXECUTE_ON_ENTER_FUNCTION_NAME}"]=" ${!assocRootNamespaceParts[@]} "





  arrNamespaceParts=()
  strFullNamespacePath=""

  local -a arrNamespaceChildSorted=()
  local -A assocSHNSMainNamespaces
  local -a arrSHNSMainNamespaces=()
  local strMainNS=""
  local strSortValue=""
  
  for strFullNamespacePath in "${!SHELLNS_COMPLETION_MAPP_NAMESPACE_TO_CHILDS[@]}"; do
    IFS=' ' read -r -a arrNamespaceParts <<< "${SHELLNS_COMPLETION_MAPP_NAMESPACE_TO_CHILDS[${strFullNamespacePath}]}"

    arrNamespaceChildSorted=($(for strSortValue in "${arrNamespaceParts[@]}"; do echo "${strSortValue}"; done | sort))
    SHELLNS_COMPLETION_MAPP_NAMESPACE_TO_CHILDS[${strFullNamespacePath}]=$(IFS=' '; echo "${arrNamespaceChildSorted[*]}")
  done
}



shellNS_register_completion_mapp_namespace_to_childs
complete -F "${SHELLNS_COMPLETION_GENERATE_OPTIONS}" "${SHELLNS_COMPLETION_EXECUTE_ON_ENTER_FUNCTION_NAME}"
