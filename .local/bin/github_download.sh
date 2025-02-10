#!/usr/bin/env bash

# Usage: ./script.sh <GitHub Owner/Repo>
REPO="$1"
if [[ -z "$REPO" ]]; then
  echo "Usage: $0 <GitHub Owner/Repo>"
  exit 1
fi

function copy_file {
    orig_filename=$1
    dest_filename=$2
    [[ ! -f "${dest_filename}" ]] && cp "${orig_filename}" "${dest_filename}"
}


# Get the latest release info from GitHub API
API_URL="https://api.github.com/repos/$REPO/releases/latest"
response=$(curl -sSL "$API_URL")

# Extract the tag name (version)
version=$(echo "$response" | jq -r .tag_name)
if [[ "$version" == "null" ]]; then
  echo "Failed to get the latest release version. Ensure the repo exists and has releases."
  exit 1
fi

# Extract the deb asset URL containing amd64 or x86_64
deb_url=$(echo "$response" | jq -r '.assets[] | select(.name | (test("\\.deb") and (contains("amd64") or contains("x86_64")))) | .browser_download_url')
if [[ -z "$deb_url" ]]; then
  echo "No .deb file found for amd64 or x86_64 in the latest release."
  exit 1
fi

# Download the .deb file
cd ~/Downloads


filename="$(basename "$deb_url")"
echo "Downloading $filename from $deb_url..."
curl -LO "$deb_url"

if [[ -f "$filename" ]]; then
  echo "Downloaded $filename (Version: $version)"
else
  echo "Failed to download the file."
  exit 1
fi


downloaded_version="$(dpkg -f $filename version)"
package="$(dpkg -f $filename package)"

dpkg_report="$(dpkg -s $package)"

echo "$dpkg_report" | grep -q '^Status: install ok' && \
  installed_version=`echo "$dpkg_report" | grep ^Version: | sed -e 's/Version: //'`

if $DEBUG; then
    echo "\$installed_version = ($installed_version)"
    echo "\$downloaded_version = ($downloaded_version)"
fi

if [[ "$installed_version" != "$downloaded_version" ]]; then
  sudo dpkg -i $filename
  copy_file $filename
else
  echo "${package} is up to date"
fi

