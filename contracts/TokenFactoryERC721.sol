// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "./ERC721Template.sol";

contract TokenFactoryERC721 {
    event DeployedERC721(
        address indexed owner,
        string name,
        string symbol,
        uint256 timestamp
    );
    mapping(address=>ERC721Template[])allERC721Of;
    function deployERC721(
        string memory name,
        string memory symbol,
        string memory ipfsCollection,
        string memory imageFileExtension
    ) external {
        ERC721Template erc721Template = new ERC721Template(
            name,
            symbol,
            ipfsCollection,
            imageFileExtension
        );
        ERC721Template(erc721Template).transferOwnership(msg.sender);
        allERC721Of[msg.sender].push(erc721Template);

        emit DeployedERC721(msg.sender, name, symbol, block.timestamp);
    }

    function getYourDeployments() external view returns(ERC721Template[] memory){
        return allERC721Of[msg.sender];

    }
}
