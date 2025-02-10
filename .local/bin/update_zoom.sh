!/usr/bin/env bash

url=https://zoom.us/client/latest/
file=zoom_amd64.deb
DEBUG=false

function copy_file {
    newfile="zoom_amd64-${downloadedVer}.deb"
    [[ ! -f  "$newfile" ]] && cp "${file}" "zoom_amd64-${downloadedVer}.deb"
}

cd ~/Downloads

wget -qN $url$file
downloadedVer=`dpkg -f $file version`

dpkgReport=`dpkg -s zoom`
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
  echo "Zoom is up to date"
fi

