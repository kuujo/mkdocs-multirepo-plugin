#!/bin/bash

url="$1"
name="$2"
branch=$3
shift 3
dirs=( "$@" )


mkdir "$name" # make the section directory
cd "$name"
# initialize git
git init

if [[ -n  "$AccessToken" ]]; then
    git config http.extraheader "AUTHORIZATION: bearer $AccessToken"
fi
# sparse checkout the old way
git config core.sparseCheckout true
git remote add -f origin "$url"
for dir in "${dirs[@]}"
do
   printf "${dir}\n">> .git/info/sparse-checkout
done
git checkout $branch
rm -rf .git