// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Marketplace {
    address public owner;
    uint256 public price = 0.01 ether;

    constructor() {
        owner = msg.sender;
    }

    function buy() public payable {
        require(msg.value == price, "Send exactly 0.01 ETH");
        payable(owner).transfer(msg.value); // Transfer ETH to the owner
    }
}
