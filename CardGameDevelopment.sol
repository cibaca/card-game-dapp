// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

import "hardhat/console.sol";

import "./Card.sol";
import "./Deck.sol";

contract CardGameDevelopment is ReentrancyGuard {
    mapping(address => Player) playerAccounts;

    constructor () {

    }
   

    struct Player { // Structure associated per user
        uint256 bid;
        GameState state;
        uint256 winnings;
        Deck deck;
        Card[] prevCards;
    }

    address public renderingContractAddress;

    string firstQuestion = "What will be the color of the next card?";
    string secondQuestion = "Will the next card be higher or lower?";
    string thirdQuestion = "Will the next card be in between the previous two cards?"; 
    string fourthQuestion = "Whats the suite of the next card?";

    enum GameState {
        NO_GAME,
        ONE,
        TWO, 
        THREE,
        FOUR
    }


    event AskQuestion(string question);
    event SendWinnings(uint256 winnings);


    function initiateGame(uint256 _bid) public {
        require(msg.sender != address(0));
        require(_bid > 0);
        require(playerAccounts[msg.sender].bid == 0 || playerAccounts[msg.sender].state == GameState.NO_GAME);

        // Shuffle deck
        Deck deck = new Deck();
        deck.shuffleDeck();
        
        Card[] memory prevCards = new Card[](4); 
        Player memory newPlayer = Player( _bid, GameState.ONE, 0, deck, prevCards);
        playerAccounts[msg.sender] = newPlayer;

        emit AskQuestion(firstQuestion);
    }

    function answerQuestionOne(string calldata colorGuess) public {
        bytes32 colorGuessBytes = keccak256(abi.encodePacked(colorGuess));
        bytes32 redBytes = keccak256(abi.encodePacked("red"));
        bytes32 blackBytes = keccak256(abi.encodePacked("black"));

        require(colorGuessBytes == redBytes || colorGuessBytes == blackBytes);
    
        //let card; // Get card from top of deck
        Player memory player = playerAccounts[msg.sender];

        require(player.state == GameState.ONE);

        Card card = player.deck.deal();

        if ((colorGuessBytes == redBytes && !card.isBlack())
        ||  (colorGuessBytes == blackBytes && card.isBlack())) {
            // Player answered correctly, winnings is 1:1 for first tier
            player.winnings += player.bid;   
        }
        player.prevCards[0] = card;
        player.state = GameState.TWO;

        emit AskQuestion(secondQuestion);
    }


    function answerQuesetionTwo(string calldata overUnder) public {
        bytes32 overUnderBytes = keccak256(abi.encodePacked(overUnder));
        bytes32 overBytes = keccak256(abi.encodePacked("over"));
        bytes32 underBytes = keccak256(abi.encodePacked("under"));
        bytes32 equalBytes = keccak256(abi.encodePacked("equal"));

        require(overUnderBytes == overBytes || overUnderBytes == underBytes
                || overUnderBytes == equalBytes);

        Player memory player = playerAccounts[msg.sender];
        
        require(player.state == GameState.TWO);

        // Get previous card
        Card prevCard = player.prevCards[0];

        // Deal card
        Card card = player.deck.deal();

        if ((overUnderBytes == overBytes && card.getRank() > prevCard.getRank())
        ||  (overUnderBytes == underBytes && card.getRank() < prevCard.getRank())
        || (overUnderBytes == equalBytes && card.getRank() == prevCard.getRank())) {
            // Winnings for second tier are 2:1 initial bid
            player.winnings += 2 * player.bid;
        }

        player.prevCards[1] = card;
        player.state = GameState.THREE;

        emit AskQuestion(thirdQuestion);
    }

    function answerQuestionThree(bool inbetween) public {
        // Question: if next card is inbetween previous two cards. Boundaries are exclusionary

        Player memory player = playerAccounts[msg.sender];
        require(player.state == GameState.THREE);
    
        // Deal card
        Card card = player.deck.deal();

        // Get previous cards in order 
        Card startCard = player.prevCards[0];
        Card endCard = player.prevCards[1];
        if (startCard.getRank() > endCard.getRank()) {
            startCard = player.prevCards[1];
            endCard = player.prevCards[0];
        }

        if ((inbetween && startCard.getRank() < card.getRank() && endCard.getRank() < card.getRank())
            || (!inbetween && startCard.getRank() <= card.getRank() || endCard.getRank() <= card.getRank())) {
            // Third tier is 3:1
            player.winnings += 3 * player.bid;
        }

        player.prevCards[3] = card;
        player.state = GameState.FOUR;

        emit AskQuestion(thirdQuestion);
    }

    function answerQuestionFour(string calldata suiteGuess) public {
        bytes32 suiteGuessBytes = keccak256(abi.encodePacked(suiteGuess));
        bytes32 clubBytes = keccak256(abi.encodePacked("club"));
        bytes32 diamondBytes = keccak256(abi.encodePacked("diamond"));
        bytes32 spadeBytes = keccak256(abi.encodePacked("spade"));
        bytes32 heartBytes = keccak256(abi.encodePacked("heart"));

        require(suiteGuessBytes == clubBytes || suiteGuessBytes == spadeBytes
                || suiteGuessBytes == diamondBytes || suiteGuessBytes == heartBytes);

        Player memory player = playerAccounts[msg.sender];  
        require(player.state == GameState.FOUR);

        // Deal card
        Card card = player.deck.deal();

        if ((suiteGuessBytes == clubBytes && card.getSuit() == 0) 
        ||  (suiteGuessBytes == diamondBytes && card.getSuit() == 1)
        || (suiteGuessBytes == heartBytes && card.getSuit() == 2)
        || (suiteGuessBytes == spadeBytes && card.getSuit() == 3)) {
            // Player wins everything and gets initial bid back 
            player.winnings += player.bid;
        } else {
            // Player loses everything if they do not get their initial bid back
            player.winnings = 0;
        }

        if (player.winnings > 0) {
            // Transfer earnings winnings from bool if greater than zero
        }

        player.state = GameState.NO_GAME;

        emit SendWinnings(player.winnings);
    }


}
