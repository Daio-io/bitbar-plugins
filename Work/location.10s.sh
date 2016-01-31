#!/bin/bash

function is_internal_network {
    [ "BBC On Network" = "$(networksetup -getcurrentlocation)" ]
}

if is_internal_network; then
  echo "🔵"
else
  echo "🔴"
fi
