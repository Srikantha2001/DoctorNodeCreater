#!/bin/bash



# imports
. scripts/utils.sh


# ENV VARIABLES

export CORE_PEER_TLS_ENABLED=true
export ORDERER_CA=${PWD}/organizations/ordererOrganizations/doctor.com/tlsca/tlsca.doctor.com-cert.pem
export PEER0_DOCORG_CA=${PWD}/organizations/peerOrganizations/docorg.doctor.com/tlsca/tlsca.docorg.doctor.com-cert.pem
export ORDERER_ADMIN_TLS_SIGN_CERT=${PWD}/organizations/ordererOrganizations/doctor.com/orderers/orderer.doctor.com/tls/server.crt
export ORDERER_ADMIN_TLS_PRIVATE_KEY=${PWD}/organizations/ordererOrganizations/doctor.com/orderers/orderer.doctor.com/tls/server.key

# Set environment variables for the peer org
setGlobals0() {
  local USING_ORG=""
  if [ -z "$OVERRIDE_ORG" ]; then
    USING_ORG=$1
  else
    USING_ORG="${OVERRIDE_ORG}"
  fi
  infoln "Using organization ${USING_ORG}"
  if [ $USING_ORG = "docorg" ]; then
    export CORE_PEER_LOCALMSPID="DocOrgMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_DOCORG_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/docorg.doctor.com/users/Admin@docorg.doctor.com/msp
    export CORE_PEER_ADDRESS=localhost:${PEER_PORT}
  else
    errorln "ORG Unknown"
  fi

  if [ "$VERBOSE" == "true" ]; then
    env | grep CORE
  fi
}

setGlobalsCLI0() {
  setGlobals0 $1

  local USING_ORG=""
  if [ -z "$OVERRIDE_ORG" ]; then
    USING_ORG=$1
  else
    USING_ORG="${OVERRIDE_ORG}"
  fi
  if [ $USING_ORG = "docorg" ]; then
    export CORE_PEER_ADDRESS=peer${PEER_NUMBER}.docorg.doctor.com:${PEER_PORT}
  else
    errorln "ORG Unknown"
  fi
}


verifyResult() {
  if [ $1 -ne 0 ]; then
    fatalln "$2"
  fi
}
