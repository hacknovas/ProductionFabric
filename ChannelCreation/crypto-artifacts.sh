
SYS_CHANNEL="Sys_channel"

ChannelName="mychannel"

echo $ChannelName

# System Genesis Block
configtxgen -profile OrdererGenesis -configPath . -channelId $SYS_CHANNEL -outputBlock ./genesis.block
            
# Channel Configuration block
configtxgen -profile BasicChannel -configPath . -channelID $ChannelName -outputCreateChannelTx ./mychannel.tx 

# AnchorPeerTx
configtxgen -profile BasicChannel -configPath . -outputAnchorPeersUpdate ./Org1MSPAnchor.tx -channelId $ChannelName -asOrg Org1
configtxgen -profile BasicChannel -configPath . -outputAnchorPeersUpdate ./Org2MSPAnchor.tx -channelId $ChannelName -asOrg Org2
configtxgen -profile BasicChannel -configPath . -outputAnchorPeersUpdate ./Org3MSPAnchor.tx -channelId $ChannelName -asOrg Org3

# https://medium.com/@gregshen0925/hyperledger-fabric-tools-2-40d923e6876b