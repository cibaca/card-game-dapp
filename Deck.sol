//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./Card.sol";
contract Deck{
    Card[] private cards;
    uint private top;

    constructor(){
        fillDeck();
        top = 0;
    }

    function fillDeck() internal{
        for(int s=0; s<4; s++){
            for(int r=1; r<=13; r++){
                cards.push(new Card(uint(s), uint(r)));
            }
        }
    }

    function deal() public returns(Card){
        require(top<52);
        return cards[top++];
    }

    function shuffleDeck() public{

    }

    function randomize(uint mod) private view returns(uint){
        return uint(keccak256(abi.encodePacked(block.timestamp,block.difficulty, 
        msg.sender))) % mod;
    }
}