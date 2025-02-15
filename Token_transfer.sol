// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract EduTransfer {
    IERC20 public eduToken;

    constructor(address _eduToken) {
        eduToken = IERC20(_eduToken);
    }

    function sendEdu(address to, uint256 amount) public {
        require(eduToken.transferFrom(msg.sender, to, amount), "Transfer failed");
    }
}
