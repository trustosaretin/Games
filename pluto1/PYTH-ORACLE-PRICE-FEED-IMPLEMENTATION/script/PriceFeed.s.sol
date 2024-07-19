// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {PriceFeed} from "../src/PriceFeed.sol";
import {PeerToken} from "../src/PeerToken.sol";

contract PriceFeedScript is Script {
    bytes32[] priceFeeds;
    address[] tokens;

    function run() public {
        vm.startBroadcast();
        PeerToken peer = new PeerToken(msg.sender);
        PriceFeed feed = new PriceFeed(
            0xA2aa501b19aff244D90cc15a4Cf739D2725B5729,
            priceFeeds,
            tokens
        );

        console.log("Peer Token deployed at address: ", address(peer));
        console.log("PriceFeed deployed at address: ", address(feed));
        vm.stopBroadcast();
    }
}
