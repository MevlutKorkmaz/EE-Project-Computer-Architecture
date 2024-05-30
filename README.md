# Betting Game "EE"

## Prepared by:

Department of Computer Engineering, MEF University

## Project Description:
"EE" is a betting game designed to be played by 4 players. The game's main mechanics involve players raising previous bets or calling them. Due to challenges faced during development, certain aspects of the game were simplified:
- The game is strictly for 4 players.
- While the betting rules remain unchanged, user input validation to prevent unreasonable inputs was not fully implemented.

Despite these simplifications, the core rules from the initial proposal are retained.

## Rules of the Game:
1. **Starting Setup**:
   - Each player starts with 3 cards.
   - The game identifies a single loser, not a winner.

2. **Gameplay**:
   - The game proceeds in rounds, starting from the first player.
   - Players bet from low-value to high-value cards.
   - Each player must call or raise the previous player's bet.
   - If a player calls a bluff, all players reveal their cards to verify the last player's bet.

3. **Example Round**:
   - Player 1: "There is a three in the game."
   - Player 2: "There is an ace in the game."
   - Player 3: "There are 2 threes in the game."
   - Player 4: Calls the bluff.
   - Players reveal their cards:
     - If Player 4 is wrong (there are 2 threes), Player 4 gets an extra card in the next round.
     - If Player 4 is right (there are not 2 threes), Player 3 gets an extra card in the next round.
   - The player who wins the bluff starts the next round.

4. **Hint for Players**:
   - Although having more cards can lead to losing, having more cards in the early rounds provides more information.

5. **Card Values**:
   - Cards are valued from lowest (two) to highest (ace).
   - Players can bet on multiple cards. For example:
     - One card < Two cards < Three cards < Three cards + Two cards < Four cards < Four cards + Two cards < Four cards + Three cards < Four cards + Three cards + Two cards, etc.

6. **Special Conditions**:
   - Players who reach seven cards in their hand must bet blindly without seeing their cards.
   - The player who reaches eight cards loses the game.

## Game Interface:
### Figure 1: Start of Game
- Displays players' cards and previous bets.
- Players input the number of cards they will bet, then each card individually.
- Previous bets are tracked with an extra element (0) for clarity.
- Calling a previous bet triggers a comparison of the last bet with all game cards.

### Figure 2: End Game
- Shows the final state of the game, indicating any discrepancies and resetting the previous bets array each round.
- Due to incorrect card comparison and card increment logic, the game might display wrong results but eventually reflects the endgame status.

## Challenges Faced:
- Initial input handling was planned as string conversion to integer arrays but was changed to direct individual inputs for simplicity.
- Ensuring accurate card comparison and correct player card increment logic was challenging and not fully resolved.

## Conclusion:
Despite these challenges, the game "EE" provides a unique betting experience with strategic bluffing and risk assessment. Future improvements can enhance input validation and the overall user experience.
