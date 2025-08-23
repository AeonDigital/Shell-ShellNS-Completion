#!/usr/bin/env bash

#
# Clear tips on push keys
#
# @return void
shellNS_completion_keybind_arrows_push() {
  shellNS_completion_function_tip_clear
  shellNS_completion_keybind_restore_key '"\e[A"' '"\e[B"'
}