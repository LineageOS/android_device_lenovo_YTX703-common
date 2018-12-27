#!/bin/bash

# See commit 45e37256 for details
sed -i -e 's|sns\.reg|sns.los|g' $1
sed -i -e 's|etc/sensors|vendor/snsc|g' $1
