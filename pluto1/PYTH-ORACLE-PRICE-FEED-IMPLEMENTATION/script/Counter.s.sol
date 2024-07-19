// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {PriceFeed} from "../src/PriceFeed.sol";
import {PeerToken} from "../src/PeerToken.sol";

contract CounterScript is Script {
    PriceFeed pricefeed;
    PeerToken peerToken;

    address [] tokens;
    bytes32 [] pricefeedIds;
    address pythcontractAddress = 0x8D254a21b3C86D32F7179855531CE99164721933;
   bytes32 DIA_USD = 0xb0948a5e5313200c632b51bb5ca32f6de0d36e9950a942d19751e833f70dabfd;
   bytes32 LINK_USD = 0x8ac0c70fff57e9aefdf5edf44b51d62c2d433653cbb2cf5cc06bb115af04d221;

   address DIA_CONTRACT_ADDRESS = 0x0349627072145AF3211C9b43C0f12b31CdbF9467;
   address LINK_CONTRACT_ADDRESS = 0x03c3c46b45155a7c70182D2Da4CFa7536DD95628;


    function setUp() public {
        tokens.push(DIA_CONTRACT_ADDRESS);
        tokens.push(LINK_CONTRACT_ADDRESS);

        pricefeedIds.push(DIA_USD);
        pricefeedIds.push(LINK_USD);
    }

     function run() public {
        vm.startBroadcast();
        peerToken = new PeerToken(msg.sender);
        pricefeed = new PriceFeed(pythcontractAddress, pricefeedIds, tokens);


        console.log("$PEER address", address(peerToken));
        console.log("Pricefeed address", address(pricefeed));

         pricefeed.addLoanableToken(
            address(peerToken),
            DIA_USD
        );
        console.log("Loanable Token Added");

        vm.stopBroadcast();
    }
}

