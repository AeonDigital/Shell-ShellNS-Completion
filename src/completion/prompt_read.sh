#!/usr/bin/env bash

#
# Checks the command currently present on the command line and separates what
# is namespace from what is argument.
#
# Populates the global variables:
# - SHELLNS_CURRENTPROMPT_IN_NAMESPACE
# - SHELLNS_CURRENTPROMPT_NAMESPACE
# - SHELLNS_CURRENTPROMPT_NAMESPACE_COMPLETIONS_LIST
# - SHELLNS_CURRENTPROMPT_FUNCTION_MAINNS
# - SHELLNS_CURRENTPROMPT_FUNCTION_NAME
# - SHELLNS_CURRENTPROMPT_FUNCTION_ARGUMENTS
#
# @param array $1
# Name of an array that contains the words that should be evaluated.
#
# @return void
shellNS_completion_prompt_read() {
  local -n arrEvaluatedWords="${1}"

  #
  # Separates the words into parts that make up the namespace and arguments
  # to be passed to the command being evoked.
  #
  # The particle -- is responsible for effecting the division between one
  # part and another.
  local strCLIWord=""
  for strCLIWord in "${arrEvaluatedWords[@]}"; do
    if [ "${strCLIWord}" == "--" ]; then
      SHELLNS_CURRENTPROMPT_IN_NAMESPACE="0"
      continue
    fi

    if [ "${SHELLNS_CURRENTPROMPT_IN_NAMESPACE}" == "1" ]; then
      SHELLNS_CURRENTPROMPT_NAMESPACE+="${strCLIWord} "
    else
      SHELLNS_CURRENTPROMPT_FUNCTION_ARGUMENTS+=("${strCLIWord}")
    fi
  done

  #
  # Normalize namespace
  SHELLNS_CURRENTPROMPT_NAMESPACE="${SHELLNS_CURRENTPROMPT_NAMESPACE#"${SHELLNS_CURRENTPROMPT_NAMESPACE%%[![:space:]]*}"}"
  SHELLNS_CURRENTPROMPT_NAMESPACE="${SHELLNS_CURRENTPROMPT_NAMESPACE%"${SHELLNS_CURRENTPROMPT_NAMESPACE##*[![:space:]]}"}"
  SHELLNS_CURRENTPROMPT_NAMESPACE="${SHELLNS_CURRENTPROMPT_NAMESPACE#${SHELLNS_COMPLETION_EXECUTE_ON_ENTER_FUNCTION_NAME} }"
  SHELLNS_CURRENTPROMPT_NAMESPACE="${SHELLNS_CURRENTPROMPT_NAMESPACE// /\.}"  

  #
  # Takes the name of the function corresponding to the namespace.
  SHELLNS_CURRENTPROMPT_FUNCTION_NAME="${SHELLNS_MAPP_NAMESPACE_TO_FUNCTION["${SHELLNS_CURRENTPROMPT_NAMESPACE}"]}"
  #
  # Identifying the name of a function, exits the 'namespace' mode
  if [ "${SHELLNS_CURRENTPROMPT_FUNCTION_NAME}" != "" ]; then
    SHELLNS_CURRENTPROMPT_IN_NAMESPACE="0"
    SHELLNS_CURRENTPROMPT_FUNCTION_MAINNS="${SHELLNS_CURRENTPROMPT_NAMESPACE%%.*}"
  else
    #
    # Identifies all possible child objects that the user can select
    SHELLNS_CURRENTPROMPT_NAMESPACE_COMPLETIONS_LIST="${SHELLNS_COMPLETION_MAPP_NAMESPACE_TO_CHILDS["${SHELLNS_CURRENTPROMPT_NAMESPACE}"]}"

    #
    # If no command list was found for the namespace being typed, 
    # understands that the user does not finished the current word, so, search for the list referring to the previous namespace.
    if [ "${SHELLNS_CURRENTPROMPT_NAMESPACE_COMPLETIONS_LIST}" == "" ]; then
      SHELLNS_CURRENTPROMPT_NAMESPACE_COMPLETIONS_LIST="${SHELLNS_COMPLETION_MAPP_NAMESPACE_TO_CHILDS["${SHELLNS_CURRENTPROMPT_NAMESPACE%.*}"]}"
    fi
  fi
}