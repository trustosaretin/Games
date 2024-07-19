## PYTH ORACLE PRICE FEED

- **testnet-coredoa**: https://rpc.test.btcs.network

## PYTH DOCUMENTATION

**PYTH DOCS**:https://docs.pyth.network/price-feeds/use-real-time-data/evm

## Setting Up and Deploying

```sh
# To build the project and install missing dependency
forge build
# Add RPC
export RPC_URL=https://rpc.test.btcs.network
# ADD PrivateKey
export PRIVATE_KEY=YOUR_PRIVATE_KEY
# To deploy the project
forge script script/PriceFeed.s.sol --rpc-url $RPC_URL --private-key $PRIVATE_KEY --broadcast --legacy
```

## Deployed Addresses

- _Peer Token `0x17975FB494576ae89D627F904Ec723B87c7C35c8`_
- _Price Feed `0x1C9f974DF781C6EB3764F21Fe961ba38305213df`_
