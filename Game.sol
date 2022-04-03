// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

import "hardhat/console.sol";

contract cardgame is ReentrancyGuard {
    mapping(address => Player) playerAccounts;

     //only for testing
        string answer1 = "red";



     uint256 winnings = 0;

 
 
    constructor  (string memory playerAddress) public
    {
     playerAddress = "test";
    }

   


    struct Player {
        
        uint256 bid;
        GameState state;
        uint256 pwinnings;
    }





    address public renderingContractAddress;

    string firstQuestion = "What will be the color of the next card?";
    string secondQuestion = "Will the next card be higher or lower?";
    string thirdQuestion = "Will the next card be in between or not the previous two cards?";
    string fourthQuestion = "Whats the suite of the next card?";

    enum GameState {
        NO_GAME,
        ONE,
        TWO, 
        THREE,
        FOUR
    }


    event QuestionOne(string firstQuestion);


    function initiateGame(uint256 _bid) public 
    {
        require(msg.sender != address(0));
        require(_bid > 0);
        require(playerAccounts[msg.sender].state == GameState.NO_GAME);

        //shuffle deck / implement unique deck

        Player memory newPlayer = Player( _bid, GameState.ONE, 0);
        playerAccounts[msg.sender] = newPlayer;
    
        emit QuestionOne(firstQuestion);
    }




    // Global variables for random card generated
    string rank;
    string suite;
    string color;
    
    //Random number generators
    function randomValue() internal {
        uint random = uint(keccak256(abi.encodePacked(block.timestamp)));
        uint indicator = random%13;
        if (indicator < 10) {
            rank = Strings.toString(indicator);
        } else if (indicator == 10) {
            rank = 'J';
        } else if (indicator == 11){
            rank = 'Q';
        } else if (indicator == 12) {
            rank = 'K';
        } else {
            rank = 'A';
        }
    } 

    function randomSuite() internal  {
        uint random = uint(keccak256(abi.encodePacked(block.timestamp)));
        uint indicator = random%4;
        if (indicator == 0) {
            suite = 'diamonds';
        } else if (indicator == 1) { 
            suite = 'spades';
        } else if (indicator == 2) {
            suite = 'hearts';
        } else {
            suite = 'clubs';
        }
    } 

    function randomColor() internal {
        if (keccak256(abi.encodePacked((suite))) == keccak256(abi.encodePacked(("hearts"))) || keccak256(abi.encodePacked((suite))) == keccak256(abi.encodePacked(("diamonds")))) {
            color = 'red';
        } else {
            color = 'black';
        }
    }


    // Function for verifying the answer for quesiton one.
    function answer_Q_1(string calldata colorGuess) public 
    {
        require(keccak256(abi.encodePacked((colorGuess))) == keccak256(abi.encodePacked(("red")))
        || keccak256(abi.encodePacked((colorGuess))) == keccak256(abi.encodePacked(("black"))));
        randomSuite();
        randomColor();
        

        Player memory player = playerAccounts[msg.sender] ;
        

        if (keccak256(abi.encodePacked((colorGuess))) == keccak256(abi.encodePacked((color)))) 
        {
           winnings += 1;
           console.log ('Correct answer, you earned +1, now your total winning is: ', winnings, 
           ', proceed to the next question');
        } 
        else {
            console.log ('Wrong answer!');
            winnings += 0;
        }
        
    }



    // Function for verifying the answer for quesiton two. 
    function answer_Q_2(string calldata overUnder) public 
    {
        require(keccak256(abi.encodePacked((overUnder))) == keccak256(abi.encodePacked(("over")))
        || keccak256(abi.encodePacked((overUnder))) == keccak256(abi.encodePacked(("under"))));

         if (keccak256(abi.encodePacked((overUnder))) == keccak256(abi.encodePacked(("over")))) 
        {
           winnings += 1;
           console.log ('Correct answer, you earned +1, now your total winning is: ', winnings, 
           ', proceed to the next question');
        } 
        else {
            console.log ('Wrong answer!');
            winnings += 0;
        }
    }


    // Function for verifying the answer for quesiton three.
    function answer_Q_3(bool boolGuess) public 
    {
        //check case sensitivity 
        require(keccak256(abi.encodePacked((boolGuess))) == keccak256(abi.encodePacked((true)))
        || keccak256(abi.encodePacked((boolGuess))) == keccak256(abi.encodePacked((false))));

         if (keccak256(abi.encodePacked((boolGuess))) == keccak256(abi.encodePacked((true)))) 
        {
           winnings += 1;
           console.log ('Correct answer, you earned +1, now your total winning is: ', winnings, 
           ', proceed to the next question');
        } 
        else {
            console.log ('Wrong answer!');
            winnings += 0;
        }

        
    }

    // Function for verifying the answer for quesiton four.
    function answer_Q_4(string calldata suiteGuess) public 
    {
        require(keccak256(abi.encodePacked((suiteGuess))) == keccak256(abi.encodePacked(("club")))
        || keccak256(abi.encodePacked((suiteGuess))) == keccak256(abi.encodePacked(("diamond")))
        || keccak256(abi.encodePacked((suiteGuess))) == keccak256(abi.encodePacked(("spade")))
        || keccak256(abi.encodePacked((suiteGuess))) == keccak256(abi.encodePacked(("heart")))
        );    

        if (keccak256(abi.encodePacked((suiteGuess))) == keccak256(abi.encodePacked(("diamond")))) 
        {
           winnings += 1;
           console.log ('Correct answer, you earned +1, now your final winning is: ', winnings, 
           ', proceed to the next question');
        } 
        else {
            winnings = 0;
            console.log ('Wrong answer! Your final winnings is: ', winnings);
        }


    }

     function Winnings() public view returns(uint256) {
        return winnings;

    }





}






