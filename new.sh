#!/bin/bash

appHome="$HOME/go/src/github.com"
appPath=""
repo="https://github.com/cosmos/sdk-application-tutorial.git"

#TODO: build these through echo
appName="cmb"
AppName="Cmb"
appService=""
abbv='("cs")'
ABBV='"CS",'
abbvs="cs"
ABBVs="CS"
appCli="cscli"
appD="csd"
token="cmtoken"
typename="cmname"
TypeName="CmName"
type="cmtype"
Type="CmType"



rename(){
  sed -i '' "s;$1;$2;g" ${appHome}/${appPath}/x/${appService}/alias.go
  sed -i '' "s;$1;$2;g" ${appHome}/${appPath}/x/${appService}/genesis.go
  sed -i '' "s;$1;$2;g" ${appHome}/${appPath}/x/${appService}/handler.go
  sed -i '' "s;$1;$2;g" ${appHome}/${appPath}/x/${appService}/keeper.go
  sed -i '' "s;$1;$2;g" ${appHome}/${appPath}/x/${appService}/module.go
  sed -i '' "s;$1;$2;g" ${appHome}/${appPath}/x/${appService}/querier.go
  sed -i '' "s;$1;$2;g" ${appHome}/${appPath}/x/${appService}/types/codec.go
  sed -i '' "s;$1;$2;g" ${appHome}/${appPath}/x/${appService}/types/key.go
  sed -i '' "s;$1;$2;g" ${appHome}/${appPath}/x/${appService}/types/msgs.go
  sed -i '' "s;$1;$2;g" ${appHome}/${appPath}/x/${appService}/types/querier.go
  sed -i '' "s;$1;$2;g" ${appHome}/${appPath}/x/${appService}/types/types.go
  sed -i '' "s;$1;$2;g" ${appHome}/${appPath}/x/${appService}/client/cli/query.go
  sed -i '' "s;$1;$2;g" ${appHome}/${appPath}/x/${appService}/client/cli/tx.go
  sed -i '' "s;$1;$2;g" ${appHome}/${appPath}/x/${appService}/client/rest/rest.go
  sed -i '' "s;$1;$2;g" ${appHome}/${appPath}/cmd/${appCli}/main.go
  sed -i '' "s;$1;$2;g" ${appHome}/${appPath}/cmd/${appD}/main.go
  sed -i '' "s;$1;$2;g" ${appHome}/${appPath}/app.go
  sed -i '' "s;$1;$2;g" ${appHome}/${appPath}/go.mod
  sed -i '' "s;$1;$2;g" ${appHome}/${appPath}/go.sum
  sed -i '' "s;$1;$2;g" ${appHome}/${appPath}/Makefile
}


while true; do

  echo "Where would you like to build your app? (Github user name):"
  read appPathStub

  result=$(echo ${appPathStub} | grep "^[0-9|a-z|A-Z|\.|-]\{1,20\}$")
  if [[ "${result}" == ""  ]]
  then
      echo "Should only contain 3~20 alphanumeric characters or '-', please try again"
      continue
  fi


  echo "What would you like to call your App?"
  read appName

  appPath=${appPathStub}/${appName}
  echo "Your application path is $appPath"

  echo "path is: ${appHome}/${appPath}"
  mkdir -p ${appHome}/${appPath}
  git clone "$repo" "${appHome}/${appPath}"

  appService="${appName}service"
  echo "service: $appService"

  cp -r ${appHome}/${appPath}/x/nameservice ${appHome}/${appPath}/x/${appService}
  cp -r ${appHome}/${appPath}/cmd/nsd ${appHome}/${appPath}/cmd/${appD}
  cp -r ${appHome}/${appPath}/cmd/nscli ${appHome}/${appPath}/cmd/${appCli}
  rm -r ${appHome}/${appPath}/x/nameservice
  rm -r ${appHome}/${appPath}/cmd/nscli
  rm -r ${appHome}/${appPath}/cmd/nsd
  echo "folders updated"

  rename nameservice $appService
  rename Nameservice $appService
  rename namesvc ${appName}svc
  rename nameServiceApp ${appName}ServiceApp
  rename NewNameServiceApp New${AppName}ServiceApp
  echo "app updated"

  rename nsd ${appD}
  rename nscli ${appCli}
  rename '"NS",' ${ABBV}
  rename '("ns")' ${abbv}
  rename nsclient ${abbvs}client
  rename nsrest ${abbvs}rest
  rename storeNS store${ABBVs}
  rename keyNS key${ABBVs}
  rename nsKeeper ${abbvs}Keeper
  rename nametoken ${token}
  echo "services updated"

  rename whois ${type}
  rename Whois ${Type}
  rename name ${typename}
  rename Name ${TypeName}
  rename Module${TypeName} ModuleName
  rename ' CmName() ' ' Name() '
  echo "types updated"

  rename 'cosmos/sdk-application-tutorial' 'jpthor/test'

  echo "replace github.com/jpthor/test => ../test" >> ${appHome}/${appPath}/go.mod
  echo "makefile updated"

  break

done
