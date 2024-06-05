#!/bin/bash

# prompt domain
echo "Please enter your address name:"
read address

# prompt uuid
echo "Please enter your uuid:"
read uuid

# generate client config
# eval "cat <<< \"$(<./client/config.json)\"" 2> /dev/null
cat ./client/config.json | sed "s/%UUID%/$uuid/g" | sed "s/%ADDRESS%/$address/g" > config.json
