// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "./ERC20Template.sol";
import "./ERC721Template.sol";

contract TokenFactory {
    mapping(address => ERC20Template[]) allERC20Of;
    mapping(address => ERC721Template[]) allERC721Of;
    event DeployedERC20(
        address indexed owner,
        string name,
        string symbol,
        uint256 indexed initialSupply,
        uint256 timestamp
    );
    event DeployedERC721(
        address indexed owner,
        string name,
        string symbol,
        uint256 timestamp
    );

    function deployERC20(
        string memory _name,
        string memory _symbol,
        uint256 _initialSupply
    ) public {
        ERC20Template erc20 = new ERC20Template(_name, _symbol, _initialSupply);
        ERC20Template(erc20).transferOwnership(msg.sender);
        ERC20Template(erc20).transfer(
            msg.sender,
            _initialSupply * (10 ** ERC20Template(erc20).decimals())
        );
        allERC20Of[msg.sender].push(erc20);
        emit DeployedERC20(
            msg.sender,
            _name,
            _symbol,
            _initialSupply,
            block.timestamp
        );
    }

    function readERC20Owner(
        address _erc20Address
    ) public view returns (address) {
        for (uint256 i = 0; i < allERC20Of[msg.sender].length; i++) {
            if (address(allERC20Of[msg.sender][i]) == _erc20Address) {
                return ERC20Template(_erc20Address).owner();
            }
        }
        return address(0);
    }

    function erc20BalanceOf(
        address _erc20Address
    ) public view returns (uint256) {
        return ERC20Template(_erc20Address).balanceOf(msg.sender);
    }

    function listERC20() public view returns (ERC20Template[] memory) {
        return allERC20Of[msg.sender];
    }

    function getERC20Name(
        address _erc20Address
    ) public view returns (string memory) {
        return ERC20Template(_erc20Address).name();
    }

    function getERC20Symbol(
        address _erc20Address
    ) public view returns (string memory) {
        return ERC20Template(_erc20Address).symbol();
    }

    function getERC20TotalSupply(
        address _erc20Address
    ) public view returns (uint256) {
        return ERC20Template(_erc20Address).totalSupply();
    }
}
