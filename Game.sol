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




 constructor  (string memory playerAddress) public {

     playerAddress = "test";
 }

    //list of answers to each question


    struct Player {
        
        uint256 bid;
        GameState state;
        uint256 winnings;
    }

    //Player newPlayer = Player( 8, GameState.ONE, 0);


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
    uint suite;
    string color;
    
    //Random number generators
    function randomValue() {
        uint random = uint(keccak256(abi.encodePacked(block.timestamp)));
        uint indicator = random%13;
        if (indicator < 10) {
            rank = string(indicator);
        } else if (indicator == 10)
            rank = 'J';
        } else if (indicator == 11) 
            rank = 'Q';
        } else if (indicator == 12)
            rank = 'K';
        } else {
            rank = 'A';
        }
    } 

    function randomSuite()  {
        uint random = uint(keccak256(abi.encodePacked(block.timestamp)));
        uint indicator = random%4;
        if (indicator == 0) {
            suite = 'diamonds;
        } else if (indicator == 1) 
            suite = 'spades';
        } else if (indicator == 2)
            suite = 'hearts';
        } else {
            suite = 'clubs';
        }
    } 

    function randomColor() {
        if (suite == 1 || suite == 2) {
             color == 'red';
        } else {
            color == 'black';
        }
    }


    // Function for verifying the answer for quesiton one.
    function answerQuestionOne(string calldata colorGuess) public 
    {
        require(keccak256(abi.encodePacked((colorGuess))) == keccak256(abi.encodePacked(("red")))
        || keccak256(abi.encodePacked((colorGuess))) == keccak256(abi.encodePacked(("black"))));
        //let card; // Get card from top of deck
        Player memory player = playerAccounts[msg.sender] ;
        // if (colorGuess == answer1 ) {
        //     player.winnings += 1;


        // }
        
        
        //the answrer is hard codded for testing purposes
            if (keccak256(abi.encodePacked((colorGuess))) == keccak256(abi.encodePacked(("red")))) 
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
    function answerQuesetionTwo(string calldata overUnder) public view  
    {
        require(keccak256(abi.encodePacked((overUnder))) == keccak256(abi.encodePacked(("over")))
        || keccak256(abi.encodePacked((overUnder))) == keccak256(abi.encodePacked(("under"))));
        
        //the answrer is hard codded for testing purposes
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
    function answerQuestionThree(bool boolGuess) public view
    {
        //check case sensitivity 

        require(keccak256(abi.encodePacked((boolGuess))) == keccak256(abi.encodePacked((true)))
        || keccak256(abi.encodePacked((boolGuess))) == keccak256(abi.encodePacked((false))));

          if (keccak256(abi.encodePacked((boolGuess))) == keccak256(abi.encodePacked(("true")))) 
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
    function answerQuestionFour(string calldata suiteGuess) public view
    {
        require(keccak256(abi.encodePacked((suiteGuess))) == keccak256(abi.encodePacked(("club")))
        || keccak256(abi.encodePacked((suiteGuess))) == keccak256(abi.encodePacked(("diamond")))
        || keccak256(abi.encodePacked((suiteGuess))) == keccak256(abi.encodePacked(("spade")))
        || keccak256(abi.encodePacked((suiteGuess))) == keccak256(abi.encodePacked(("heart")))
        );    
    }
      if (keccak256(abi.encodePacked((suiteGuess))) == keccak256(abi.encodePacked(("diamond")))) 
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






