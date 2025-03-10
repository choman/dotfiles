#!/usr/bin/env bash

DCONF_PATH="/org/gnome/meld/filename-filters"

# Read the current filters
current_filters=$(dconf read "$DCONF_PATH")

# If no filters are set, initialize an empty list
if [ "$current_filters" = "null" ]; then
  current_filters="[]"
fi

# Check if '.direnv' is already present
if [[ "$current_filters" == *".direnv"* ]]; then
  # If present but disabled, enable it by replacing 'false' with 'true'
  updated_filters=$(echo "$current_filters" | sed "s/('direnv', false, '.direnv')/('direnv', true, '.direnv')/")
  
  if [[ "$current_filters" != "$updated_filters" ]]; then
    echo "'.direnv' filter was disabled. Enabling it..."
    dconf write "$DCONF_PATH" "$updated_filters"
  else
    echo "'.direnv' filter is already enabled."
  fi
else
  # Add the '.direnv' filter with 'true' (enabled)
  updated_filters="${current_filters%]*}, ('direnv', true, '.direnv')]"
  dconf write "$DCONF_PATH" "$updated_filters"
  echo "'.direnv' filter added and enabled."
fi
