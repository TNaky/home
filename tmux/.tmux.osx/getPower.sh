#!/bin/sh
POWER=`/usr/bin/pmset -g ps | tail -n 1 | awk '{print $2}' | sed 's/;//' | sed 's/%//';`
if [ $POWER -gt 60 ]; then
  echo "⚡ #[fg=colour46]${POWER}%"
elif [ $POWER -gt 30 ]; then
  echo "⚡ #[fg=colour46]${POWER}%"
else
  echo "⚡ #[fg=colour46]${POWER}%"
fi
