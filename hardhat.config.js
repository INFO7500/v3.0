require("@nomiclabs/hardhat-waffle");
require('solidity-coverage');
require("@nomiclabs/hardhat-truffle5");
module.exports = {
  solidity: "0.8.9",
  paths: {
    artifacts: './artifacts',
  },
  networks: {
    hardhat: {
      chainId: 31337,
    }
  },
  mocha: {
    timeout: 40000
  }
};
