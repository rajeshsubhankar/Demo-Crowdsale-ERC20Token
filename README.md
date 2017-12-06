# Demo-Crowdsale-ERC20Token

A quick truffle based DApp to showcase standard ERC20 token creation and crowd sale.

## Getting Started

Download or clone the repo to your local machine. Check for any missing dependencies.

### Prerequisites

Get your **access token** from [INFURA](https://infura.io/). Configure the tokwn in **Truffle.js** file.

Install **MetaMask** in chrome and create few accounts preferably by connecting to **Ropsten** test network. 

Use the generated **mnemonic** in your MetaMask to configure your **Truffle.js** file.

Install the **truffle-hdwallet-provider**.
```
npm install truffle-hdwallet-provider
```

### Installing

Open your terminal and start the local test network.
```
ganache-cli
```
Above command will give you few test accounts preloaded with ethers. Use those accounts to deploy and communicate with your contracts.

From your DApp folder location, **compile** and **migrate** your contracts to your **ganache** test network.
```
truffle.cmd compile
```
```
truffle.cmd migrate --network development
```

Use **Remix** and **MetaMask** to communicate with your contracts. Described in next section.


## Deployment

To deploy this application to **ropsten** test network, try below commands. Make sure you have **INFURA** access token and **MetaMask** mnemonic is confifured in Truiffle.js file.

To compile your contracts.
```
truffle.cmd compile
```
To deploy in test network. `--reset` only if you are redeploying the contracts.
```
truffle.cmd migrate --network ropsten --reset
```

## Test

Use [Remix](https://remix.ethereum.org/) along with [MetaMask](https://metamask.io/) to test your DApp. 

Select **Injected Web3** as environment under **Run** configuration. Provide your contract creation addres in **At Address** field to communicate with your deployed contract. It will populate all your contract methods and public variables. 

Start with **OreoCoin** contract. Transfer few OreoCoins to CrowdSale contract address using **Transfer** function. If configured correctly, **MetaMask** will automatically inject the web3 provider so that for every **Transaction** it will ask your approval.

After successful **OreoCoins** transfer to your **CrowdSale** contract, start playing with your CrowdSale contract. Use **MetaMask** to donate few **ethers** to your **CrowdSale** contract address. Use **safeTransfer** function to transfer ethers back to your account after the crowd sale ends. 

## Built With

* [Truffle](http://truffleframework.com/) - The DApp Framework
* [Ganache](https://github.com/trufflesuite/ganache-cli) - Local Test Network
* [hdwallet-provider](https://github.com/trufflesuite/truffle-hdwallet-provider) - Web3 Provider
* [INFURA](https://infura.io/) - Gateway to Ropsten Test Network
* [MetaMask](https://metamask.io/) - Account Management & Web3 injection


## Authors

* **Rajesh Subhankar** - *Initial work* - [rajeshsubhankar](https://github.com/rajeshsubhankar)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* [Ethereum Getting Started](https://www.ethereum.org/crowdsale)


