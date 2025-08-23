#!/usr/bin/env bash

#
# Get path to the manuals directory.
SHELLNS_TMP_PATH_TO_DIR_MANUALS="$(tmpPath=$(dirname "${BASH_SOURCE[0]}"); realpath "${tmpPath}/src-manuals/${SHELLNS_CONFIG_INTERFACE_LOCALE}")"


#
# Mapp function to manual.
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


#
# Mapp namespace to function.
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