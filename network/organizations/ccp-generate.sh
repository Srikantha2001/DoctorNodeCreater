#!/bin/bash

function one_line_pem {
    echo "`awk 'NF {sub(/\\n/, ""); printf "%s\\\\\\\n",$0;}' $1`"
}

function json_ccp {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${PPORT}/$2/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        -e "s/\${PEER_NUMBER}/$6/" \
        organizations/ccp-template.json
}

function yaml_ccp {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${PPORT}/$2/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        organizations/ccp-template.yaml | sed -e $'s/\\\\n/\\\n          /g'
}

ORG="docorg"
PPORT=${PEER_PORT}
CAPORT=7054
PEERPEM=organizations/peerOrganizations/docorg.doctor.com/tlsca/tlsca.docorg.doctor.com-cert.pem
CAPEM=organizations/peerOrganizations/docorg.doctor.com/ca/ca.docorg.doctor.com-cert.pem
PEERNUM=${PEER_NUMBER}

echo "$(json_ccp $ORG $PPORT $CAPORT $PEERPEM $CAPEM $PEERNUM)" > organizations/peerOrganizations/docorg.doctor.com/connection-docorg.json
echo "$(yaml_ccp $ORG $PPORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/docorg.doctor.com/connection-docorg.yaml
