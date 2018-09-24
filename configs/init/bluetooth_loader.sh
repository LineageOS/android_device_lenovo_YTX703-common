#!/vendor/bin/sh

set -e -u -o pipefail

# Ensure /persist/bluetooth/.bt_nv.bin exists
btnvtool -O
# Convert '1.2a.3b.4c.5d.6d' to '6d:5d:4c:3b:2a:01'
awk_program='                                                \
/--board-address/ {                                          \
    split($2, mac, ".");                                     \
    for (i = 1; i <= 6; i++) {                               \
        if (length(mac[i]) == 1) {                           \
            mac[i] = "0" mac[i];                             \
        }                                                    \
    }                                                        \
    printf("%s:%s:%s:%s:%s:%s\n",                            \
           mac[6], mac[5], mac[4], mac[3], mac[2], mac[1]);  \
}'
btaddr=$(btnvtool -p 2>&1 | awk "${awk_program}")
setprop ro.boot.btmacaddr ${btaddr}

