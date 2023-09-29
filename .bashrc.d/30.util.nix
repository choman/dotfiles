NIX_PROFILE="${HOME}/.nix-profile/etc/profile.d/nix.sh"
NIX_HOME_MANAGER="${HOME}/.nix-profile/etc/profile.d/hm-session-vars.sh"
source_if_exists "${NIX_PROFILE}"
source_if_exists "${NIX_HOME_MANAGER}"

