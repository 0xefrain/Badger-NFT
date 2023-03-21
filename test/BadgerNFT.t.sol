// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/BadgerNFT.sol";
import "../src/ERC721Receiver.sol";


contract BadgerNFTTest is Test {
    address public contractOwner;
    address public user1;
    address public user2;
    BadgerNFT private badgerNFT;
    ERC721Receiver private erc721Receiver1;
    ERC721Receiver private erc721Receiver2;
    uint256 constant NFT_ID = 0;


    function setUp() public {
        badgerNFT = new BadgerNFT();
        erc721Receiver1 = new ERC721Receiver();
        erc721Receiver2 = new ERC721Receiver();
        contractOwner = address(this);
        user1 = address(erc721Receiver1);
        user2 = address(erc721Receiver2);
    }


    function testMint() public {
        badgerNFT.safeMint(user1);
        assertEq(badgerNFT.ownerOf(NFT_ID), user1);
    }

    function testTransfer() public {
        badgerNFT.safeMint(user1);
        assertEq(badgerNFT.ownerOf(NFT_ID), user1);
        vm.prank(user1); // changed to user1 from owner
        badgerNFT.transferFrom(user1, user2, NFT_ID);
        assertEq(badgerNFT.ownerOf(NFT_ID), user2);
    }
}
