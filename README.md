Assignment Problem –

Create an ICO Smart Contract, with your custom ERC20 Token with the below details: Total Supply of Token: 100 Million Initial Value at $0.01 (Pre-sale Quantity: 30 Million) 2nd Sale Value at $0.02 (Seed Sale Quantity: 50 Million) Final Sale for Remaining Tokens should be dynamically allocated.

The project uses:

•	Ethereum blockchain as a base of infrastructure

•	truffle@5.4.8 for compile, migrate and deploy on Ganache

•	Openzeppelin/contracts@4.3.1 contracts as a base of source code

•	Ganache v2.5.4 used for migration and deployment of contracts.

•	OS - Windows2010.

•	IDE – VS Code

Token summary

•	Current token address: 0x29904F276e60457FBcF36e0Bc7d92182A1E97822

•	Token symbol: SLT

•	Token Name : Solu Lab Token

•	Token decimals: 18

•	Total Supply (Cap) : 1000000000 (100 million)

Assignment Summary -

1.  SoluLabToken contact is used to create ERC20 Token with Pusuable, Mintable. It contains SLT token smart contract. SLT is a capped, pusuable and mintable token with an option to set totalSuppy (Cap) not cap adjustment.
2.  BaseSoluLabICOSale is an abstract contract to use for Crowdsale, CappedCrowdsale, TimedCrowdsale, RefundableCrowdsale as current Openzeppelin contract doesn't have crowdsale mechanism so, customised all above Crowdsale from openzeppelin@2.5.x version with compatible for solidity 0.8.0. Also, it contains the general functionality of the crowdsale staging given in the Assignment as Presale, SecondSale and Final Sale rates would be $0.01, $0.02 and dynamic rate respectively. Not handled dynamic rates as was not clear the strategy of dynamic rate however, keep as $1 value for final sale. Find CrowdSale related contracts in the folder "contracts/crowdsale".

•	It allows to set the ETHUSD rate

•	Any payment less than ETHER_THRESHOLD (100 finney) will be rejected

•	ETHMNR rate is defined as ETHUSD 

•	After the end of crowdsale the ownership of the token instance will be transferred to original owner.

3.  SoluLabICOSale  contract is used for different staged sales (PreSale, SecondSale and FinalSale). This is being used for ICO PreSale, SecondSale and FinalSale and have ability to set goals for each stage (e.g. supply for stage and rate for stage).

Assumption -

As doesn't have start time and end time for each stage so, consider 6 months for each stage. However all stages have supply cap but not have end time in the provided problem.

Project Setup – Migration and Deployment 

Check code from - https://github.com/SuvarnaJogdand/SLT_ERC20TokenAssignment

1.	Truffle Install - 

	•	npm install -g truffle@5.4.8
	•	truffle unbox react
	
2.	Openzeppelin contracts install

	•	install --save @openzeppelin/contracts@4.3.1
	
3.	Project Compilation

	•	truffle compile
	
4.	Migration and Deployment - Before executing below command, need to start the Ganache and should run at host: "127.0.0.1" and port: 7545
                                   If Ganache is running on different host and port, need to modify truffle-config.js for the host and port under
				   networks: {
                                              develop: {
                                              host: "127.0.0.1",
                                              port: 7545
                                             }

	•	truffle migrate







