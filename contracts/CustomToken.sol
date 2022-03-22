//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract CustomToken {

    string private  _name;
    string private _symbol;
    uint256 private _totalToken;
    uint8 private _decimals;
    address private _owner;

    mapping( address => uint256) private _balances;
    mapping( address => mapping(address=> uint256) ) _allowed;

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed owner, address indexed spender, uint value);



    constructor(string memory tokenName, string memory tokenSymbol){

        _owner=msg.sender;
        _name=tokenName;
        _symbol=tokenSymbol;
        _decimals=18;
    }

    modifier onlyOwner {
        require(msg.sender == _owner, "Only owner can call this function." );
        _;
    }

    function mint( address receiver, uint amount) public onlyOwner returns  ( bool ){

        require( receiver!= address(0), "Mint to zero account!" );

        _totalToken+=amount;
        _balances[receiver]+=amount;
        emit Transfer(address(0), receiver, amount);

        return true;
    }

    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function decimals() public view returns (uint8) {
        return _decimals;
    }

    function totalSupply() public view returns (uint256){
        return _totalToken;
    }


    function balanceOf(address _accAddress) public view returns (uint256 balance){
        return _balances[_accAddress];
    }

    function transfer(address receiver, uint256 value) public returns (bool success) {

        require(receiver!= address(0), "Transfer to zero address!");
        require( _balances[msg.sender]>=value, "Not enough token on balance!");

        _balances[msg.sender]-=value;
        _balances[receiver]+=value;

        emit Transfer(msg.sender, receiver, value);

        return true;
    }

    function transferFrom(
        address sender, 
        address receiver, 
        uint256 amount
        ) 
        public returns (bool success) {               

            console.log( "!!!!!!!!!!! From  tranferFrom()  log !!!!!!!!!!")  ;
            console.log( "tranferFrom() msg.sender: ", msg.sender);       

            require( _balances[sender]>= amount, "Insufficient token");            
            require( _allowed[sender][msg.sender]>=amount, "Insufficient allowance");   

            require(sender != address(0), "ERC20: transfer from the zero address");
            require(receiver != address(0), "ERC20: transfer to the zero address");           

            _allowed[sender][msg.sender] -= amount;
            _balances[sender]-=amount;
            _balances[receiver]+=amount;
            emit Transfer(sender, receiver, amount);

            return true;


    }


    function approve(address spender, uint256 amount) public returns (bool success) {

        _allowed[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;

    } 
    
    function allowance( address  owner, address spender) public view returns (uint256 remaining) {

        return _allowed[owner][spender];

    }

    function burn( uint256 amount) public onlyOwner returns (bool succes){
        require( _balances[msg.sender]>=amount);
        _balances[msg.sender]-=amount;
        _totalToken-=amount;
         emit Transfer(msg.sender, address(0), amount);
        return true;

    }

    function getOwner() public view returns (address){
        return _owner;
    }






}