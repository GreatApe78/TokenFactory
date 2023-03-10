// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ERC721Template is ERC721URIStorage,Ownable {
    
    using Counters for uint256;

    
    string private _ipfsCollection;
    uint256 private _tokenCounter;
    string private _imageFileExtension;


    constructor(
        string memory name,
        string memory symbol,
        string memory ipfsCollection,
        string memory imageFileExtension
    ) ERC721(name, symbol) {
        _ipfsCollection = ipfsCollection;
        _imageFileExtension = imageFileExtension;
    }

    function getIpfsCollection() public view returns(string memory){
        return _ipfsCollection;

    }

    function setIpfsCollection(string memory newCollectionUrl) external  onlyOwner(){
        _ipfsCollection = newCollectionUrl;
    }

    function getTokenCounter() public view returns(uint256){
        return _tokenCounter;
    }



}
