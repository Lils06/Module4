// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Ownable {
    address public Lils;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor() {
        Lils = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == Lils, "Ownable: caller is not the owner");
        _;
    }

    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(Lils, newOwner);
        Lils = newOwner;
    }
}
