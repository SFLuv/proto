# Clean Install of SFLuv Local Development Environment

# Overview

In this example we are going to be setting up a local blockchain with MockCoin (representing the underlying stablecoin) and SFLuv contracts.

Then we will set up the following accounts:
* An account to mint SFLuv representing the company wallet
* An account representing a volunteer that receives SFLuv
* An account representing a merchant who received SFLuv from the volunteer

## Install Foundry

https://book.getfoundry.sh/getting-started/installation

Note that on my machine the Foundry setup script appended to paths in ~/.bashrc so I have to `source ~/.bashrc` to get command lines to work

## Get latest SFLuv Proto code

`git clone https://github.com/SFLuv/proto.git`

## Start local chain

`anvil --hardfork cancun --chain-id 1337`

Note that when Anvil is started it will print 10 "Available Accounts" and "Private Keys". Take note of the first account and private key ("0") you will need it later for FAUCET_ACCOUNT and FAUCET_ACCOUNT_PKEY

## You Need Multiple Keypairs

export FAUCET_ACCOUNT=0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
export FAUCET_ACCOUNT_PKEY=0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

export SFLUV_CONTRACT_PKEY=0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

export SFLUV_WALLET=0x126B8C0Ce22e3c85e47bE16532f8DB276A4A9000
export SFLUV_WALLET_PKEY=0xd1b9ce652a31151f22c1f0900a01f13340cd375da1a98d2729261559baecd34e

export VOLUNTEER_WALLET=0x4c783440D63c7943D31Eab63e4381fFBb7E71942
export VOLUNTEER_WALLET_PKEY=0x2413056454e962339d235f2a89ec9939fe75dfb08a10c6c57e81890ca5103d81

## Deploy SFLuv and Mock coins

`forge script script/DeployTest.s.sol --broadcast --fork-url http://localhost:8545 --private-key $SFLUV_PKEY`

You should see output like:

```
##### dev
✅  [Success] Hash: 0x1f429d8321a578ab031069b3d204f01929318fc7d4831982ec3f68a586530774
Contract Address: 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512
Block: 2
Paid: 0.003989498912889534 ETH (4499538 gas * 0.886646343 gwei)


##### dev
✅  [Success] Hash: 0xbe26d8d8cdd58cbc6ed061a3fef2577798343f2a4e2d0236052f4cb6a9c1f62b
Contract Address: 0x5FbDB2315678afecb367f032d93F642f64180aa3
Block: 1
Paid: 0.001397561001397561 ETH (1397561 gas * 1.000000001 gwei)
```

Mock coin was deployed at 0x5FbDB2315678afecb367f032d93F642f64180aa3
Test SFLuv was deployed at 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512

# Assign Minter role to SFLuv Wallet

`forge script script/AssignRole.s.sol --broadcast --fork-url http://localhost:8545 --private-key $SFLUV_CONTRACT_PKEY --sig "run(address)" $SFLUV_WALLET`

# Send MockCoin to SFLub Wallet

`cast send --private-key $SFLUV_CONTRACT_PKEY 0x5FbDB2315678afecb367f032d93F642f64180aa3 "mint(address,uint256)" $SFLUV_WALLET 1000000000`

# Check MockCoin balance

`cast call 0x5FbDB2315678afecb367f032d93F642f64180aa3 "balanceOf(address)" $SFLUV_WALLET`

# Send ETH from Faucet account

`cast send --private-key $FAUCET_ACCOUNT_PKEY 0xD76b5c2A23ef78368d8E34288B5b65D616B746aE "deposit(address,uint256)" $SFLUV_WALLET 1ether`
`cast call 0xD76b5c2A23ef78368d8E34288B5b65D616B746aE "balanceOf(address)" $SFLUV_WALLET`

# Mint SFLuv to SFLuv Wallet

`forge script script/MintLuv.s.sol --broadcast --fork-url http://localhost:8545 --private-key $SFLUV_WALLET_PKEY --sig "run(address,uint256)" $VOLUNTEER_WALLET 1000000`