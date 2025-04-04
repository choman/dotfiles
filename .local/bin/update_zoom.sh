#!/usr/bin/env bash

url=https://zoom.us/client/latest/
file=zoom_amd64.deb
DEBUG=false

DOWNLOAD_DIR="${HOME}/Downloads/packages"

ensure_dest() {
   mkdir -p "${DOWNLOAD_DIR}"
}

function copy_file {
    new_file="zoom_amd64-${downloaded_version}.deb"
    [[ ! -f  "$new_file" ]] && cp "${file}" "${new_file}"
}

ensure_dest
cd ${DOWNLOAD_DIR}

wget -qN $url$file
downloaded_version=$(dpkg -f $file version)

dpkg_report=$(dpkg -s zoom)
echo "$dpkg_report" | grep -q '^Status: install ok' && \
	installed_version=$(echo "$dpkg_report" | grep ^Version: | sed -e 's/Version: //')

if $DEBUG; then
    echo "\$installed_version = (${installed_version})"
    echo "\$downloaded_version = (${downloaded_version})"
fi

if [[ "${installed_version}" != "${downloaded_version}" ]]; then
  sudo dpkg -i $file
  copy_file
else
  echo "Zoom is up to date"
fi

