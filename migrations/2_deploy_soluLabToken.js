var SoluLabToken = artifacts.require("./SoluLabToken.sol");
var PreSale = artifacts.require("./SoluLabICOSale.sol");
var SecondSale = artifacts.require("./SoluLabICOSale.sol");
var FinalSale = artifacts.require("./SoluLabICOSale.sol");



const duration = {
    seconds: function(val) { return val},
    minutes: function(val) { return val * this.seconds(60) },
    hours:   function(val) { return val * this.minutes(60) },
    days:    function(val) { return val * this.hours(24) },
    weeks:   function(val) { return val * this.days(7) },
    years:   function(val) { return val * this.days(365)}
};

module.exports = function(deployer, network, accounts) {

	const preSaleGoal =    300000000;
  const secondSaleGoal = 500000000;
  const finalSaleGoal =  200000000;
  const soluTokenCap =   1000000000;
  const preSaleUsdRate = 0.01;
  const secondSaleUsdRate = 0.02;
  const findSaleUsdRate = 0.1;
  const tokenSymbol = "SLT";
  const tokenName = "Solu Lab Token";
  
// As assignment deosn't provided the time limit for each stage still, i have taken 6 month for each stage.
	const preIcoStartTime = web3.eth.getBlock('latest').timestamp + duration.minutes(1);
	const preIcoEndTime = preIcoStartTime + duration.days(180);
	const wallet = accounts[1];

	const icoSecondStartTime = preIcoStartTime + web3.eth.getBlock(web3.eth.blockNumber).timestamp + duration.minutes(1);
	const icoSecondEndTime = icoSecondStartTime + duration.minutes(180); 

  const icoFinalStartTime = icoSecondEndTime + web3.eth.getBlock(web3.eth.blockNumber).timestamp + duration.minutes(1);
	const icoFinalEndTime = icoFinalStartTime + duration.minutes(180);
	

  	deployer.deploy(SoluLabToken, tokenName,tokenSymbol,soluTokenCap).then(function(instance) {
		deployer.deploy(PreSale, preIcoStartTime, preIcoEndTime, preSaleGoal, soluTokenCap, preSaleUsdRate, 'PreSale', new web3.utils.toBN(1), preSaleUsdRate, wallet, SoluLabToken.address);
    deployer.deploy(SecondSale, icoSecondStartTime, icoSecondEndTime, secondSaleGoal, soluTokenCap, secondSaleUsdRate, 'SecondSale', new web3.utils.toBN(1), secondSaleUsdRate, wallet, SoluLabToken.address);
    deployer.deploy(FinalSale, icoFinalStartTime, icoFinalEndTime, finalSaleGoal, soluTokenCap, findSaleUsdRate, 'FinalSale', new web3.utils.toBN(1), findSaleUsdRate, wallet, SoluLabToken.address);
	});
};