#!/usr/bin/env bash
export branch=$(git branch | grep \* | cut -d ' ' -f2)
echo "You are working on $branch"
read -p "Enter commit message: " commit
git add -A
git commit -am "$commit" && git push