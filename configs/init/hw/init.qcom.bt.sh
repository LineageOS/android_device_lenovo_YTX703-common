#!/vendor/bin/sh
# Copyright (c) 2009-2013, The Linux Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of The Linux Foundation nor
#       the names of its contributors may be used to endorse or promote
#       products derived from this software without specific prior written
#       permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NON-INFRINGEMENT ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

set -e -u -o pipefail

LOG_TAG="qcom-bluetooth"
LOG_NAME="${0}:"

loge() {
  log -t $LOG_TAG -p e "$LOG_NAME $@"
}

logi() {
  log -t $LOG_TAG -p i "$LOG_NAME $@"
}

failed() {
  loge "$1: exit code $2"
  exit $2
}

#
# Set Bluetooth MAC address using btnvtool
#
config_bt() {

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
}

if [ -n "${1+x}" ] && [ "$1" = "onboot" ]; then
    config_bt
    exit 0
fi

logi "** Transport: smd, Stack: bluedroid **"
setprop vendor.bluetooth.status off

# Note that "hci_qcomm_init -e" prints expressions to set the shell variables
# BTS_DEVICE, BTS_TYPE, BTS_BAUD, and BTS_ADDRESS.

eval $(hci_qcomm_init -e && echo "exit_code_hci_qcomm_init=0" || echo "exit_code_hci_qcomm_init=1")

case $exit_code_hci_qcomm_init in
  0) logi "Bluetooth QSoC firmware download succeeded, $BTS_DEVICE $BTS_TYPE $BTS_BAUD $BTS_ADDRESS";;
  *) failed "Bluetooth QSoC firmware download failed" $exit_code_hci_qcomm_init;
     exit $exit_code_hci_qcomm_init;;
esac

setprop vendor.bluetooth.status on

exit 0
