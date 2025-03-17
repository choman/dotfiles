#!/usr/bin/env bash

#!/usr/bin/env bash

DCONF_PATH="/org/gnome/meld/filename-filters"

add_or_enable_filter() {
  local name="$1"
  local pattern="$2"

  # Read current filters
  current_filters=$(dconf read "$DCONF_PATH")

  # If no filters are set, initialize an empty list
  if [ "$current_filters" = "null" ]; then
    current_filters="[]"
  fi

  # Check if the filter already exists
  if [[ "$current_filters" == *"$pattern"* ]]; then
    # Enable the filter if it's currently disabled
    updated_filters=$(echo "$current_filters" | sed "s/('$name', false, '$pattern')/('$name', true, '$pattern')/")

    if [[ "$current_filters" != "$updated_filters" ]]; then
      echo "'$name' filter was disabled. Enabling it..."
      dconf write "$DCONF_PATH" "$updated_filters"
    else
      echo "'$name' filter is already enabled."
    fi
  else
    # Add the new filter
    updated_filters="${current_filters%]*}, ('$name', true, '$pattern')]"
    dconf write "$DCONF_PATH" "$updated_filters"
    echo "'$name' filter added and enabled."
  fi
}

# Example usage
add_or_enable_filter "direnv" ".direnv"
add_or_enable_filter "bundle" ".bundle"
