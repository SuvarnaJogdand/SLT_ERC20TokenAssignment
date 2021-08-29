//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./crowdsale/Crowdsale.sol";
import "./SoluLabToken.sol";
import "./crowdsale/CrowdsaleStage.sol";
import "./BaseSoluLabICOSale.sol";
import "./crowdsale/MintedCrowdsale.sol";
import "./crowdsale/CappedCrowdsale.sol";
import "./crowdsale/TimedCrowdsale.sol";
import "./crowdsale/RefundableCrowdsale.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";

contract SoluLabICOSale is BaseSoluLabICOSale
{
    constructor(uint256 _openTime, uint256 _closeTime, uint256 _goal, uint256 _cap,
        uint256 _centWeiRate, uint _stage, 
        uint256 _tokenTarget, uint256 _initialRate, address payable _ownerWallet, SoluLabToken _token) public
        BaseSoluLabICOSale(_tokenTarget, _centWeiRate, _stage)
        CappedCrowdsale(_cap)
        RefundableCrowdsale(_goal)
        FinalizableCrowdsale()
        TimedCrowdsale(_openTime, _closeTime)
        Crowdsale(_initialRate, _ownerWallet, _token)
    {
        require(_goal <= _cap);
    }

   
    function _finalization() internal override{
        super._finalization();
    }

}