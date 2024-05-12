import { ethers } from "hardhat";

async function main() {
    // 0x5FbDB2315678afecb367f032d93F642f64180aa3
    const wlmao = await ethers.deployContract("WLMAO", ["0x475140f769769BC3b7c5f9D67b850862abEc6484"]);
    await wlmao.waitForDeployment();

    console.log("WLMAO Token deployed to: ", wlmao.target);

    // Test Deposit functionality
    const [signer, addr2] = await ethers.getSigners();
    console.log(ethers.formatEther(await wlmao.balanceOf(signer.address)));


    const lmao = await ethers.getContractAt("LMAO", "0x3D238Dc2dDa06c1a15ea38330d84c0cf47Be0F3c");
    console.log(ethers.formatEther(await lmao.balanceOf(addr2)));
    console.log(ethers.formatEther(await lmao.balanceOf(signer)));

    console.log(ethers.formatEther(await lmao.balanceOf("0x3D238Dc2dDa06c1a15ea38330d84c0cf47Be0F3c")));
    await lmao.connect(signer).approve(wlmao.target, ethers.parseEther("5000000"));

    console.log(ethers.formatEther(await wlmao.balanceOf(signer.address)));
    const depBal = await wlmao.deposit(ethers.parseEther("0.3"));
    depBal.wait();

    // console.log(ethers.formatEther(await wlmao.balanceOf(signer.address)));
    console.log(ethers.formatEther(await lmao.balanceOf(wlmao.target)));
    console.log(ethers.formatEther(await lmao.balanceOf("0x3D238Dc2dDa06c1a15ea38330d84c0cf47Be0F3c")));
    console.log(ethers.formatEther(await ethers.provider.getBalance("0x3D238Dc2dDa06c1a15ea38330d84c0cf47Be0F3c")));
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
