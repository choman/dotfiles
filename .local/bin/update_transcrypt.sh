#!/usr/bin/env bash

BASE_DIR="${HOME}/repos/github"
DEST="${BASE_DIR}/transcrypt"
BIN_SRC="${DEST}/transcrypt"
BIN_DST="/usr/local/bin/transcrypt"

function ensure_base_dir
{
   local dir=$1
   local base_dir="$(dirname "${dir}")"

   echo base_dir = $base_dir
   [[ -d "${base_dir}" ]] || mkdir -p "${base_dir}"
}

ensure_base_dir "${DEST}"
##ensure_base_dir "${BIN_DST}"

[[ -d "${DEST}" ]] || {
    pushd ${BASE_DIR} && git clone https://github.com/elasticdog/transcrypt.git && popd
}

pushd "${DEST}"
pwd
git pull --rebase
popd

echo "Setting up link as root"
[[ -h "${BIN_DST}" ]] || sudo ln -s "${BIN_SRC}" "${BIN_DST}"
ls -la "${BIN_DST}"
