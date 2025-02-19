#!/usr/bin/env bash

DEBUG=false

declare -A IP_MAP

function read_ips
{
   yaml_file="${HOME}/.config/yadm/ips.yml"

   while IFS='|' read -r ip category; do
      IP_MAP["$ip"]="$category"
   done < <(yq -o=json "$yaml_file" | jq -r 'to_entries | .[] | .key as $group | .value[] | "\(.)|\($group)"')

   # Display all IP mappings for debug
   if $DEBUG; then
       echo "IP Map Contents:"
       for ip in "${!IP_MAP[@]}"; do
         echo "IP: $ip -> Category: ${IP_MAP[$ip]}"
       done
       echo "DONE"
   fi
}

function get_system_type
{
   #system_type="${IP_MAP["${external_ip}"]:-"Unknown System (Public IP: $external_ip)"}"
   system_type="${IP_MAP["${external_ip}"]:-"unknown"}"
  
   if [[ "${system_type}" =~ ^(unkown|home) && -f "${HOME}/.config/work" ]]; then
      system_type="homework"
   fi

   if $DEBUG; then
      if [[ "${system_type}" = "unknown" ]]; then
        echo "System Type: Unknown System (Public IP: $external_ip)"
      else
        echo "System Type: ${system_type}"
      fi
   fi


   echo "${system_type}"
}

external_ip="$(curl -s https://ifconfig.me)"

if [[ "$1" == "show" ]]; then
    echo $external_ip
    exit 1
fi
read_ips
get_system_type

