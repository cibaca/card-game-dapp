# DApp Game Application
For the LionHack Hacksthon, as a beginner into blockchain we started by exploring topics that we could based on some already known development. We also wanted to work towards knowing the implementation of Solidity from a blockchain developer perspective. The initially we started working on a bounty for ViteX ecosystem. For this we had to utlize solidity++ as the ecosystem supports this extension of solidity. We also explored on stacking process works with ViteX as we had to retrive APR, 30 day transaction history and 7 day Moving Average of each of their user on a Yield Dashboard and present it in the graphical representation. For Dashboard we had intend to use ReactJs. 

While exploring the ecosystem and connecting with the developers of ViteX, we came across that the API's are available to fetch the details fromt his system so it wont have much implementation in using SOlidity and we can directly create some standard backend functions which will sent the data to the dashboard. So for the hackathon we want to work on some blockchain tech implementation. 

So we came up with an idea to utilize this learning into a game application where we just start with the basic guess the game. This game will be a Game platform where we can series of different games, currently we intend to card a number of card games. 

# Overview of our Game
The game will have a deck of cards which would like playing cards along with uno cards or cards with random design. 
our first game is Guess the card where user join using their wallet ID. And he would have an option to play by bidding an value greater than zero. 

The user will earn money based on the amount they will bid. So if the user is bidding 1 ETH . They would earn 1 for first question, 2 for Second, 3 for third and so on. They would only receive winnings once they have answered all the questions correctly. 

#### Sample Questions - 
1. Player has to guess the color of the first card. 
3. Player has to guess over/under for the next card.
3. Player has to guess inbetween or not of the previous two cards
4. Player has to guess the suite of the fourth card.

This application will have an option of add based by creating different smart contracts for each game. 

# Tech Stack
1. Solidity - We are using Solidity for developing smart contracts for deck of 52 cards as well the Guess the Card game. 
3. Arbitrum One - Platform where we will deploy pour application as it had quiet low fee compared to other platforms
4. RemiX - IDE for developing and testing our smart contracts. 
5. Integrations - We are still researching on what would be the most appropriate tech for building UI and if we could integrate with something like Pygame

# Current Implementation


