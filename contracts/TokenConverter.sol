//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import  "./CustomToken.sol";

import "hardhat/console.sol";

contract TokenConverter {

    address private _token1;
    address private _owner1;
    address private _token2;
    address private _owner2;

    address private _owner;

    modifier onlyOwner(){
        require(msg.sender == _owner, "Not owner");
        _;
    }


    constructor( )  {            
        _owner=msg.sender;
    }

    function setToken1Address( address tokenAddress) public returns(bool) {
        _token1=tokenAddress;
        return true;
    }

    function setToken2Address( address tokenAddress) public returns(bool) {
        _token2=tokenAddress;
        return true;
    }

    function setAccount_1_Address( address accAddress) public returns(bool) {
        _owner1=accAddress;
        return true;
    }

    function setAccount_2_Address( address accAddress) public returns(bool) {
        _owner2=accAddress;
        return true;
    }

    


    function swapToken( uint256 amount) public returns( bool succes ) {

        require(msg.sender == _owner1 || msg.sender == _owner2, "Not authorized user!");

        CustomToken token1 = CustomToken(_token1);
        CustomToken token2 = CustomToken(_token2);

        

        console.log("!!!!!!!!!!!!!!!!token1.allowance address(this)=", address(this));

        require(token1.allowance( _owner1, address(this) )>= amount, "Token 1 allowance too low");
        require(token2.allowance( _owner2, address(this) )>= amount, "Token 2 allowance too low");

        bool succesed1 =  token1.transferFrom(_owner1, _owner2, amount);
        require(succesed1, "Token swap failed");

        bool succesed2 = token2.transferFrom(_owner2, _owner1, amount);
        require(succesed2, "Token swap failed");
       
        return true;

    }



    




}

