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

contract WLMAO is ERC20 {
    address immutable LMAO_ADDRESS;

    constructor(address _LMAO) ERC20("WLMAOToken", "WLTK") {
        LMAO_ADDRESS = _LMAO;
    }

    function deposit(uint _amount) external {
        IERC20(LMAO_ADDRESS).transferFrom(msg.sender, address(this), _amount);
        // Mint only 92% of the token.
        uint taxedAmount = (_amount * 92) / 100;
        _mint(msg.sender, taxedAmount);
    }

    function withdraw(uint _amount) external {
        require(balanceOf(msg.sender) >= _amount, "Insufficient balance");
        IERC20(LMAO_ADDRESS).transfer(msg.sender, _amount);
        _burn(msg.sender, _amount);
    }

    fallback() external payable {}

    receive() external payable {}
}

/*
contract Lmao is ERC20("DY", "DD") {
    address owner; // set a state var

    constructor() {
        owner = msg.sender; // assig owner to msg.sender
        _mint(owner, 10000e18); // mint to owner
    }

    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual override {
        uint fee = (8 * amount) / 100;
        uint remainingbal = amount - fee;
        super._transfer(from, to, remainingbal);
        // to call parent func use super(inherit the main contract)
        super._transfer(from, owner, fee); //transfer to the owner of the account.
    }
}

contract Wlmao is ERC20("DYPUMPING", "dwd") {
    IERC20 LMAO;

    constructor(address _LMAO) {
        LMAO = IERC20(_LMAO);
    }

    function depositLmao(uint _amount) public {
        LMAO.transferFrom(msg.sender, address(this), _amount);
        uint calculate = (92 * _amount) / 100;
        _mint(msg.sender, calculate);
    }

    function swapBack(uint _amount) public {
        require(
            balanceOf(msg.sender) >= _amount,
            "must be greater than amount"
        );
        LMAO.transfer(msg.sender, _amount);
        _burn(msg.sender, _amount);
    }
}
*/
