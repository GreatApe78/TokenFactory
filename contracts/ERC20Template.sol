// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
contract ERC20Template is ERC20, Ownable {
    constructor(string memory _name, string memory _symbol, uint256 _initialSupply) ERC20(_name, _symbol){
        _mint(msg.sender, _initialSupply * (10 ** decimals()));
    }
}