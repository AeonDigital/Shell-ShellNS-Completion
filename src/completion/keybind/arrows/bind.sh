#!/usr/bin/env bash

#
# Controls the events of the 'up arrow' and 'down arrow' buttons while
# presenting filling hints to the user, ensuring that they will
# disappear if they press any of these keys.
#
# - '"\e[A"' : 'up arrow'
# - '"\e[B"' : 'down arrow'
#
# @return void
shellNS_completion_keybind_arrows_bind() {
  bind -x '"\e[A":shellNS_completion_keybind_arrows_push'
  bind -x '"\e[B":shellNS_completion_keybind_arrows_push'
}