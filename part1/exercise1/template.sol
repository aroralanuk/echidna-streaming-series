pragma solidity ^0.7.0;

import "token.sol";

contract TestToken is Token {
    address echidna_caller = msg.sender;

    constructor() public {
        balances[echidna_caller] = 10_000;
    }

    // add the property, need echidna_*
    function echidna_test_balance() public view returns (bool) {
        return balances[echidna_caller] <= 10_000;
    }
}
