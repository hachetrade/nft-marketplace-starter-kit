// SPDX-License-Identifier: MIT 
pragma solidity >=0.4.22 < 0.9.0;

import './ERC721.sol';


contract ERC721Enumerable is ERC721 {

    uint256[] private _allTokens;

    // mapping from tokenId to position in _allTokens array

    mapping(uint256 => uint256) private _allTokensIndex; 

    // mapping of owner to list of all owner token ids

    mapping(address => uint256[]) private _ownedTokens;

    // mapping from tokenID to index of the owner tokens list

    mapping(uint256 => uint256) private _ownedTokensIndex;

    /// @notice Count NFTs tracked by this contract
    /// @return A count of valid NFTs tracked by this contract, where each one of
    ///  them has an assigned and queryable owner not equal to the zero address
    function totalSupply() public view returns (uint256){
            return _allTokens.length;
    }

   
        
    function _mint(address address_to, uint256 tokenId) internal override(ERC721){
        super._mint(address_to, tokenId);
        _addTokensToAllTokenEnumeration(tokenId);
        _addTokensToOwnerEnumeration(tokenId, address_to);

    }

    function _addTokensToAllTokenEnumeration(uint256 tokenId) private {
        _allTokensIndex[tokenId] = _allTokens.length;
        _allTokens.push(tokenId);
    }

    function _addTokensToOwnerEnumeration(uint256 tokenId, address address_owner) private {
       _ownedTokensIndex[tokenId] = _ownedTokens[address_owner].length;
       _ownedTokens[address_owner].push(tokenId);     
    }

    function numberOftokensOwned() external view returns(uint256){
        address owner = msg.sender;
        return _ownedTokens[owner].length;

    }
    function tokenByIndex(uint256 index) external view returns(uint256) {
            require(index < totalSupply(), "global index is out of reach");
            return _allTokens[index];
    }

    function tokenOfOwnerByIndex(uint256 index, address owner) external view returns(uint256){
        require(index< balanceOf(owner), "owner index is out of reach");
        return _ownedTokens[owner][index];

    }
    function listOfTokenOwned(address owner) external view returns(uint256[] memory) {
        return _ownedTokens[owner];
    }
    
    

}