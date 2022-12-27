import "token.sol";

contract TestToken is Token {
    constructor() public {
        paused(); // pause the contract
        owner = address(0x0); // lose ownership
    }

    // add the property

    // 1.Owner()
    // 2.resume()

    // echidna using corpse to store different scenarios
    // and tracking coverage
    // corpse = unique(coverage)
    // serial corpse and add slices to get "educated" guesses
    function echidna_cannot_be_unpaused() public view returns (bool) {
        return is_paused;
    }
}
