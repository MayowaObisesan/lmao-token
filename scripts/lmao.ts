import { ethers } from "hardhat";

async function main() {
    const lmao = await ethers.deployContract("LMAO", []);
    await lmao.waitForDeployment();

    console.log("LMAO Token deployed to: ", lmao.target);

    const [addr1, addr2] = await ethers.getSigners();

    console.log(ethers.formatEther(await lmao.balanceOf(addr1.address)));
    console.log(ethers.formatEther(await lmao.balanceOf(addr2.address)));

    await lmao.transfer(addr2.address, ethers.parseEther("2"));

    console.log(ethers.formatEther(await lmao.balanceOf(addr1.address)));
    console.log(ethers.formatEther(await lmao.balanceOf(addr2.address)));
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
