pragma solidity ^0.5.7;

contract Faucet {
    
  address payable owner;
  
  // Sets owner, who is allowed to destroy the faucet.
  constructor() public {
    owner = msg.sender;
  }
  
  // Destructor
  function destroy() public {
    require(msg.sender == owner);
    selfdestruct(owner);
  }
  
  // Give out ether to whoever wants it.
  function withdraw(uint amt) public {
    require(amt <= 0.1 ether);
    msg.sender.transfer(amt);
  }

  // Accept any incoming amount.
  function () payable external {}
}

