#!/usr/bin/env bash

if [[ "$(declare -p "SHELLNS_STANDALONE_LOAD_STATUS" 2> /dev/null)" != "declare -A"* ]]; then
  declare -gA SHELLNS_STANDALONE_LOAD_STATUS
fi
SHELLNS_STANDALONE_LOAD_STATUS["shellns_completion_standalone.sh"]="ready"
unset SHELLNS_STANDALONE_DEPENDENCIES
declare -gA SHELLNS_STANDALONE_DEPENDENCIES
shellNS_standalone_install_set_dependency() {
  local strDownloadFileName="shellns_${2,,}_standalone.sh"
  local strPkgStandaloneURL="https://raw.githubusercontent.com/AeonDigital/${1}/refs/heads/main/standalone/package.sh"
  SHELLNS_STANDALONE_DEPENDENCIES["${strDownloadFileName}"]="${strPkgStandaloneURL}"
}
shellNS_standalone_install_set_dependency "Shell-ShellNS-Manual" "manual"
declare -gA SHELLNS_DIALOG_TYPE_COLOR=(
  ["raw"]=""
  ["info"]="\e[1;34m"
  ["warning"]="\e[0;93m"
  ["error"]="\e[1;31m"
  ["question"]="\e[1;35m"
  ["input"]="\e[1;36m"
  ["ok"]="\e[20;49;32m"
  ["fail"]="\e[20;49;31m"
)
declare -gA SHELLNS_DIALOG_TYPE_PREFIX=(
  ["raw"]=" - "
  ["info"]="inf"
  ["warning"]="war"
  ["error"]="err"
  ["question"]=" ? "
  ["input"]=" < "
  ["ok"]=" v "
  ["fail"]=" x "
)
declare -g SHELLNS_DIALOG_PROMPT_INPUT=""
shellNS_standalone_install_dialog() {
  local strDialogType="${1}"
  local strDialogMessage="${2}"
  local boolDialogWithPrompt="${3}"
  local codeColorPrefix="${SHELLNS_DIALOG_TYPE_COLOR["${strDialogType}"]}"
  local strMessagePrefix="${SHELLNS_DIALOG_TYPE_PREFIX[${strDialogType}]}"
  if [ "${strDialogMessage}" != "" ] && [ "${codeColorPrefix}" != "" ] && [ "${strMessagePrefix}" != "" ]; then
    local strIndent="        "
    local strPromptPrefix="      > "
    local codeColorNone="\e[0m"
    local codeColorText="\e[0;49m"
    local codeColorHighlight="\e[1;49m"
    local tmpCount="0"
    while [[ "${strDialogMessage}" =~ "**" ]]; do
      ((tmpCount++))
      if (( tmpCount % 2 != 0 )); then
        strDialogMessage="${strDialogMessage/\*\*/${codeColorHighlight}}"
      else
        strDialogMessage="${strDialogMessage/\*\*/${codeColorNone}}"
      fi
    done
    local codeNL=$'\n'
    strDialogMessage=$(echo -ne "${strDialogMessage}")
    strDialogMessage="${strDialogMessage//${codeNL}/${codeNL}${strIndent}}"
    local strShowMessage=""
    strShowMessage+="[ ${codeColorPrefix}${strMessagePrefix}${codeColorNone} ] "
    strShowMessage+="${codeColorText}${strDialogMessage}${codeColorNone}\n"
    echo -ne "${strShowMessage}"
    if [ "${boolDialogWithPrompt}" == "1" ]; then
      SHELLNS_DIALOG_PROMPT_INPUT=""
      read -r -p "${strPromptPrefix}" SHELLNS_DIALOG_PROMPT_INPUT
    fi
  fi
  return 0
}
shellNS_standalone_install_dependencies() {
  if [[ "$(declare -p "SHELLNS_STANDALONE_DEPENDENCIES" 2> /dev/null)" != "declare -A"* ]]; then
    return 0
  fi
  if [ "${#SHELLNS_STANDALONE_DEPENDENCIES[@]}" == "0" ]; then
    return 0
  fi
  local pkgFileName=""
  local pkgSourceURL=""
  local pgkLoadStatus=""
  for pkgFileName in "${!SHELLNS_STANDALONE_DEPENDENCIES[@]}"; do
    pgkLoadStatus="${SHELLNS_STANDALONE_LOAD_STATUS[${pkgFileName}]}"
    if [ "${pgkLoadStatus}" == "" ]; then pgkLoadStatus="0"; fi
    if [ "${pgkLoadStatus}" == "ready" ] || [ "${pgkLoadStatus}" -ge "1" ]; then
      continue
    fi
    if [ ! -f "${pkgFileName}" ]; then
      pkgSourceURL="${SHELLNS_STANDALONE_DEPENDENCIES[${pkgFileName}]}"
      curl -o "${pkgFileName}" "${pkgSourceURL}"
      if [ ! -f "${pkgFileName}" ]; then
        local strMsg=""
        strMsg+="An error occurred while downloading a dependency.\n"
        strMsg+="URL: **${pkgSourceURL}**\n\n"
        strMsg+="This execution was aborted."
        shellNS_standalone_install_dialog "error" "${strMsg}"
        return 1
      fi
    fi
    chmod +x "${pkgFileName}"
    if [ "$?" != "0" ]; then
      local strMsg=""
      strMsg+="Could not give execute permission to script:\n"
      strMsg+="FILE: **${pkgFileName}**\n\n"
      strMsg+="This execution was aborted."
      shellNS_standalone_install_dialog "error" "${strMsg}"
      return 1
    fi
    SHELLNS_STANDALONE_LOAD_STATUS["${pkgFileName}"]="1"
  done
  if [ "${1}" == "1" ]; then
    for pkgFileName in "${!SHELLNS_STANDALONE_DEPENDENCIES[@]}"; do
      pgkLoadStatus="${SHELLNS_STANDALONE_LOAD_STATUS[${pkgFileName}]}"
      if [ "${pgkLoadStatus}" == "ready" ]; then
        continue
      fi
      . "${pkgFileName}"
      if [ "$?" != "0" ]; then
        local strMsg=""
        strMsg+="An unexpected error occurred while load script:\n"
        strMsg+="FILE: **${pkgFileName}**\n\n"
        strMsg+="This execution was aborted."
        shellNS_standalone_install_dialog "error" "${strMsg}"
        return 1
      fi
      SHELLNS_STANDALONE_LOAD_STATUS["${pkgFileName}"]="ready"
    done
  fi
}
shellNS_standalone_install_dependencies "1"
unset shellNS_standalone_install_set_dependency
unset shellNS_standalone_install_dependencies
unset shellNS_standalone_install_dialog
unset SHELLNS_STANDALONE_DEPENDENCIES
unset SHELLNS_KEYBIND_MAPPING_KEYS_TO_FUNCTION
declare -gA SHELLNS_KEYBIND_MAPPING_KEYS_TO_FUNCTION
unset SHELLNS_KEYBIND_MAPPING_FUNCTION_TO_KEYS
declare -gA SHELLNS_KEYBIND_MAPPING_FUNCTION_TO_KEYS
readonly SHELLNS_COMPLETION_TYPE="bash_native"
readonly SHELLNS_COMPLETION_EXECUTE_ON_ENTER_FUNCTION_NAME="shns"
readonly SHELLNS_COMPLETION_GENERATE_OPTIONS="_shns"
unset SHELLNS_COMPLETION_MAPP_NAMESPACE_TO_CHILDS
declare -gA SHELLNS_COMPLETION_MAPP_NAMESPACE_TO_CHILDS
declare -gA SHELLNS_CURRENTPROMPT_FUNCTIONS_MANUALS
SHELLNS_CURRENTPROMPT_IN_NAMESPACE=""
SHELLNS_CURRENTPROMPT_NAMESPACE=""
SHELLNS_CURRENTPROMPT_NAMESPACE_COMPLETIONS_LIST=""
SHELLNS_CURRENTPROMPT_FUNCTION_MAINNS=""
SHELLNS_CURRENTPROMPT_FUNCTION_NAME=""
declare -ga SHELLNS_CURRENTPROMPT_FUNCTION_ARGUMENTS=()
SHELLNS_CURRENTPROMPT_PARAM_TIP_COUNT_LINES="1"
SHELLNS_MAIN_PATH_TO_EXTRACTED_MANUALS="${XDG_CACHE_HOME}/shellns/manuals/${SHELLNS_CONFIG_INTERFACE_LOCALE}"
if [ "${XDG_CACHE_HOME}" == "" ]; then
  SHELLNS_MAIN_PATH_TO_EXTRACTED_MANUALS="${HOME}/.cache/shellns/manuals/${SHELLNS_CONFIG_INTERFACE_LOCALE}"
fi
shellNS_completion_namespace_display_color() {
  shellNS_completion_namespace_prepare "1"
  echo -e "\n${SHELLNS_CURRENTPROMPT_NAMESPACE_COMPLETIONS_LIST[@]}"
  PS1="${PS1@P}"
  echo -ne "${PS1}${COMP_LINE}"
}
shellNS_completion_namespace_display_bash_native() {
  shellNS_completion_namespace_prepare "0"
  local strCurrentWord="${COMP_WORDS[${COMP_CWORD}]}"
  COMPREPLY=($(compgen -W "${SHELLNS_CURRENTPROMPT_NAMESPACE_COMPLETIONS_LIST}" -- "${strCurrentWord}"))
}
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
shellNS_completion_reset() {
  COMPREPLY=()
  SHELLNS_CURRENTPROMPT_IN_NAMESPACE="1"
  SHELLNS_CURRENTPROMPT_NAMESPACE=""
  SHELLNS_CURRENTPROMPT_NAMESPACE_COMPLETIONS_LIST=""
  SHELLNS_CURRENTPROMPT_FUNCTION_MAINNS=
  SHELLNS_CURRENTPROMPT_FUNCTION_NAME=""
  SHELLNS_CURRENTPROMPT_FUNCTION_ARGUMENTS=()
}
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
    echo -ne "\e7\n\e[2K${strParamTip}\e8"
  fi
}
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
shellNS_completion_keybind_arrows_bind() {
  bind -x '"\e[A":shellNS_completion_keybind_arrows_push'
  bind -x '"\e[B":shellNS_completion_keybind_arrows_push'
}
shellNS_completion_keybind_arrows_push() {
  shellNS_completion_function_tip_clear
  shellNS_completion_keybind_restore_key '"\e[A"' '"\e[B"'
}
shellNS_completion_keybind_normalize_key() {
  local key="${1}"
  key="${key//\"/}"
  key="${key//\\/<ESC>}"
  echo -ne "${key}"
}
shellNS_completion_prompt_read() {
  local -n arrEvaluatedWords="${1}"
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
  SHELLNS_CURRENTPROMPT_NAMESPACE="${SHELLNS_CURRENTPROMPT_NAMESPACE#"${SHELLNS_CURRENTPROMPT_NAMESPACE%%[![:space:]]*}"}"
  SHELLNS_CURRENTPROMPT_NAMESPACE="${SHELLNS_CURRENTPROMPT_NAMESPACE%"${SHELLNS_CURRENTPROMPT_NAMESPACE##*[![:space:]]}"}"
  SHELLNS_CURRENTPROMPT_NAMESPACE="${SHELLNS_CURRENTPROMPT_NAMESPACE#${SHELLNS_COMPLETION_EXECUTE_ON_ENTER_FUNCTION_NAME} }"
  SHELLNS_CURRENTPROMPT_NAMESPACE="${SHELLNS_CURRENTPROMPT_NAMESPACE// /\.}"  
  SHELLNS_CURRENTPROMPT_FUNCTION_NAME="${SHELLNS_MAPP_NAMESPACE_TO_FUNCTION["${SHELLNS_CURRENTPROMPT_NAMESPACE}"]}"
  if [ "${SHELLNS_CURRENTPROMPT_FUNCTION_NAME}" != "" ]; then
    SHELLNS_CURRENTPROMPT_IN_NAMESPACE="0"
    SHELLNS_CURRENTPROMPT_FUNCTION_MAINNS="${SHELLNS_CURRENTPROMPT_NAMESPACE%%.*}"
  else
    SHELLNS_CURRENTPROMPT_NAMESPACE_COMPLETIONS_LIST="${SHELLNS_COMPLETION_MAPP_NAMESPACE_TO_CHILDS["${SHELLNS_CURRENTPROMPT_NAMESPACE}"]}"
    if [ "${SHELLNS_CURRENTPROMPT_NAMESPACE_COMPLETIONS_LIST}" == "" ]; then
      SHELLNS_CURRENTPROMPT_NAMESPACE_COMPLETIONS_LIST="${SHELLNS_COMPLETION_MAPP_NAMESPACE_TO_CHILDS["${SHELLNS_CURRENTPROMPT_NAMESPACE%.*}"]}"
    fi
  fi
}
SHELLNS_TMP_PATH_TO_DIR_MANUALS="$(tmpPath=$(dirname "${BASH_SOURCE[0]}"); realpath "${tmpPath}/src-manuals/${SHELLNS_CONFIG_INTERFACE_LOCALE}")"
SHELLNS_MAPP_FUNCTION_TO_MANUAL["shellNS_completion_function_getManual"]="${SHELLNS_TMP_PATH_TO_DIR_MANUALS}/completion/function/getManual.man"
SHELLNS_MAPP_FUNCTION_TO_MANUAL["shellNS_completion_function_tip_clear"]="${SHELLNS_TMP_PATH_TO_DIR_MANUALS}/completion/function/tip/clear.man"
SHELLNS_MAPP_FUNCTION_TO_MANUAL["shellNS_completion_function_tip_show"]="${SHELLNS_TMP_PATH_TO_DIR_MANUALS}/completion/function/tip/show.man"
SHELLNS_MAPP_FUNCTION_TO_MANUAL["shellNS_completion_keybind_arrows_bind"]="${SHELLNS_TMP_PATH_TO_DIR_MANUALS}/completion/keybind/arrows/bind.man"
SHELLNS_MAPP_FUNCTION_TO_MANUAL["shellNS_completion_keybind_arrows_push"]="${SHELLNS_TMP_PATH_TO_DIR_MANUALS}/completion/keybind/arrows/push.man"
SHELLNS_MAPP_FUNCTION_TO_MANUAL["shellNS_completion_keybind_normalize_key"]="${SHELLNS_TMP_PATH_TO_DIR_MANUALS}/completion/keybind/normalize_key.man"
SHELLNS_MAPP_FUNCTION_TO_MANUAL["shellNS_completion_keybind_register_original"]="${SHELLNS_TMP_PATH_TO_DIR_MANUALS}/completion/keybind/register_original.man"
SHELLNS_MAPP_FUNCTION_TO_MANUAL["shellNS_completion_keybind_restore_key"]="${SHELLNS_TMP_PATH_TO_DIR_MANUALS}/completion/keybind/restore_key.man"
SHELLNS_MAPP_FUNCTION_TO_MANUAL["shellNS_completion_namespace_display_bash_native"]="${SHELLNS_TMP_PATH_TO_DIR_MANUALS}/completion/namespace/display/bash_native.man"
SHELLNS_MAPP_FUNCTION_TO_MANUAL["shellNS_completion_namespace_display_color"]="${SHELLNS_TMP_PATH_TO_DIR_MANUALS}/completion/namespace/display/color.man"
SHELLNS_MAPP_FUNCTION_TO_MANUAL["shellNS_completion_namespace_prepare"]="${SHELLNS_TMP_PATH_TO_DIR_MANUALS}/completion/namespace/prepare.man"
SHELLNS_MAPP_FUNCTION_TO_MANUAL["shellNS_completion_prompt_read"]="${SHELLNS_TMP_PATH_TO_DIR_MANUALS}/completion/prompt_read.man"
SHELLNS_MAPP_FUNCTION_TO_MANUAL["shellNS_completion_reset"]="${SHELLNS_TMP_PATH_TO_DIR_MANUALS}/completion/reset.man"
SHELLNS_MAPP_NAMESPACE_TO_FUNCTION["completion.function.getManual"]="shellNS_completion_function_getManual"
SHELLNS_MAPP_NAMESPACE_TO_FUNCTION["completion.function.tip.clear"]="shellNS_completion_function_tip_clear"
SHELLNS_MAPP_NAMESPACE_TO_FUNCTION["completion.function.tip.show"]="shellNS_completion_function_tip_show"
SHELLNS_MAPP_NAMESPACE_TO_FUNCTION["completion.keybind.arrows.bind"]="shellNS_completion_keybind_arrows_bind"
SHELLNS_MAPP_NAMESPACE_TO_FUNCTION["completion.keybind.arrows.push"]="shellNS_completion_keybind_arrows_push"
SHELLNS_MAPP_NAMESPACE_TO_FUNCTION["completion.keybind.normalize.key"]="shellNS_completion_keybind_normalize_key"
SHELLNS_MAPP_NAMESPACE_TO_FUNCTION["completion.keybind.register.original"]="shellNS_completion_keybind_register_original"
SHELLNS_MAPP_NAMESPACE_TO_FUNCTION["completion.keybind.restore.key"]="shellNS_completion_keybind_restore_key"
SHELLNS_MAPP_NAMESPACE_TO_FUNCTION["completion.namespace.display.bash.native"]="shellNS_completion_namespace_display_bash_native"
SHELLNS_MAPP_NAMESPACE_TO_FUNCTION["completion.namespace.display.color"]="shellNS_completion_namespace_display_color"
SHELLNS_MAPP_NAMESPACE_TO_FUNCTION["completion.namespace.prepare"]="shellNS_completion_namespace_prepare"
SHELLNS_MAPP_NAMESPACE_TO_FUNCTION["completion.prompt.read"]="shellNS_completion_prompt_read"
SHELLNS_MAPP_NAMESPACE_TO_FUNCTION["completion.reset"]="shellNS_completion_reset"
unset SHELLNS_TMP_PATH_TO_DIR_MANUALS
