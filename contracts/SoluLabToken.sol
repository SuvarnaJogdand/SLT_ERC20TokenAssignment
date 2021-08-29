//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/token/ERC20/presets/ERC20PresetMinterPauser.sol";

contract SoluLabToken is ERC20PresetMinterPauser,ERC20Capped
 {
constructor(string memory name_, string memory symbol_, uint256 cap_) 
        ERC20Capped(cap_)  
        ERC20PresetMinterPauser(name_, symbol_)
        public
    {
        //_mint(msg.sender, 100000000 * 10 ** decimals());
       // _mint(msg.sender, cap_);
    }


    function _mint(address account, uint256 amount) internal  override(ERC20Capped,ERC20) {
       //require(ERC20.totalSupply() + amount <= cap(), "SoluLabToken: cap exceeded");
        super._mint(account, amount);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal override(ERC20, ERC20PresetMinterPauser) {
        super._beforeTokenTransfer(from, to, amount);
    }

}