#!/usr/bin/env bash

UBIN=/usr/bin

${UBIN}/gsettings set org.gnome.desktop.interface clock-format '12h'
${UBIN}/gsettings set org.gnome.desktop.interface clock-show-weekday true
${UBIN}/gsettings set org.gnome.desktop.calendar show-weekdate true

