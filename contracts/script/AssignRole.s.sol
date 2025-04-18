// Script assign_role.sh
// SPDX-License-Identifier: MIT
pragma solidity <=0.8.19;

import { Script, console2 } from "forge-std/Script.sol";
import "../src/SFLUVv1.sol";

contract AssignRoleScript is Script {
    address public contractAddress;
    bytes32 public roleToGrant;
    address public accountToGrant;

    function run() public {
        vm.startBroadcast();

        contractAddress = 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512; // Deployed SFLuv
        roleToGrant = keccak256("MINTER"); // Define your role
        accountToGrant = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8; // Anvil account 1

        SFLUVv1 con = SFLUVv1(contractAddress);
        // Ensure the caller has the required role to grant roles
        bytes32 adminRole = con.DEFAULT_ADMIN_ROLE();
        require(con.hasRole(adminRole, msg.sender), "Caller is not an admin");

        if (con.hasRole(roleToGrant, accountToGrant)) {
            console2.log("Account %s already has role", accountToGrant);
        } else {
            con.grantRole(roleToGrant, accountToGrant);
            console2.log("Granted role to account %s",address(accountToGrant));
        }
    }
}

// forge script --private-key 6bb398da346c963b231abd9b6bd626f73a75060822504213495d53b3b11e3187 --rpc-url http://127.0.0.1:8545 script/AssignRole.s.sol