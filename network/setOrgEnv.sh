#!/bin/bash
#
# SPDX-License-Identifier: Apache-2.0




# default to using docorg
ORG=${1:-docorg}

# Exit on first error, print all commands.
set -e
set -o pipefail

# Where am I?
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

ORDERER_CA=${DIR}/network/organizations/ordererOrganizations/doctor.com/tlsca/tlsca.doctor.com-cert.pem
PEER0_DOCORG_CA=${DIR}/network/organizations/peerOrganizations/docorg.doctor.com/tlsca/tlsca.docorg.doctor.com-cert.pem


if [[ ${ORG,,} == "docorg" ]; then

   CORE_PEER_LOCALMSPID=DocOrgMSP
   CORE_PEER_MSPCONFIGPATH=${DIR}/network/organizations/peerOrganizations/docorg.doctor.com/users/Admin@docorg.doctor.com/msp
   CORE_PEER_ADDRESS=localhost:${PEER_PORT}
   CORE_PEER_TLS_ROOTCERT_FILE=${DIR}/network/organizations/peerOrganizations/docorg.doctor.com/tlsca/tlsca.docorg.doctor.com-cert.pem

else
   echo "Unknown \"$ORG\", please choose docorg/Digibank or DocOrg2/Magnetocorp"
   echo
   exit 1
fi

# output the variables that need to be set
echo "CORE_PEER_TLS_ENABLED=true"
echo "ORDERER_CA=${ORDERER_CA}"
echo "PEER0_DOCORG_CA=${PEER0_DOCORG_CA}"

echo "CORE_PEER_MSPCONFIGPATH=${CORE_PEER_MSPCONFIGPATH}"
echo "CORE_PEER_ADDRESS=${CORE_PEER_ADDRESS}"
echo "CORE_PEER_TLS_ROOTCERT_FILE=${CORE_PEER_TLS_ROOTCERT_FILE}"

echo "CORE_PEER_LOCALMSPID=${CORE_PEER_LOCALMSPID}"
