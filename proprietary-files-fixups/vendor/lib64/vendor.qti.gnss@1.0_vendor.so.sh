#!/bin/bash

patchelf --replace-needed "android.hardware.gnss@1.0.so" "android.hardware.gnss@1.0-v27.so" $1
