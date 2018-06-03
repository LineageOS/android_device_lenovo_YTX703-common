Shared Device Tree for Lenovo Yoga Tab 3 Plus Wi-Fi (YTX703F) and LTE (YTX703L)
===============================================================================

Basic   | Spec Sheet
-------:|:-------------------------
CHIPSET | Qualcomm MSM8976/APQ8076 Snapdragon 652
CPU     | Quad-core 1.4 GHz Cortex-A53 & Dual-core 1.8 GHz Cortex-A72
GPU     | Adreno 510
Memory  | 3 GB
Shipped Android Version | Android 6.0.1 
Storage | 32 GB
Battery | 9300 mAh (non-removable)
Dimensions | 247 x 179 mm
Display | 1600 x 2560 pixels 10.1"
Rear Camera  | 13.0 MP
Front Camera | 5.0 MP
Release Date | December 2016

![Lenovo Yoga Tablet 3 Plus](http://cdn2.gsmarena.com/vv/pics/lenovo/lenovo-yoga-tab3-plus.jpg "Lenovo Tablet 3 Plus")

Pick list
---------

The following not-yet-merged changes are necessary for successful
compilation of LineageOS for the device:

* https://review.lineageos.org/c/LineageOS/android_build/+/215826
* https://review.lineageos.org/c/LineageOS/android_frameworks_base/+/214991

From a shell environment, you can pick them as following:

```bash
$ source build/envsetup.sh
$ repopick 215826
$ repopick 214991
```

