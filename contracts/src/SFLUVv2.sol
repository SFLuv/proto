pragma solidity <=0.8.19;

import "@openzeppelin-upgradeable/contracts/access/extensions/AccessControlDefaultAdminRulesUpgradeable.sol";
import "@openzeppelin-upgradeable/contracts/token/ERC20/extensions/ERC20WrapperUpgradeable.sol";

contract SFLUVv2 is ERC20WrapperUpgradeable, AccessControlDefaultAdminRulesUpgradeable {

    uint48 constant private initialDelay = 60 * 60 * 24 * 7; // 7 days?

    constructor(IERC20 underlyingToken)
        ERC20WrapperUpgradeable(underlyingToken)
        ERC20Upgradeable("SFLUV V2.0", "SFLUV")
        AccessControlDefaultAdminRulesUpgradeable(initialDelay, msg.sender) {}

//    function decimals() public pure override(ERC20, ERC20Wrapper) returns (uint8) {
//        return 6; // could get this dynamically from the underlying token, but the current target only is USDC so...
//    }

    // this role allows the holder to mint (wrap) underlying USDC into SFLUV
    bytes32 public constant MINTER_ROLE = keccak256("MINTER");

    function depositFor(address account, uint256 amount) public override returns (bool) {
        require(hasRole(MINTER_ROLE, _msgSender()));
        return ERC20WrapperUpgradeable.depositFor(account, amount);
    }

}
