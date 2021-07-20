#!/bin/bash

current_space_in_display_index=$(yabai -m query --spaces --display | jq '[.[]|.focused > 0]|index(true)')

spaces_in_display=$(yabai -m query --spaces --display | jq 'length')

next_space_index=$((($current_space_in_display_index+1)%$spaces_in_display))

next_space_id=$(yabai -m query --spaces --display | jq ".[$next_space_index]|.index")


$(yabai -m space --focus "$next_space_id")


