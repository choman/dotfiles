#!/usr/bin/env bash

store=${1:test}

echo "password=$(gopass show -o "${store}")"
