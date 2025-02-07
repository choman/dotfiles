#!/usr/bin/env bash
#
#
#
#
DOCK_AUTOHIDE=true
DOCK_EXTEND_HEIGHT=false # panel mode
DOCK_FIXED=false
DOCK_ICON_SIZE=38
DOCK_INTELLIHIDE=true
UBIN=/usr/bin

echo "Setting dock-to-dash settings"
echo "  - Detecting physical/virtual system - via systemd-detect-virt"
if systemd-detect-virt -q; then
   echo "  - virtual"
   DOCK_AUTOHIDE=false
   DOCK_INTELLIHIDE=false
fi

${UBIN}/gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed $DOCK_FIXED
${UBIN}/gsettings set org.gnome.shell.extensions.dash-to-dock autohide $DOCK_AUTOHIDE
## ${UBIN}/gsettings set org.gnome.shell.extensions.dash-to-dock intellihide $DOCK_INTELLIHIDE
${UBIN}/gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size $DOCK_ICON_SIZE
${UBIN}/gsettings set org.gnome.shell.extensions.dash-to-dock extend-height $DOCK_EXTEND_HEIGHT
