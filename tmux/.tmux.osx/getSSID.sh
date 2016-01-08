#!/bin/sh
info=`/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I`
ssid=`echo "${info}" | grep -w SSID | awk '{print $2}'`
rssi=`echo "${info}" | grep -w agrCtlRSSI | awk '{print $2}'`
stat=`echo "${info}" | grep -w state | awk '{print $2}'`
rate=`echo "${info}" | grep -w state lastTxRate awk '{print $2}'`
if [ ${ssid} = '' ]; then
  echo 'Wi-Fi off'
elif [ ${stat} != 'running' ]; then
  echo 'Wi-Fi off'
else
  levels=(▁ ▃ ▅ ▇ )
  colour="#[fg=colour246]"
  echo "${colour}${ssid} ${rate}Mbps"
fi
