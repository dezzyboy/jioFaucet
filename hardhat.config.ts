import * as dotenv from "dotenv";

import { HardhatUserConfig, task } from "hardhat/config";
import "@nomiclabs/hardhat-etherscan";
import "@nomiclabs/hardhat-waffle";
import "@typechain/hardhat";
import "hardhat-gas-reporter";
import "solidity-coverage";

dotenv.config();

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

const config: HardhatUserConfig = {
  paths: {
    sources: "./contracts",
    artifacts: "./build/artifacts",
    cache: "./build/cache",
  },
  solidity: "0.8.4",
  defaultNetwork: "godwoken",
  networks: {
    hardhat: {},
    godwoken: {
      url: `https://godwoken-testnet-v1.ckbapp.dev`,
      chainId: 71401,
      accounts: [`${process.env.PRIVATE_KEY}`],
    },
    dogechain: {
      url: `https://rpc-testnet.dogechain.dog`,
      chainId: 568,
      accounts: [`${process.env.PRIVATE_KEY}`],
    },
    thundercore: {
      url: `https://testnet-rpc.thundercore.com`,
      chainId: 18,
      gas: 90000000,
      gasPrice: 1e9,
      accounts: [`${process.env.PRIVATE_KEY}`],
    },
    ropsten: {
      url: process.env.ROPSTEN_URL || "",
      accounts:
        process.env.PRIVATE_KEY !== undefined ? [process.env.PRIVATE_KEY] : [],
    },
  },
  typechain: {
    outDir: "./build/typechain/",
  },
  gasReporter: {
    enabled: process.env.REPORT_GAS !== undefined,
    currency: "USD",
  },
  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY,
  },
};

export default config;
