pragma solidity ^0.8.20;

import { Script, console2 } from "forge-std/Script.sol";
import {MockCoin} from "../src/MockCoin.sol";
import {SFLUVv1} from "../src/SFLUVv1.sol";
import "../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

contract DeployTest is Script {
    function run() public virtual {
        vm.startBroadcast();

        address mockCoin = address(new MockCoin());
        console2.log("Mock coin deployed at: %s", address(mockCoin));

        address luvTest = address(new SFLUVv1(IERC20(mockCoin)));
        console2.log("Test SFLuv deployed at: %s", address(luvTest));
    }
}
