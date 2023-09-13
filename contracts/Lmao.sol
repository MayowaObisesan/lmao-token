// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract LMAO is ERC20, Ownable {
    constructor() ERC20("LMAOToken", "LTK") {
        _mint(msg.sender, 1000 * 10 ** decimals()); // mint 1000 ethers token to owner
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual override {
        uint tax = (amount * 8) / 100;
        uint afterTax = amount - tax;
        super._transfer(from, to, afterTax);
        super._transfer(from, msg.sender, tax);
    }

    fallback() external payable {}

    receive() external payable {}
}
