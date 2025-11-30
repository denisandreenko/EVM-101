// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract ForceFeeder {
    constructor(address payable _force) payable {
        // EIP-6780: selfdestruct still works when called in the same
        // transaction as contract creation (constructor)
        selfdestruct(_force);
    }
}