const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Greeter", function () {
  it("Should return the new greeting once it's changed", async function () {

    const [deployer, acc1, acc2, acc3, acc4, ...lastAcc] = await hre.ethers.getSigners();
  const CustomToken = await hre.ethers.getContractFactory('CustomToken');  
  const TokenConverter = await hre.ethers.getContractFactory('TokenConverter');


  const token1Address = "0x5FbDB2315678afecb367f032d93F642f64180aa3";
  const owner1Address = acc1.address;
  const token2Address = "0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512";
  const owner2Address= acc2.address;

  const convertTokenAddress = "0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0";

  const token1 = await CustomToken.attach(token1Address);
  const succesed1= await token1.connect(acc1).approve(owner2Address, hre.ethers.utils.parseEther('20'));
  if (!succesed1) { "succesed1=false"; return;}

  let a = await token1.allowance(acc1.address, owner2Address);

  const allow1 = hre.ethers.utils.formatEther( a);
  console.log("alowed[acc1][owner2Address]=", allow1);

  const token2 = await CustomToken.attach(token2Address);
  const succesed2= await token2.connect(acc2).approve(owner1Address, hre.ethers.utils.parseEther('20'));
  if (!succesed2) { "succesed2=false"; return;}

  let b = await token2.allowance(acc2.address, owner1Address);
  const allow2 = hre.ethers.utils.formatEther( b );
  console.log("alowed[acc2][owner1Address]=", allow2);

  const converter = await TokenConverter.attach(convertTokenAddress);

  let succesed =false;
  succesed = await converter.setToken1Address(token1Address);
  succesed = await converter.setToken2Address(token2Address);
  succesed = await converter.setAccount_1_Address(owner1Address);
  succesed = await converter.setAccount_2_Address(owner2Address);

  if ( !succesed) {console.log("Fail to set token address on Converter"); return;}


  const amountEther  = hre.ethers.utils.parseEther('10');
  const succesed3 = await converter.connect(acc1).swapToken(  amountEther  );

  if (!succesed3) { "succesed3=false"; return;}
   


  });
});
