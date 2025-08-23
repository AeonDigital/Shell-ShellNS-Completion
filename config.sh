#!/usr/bin/env bash

#
# KEYBIND
#

#
# Mapping Original Bind
# Keys to Functions
unset SHELLNS_KEYBIND_MAPPING_KEYS_TO_FUNCTION
declare -gA SHELLNS_KEYBIND_MAPPING_KEYS_TO_FUNCTION
#
# Mapping Original Bind
# Functions to Keys
unset SHELLNS_KEYBIND_MAPPING_FUNCTION_TO_KEYS
declare -gA SHELLNS_KEYBIND_MAPPING_FUNCTION_TO_KEYS





#
# COMPLETION
#

#
# Autocomplete display type: bash_native | color
readonly SHELLNS_COMPLETION_TYPE="bash_native"
#
# Name of the function that should be executed when the user presses enter
# on the command line.
readonly SHELLNS_COMPLETION_EXECUTE_ON_ENTER_FUNCTION_NAME="shns"
#
# Name of the function that generates the autocomplete.
readonly SHELLNS_COMPLETION_GENERATE_OPTIONS="_shns"

#
# Associative array that maps each namespace to its child components.
unset SHELLNS_COMPLETION_MAPP_NAMESPACE_TO_CHILDS
declare -gA SHELLNS_COMPLETION_MAPP_NAMESPACE_TO_CHILDS





#
# CURRENTPROMPT
#

#
# Saves the information of all manuals that have already been read by
# the autocomplete completion tip generator.
declare -gA SHELLNS_CURRENTPROMPT_FUNCTIONS_MANUALS

#
# If the user is typing the part of the namespace
SHELLNS_CURRENTPROMPT_IN_NAMESPACE=""
#
# Full description of the namespace being evoked on the command line.
SHELLNS_CURRENTPROMPT_NAMESPACE=""
#
# List of all valid options for the present prompt.
SHELLNS_CURRENTPROMPT_NAMESPACE_COMPLETIONS_LIST=""
#
# Main name of the function namespace.
SHELLNS_CURRENTPROMPT_FUNCTION_MAINNS=""
#
# Name of the function that should be executed.
SHELLNS_CURRENTPROMPT_FUNCTION_NAME=""
#
# Collection of arguments that should be passed to the target function.
declare -ga SHELLNS_CURRENTPROMPT_FUNCTION_ARGUMENTS=()

#
# Keeps track of the total rows that the tooltip currently being shown has.
SHELLNS_CURRENTPROMPT_PARAM_TIP_COUNT_LINES="1"





#
# MANUALS
#

# Path to store the extracted manuals.
SHELLNS_MAIN_PATH_TO_EXTRACTED_MANUALS="${XDG_CACHE_HOME}/shellns/manuals/${SHELLNS_CONFIG_INTERFACE_LOCALE}"
if [ "${XDG_CACHE_HOME}" == "" ]; then
  SHELLNS_MAIN_PATH_TO_EXTRACTED_MANUALS="${HOME}/.cache/shellns/manuals/${SHELLNS_CONFIG_INTERFACE_LOCALE}"
fi








# #
# # Package Config

# #
# # Fonts to create this package
# # https://opensource.com/article/18/3/creating-bash-completion-script
# # https://www.gnu.org/software/bash/manual/html_node/Programmable-Completion-Builtins.html#Programmable-Completion-Builtins
# # https://iridakos.com/programming/2018/03/01/bash-programmable-completion-tutorial


# #
# # Autocomplete display type: bash_native | custom
# SHELLNS_AUTOCOMPLETE_TYPE="bash_native"






# #
# # Collection of maximum line sizes to generate the fill tips.
# unset SHELLNS_PARAM_TIP_LINELIMITS
# declare -ga SHELLNS_PARAM_TIP_LINELIMITS=("48" "64" "80" "96" "112" "128" "144" "160")




# #
# # Variables to Show Namespace Completion

# #
# # Colors to use in custom autocomplete and tip parameters
# SHELLNS_COLOR_NONE="\e[0m"

# SHELLNS_COLOR_COMPLETIONS_NS="\e[1;34m"
# SHELLNS_COLOR_COMPLETIONS_FN="\e[1;36m"



# #
# # Variables to Show Parameter Tips

# #
# # Collection of placeholders for colorization commands for the
# # fill hint messages and their respective colors.
# unset SHELLNS_PARAM_TIP_MAPPING_PLACEHOLDER_TO_COLOR
# declare -gA SHELLNS_PARAM_TIP_MAPPING_PLACEHOLDER_TO_COLOR
# SHELLNS_PARAM_TIP_MAPPING_PLACEHOLDER_TO_COLOR["{{NONE}}"]="\e[0m"

# SHELLNS_PARAM_TIP_MAPPING_PLACEHOLDER_TO_COLOR["{{PARAM_BRACKETS}}"]=""
# SHELLNS_PARAM_TIP_MAPPING_PLACEHOLDER_TO_COLOR["{{PARAM_TYPE}}"]="\e[1;94;49m"
# SHELLNS_PARAM_TIP_MAPPING_PLACEHOLDER_TO_COLOR["{{PARAM_DOLLAR}}"]="\e[1;94;49m"
# SHELLNS_PARAM_TIP_MAPPING_PLACEHOLDER_TO_COLOR["{{PARAM_POS}}"]="\e[1;94;49m"
# SHELLNS_PARAM_TIP_MAPPING_PLACEHOLDER_TO_COLOR["{{PARAM_TEXT}}"]=""
# SHELLNS_PARAM_TIP_MAPPING_PLACEHOLDER_TO_COLOR["{{PARAM_TEXT_HIGHLIGHT}}"]=""

# SHELLNS_PARAM_TIP_MAPPING_PLACEHOLDER_TO_COLOR["{{OPT_HEADER}}"]="\e[1;37m"
# SHELLNS_PARAM_TIP_MAPPING_PLACEHOLDER_TO_COLOR["{{OPT_MINMAX}}"]=""
# SHELLNS_PARAM_TIP_MAPPING_PLACEHOLDER_TO_COLOR["{{OPT_TIP_BULLET}}"]="\e[1;94;49m"
# SHELLNS_PARAM_TIP_MAPPING_PLACEHOLDER_TO_COLOR["{{OPT_TIP_TEXT}}"]="\e[2;49;37m"
# SHELLNS_PARAM_TIP_MAPPING_PLACEHOLDER_TO_COLOR["{{OPT_BRACKETS}}"]=""
# SHELLNS_PARAM_TIP_MAPPING_PLACEHOLDER_TO_COLOR["{{OPT_VALUE}}"]="\e[0;90;49m"
# SHELLNS_PARAM_TIP_MAPPING_PLACEHOLDER_TO_COLOR["{{OPT_LABEL}}"]=""


# #
# # Maintain only the record of each key that represents a placeholder.
# unset SHELLNS_PARAM_TIP_PLACEHOLDERS
# declare -ga SHELLNS_PARAM_TIP_PLACEHOLDERS=()
# for k in "${!SHELLNS_PARAM_TIP_MAPPING_PLACEHOLDER_TO_COLOR[@]}"; do
#   SHELLNS_PARAM_TIP_PLACEHOLDERS+=("${k}")
# done
# unset k