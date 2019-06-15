#!/bin/bash

appHome="$HOME/go/src/github.com"
appName="jpthor/test"
appPath="${appHome}/${appName}"
repo="https://github.com/cosmos/sdk-application-tutorial.git"


while true; do
   rm -rf ${appPath}
  git clone "$repo" "$appPath"

  break
  done
