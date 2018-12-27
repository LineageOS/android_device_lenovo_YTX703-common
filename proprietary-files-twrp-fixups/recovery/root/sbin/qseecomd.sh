#!/bin/bash

# Inspired by bootable/recovery-twrp/prebuilt/relink.sh
sed -i \
	-e "s|/system/bin/linker64\x00|/sbin/linker64\x00\x00\x00\x00\x00\x00\x00|g" \
	-e "s|/system/bin/linker\x00|/sbin/linker\x00\x00\x00\x00\x00\x00\x00|g" \
	-e "s|/system/bin/sh\x00|/sbin/sh\x00\x00\x00\x00\x00\x00\x00|g" \
	-e "s|/system/lib64\x00|/sbin\x00\x00\x00\x00\x00\x00\x00\x00\x00|g" \
	-e "s|/system/lib\x00|/sbin\x00\x00\x00\x00\x00\x00\x00|g" $1

