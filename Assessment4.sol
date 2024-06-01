// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract LilsToken is ERC20 {
    address public showowner;
    
    struct Item {
        uint256 itemId;
        string itemName;
    }

    mapping(address => Item[]) private redeemedItems;
    uint256 public nextItemId;

    event ItemRedeemed(address indexed player, uint256 itemId, string itemName);

    constructor(uint256 initialSupply) ERC20("DEGEN", "DGN") {
        showowner = msg.sender;
        _mint(msg.sender, initialSupply);
        nextItemId = 1;
    }

    function mint(address to, uint256 amount) public {
        require(msg.sender == showowner, "You're not the owner");
        _mint(to, amount);
    }

    function redeem( address account, uint256 amount, string memory itemName) public {
        require(balanceOf(account)>=amount, "You don't have enough balance");
        _burn(account,  amount);
        
        Item memory newItem = Item({
            itemId: nextItemId,
            itemName: itemName
        });
        
        redeemedItems[account].push(newItem);
        emit ItemRedeemed(account, nextItemId, itemName);
        
        nextItemId++;
    }

    function transfer(address to, uint256 amount) public virtual override returns (bool) {
        _transfer(_msgSender(), to, amount);
        return true;
    }
    
    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    function redeemHistory(address player) public view returns (Item[] memory) {
        return redeemedItems[player];
    }
}
