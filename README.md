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

Build instructions
------------------

Follow the steps at [LineageOS](https://github.com/lineageos/android/tree/cm-14.1) to set up a cm-14.1 build tree.
Prior to issuing the `repo sync` command, add the following to the
`.repo/local_manifests/roomservice.xml` file:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<manifest>
  <remote fetch="ssh://git@github.com/vladimiroltean/" name="unofficial" />
  <project name="android_device_lenovo_YTX703-common" path="device/lenovo/YTX703-common" remote="unofficial" revision="cm-14.1" />
  <project name="android_vendor_lenovo_YTX703-common" path="vendor/lenovo/YTX703-common" remote="unofficial" revision="cm-14.1" />
  <project name="android_kernel_lenovo_msm8976" path="kernel/lenovo/msm8976" remote="unofficial" revision="cm-14.1-caf-LA.BR.1.3.6-04510-8976.0" />
</manifest>
```

Then execute `repo sync` (again). Then (change accordingly if you have
an F device):

```bash
$ source build/envsetup.sh
$ lunch lineage_YTX703L-userdebug
$ mka bacon
```

To update the proprietary makefiles with new blobs extracted from a
system image (not necessary if you only want to build a release image),
you can run the following (Change accordingly if you have an F device):

```bash
$ cd /opt/stock/
$ simg2img system.img system2.img
$ mkdir system
$ sudo mount -o loop system2.img system
$ ./YTX703L/extract-files.sh -d /opt/stock/system/
```

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

Version control
---------------

Release builds are published on the [XDA forum](https://forum.xda-developers.com/thinkpad-tablet/development/unofficial-lineageos-14-1-lenovo-yoga-t3561457).
To reproduce a build on a particular date, the
`android_device_lenovo_YTX703-common` and `android_vendor_lenovo_YTX703-common`
use a versioning system based on git tags.
The `android_kernel_lenovo_msm8976` repository does not yet adhere to
this system, and the `cm-14.1-caf-LA.BR.1.3.6-04510-8976.0` branch
(continuously rebased) should be use for building.

