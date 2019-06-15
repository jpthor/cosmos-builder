#!/bin/bash

while true; do

  mkdir -p $HOME/go/bin
  echo "export GOPATH=$HOME/go" >> ~/.bash_profile
  echo "export GOBIN=\$GOPATH/bin" >> ~/.bash_profile
  echo "export PATH=\$PATH:\$GOBIN" >> ~/.bash_profile
  echo "export GO111MODULE=on" >> ~/.bash_profile
  source ~/.bash_profile

  appHome="$HOME/go/src/github.com"
  appPath="jpthor/test"

  cd ${appHome}/${appPath}
  make install
  csd init cschain --chain-id cschain

  # cscli keys add jack
  # cscli keys add alice

  csd add-genesis-account $(cscli keys show jack -a) 1000cstoken,100000000stake
  csd add-genesis-account $(cscli keys show alice -a) 1000cstoken,100000000stake

  cscli config chain-id cschain
  cscli config output json
  cscli config indent true
  cscli config trust-node true

  csd gentx --name jack
  csd collect-gentxs
  csd validate-genesis

  csd start & cscli rest-server --chain-id cschain --trust-node && fg

  break

done
