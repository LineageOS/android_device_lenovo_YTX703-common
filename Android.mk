#
# Copyright (C) 2016 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# This contains the module build definitions for the hardware-specific
# components for this device.
#
# As much as possible, those components should be built unconditionally,
# with device-specific names to avoid collisions, to avoid device-specific
# bitrot and build breakages. Building a component unconditionally does
# *not* include it on all devices, so it is safe even with hardware-specific
# components.

LOCAL_PATH := $(call my-dir)

ifneq ($(filter YTX703F YTX703L, $(TARGET_DEVICE)),)

include $(call all-makefiles-under,$(LOCAL_PATH))

include $(CLEAR_VARS)
###########################################################
## Commands for copying files
###########################################################

# Define a rule to create a symlink.  For use via $(eval).
# $(1): symlink target
# $(2): symlink file name
define create-symlink
$(2):
	@echo "Symbolic link: $2 -> $1"
	mkdir -p $(dir $2)
	rm -rf $2
	ln -sf $1 $2
endef

# -----------------------------------------------------------------
# Define rules to create BOARD_SYSTEM_EXTRA_SYMLINKS defined by
# the product. Very similar in role to the ramdisk board-defined
# symlinks created in system/core/rootdir/Android.mk.
# BOARD_SYSTEM_EXTRA_SYMLINKS is a list of <target>:<link_name>.
ifdef BOARD_VENDOR_EXTRA_SYMLINKS
   $(foreach pair, $(BOARD_VENDOR_EXTRA_SYMLINKS), \
     $(eval target := $(call word-colon,1,$(pair))) \
     $(eval link_name := $(call word-colon,2,$(pair))) \
     $(eval full_link_name := $(call append-path,$(PRODUCT_OUT)/$(TARGET_COPY_OUT_VENDOR),$(link_name))) \
     $(eval $(call create-symlink,$(target),$(full_link_name))) \
     $(eval ALL_DEFAULT_INSTALLED_MODULES += $(full_link_name)))
endif

endif
