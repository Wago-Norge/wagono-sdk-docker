#!/bin/bash
set -e

TAG=${1:-V03.09.07_21}
USER=$2
PASSWORD=$3

[[ -z $USER ]] && read -p "SVN user: " USER
[[ -z $PASSWORD ]] && read -s -p "Password:" PASSWORD

echo "export LC_CTYPE=en_US.UTF-8" >> ~/.profile
#The directory /secrets is mounted from the user home directory in the host system, see the mounts section in .devcontainer/devcontainer.json
echo "export JFROG_APIKEY=$(cat /secrets/jfrog-api-key)" >> ~/.profile
source ~/.profile

svn checkout --no-auth-cache --username $USER --password $PASSWORD https://svsv01003.wago.local/svn/repo3/pfc/tags/wago-pfc200/$TAG/ src/$TAG
cp configs/* src/$TAG/ptxproj/configs/wago-pfcXXX

mkdir -p ~/.ptxdist
cp .devcontainer/scripts/ptxdistrc-2020.08 ~/.ptxdist/ptxdistrc-2020.08
cd src/$TAG/ptxproj
ptxdist platform configs/wago-pfcXXX/platformconfig_minimal 
ptxdist select configs/wago-pfcXXX/ptxconfig_pfc_g2_minimal
ptxdist toolchain /opt/gcc-Toolchain-2019.12/arm-linux-gnueabihf/bin


