//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./crowdsale/Crowdsale.sol";
import "./crowdsale/CrowdsaleStage.sol";
import "./crowdsale/MintedCrowdsale.sol";
import "./crowdsale/CappedCrowdsale.sol";
import "./crowdsale/TimedCrowdsale.sol";
import "./crowdsale/RefundableCrowdsale.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";


abstract contract BaseSoluLabICOSale   is  Crowdsale,CappedCrowdsale, TimedCrowdsale,  RefundableCrowdsale{


    uint256 public usdEth;
    uint256 public tokensPurchased;
    uint256 public tokenTarget;
// If amount of wei sent is less than the threshold, revert. It can be usefull for dynamic price calculation.
uint256 public constant ETHER_THRESHOLD = 100 * 1e15;

uint256 rate;
uint256 public constant CENT_DECIMALS = 1e18;

  // original contract owner, needed for transfering the ownership of token back after the end of crowdsale
  address internal deployer;

  CrowdsaleStage public stage;
   mapping(address => uint256) public contributions;

  constructor(uint256 _tokenTarget, uint256 _usdEth, uint _stage) 
  {
    require(_tokenTarget > 0);
        require(_usdEth > 0);
        tokenTarget = _tokenTarget;
        usdEth = _usdEth;
         rate = usdEth * CENT_DECIMALS;
         setCrowdsaleStage(_stage);
         deployer = msg.sender;
  }


  /**
  * @dev Allows admin to update the crowdsale stage
  * @param _stage Crowdsale stage
  */
  function setCrowdsaleStage(uint _stage) public {
    if(uint(CrowdsaleStage.PreSale) == _stage) {
      stage = CrowdsaleStage.PreSale;
    } else if (uint(CrowdsaleStage.SecondSale) == _stage) {
      stage = CrowdsaleStage.SecondSale;
    }else if (uint(CrowdsaleStage.FinalSale) == _stage) {
      stage = CrowdsaleStage.FinalSale;
    }


    if(stage == CrowdsaleStage.FinalSale) {
        // Logic needs to write for dynamic rate generation.  
         rate = (1) * CENT_DECIMALS; // just used $1
    } 
  }

  /**
  * @dev Returns the amount contributed so far by a sepecific user.
  * @param _beneficiary Address of contributor
  * @return User contribution so far
  */
  function getUserContribution(address _beneficiary)
    public view returns (uint256)
  {
    return contributions[_beneficiary];
  }

 

  /**
   * @dev forwards funds to the wallet during the PreICO stage, then the refund vault during ICO stage
   */
  function _forwardFunds() internal override(Crowdsale,RefundableCrowdsale){
    if(stage == CrowdsaleStage.PreSale) {
      walletShow().transfer(msg.value);
    } else  {
      RefundableCrowdsale._forwardFunds();
    }
  }

  /**
  * @dev Extend parent behavior requiring purchase to respect investor min/max funding cap.
  * @param _beneficiary Token purchaser
  * @param _weiAmount Amount of wei contributed
  */
  function _preValidatePurchase(
    address _beneficiary,
    uint256 _weiAmount
  )
  internal override(TimedCrowdsale,CappedCrowdsale,Crowdsale) 
  {
    //uint256 newTokenAmount = tokensPurchased.add(_getTokenAmount(_weiAmount));

    //require(newTokenAmount <= tokenTarget);
    require(_weiAmount >= ETHER_THRESHOLD);
    CappedCrowdsale._preValidatePurchase(_beneficiary, _weiAmount);
    uint256 _existingContribution = contributions[_beneficiary];
    uint256 _newContribution = _existingContribution +_weiAmount;
    contributions[_beneficiary] = _newContribution;
  }

  function _getTokenAmount(uint256 _weiAmount) internal view override returns (uint256) {
        return _weiAmount * rate;
    }


    function _deliverTokens(address _beneficiary, uint256 _tokenAmount) internal override  {
        tokensPurchased = tokensPurchased + _tokenAmount;
        super._deliverTokens(_beneficiary, _tokenAmount);
    }


  /**
   * @dev enables token transfers, called when owner calls finalize()
  */
  function _finalization() internal virtual override {
    super._finalization();
  }

}