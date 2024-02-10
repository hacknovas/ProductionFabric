function createorg3 {

  echo
	echo "Enroll the CA admin"
  echo
	mkdir -p organizations/peerOrganizations/org3.example.com/

	export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/org3.example.com/

  
  fabric-ca-client enroll -u https://admin:adminpw@localhost:10054 --caname ca-org3 --tls.certfiles ${PWD}/organizations/fabric-ca/org3/tls-cert.pem
  
# which one has organization access
  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-10054-ca-ogr3.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-10054-ca-ogr3.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-10054-ca-ogr3.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-10054-ca-ogr3.pem
    OrganizationalUnitIdentifier: orderer' > ${PWD}/organizations/peerOrganizations/org3.example.com/msp/config.yaml

# Register...
  echo
	echo "Register peer0"
  echo
  
	fabric-ca-client register --caname ca-org3 --id.name peer0 --id.secret peer0pw --id.type peer --id.attrs '"hf.Registrar.Roles=peer"' --tls.certfiles ${PWD}/organizations/fabric-ca/org3/tls-cert.pem
  
  echo
	echo "Register peer1"
  echo
  
	fabric-ca-client register --caname ca-org3 --id.name peer1 --id.secret peer1pw --id.type peer --id.attrs '"hf.Registrar.Roles=peer"' --tls.certfiles ${PWD}/organizations/fabric-ca/org3/tls-cert.pem


  echo
  echo "Register user"
  echo
  
  fabric-ca-client register --caname ca-org3 --id.name user1 --id.secret user1pw --id.type client --id.attrs '"hf.Registrar.Roles=client"' --tls.certfiles ${PWD}/organizations/fabric-ca/org3/tls-cert.pem
  

  echo
  echo "Register the org admin"
  echo
  
  fabric-ca-client register --caname ca-org3 --id.name org3admin --id.secret org3adminpw --id.type admin --id.attrs '"hf.Registrar.Roles=admin"' --tls.certfiles ${PWD}/organizations/fabric-ca/org3/tls-cert.pem
  
  # dir creation
	mkdir -p organizations/peerOrganizations/org3.example.com/peers
  mkdir -p organizations/peerOrganizations/org3.example.com/peers/peer0.org3.example.com

# Enroll peer0
  echo
  echo "## Generate the peer0 msp"
  echo
  
	fabric-ca-client enroll -u https://peer0:peer0pw@localhost:10054 --caname ca-org3 -M ${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer0.org3.example.com/msp --csr.hosts peer0.org3.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/org3/tls-cert.pem
  # transfering configfile to peer0 msp
  cp ${PWD}/organizations/peerOrganizations/org3.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer0.org3.example.com/msp/config.yaml

  echo
  echo "## Generate the peer0-tls certificates"
  echo
  
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:10054 --caname ca-org3 -M ${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer0.org3.example.com/tls --enrollment.profile tls --csr.hosts peer0.org3.example.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/org3/tls-cert.pem
  
  cp ${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer0.org3.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer0.org3.example.com/tls/ca.crt
  cp ${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer0.org3.example.com/tls/signcerts/* ${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer0.org3.example.com/tls/server.crt
  # {NotWorking} cp ${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer0.org3.example.com/tls/keystore/* ${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer0.org3.example.com/tls/server.key 

  mkdir ${PWD}/organizations/peerOrganizations/org3.example.com/msp/tlscacerts
  cp ${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer0.org3.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/org3.example.com/msp/tlscacerts/ca.crt

  mkdir ${PWD}/organizations/peerOrganizations/org3.example.com/tlsca
  cp ${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer0.org3.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/org3.example.com/tlsca/tlsca.org3.example.com-cert.pem

  mkdir ${PWD}/organizations/peerOrganizations/org3.example.com/ca
  cp ${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer0.org3.example.com/msp/cacerts/* ${PWD}/organizations/peerOrganizations/org3.example.com/ca/ca.org3.example.com-cert.pem


# Enroll peer1
  echo
  echo "## Generate the peer1 msp"
  echo
  
	fabric-ca-client enroll -u https://peer1:peer1pw@localhost:10054 --caname ca-org3 -M ${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer1.org3.example.com/msp --csr.hosts peer1.org3.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/org3/tls-cert.pem
  
  cp ${PWD}/organizations/peerOrganizations/org3.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer1.org3.example.com/msp/config.yaml

  echo
  echo "## Generate the peer1-tls certificates"
  echo
  
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:10054 --caname ca-org3 -M ${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer1.org3.example.com/tls --enrollment.profile tls --csr.hosts peer1.org3.example.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/org3/tls-cert.pem
  
  cp ${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer1.org3.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer1.org3.example.com/tls/ca.crt
  cp ${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer1.org3.example.com/tls/signcerts/* ${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer1.org3.example.com/tls/server.crt
  # {Notworkin}# cp ${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer1.org3.example.com/tls/keystore/* ${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer1.org3.example.com/tls/server.key

  mkdir ${PWD}/organizations/peerOrganizations/org3.example.com/msp/tlscacerts
  cp ${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer1.org3.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/org3.example.com/msp/tlscacerts/ca.crt

  mkdir ${PWD}/organizations/peerOrganizations/org3.example.com/tlsca
  cp ${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer1.org3.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/org3.example.com/tlsca/tlsca.org3.example.com-cert.pem

  mkdir ${PWD}/organizations/peerOrganizations/org3.example.com/ca
  cp ${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer1.org3.example.com/msp/cacerts/* ${PWD}/organizations/peerOrganizations/org3.example.com/ca/ca.org3.example.com-cert.pem


# dir Creation
  mkdir -p organizations/peerOrganizations/org3.example.com/users
  mkdir -p organizations/peerOrganizations/org3.example.com/users/User1@org3.example.com
# 
  echo
  echo "## Generate the user msp"
  echo
  
	fabric-ca-client enroll -u https://user1:user1pw@localhost:10054 --caname ca-org3 -M ${PWD}/organizations/peerOrganizations/org3.example.com/users/User1@org3.example.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/org3/tls-cert.pem
  

  mkdir -p organizations/peerOrganizations/org3.example.com/users/Admin@org3.example.com

  echo
  echo "## Generate the org admin msp"
  echo
  
	fabric-ca-client enroll -u https://org3admin:org3adminpw@localhost:10054 --caname ca-org3 -M ${PWD}/organizations/peerOrganizations/org3.example.com/users/Admin@org3.example.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/org3/tls-cert.pem
  

  cp ${PWD}/organizations/peerOrganizations/org3.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/org3.example.com/users/Admin@org3.example.com/msp/config.yaml

}


createorg3


# Required Permission to exec above instruction
# sudo chmod -R 777 organizations