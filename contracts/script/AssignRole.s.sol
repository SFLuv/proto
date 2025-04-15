// Script assign_role.sh
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/SFLUVv1.sol";

contract AssignRoleScript {
    address public contractAddress;
    bytes32 public roleToGrant;
    address public accountToGrant;

    function run() public {
        contractAddress = 0x9757FEeFbC609077d762992fe579c1E46f066BeB; // Replace with your contract's address
        roleToGrant = keccak256("MINTER"); // Define your role
        accountToGrant = 0x6F8622eA38398C2A6579aBCD278897101aDc7bCd; // Replace with the address you want to grant the role to

        SFLUVv1 con = SFLUVv1(contractAddress);
        // Ensure the caller has the required role to grant roles
        bytes32 adminRole = con.DEFAULT_ADMIN_ROLE();
        require(con.hasRole(adminRole, msg.sender), "Caller is not an admin");

        con.grantRole(roleToGrant, accountToGrant);
    }
}

// forge script --private-key 6bb398da346c963b231abd9b6bd626f73a75060822504213495d53b3b11e3187 --rpc-url http://127.0.0.1:8545 script/AssignRole.s.sol