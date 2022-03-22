const hre = require("hardhat");


async function main(){

    const [deployer] = await hre.ethers.getSigners();

    const A_token = await hre.ethers.getContractFactory("CustomToken");
    const a_token  = await A_token.deploy("A-TOKEN", "ATK");
    await a_token.deployed();

    console.log("A_TOKEN deployed. Contract address: "+a_token.address);
    

    const B_token = await hre.ethers.getContractFactory("CustomToken");
    const b_token  = await B_token.deploy("B-TOKEN", "BTK");
    await b_token.deployed();

    console.log("B_TOKEN deployed. Contract address: "+b_token.address);

    const Converter = await hre.ethers.getContractFactory("TokenConverter");
    const converter  = await Converter.deploy();
    await converter.deployed();

    console.log("Converter deployed. Contract address: "+converter.address);




}


main()
.then(()=> process.exit(0))
.catch( ( error) => {
    console.error(error);
    process.exit(1);

} )