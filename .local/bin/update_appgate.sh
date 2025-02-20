#!/usr/bin/env bash

url=https://bin.appgate-sdp.com/latest/ubuntu/
file=AppGate-SDP-client.deb
DEBUG=false

function copy_file {
    new_file="appgate-sdp_${downloadedVer}_amd64.deb"
    [[ ! -f  "$new_file" ]] && cp "${file}" "${new_file}"
}

cd ~/Downloads

wget -qN $url$file
downloadedVer=`dpkg -f $file version`

dpkgReport=`dpkg -s appgate`
echo "$dpkgReport" | grep -q '^Status: install ok' && \
  installedVer=`echo "$dpkgReport" | grep ^Version: | sed -e 's/Version: //'`

if $DEBUG; then
    echo "\$installedVer = ($installedVer)"
    echo "\$downloadedVer = ($downloadedVer)"
fi

if [[ "$installedVer" != "$downloadedVer" ]]; then
  sudo dpkg -i $file
  copy_file
else
  echo "appgate is up to date"
fi

