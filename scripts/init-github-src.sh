#!/bin/bash
set -e

TAG=${1:-FW21-V03.09.04}

mkdir -p src
git clone --branch $TAG https://github.com/WAGO/pfc-firmware-sdk-G2.git src/$TAG

cp  configs/* src/$TAG/configs/wago-pfcXXX

cd src/$TAG
ptxdist platform configs/wago-pfcXXX/platformconfig_minimal 
ptxdist select configs/wago-pfcXXX/ptxconfig_pfc_g2_minimal
ptxdist toolchain /opt/gcc-Toolchain-2019.12/arm-linux-gnueabihf/bin
