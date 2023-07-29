// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.0;

import './ERC721Connector.sol';

contract KryptoBird is ERC721Connector {

    string [] public kryptobirdz; // array to store our nfts

    mapping(string => bool) _kryptoBirdzExists;

    function mint(string memory _kryptobird) public {
       // uint _id = KryptoBirdz.push(_kryptoBird); deprecated cause .push no longer returns lenght
       require(!_kryptoBirdzExists[_kryptobird], "Error kryptobird already exist");
       kryptobirdz.push(_kryptobird);
       uint _id = kryptobirdz.length - 1;
       
        _mint(msg.sender, _id);
        _kryptoBirdzExists[_kryptobird] = true;


    }
    function listOfBirdz() external view returns(string[] memory){
        return kryptobirdz;
    }
   
    constructor() ERC721Connector('KryptoBird', 'KBIRDZ') {
        
    }
}


