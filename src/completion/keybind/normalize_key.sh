#!/usr/bin/env bash

#
# Normalizes the notation used to represent a key.
#
# @param string $1
# String that represents the key.
#
# @return string
shellNS_completion_keybind_normalize_key() {
  local key="${1}"
  key="${key//\"/}"
  key="${key//\\/<ESC>}"
  echo -ne "${key}"
}