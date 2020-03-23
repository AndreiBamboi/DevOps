#!/usr/bin/env bash
my_array=(foo bar baz)
for index in "${!my_array[*]}"; do echo "$index"; done