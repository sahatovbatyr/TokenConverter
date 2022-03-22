const hre = require("hardhat");

async function main (){

    const [deployer, acc1, acc2] = await hre.ethers.getSigners();

    const address_A = '0x5FbDB2315678afecb367f032d93F642f64180aa3';
    const address_B = '0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512';

    const CustomToken = await ethers.getContractFactory('CustomToken');
    const a_token =  await CustomToken.attach(address_A);
    const b_token = await CustomToken.attach(address_B);

    console.log(a_token.address);
    const bal =await a_token.symbol();
    console.log("contract balance:", bal.toString()  );

    // await a_token.connect(acc1).transfer(acc2.address, 100);

    // await a_token.mint(deployer.address, 500);
    const balance =await a_token.balanceOf(address_A);
    console.log("contract balance:", balance.toString()  );

    let totalSuply = await a_token.totalSupply();
    console.log( "Total Supply: ", totalSuply.toString());

    let deployerBalance = await a_token.balanceOf(deployer.address);
    console.log( "Deployer balance: ", deployerBalance.toString());

    let acc1_Balance = await a_token.balanceOf(acc1.address);
    console.log( "Account_1 balance: ", acc1_Balance.toString());

    let acc2_Balance = await a_token.balanceOf(acc2.address);
    console.log( "Account_2 balance: ", acc2_Balance.toString());

    





    // console.log("a-token name:", name );




}

main( )
.then( ()=> process.exit(0) )
.catch((err) => {

    console.error(err);
    process.exit(1);

})