#!/bin/bash

sed -i -e 's|system/etc|vendor/etc|g' $1
sed -i -e 's|system/lib/hw|vendor/lib/hw|g' $1
sed -i -e 's|etc/acdbdata|vendor/etc/a|g' $1

