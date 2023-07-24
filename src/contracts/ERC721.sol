// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.0;

contract ERC721 {

    event Transfer(
        address indexed address_from,
         address indexed address_to,
          uint256 indexed tokenId);

    mapping(uint256 => address) private _tokenOwner;
    mapping(address => uint256) private _OwnedTokensCount;

    function _mint(address address_to, uint256 tokenId) internal {
        require(address_to != address(0), "invalid mint address fucket");
        require(_tokenOwner[tokenId] == address(0), "you are late mate, token already minted");

        _tokenOwner[tokenId] = address_to;
        _OwnedTokensCount[address_to] +=1;

        emit Transfer(address(0), address_to, tokenId);
    }


}

