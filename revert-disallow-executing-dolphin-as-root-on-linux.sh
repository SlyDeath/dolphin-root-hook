#!/bin/sh

CURRENT_DIR=$(pwd)
USER_DIR="__USER_DIR__"

[ ! -d $USER_DIR/.cache/dolphin-root-hook ] && mkdir -p $USER_DIR/.cache/dolphin-root-hook

cd $USER_DIR/.cache/dolphin-root-hook || exit

if [ ! -d $USER_DIR/.cache/dolphin-root-hook/dolphin ]; then
  git clone https://github.com/KDE/dolphin.git
  cd ./dolphin || exit
else
  cd ./dolphin || exit
  git pull
fi

git apply "$CURRENT_DIR"/revert-disallow-executing-dolphin-as-root-on-linux.patch || echo 'Already applied'

mkdir -p build
cd build || exit
cmake ..
make -j "$(nproc)"
sudo make install
