#!/bin/sh
# 電池残量を取得
POWER=`/usr/bin/pmset -g ps | tail -n 1 | awk '{print $2}' | sed 's/;//' | sed 's/%//';`
# 電池残量によって色を設定
COLOUR=""
if [ $POWER -gt 60 ]; then
  # 緑
  COLOUR="#[fg=colour46]"
elif [ $POWER -gt 30 ]; then
  # 黄
  COLOUR="#[fg=colour226]"
else
  # 赤
  COLOUR="#[fg=colour1]"
fi
echo "⚡ ${COLOUR}${POWER}%"
