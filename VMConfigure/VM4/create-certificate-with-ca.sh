function createOrdererCertificate {

  echo
	echo "Enroll the CA admin"
  echo
	mkdir -p organizations/ordererOrganizations/example.com/

	export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/ordererOrganizations/example.com/

  fabric-ca-client enroll -u https://admin:adminpw@localhost:9054 --caname ca-orderer --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem
  
# which one has organization access
  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: orderer' > ${PWD}/organizations/ordererOrganizations/example.com/msp/config.yaml

# Register...
  echo
	echo "Register orderer1"
  echo
  
	fabric-ca-client register --caname ca-orderer --id.name orderer1 --id.secret orderer1pw --id.type orderer --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem
  
  echo
	echo "Register orderer2"
  echo
  
	fabric-ca-client register --caname ca-orderer --id.name orderer2 --id.secret orderer2pw --id.type orderer --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem


  echo
  echo "Register orderer3"
  echo
  
  fabric-ca-client register --caname ca-orderer --id.name orderer3 --id.secret orderer3pw --id.type orderer --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem
  

  echo
  echo "Register orderer admin"
  echo
  
  fabric-ca-client register --caname ca-orderer --id.name ordererAdmin --id.secret ordererAdminpw --id.type admin --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem
  
  # --------------------------------------------------------
  # dir creation
	mkdir -p organizations/ordererOrganizations/example.com/orderers

  # Enroll orderer1
  echo
  echo "## Generate the orderer1 msp"
  echo
  
	fabric-ca-client enroll -u https://orderer1:orderer1pw@localhost:9054 --caname ca-orderer -M ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer1.example.com/msp --csr.hosts orderer1.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem
  # transfering configfile to orderer1 msp
  cp ${PWD}/organizations/ordererOrganizations/example.com/msp/config.yaml ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer1.example.com/msp/config.yaml

  echo
  echo "## Generate the orderer1-tls certificates"
  echo
  
  fabric-ca-client enroll -u https://orderer1:orderer1pw@localhost:9054 --caname  ca-orderer  -M ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer1.example.com/tls --enrollment.profile tls --csr.hosts orderer1.example.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem
  
  cp ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer1.example.com/tls/tlscacerts/* ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer1.example.com/tls/ca.crt
  cp ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer1.example.com/tls/signcerts/* ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer1.example.com/tls/server.crt
  # {NotWorking} cp ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer1.example.com/tls/keystore/* ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer1.example.com/tls/server.key 

  mkdir ${PWD}/organizations/ordererOrganizations/example.com/msp/tlscacerts
  cp ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer1.example.com/tls/tlscacerts/* ${PWD}/organizations/ordererOrganizations/example.com/msp/tlscacerts/ca.crt

  mkdir ${PWD}/organizations/ordererOrganizations/example.com/tlsca
  cp ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer1.example.com/tls/tlscacerts/* ${PWD}/organizations/ordererOrganizations/example.com/tlsca/tlsca.example.com-cert.pem

  mkdir ${PWD}/organizations/ordererOrganizations/example.com/ca
  cp ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer1.example.com/msp/cacerts/* ${PWD}/organizations/ordererOrganizations/example.com/ca/ca.example.com-cert.pem


# ----------------------------------------------------------------------------------------
  # Enroll orderer2
  echo
  echo "## Generate the orderer2 msp"
  echo
  
	fabric-ca-client enroll -u https://orderer2:orderer2pw@localhost:9054 --caname ca-orderer -M ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer2.example.com/msp --csr.hosts orderer2.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem
  # transfering configfile to orderer2 msp
  cp ${PWD}/organizations/ordererOrganizations/example.com/msp/config.yaml ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer2.example.com/msp/config.yaml

  echo
  echo "## Generate the orderer2-tls certificates"
  echo
  
  fabric-ca-client enroll -u https://orderer2:orderer2pw@localhost:9054 --caname  ca-orderer  -M ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer2.example.com/tls --enrollment.profile tls --csr.hosts orderer2.example.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem
  
  cp ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/tlscacerts/* ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/ca.crt
  cp ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/signcerts/* ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/server.crt
  # {NotWorking} cp ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/keystore/* ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/server.key 

  cp ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/tlscacerts/* ${PWD}/organizations/ordererOrganizations/example.com/msp/tlscacerts/ca.crt
  cp ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/tlscacerts/* ${PWD}/organizations/ordererOrganizations/example.com/tlsca/tlsca.example.com-cert.pem
  cp ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer2.example.com/msp/cacerts/* ${PWD}/organizations/ordererOrganizations/example.com/ca/ca.example.com-cert.pem


# ----------------------------------------------------------------------------------------
  # Enroll orderer3
  echo
  echo "## Generate the orderer3 msp"
  echo
  
	fabric-ca-client enroll -u https://orderer3:orderer3pw@localhost:9054 --caname ca-orderer -M ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer3.example.com/msp --csr.hosts orderer3.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem
  # transfering configfile to orderer3 msp
  cp ${PWD}/organizations/ordererOrganizations/example.com/msp/config.yaml ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer3.example.com/msp/config.yaml

  echo
  echo "## Generate the orderer3-tls certificates"
  echo
  
  fabric-ca-client enroll -u https://orderer3:orderer3pw@localhost:9054 --caname  ca-orderer  -M ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer3.example.com/tls --enrollment.profile tls --csr.hosts orderer3.example.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem
  
  cp ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer3.example.com/tls/tlscacerts/* ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer3.example.com/tls/ca.crt
  cp ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer3.example.com/tls/signcerts/* ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer3.example.com/tls/server.crt
  # {NotWorking} cp ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer3.example.com/tls/keystore/* ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer3.example.com/tls/server.key 

  cp ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer3.example.com/tls/tlscacerts/* ${PWD}/organizations/ordererOrganizations/example.com/msp/tlscacerts/ca.crt
  cp ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer3.example.com/tls/tlscacerts/* ${PWD}/organizations/ordererOrganizations/example.com/tlsca/tlsca.example.com-cert.pem
  cp ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer3.example.com/msp/cacerts/* ${PWD}/organizations/ordererOrganizations/example.com/ca/ca.example.com-cert.pem


# ----------------------------------------------------------------------------------------
  # Enroll admin orderer

  echo
  echo "## Generate the orderer admin msp"
  echo
  
  # dir Creation
  mkdir -p organizations/ordererOrganizations/example.com/users
  mkdir -p organizations/ordererOrganizations/example.com/users/Admin@example.com
  
	fabric-ca-client enroll -u https://ordererAdmin:ordererAdminpw@localhost:9054 --caname  ca-orderer  -M ${PWD}/organizations/ordererOrganizations/example.com/users/Admin@example.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/organizations/ordererOrganizations/example.com/msp/config.yaml ${PWD}/organizations/ordererOrganizations/example.com/users/Admin@example.com/msp/config.yaml

}


createOrdererCertificate


# Required Permission to exec above instruction
# sudo chmod -R 777 organizations