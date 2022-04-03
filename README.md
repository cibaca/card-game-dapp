# DApp Game Application
For the LionHack Hackathon, as beginners into blockchain we started by exploring topics that we could base on some already known development. We also wanted to work towards working on Solidity from a blockchain developer perspective. Initially we started working on a bounty for the ViteX ecosystem. For this we had to utlize solidity++ as the ecosystem supports this extension of solidity. We also explored on stacking process works with ViteX as we had to retrive APR, 30 day transaction history and 7 day Moving Average of each of their user on a Yield Dashboard and present it in the graphical representation. For Dashboard we had intend to use ReactJs. 

While exploring the ecosystem and connecting with the developers of ViteX, we came across that the API's are available to fetch the details fromt his system so it wont have much implementation in using SOlidity and we can directly create some standard backend functions which will sent the data to the dashboard. So for the hackathon we preferred to work on some blockchain tech implementation. 

So we came up with an idea to utilize this learning into a game application where we just start with the basic guess the game. This game will be a Game platform where we can series of different games, currently we intend to card a number of card games. 

# Overview of our Game
To begin the game, user logs in using the valid wallet ID and will have a set of random shuffled playing cards from which they would need to guess the correct next card based on the questions/conditions. The user can bid any value greater than zero. 

The user will earn money based on the amount they will bid. So if the user is bidding 1 ETH . They would earn 1 for first question, 2 for Second, 3 for third and so on. They would only receive winnings once they have answered all the questions correctly. 

#### Sample Questions - 
1. Player has to guess the color of the first card. 
3. Player has to guess over/under for the next card.
3. Player has to guess inbetween or not of the previous two cards
4. Player has to guess the suite of the fourth card.

This application will have an option of add based by creating different smart contracts for each game. 

# Tech Stack
1. Solidity - We are using Solidity for developing smart contracts for deck of 52 cards as well the Guess the Card game. 
3. Arbitrum One - Platform where we will deploy our application as it had quiet low fee compared to other platforms
4. RemiX - IDE for developing and testing our smart contracts. 
5. Integrations - We are still researching on what would be the most appropriate tech for building UI and if we could integrate with something like Pygame


# Analysis of the Game

Our game would have a starting pool with certain funds to payout users and store income to. This pool would be some kind of account where funds would be taken and put into.
Min Bet - Initially it would be greater than zero later it would changed based on the data that we receive by deploying a demo application on arbitrum and how the app is performing with fluctuating user utlization. 
Max Payout is 7 times the intial bet, and is only received when the user guesses the 4 questions correctly. In the average case (E(x)), this probability is approximately 3%
Safety Margin is 1870 which considering user play simultaneously assuming users pay oen hour a day. 
Safe MaX Bet = PoolSize / 7 * 1870

# Current Implementation


