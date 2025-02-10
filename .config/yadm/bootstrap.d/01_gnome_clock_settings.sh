#!/usr/bin/env bash

UBIN=/usr/bin

echo "Setting gnome clock settings"
${UBIN}/gsettings set org.gnome.desktop.interface clock-format '12h'
${UBIN}/gsettings set org.gnome.desktop.interface clock-show-weekday true
${UBIN}/gsettings set org.gnome.desktop.calendar show-weekdate true

