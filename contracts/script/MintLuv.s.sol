pragma solidity ^0.8.20;

import { Script, console2 } from "forge-std/Script.sol";
import {SFLUVv1} from "../src/SFLUVv1.sol";
import "../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

// Mock coin deployed at: 0x5FbDB2315678afecb367f032d93F642f64180aa3
// Test SFLuv deployed at: 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512
address constant BASE_COIN_ADDRESS = 0x5FbDB2315678afecb367f032d93F642f64180aa3;
address constant SFLUV_ADDRESS = 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512;

address constant TO_ADDRESS = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8;
uint256 constant TO_AMT = 1000000;

contract MintLuv is Script {
    function run() public virtual {
        vm.startBroadcast();

        IERC20 base = IERC20(BASE_COIN_ADDRESS);
        SFLUVv1 luv = SFLUVv1(SFLUV_ADDRESS);

        require(luv.hasRole(keccak256("MINTER"), msg.sender), "Caller is not a minter");

        base.approve(SFLUV_ADDRESS, TO_AMT);
        luv.depositFor(TO_ADDRESS, TO_AMT);
        // console2.log("Test SFLuv deployed at: %s", address(luvTest));
    }
}
