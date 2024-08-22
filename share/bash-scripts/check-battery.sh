#!/bin/bash

ERGO_KEYB=$(busctl call --json=pretty org.freedesktop.UPower /org/freedesktop/UPower/devices/keyboard_dev_E2_DF_3B_67_6E_A7 org.freedesktop.DBus.Properties GetAll s 'org.freedesktop.UPower.Device' | jq '.data[].Percentage.data|round')

if [[ $ERGO_KEYB -ne 0 && $ERGO_KEYB -lt 15 ]]; then
  notify-send -u critical -t 0 -a "Keyboard Notifier" "Ergonut One is Low" "Please charge the ergonaut keyboard"
fi

THINKPAD_BATTERY=$(busctl call --json=pretty org.freedesktop.UPower /org/freedesktop/UPower/devices/battery_BAT0 org.freedesktop.DBus.Properties GetAll s 'org.freedesktop.UPower.Device' | jq '.data[].Percentage.data|round')

if [[ $THINKPAD_BATTERY -lt 15 ]]; then
  notify-send -u critical -t 0 -a "Keyboard Notifier" "Thinkpad is Low" "Please charge the thinkpad"
fi
