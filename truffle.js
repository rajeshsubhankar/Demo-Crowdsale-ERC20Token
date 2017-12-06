var HDWalletProvider = require("truffle-hdwallet-provider");

var infuraKey = "YourInfuraKey"; //Replace with your infura key
var mnemonic = "Create your twelve word mnemonic from MetaMask connecting to Ropsten Network";

module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!
  networks: {
    live: {
      network_id: 1 // Ethereum public network
      // optional config values
      // host - defaults to "localhost"
      // port - defaults to 8545
      // gas
      // gasPrice
      // from - default address to use for any transaction Truffle makes during migrations
    },
    ropsten: {
      provider: new HDWalletProvider(mnemonic, 'https://ropsten.infura.io/' + infuraKey),
      network_id: '3',
      gas: 4600000
    },
    development: {
      host: "localhost",
      port: 8545,
      network_id: "*" // Match any network id
    }
  }
};
