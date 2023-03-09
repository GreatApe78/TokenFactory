// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;
import "./ERC20Template.sol";


contract TokenFactory {
    event DeployedERC20(address indexed owner,string  name,string symbol,uint256 indexed initialSupply,uint256 timestamp);
    
    ERC20Template[] allTokenContracts;
    
    mapping(address => ERC20Template[]) allERC20Of;
    function deployERC20(string memory _name, string memory _symbol, uint256 _initialSupply) public {
        ERC20Template erc20 = new ERC20Template(_name, _symbol, _initialSupply);
        ERC20Template(erc20).transferOwnership(msg.sender);
        ERC20Template(erc20).transfer(msg.sender, _initialSupply * (10 ** ERC20Template(erc20).decimals()));
        allTokenContracts.push(erc20);
        allERC20Of[msg.sender].push(erc20);
        emit DeployedERC20(msg.sender, _name, _symbol, _initialSupply, block.timestamp);
    }
    /* 
    function getBalanceOfToken(address erc20Address) external view returns(uint256){
        
    } */
    function transferERC20(address _erc20Address,address to,uint256 amount) external {
        ERC20Template(_erc20Address).approve(address(this),amount);
        ERC20Template(_erc20Address).transferFrom(msg.sender,to,amount);
    }
    function erc20BalanceOf(address _erc20Address, address _targetAddress) public view returns(uint256){
        return ERC20Template(_erc20Address).balanceOf(_targetAddress);
    }
    function getBalanceOfToken(address _tokenAddress) external view returns(uint256){
        return ERC20Template(_tokenAddress).balanceOf(msg.sender);
    }
    function listERC20() public view returns(ERC20Template[] memory){
        return allERC20Of[msg.sender];
    }
}