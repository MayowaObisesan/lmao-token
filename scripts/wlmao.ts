import { ethers } from "hardhat";

async function main() {
    const wlmao = await ethers.deployContract("WLMAO", ["0x5FbDB2315678afecb367f032d93F642f64180aa3"]);
    await wlmao.waitForDeployment();

    console.log("WLMAO Token deployed to: ", wlmao.target);

    // Test Deposit functionality
    const [signer] = await ethers.getSigners();
    const wlmaoContract = await ethers.getContractAt("WLMAO", wlmao.target);
    console.log(await wlmaoContract.balanceOf(signer.address));
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
