#!/usr/bin/env bash
#
#
#
#
DOCK_FIXED=false
DOCK_AUTOHIDE=true
DOCK_INTELLIHIDE=true
DOCK_ICON_SIZE=38
UBIN=/usr/bin

echo "Detecting physical/virtual system - via systemd-detect-virt"
if systemd-detect-virt -q; then
   echo "  - virtual"
   DOCK_AUTOHIDE=false
   DOCK_INTELLIHIDE=false
fi

${UBIN}/gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed $DOCK_FIXED
${UBIN}/gsettings set org.gnome.shell.extensions.dash-to-dock audtohide $DOCK_AUTOHIDE
## ${UBIN}/gsettings set org.gnome.shell.extensions.dash-to-dock intellihide $DOCK_INTELLIHIDE
${UBIN}/gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size $DOCK_ICON_SIZE
