pragma solidity ^0.5.7;

// A distributed lottery game (with some flaws).
contract Lottery {
    // Constants related to the betting rules.
    uint256 constant BET_AMT = 0.2 ether;
    uint8 constant NUM_BETS = 3;
    
    address payable[] players;
    address payable winnder;
    
    // Running total, used to select the winner of the lottery.
    uint total;
    unit j;
    
    constructor() public {
        //
        players = new address payable players[](NUM_BETS);
        //
        // You may need to add extra variables to the contract
        // in order to get this assignment working.
        total = 0;
        j = 0;
    }
    
    // Destructor -- The winner calls this to collect his earnings.
    function destroy() external {
        require(j == NUM_BETS);
        require(msg.sender == winner);
        selfdestruct(winner);
        // Verify that betting is finished, and that the caller
        // is the winner.  If so, call selfdestruct with the winner's
        // address to claim the funds.
    }
    
    // A player bets and is registered for the game.
    // Each player must choose a number.
    // When the last player bets, the winner is determined.
    function bet(uint n) payable external {
        //
        require(n == BET_AMT);
        require(msg.gasleft >= n)
        total = total + n;
        players[j] = msg.sender; 
        j = j + 1;
        unit x = 0;
        if(j == NUM_BETS){
            x = total % 3;
            if(x == 0){
                winner = players[0];
            }
            else if(x == 2){
                winner = players[1];
            }
            else{
                winner = players[2];
            }
        }
        // Ensure that the caller has bet exactly BET_AMT
        // and that bets can still be taken.
        // If so, track the caller's key and add their selected
        // number 'n' to the total.
        //
        // If this call is the last bet, select the winner
        // by modding the total by the number of players.
    }

    // Show who won the bet.
    function showWinner() external view returns(address) {
        require(j == NUM_BETS);
        return winner;
        // Ensure that the betting has concluded before this
        // function is called.  If so, return the address
        // of the selected winner.
    }

}
