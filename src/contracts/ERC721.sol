// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.0;

contract ERC721 {

    event Transfer
    (
        address indexed address_from,
        address indexed address_to,
        uint256 indexed tokenId
    );

    mapping(uint256 => address) private _tokenOwner;
    mapping(address => uint256) private _OwnedTokensCount;

    function _mint(address address_to, uint256 tokenId) internal virtual {
        require(address_to != address(0), "invalid mint address fucket");
        require(_tokenOwner[tokenId] == address(0), "you are late mate, token already minted");

        _tokenOwner[tokenId] = address_to;
        _OwnedTokensCount[address_to] +=1;

        emit Transfer(address(0), address_to, tokenId);
    }
    
    
    /// @notice Count all NFTs assigned to an owner
    /// @dev NFTs assigned to the zero address are considered invalid, and this
    ///  function throws for queries about the zero address.
    /// @param _owner An address for whom to query the balance
    /// @return The number of NFTs owned by `_owner`, possibly zero

    function balanceOf(address _owner) external view returns(uint256) {
        require(_owner != address(0), "throwing you fucking out, mate");
        return _OwnedTokensCount[_owner];
    }



    /// @notice Find the owner of an NFT
    /// @dev NFTs assigned to zero address are considered invalid, and queries
    ///  about them do throw.
    /// @param _tokenId The identifier for an NFT
    /// @return The address of the owner of the NFT


    function ownerOf(uint256 _tokenId) external view returns (address) {
        address owner = _tokenOwner[_tokenId];
        require(owner != address(0), "throwing you fucking out, mate 2");
        return owner;
    }


}

