#!/bin/bash

#######
appHome="$HOME/go/src/github.com"
appPath=""
appName=""
repo="https://github.com/cosmos/sdk-application-tutorial.git"


# while true; do
#     echo "Where would you like to build your app? (Github user name):"
#     read appPathStub
#
#     result=$(echo ${appPathStub} | grep "^[0-9|a-z|A-Z|\.|-]\{1,20\}$")
#     if [[ "${result}" == ""  ]]
#     then
#         echo "Should only contain 3~20 alphanumeric characters or '-', please try again"
#         continue
#     fi
#
#     appPath="$appHome/$appPathStub"
#     echo "Your application path is $appPath"
#     mkdir -p ${appPath}
#     git clone "$repo" "$appPath"
#     break
# done

while true; do
  What would you like to call your App name?
  read appName
  cp $HOME/file.txt $HOME/filenew.txt

  sed -i -e 's/nameservice/testservice/g' $HOME/filenew.txt

  # while read a ; do echo ${a//abc/XYZ} ; done < /tmp/file.txt > /tmp/file.txt.t ; mv /tmp/file.txt{.t,}

done
