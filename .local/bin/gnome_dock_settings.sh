#!/usr/bin/env bash
#
#

if systemd-detect-virt -q; then
   echo "Physical"
fi
