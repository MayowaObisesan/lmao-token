// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
// ERC20 has to value "name,symbol";

contract Lmao is ERC20 ("DY","DD"){
    address owner;// set a state var
    
    constructor(){
        owner =  msg.sender;// assig owner to msg.sender
        _mint(owner, 10000e18);// mint to owner
    }

     function _transfer(address from, address to, uint256 amount) internal virtual override{
       uint fee = (8 * amount)/100;
       uint remainingbal = amount - fee;
       super._transfer(from,to,remainingbal);
       // to call parent func use super(inherit the main contract) 
       super._transfer(from,owner,fee);//transfer to the owner of the account.
        }


}


contract Wlmao is ERC20("DYPUMPING","dwd"){
    IERC20 LMAO;
    constructor(address _LMAO){
         LMAO = IERC20(_LMAO);
    }
    function depositLmao (uint _amount)public{
        LMAO.transferFrom(msg.sender, address(this), _amount);
        uint calculate = (92 * _amount)/100;
        _mint(msg.sender, calculate);
}

   function swapBack(uint _amount)public{
    require(balanceOf(msg.sender) >= _amount, "must be greater than amount");
    LMAO.transfer(msg.sender, _amount);
    _burn(msg.sender, _amount);
   }
}