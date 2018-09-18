#!/vendor/bin/sh

btnvtool -O
btaddr=$(btnvtool -p 2>&1 | awk '/--board-address/ { gsub(/\./, ":", $2); print $2; }')
setprop ro.boot.btmacaddr ${btaddr}

