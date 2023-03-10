// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ERC721Template is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    using Strings for uint256;
    
    string private _ipfsCollection;
    Counters.Counter private _tokenCounter;
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

    function mintNFT() public {
        string memory imageUri;
        uint256 tokenId = _tokenCounter.current();
        string memory newTokenUri;
        
        imageUri = string(abi.encodePacked(getIpfsCollection(),tokenId.toString(),getImageFileExtension()));
        newTokenUri = defineTokenUri(imageUri);
        _safeMint(msg.sender, tokenId);
        _setTokenURI(tokenId, newTokenUri);
        
        _tokenCounter.increment();
    }

    function getIpfsCollection() public view returns (string memory) {
        return _ipfsCollection;
    }

    function setIpfsCollection(
        string memory newCollectionUrl
    ) external onlyOwner {
        _ipfsCollection = newCollectionUrl;
    }

    function getImageFileExtension() public view returns (string memory) {
        return _imageFileExtension;
    }

    function setImageFileExtension(
        string memory newFileExtension
    ) external onlyOwner {
        _imageFileExtension = newFileExtension;
    }

    function defineTokenUri(string memory imageUri) internal pure returns(string memory){
        string memory prefix = "data:application/json;base64,";

        string memory sampleJson = string(abi.encodePacked('{"name": " Sample name","image": "',imageUri,'","description": "Sample description"}'));

        string memory encodedJson = string(Base64.encode(bytes(sampleJson)));

        return string(abi.encodePacked(prefix,encodedJson));

    }

}

library Base64 {
    string internal constant TABLE = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';

    function encode(bytes memory data) internal pure returns (string memory) {
        if (data.length == 0) return '';
        
        // load the table into memory
        string memory table = TABLE;

        // multiply by 4/3 rounded up
        uint256 encodedLen = 4 * ((data.length + 2) / 3);

        // add some extra buffer at the end required for the writing
        string memory result = new string(encodedLen + 32);

        assembly {
            // set the actual output length
            mstore(result, encodedLen)
            
            // prepare the lookup table
            let tablePtr := add(table, 1)
            
            // input ptr
            let dataPtr := data
            let endPtr := add(dataPtr, mload(data))
            
            // result ptr, jump over length
            let resultPtr := add(result, 32)
            
            // run over the input, 3 bytes at a time
            for {} lt(dataPtr, endPtr) {}
            {
               dataPtr := add(dataPtr, 3)
               
               // read 3 bytes
               let input := mload(dataPtr)
               
               // write 4 characters
               mstore(resultPtr, shl(248, mload(add(tablePtr, and(shr(18, input), 0x3F)))))
               resultPtr := add(resultPtr, 1)
               mstore(resultPtr, shl(248, mload(add(tablePtr, and(shr(12, input), 0x3F)))))
               resultPtr := add(resultPtr, 1)
               mstore(resultPtr, shl(248, mload(add(tablePtr, and(shr( 6, input), 0x3F)))))
               resultPtr := add(resultPtr, 1)
               mstore(resultPtr, shl(248, mload(add(tablePtr, and(        input,  0x3F)))))
               resultPtr := add(resultPtr, 1)
            }
            
            // padding with '='
            switch mod(mload(data), 3)
            case 1 { mstore(sub(resultPtr, 2), shl(240, 0x3d3d)) }
            case 2 { mstore(sub(resultPtr, 1), shl(248, 0x3d)) }
        }
        
        return result;
    }
}