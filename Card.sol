//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Strings.sol";

contract Card{
    uint public immutable suit;
    uint public immutable rank;

    constructor(uint s, uint r){
        require(s >= 0 && s < 4 && r > 0 && r <= 13);
        suit = s;
        rank = r;
    }

    function getRank() public view returns(uint){
        return rank;
    }

    function getSuit() public view returns(uint){
        return suit; 
    }

    function isBlack() public view returns(bool){
        return suit == 1 || suit == 2;
    }

    function toString() public view returns(string memory){
        string memory txt; 
        if(suit == 0){
            txt = "clubs";
        }
        else if(suit == 1){
            txt = "diamonds";
        }
        else if(suit == 2){
            txt = "hearts";
        }
        else{
            txt = "spades";
        }
        if(rank == 1){
            txt = concatenate(txt, "A");
        }
        else if(rank == 11){
            txt = concatenate(txt, "J");
        }
        else if(rank ==12){
            txt = concatenate(txt, "Q");
        }
        else if(rank == 13){
            txt = concatenate(txt, "K");
        }
        else{
            txt = concatenate(txt, Strings.toString(uint(rank)));
        }
        return txt;
    }

    function compareTo(Card other) public view returns(int){
        int c = int(this.getRank() - other.getRank());
        if(c == 0){
            c = int(this.getSuit() - other.getSuit());
        }
        return c;
    }

    function concatenate(string memory a, string memory b) public pure returns(string memory){
        return string(bytes.concat(bytes(a), " ", bytes(b)));
    }
}