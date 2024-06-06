// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract LilsToken is ERC20 {
    address public contractOwner;
    
    struct Item {
        uint256 id;
        string name;
    }

    mapping(address => Item[]) private  playerItems;
    uint256 private itemIdCounter;

    event ItemRedeemed(address indexed player, uint256 itemId, string itemName);

    constructor(uint256 initialSupply) ERC20("DEGEN", "DGN") {
        contractOwner = msg.sender;
        _mint(msg.sender, initialSupply);
        itemIdCounter = 1;
    }

    modifier onlyOwner() {
        require(msg.sender == contractOwner, "Caller is not the owner");
        _;
    }

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    function redeemTokens(address account, uint256 amount, string memory itemName) external {
        require(balanceOf(account) >= amount, "Insufficient token balance");
        _burn(account, amount);
        
        Item memory newItem = Item({
            id: itemIdCounter,
            name: itemName
        });
        
        playerItems[account].push(newItem);
        emit ItemRedeemed(account, itemIdCounter, itemName);
        
        itemIdCounter++;
    }

    function getRedemptionHistory(address player) external view returns (Item[] memory) {
        return playerItems[player];
    }

    function burnTokens(uint256 amount) external {
        _burn(msg.sender, amount);
    }

    function transferTokens(address to, uint256 amount) external returns (bool) {
        _transfer(msg.sender, to, amount);
        return true;
    }
}
