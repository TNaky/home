#!/bin/sh
INFO=`/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I`
SSID=`echo "${INFO}" | grep -w SSID | awk '{print $2}'`
if [ ${SSID} = '' ]; then
  echo 'Wi-Fi off'
else
  COLOUR="#[fg=colour246]"
  echo "${COLOUR}${SSID}"
fi
