#!/bin/bash

sed -i -e 's|system/etc|vendor/etc|g' $1
sed -i -e 's|libprotobuf-cpp-lite\.so|libprotobuf-cpp-Hlte.so|g' $1

