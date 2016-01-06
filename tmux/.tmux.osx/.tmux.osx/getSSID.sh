SSID=`/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I`
SSID=`echo "${SSID}" | grep -w SSID | awk '{print $2}'`
echo "${SSID}"
