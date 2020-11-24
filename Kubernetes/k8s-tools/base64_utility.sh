#!/usr/bin/env bash
echo "Utility to decode/encode using bas64"
read -p "Lets choose the action , 1 for encode and 2 for decode. What is your choice:  " action

if [ $action == 2 ]; then
    echo "You choose to decode. Make sure to add an base64 encoded string"
    read -p "Now add you input for decoding: " input_decode
    result_decode=$(echo -n $input_decode | base64 -d)
    echo "You result is : $result_decode"
elif [[ $action == 1 ]]; then
    echo "You choose to encode. Make sure to add an decoded string"
    read -p "Now add you input for encoding: " input_encode
    result_encode=$(echo -n $input_encode | base64 )
    echo "You result is : $result_encode"
else
  echo "No action selected. Please try again"
fi
