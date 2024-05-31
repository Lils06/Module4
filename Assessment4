// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract LilsToken is ERC20 {
    address public showowner;

    constructor(uint256 initialSupply) ERC20("DEGEN", "DGN") {
        showowner = msg.sender;
        _mint(msg.sender, initialSupply);
    }

    function mint(address to, uint256 amount) public {
        require(msg.sender == showowner, "You're not the owner");
        _mint(to, amount);
    }

    function redeem(address from, uint256 amount) public {
        require(msg.sender == showowner, "You're not the owner");
        _burn(from, amount);
    }

    function transfer(address to, uint256 amount) public virtual override returns (bool) {
        _transfer(_msgSender(), to, amount);
        return true;
    }
    
    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }
}
