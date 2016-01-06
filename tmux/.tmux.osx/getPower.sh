/usr/bin/pmset -g ps | tail -n 1 | awk '{print $2}' | sed 's/;//';
