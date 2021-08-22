#!/bin/sh

if [ ! -f /etc/pacman.d/hooks/revert-disallow-executing-dolphin-as-root-on-linux.hook ]; then

  [ ! -d /etc/pacman.d/hooks ] && sudo mkdir -p /etc/pacman.d/hooks

  mkdir -p ~/.local/share/a_miscs/dolphin-root-hook

  cp ./revert-disallow-executing-dolphin-as-root-on-linux.sh ~/.local/share/a_miscs/dolphin-root-hook
  cp ./revert-disallow-executing-dolphin-as-root-on-linux.patch ~/.local/share/a_miscs/dolphin-root-hook
  sed -i "s/__USER_DIR__/\/home\/$USER/g" ~/.local/share/a_miscs/dolphin-root-hook/revert-disallow-executing-dolphin-as-root-on-linux.sh

  if [ ! -f /etc/pacman.d/hooks/revert-disallow-executing-dolphin-as-root-on-linux.hook ]; then
    echo "[Trigger]
Operation=Install
Operation=Upgrade
Type=Package
Target=dolphin

[Action]
Description=Revert disallow executing Dolphin as root on Linux
Depends=git
Depends=cmake
Depends=make
When=PostTransaction
Exec=/bin/sh $HOME/.local/share/a_miscs/dolphin-root-hook/revert-disallow-executing-dolphin-as-root-on-linux.sh
" | sudo tee /etc/pacman.d/hooks/revert-disallow-executing-dolphin-as-root-on-linux.hook
  fi
  echo 'Hook has been installed'
else
  echo 'Hook already installed'
fi
