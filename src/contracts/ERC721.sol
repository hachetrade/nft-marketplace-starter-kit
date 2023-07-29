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

    // mapping from tokenid to approved addresses
    mapping(uint256 => address) private _tokenApprovals;


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

    function balanceOf(address _owner) public view returns(uint256) {
        require(_owner != address(0), "throwing you fucking out, mate");
        return _OwnedTokensCount[_owner];
    }

    /// @notice Transfer ownership of an NFT -- THE CALLER IS RESPONSIBLE
    ///  TO CONFIRM THAT `_to` IS CAPABLE OF RECEIVING NFTS OR ELSE
    ///  THEY MAY BE PERMANENTLY LOST
    /// @dev Throws unless `msg.sender` is the current owner, an authorized
    ///  operator, or the approved address for this NFT. Throws if `_from` is
    ///  not the current owner. Throws if `_to` is the zero address. Throws if
    ///  `_tokenId` is not a valid NFT.
    /// @param _from The current owner of the NFT
    /// @param _to The new owner
    /// @param _tokenId The NFT to transfer


    function _transferFrom(address _from, address _to, uint256 _tokenId) internal{
        require(_to != address(0), "Receiver not allowed");
        require(_tokenOwner[_tokenId] == _from, "you cant tranfer something you dont own");
        _OwnedTokensCount[_from] -=1;
        _OwnedTokensCount[_to] +=1;
        _tokenOwner[_tokenId] = _to;
        emit Transfer(_from, _to, _tokenId);

    }

    function transferFrom(address _from, address _to, uint256 _tokenId) public {
        _transferFrom(_from, _to, _tokenId);
    }



    /// @notice Find the owner of an NFT
    /// @dev NFTs assigned to zero address are considered invalid, and queries
    ///  about them do throw.
    /// @param _tokenId The identifier for an NFT
    /// @return The address of the owner of the NFT


    function ownerOf(uint256 _tokenId) public view returns (address) {
        address owner = _tokenOwner[_tokenId];
        require(owner != address(0), "throwing you fucking out, mate 2");
        return owner;
    }


}

