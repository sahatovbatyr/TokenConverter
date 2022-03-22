## This project provide swap between two ERC20 tokens. Atoken (ATK) swap Btoken (BTK)  
Creating two tokens via our CustomToken.sol.  CustomToken("A-token", "ATK") and CustomToken("B-token", "BTK").
Our TokenConverter.sol has to provide swap between ATK and BTK tokens.


1.  First of all install all dependences, on root folder in terminal : npm install ( node.js must be installed)  
2.  launch hardhat local environment: npx hardhat node  
3.  To deploy our contracts to hardhat I created deploy-hardhat.js file in scripts folder.
    in terminal run: npx hardhat run scripts/deploy-hardhat.js --network localhost
    in console, if not fail, it has to show up 3 lines addresses:   
    
    Example:  
    A_TOKEN deployed. Contract address: 0x5FbDB2315678afecb367f032d93F642f64180aa3  
    B_TOKEN deployed. Contract address: 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512  
    Converter deployed. Contract address: 0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0  

4.  These addresses you have to put in hardhat.config.js file.  
    inside this config.js file you will see variables using these adresses.  
5.  Now we have tasks in our hardhat.config.js file. ( balances, accounts, mint, swap)  
    our  A_TOKEN and B_TOKEN tokens deployed, but no supply on it. therefore, first of all we need mint some token supply.  
    
6.    For this in terminal:  
    
    npx hardhat mint --tokentype "atoken" --receiver "0x70997970c51812dc3a010c7d01b50e0d17dc79c8" --amount 100 --network localhost  

    npx hardhat mint --tokentype "btoken" --receiver "0x3c44cdddb6a900fa2b585dd299e03d12fa4293bc" --amount 200 --network localhost  

    for checking tokens was minted use this:  
    npx hardhat balances --tokentype "atoken" --network localhost  
    npx hardhat balances --tokentype "btoken" --network localhost

7.  Now we have some tokens, we need swap ATK and BTK:  
    npx hardhat swap --network localhost  

8.  if not fail, after all check balances:  
    npx hardhat balances --tokentype "atoken" --network localhost  
    npx hardhat balances --tokentype "btoken" --network localhost










