#!/bin/bash

function is_internal_network {
    [ "BBC On Network" = "$(networksetup -getcurrentlocation)" ]
}

if is_internal_network; then
  echo "On Network |color=#2196f3|font=UbuntuMono-Bold"
else
  echo "Off Network |color=#f57c00|font=UbuntuMono-Bold"
fi
