// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract WLMAO is ERC20 {
    address immutable LMAO_ADDRESS;

    constructor(address _LMAO) ERC20("WLMAOToken", "WLTK") {
        LMAO_ADDRESS = _LMAO;
    }

    function deposit(uint _amount) external {
        IERC20(LMAO_ADDRESS).transferFrom(msg.sender, address(this), _amount);
        // Mint only 92% of the token.
        uint taxedAmount = (_amount * 92) / 100;
        // _mint(msg.sender, taxedAmount);
    }

    function withdraw(uint _amount) external {
        require(balanceOf(msg.sender) >= _amount, "Insufficient balance");
        IERC20(LMAO_ADDRESS).transfer(msg.sender, _amount);
        _burn(msg.sender, _amount);
    }

    fallback() external payable {}

    receive() external payable {}
}
