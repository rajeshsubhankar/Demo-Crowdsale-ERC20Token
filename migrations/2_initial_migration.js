var OreoCoin = artifacts.require("./OreoCoin.sol");
var CrowdSale = artifacts.require("./CrowdSale.sol");

module.exports = function(deployer) { //name, symbol, initial supply
  deployer.deploy(OreoCoin, "OreoCoin", "O`", 21000).then(function() {
    return deployer.deploy(CrowdSale, 10, 10, 2, OreoCoin.address); //goal amt, duration, price of token, token address
  }); 
};
