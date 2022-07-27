// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
import { ethers } from "hardhat";
// eslint-disable-next-line camelcase
async function main() {
  const signers = await ethers.getSigners();
  const wallet = signers[0];
  const provider = wallet.provider;
  const network = await provider?.getNetwork();
  const networkName = network?.name;
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');

  // We get the contract to deploy
  console.log("Deploy");
  console.log(await wallet.getAddress());

  const Faucet = await ethers.getContractFactory("JioFaucet");
  const faucet = await Faucet.deploy();
  console.log("Faucet deployed");

  await faucet.deployed();
  console.log(networkName);
  console.log("faucet:", faucet.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
