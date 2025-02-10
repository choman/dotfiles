#!/usr/bin/env bash


owner="fastfetch-cli"
repo="fastfetch"


dpkgReport="$(dpkg -s fastfetch)"

$HOME/.local/bin/github_download.sh "${owner}/${repo}"

