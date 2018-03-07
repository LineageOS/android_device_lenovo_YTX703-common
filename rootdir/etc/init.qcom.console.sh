#!/system/bin/sh
# Copyright (c) 2012-2013, The Linux Foundation. All rights reserved.
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

#
# For controlling console and shell on console on 8960 - perist.serial.enable 8960
# On other target use default ro.debuggable property.
#
serial=`getprop persist.serial.enable`
dserial=`getprop ro.debuggable`
case "$target" in
    "msm8960")
        case "$serial" in
            "0")
                echo 0 > /sys/devices/platform/msm_serial_hsl.0/console
                ;;
            "1")
                echo 1 > /sys/devices/platform/msm_serial_hsl.0/console
                start console
                ;;
            *)
                case "$dserial" in
                     "1")
                         start console
                         ;;
                esac
                ;;
        esac
        ;;

    "msm8610" | "msm8974" | "msm8226")
        case "$serial" in
             "0")
                echo 0 > /sys/devices/f991f000.serial/console
                ;;
             "1")
                echo 1 > /sys/devices/f991f000.serial/console
                start console
                ;;
            *)
                case "$dserial" in
                     "1")
                        start console
                        ;;
                esac
                ;;
        esac
        ;;
    *)
        case "$dserial" in
            "1")
                start console
                ;;
        esac
        ;;
esac
