pragma solidity ^0.6.0;

import "../uni-v2/UniswapV2ERC20.sol";
import "../uni-v2/UniswapV2Pair.sol";
import "../uni-v2/UniswapV2Factory.sol";

contract Users {
    function proxy(address target, bytes memory data) public returns (bool success, bytes memory retData) {
        return target.call(data);
    }
}

contract Setup {
    UniswapV2Factory factory;
    UniswapV2Pair pair;
    UniswapV2ERC20 testToken1;
    UniswapV2ERC20 testToken2;
    Users userA;
    Users userB;
    bool completed;

    constructor() public {
        testToken1 = new UniswapV2ERC20();
        testToken2 = new UniswapV2ERC20();
        factory = new UniswapV2Factory(address(this));
        address testPair = factory.createPair(address(testToken1), address(testToken2));
        pair = UniswapV2Pair(testPair);

        userA = new Users();
        userA.proxy(address(testToken1),abi.encodeWithSelector(testToken1.approve.selector, address(pair),uint(-1)));
        userA.proxy(address(testToken2), abi.encodeWithSelector(testToken2.approve.selector,address(pair),uint(-1)));

        userB = new Users();
        userB.proxy(address(testToken1),abi.encodeWithSelector(testToken1.approve.selector, address(pair),uint(-1)));
        userB.proxy(address(testToken2), abi.encodeWithSelector(testToken2.approve.selector,address(pair),uint(-1)));
    }

    function _init(uint amount1, uint amount2) internal {
        _init(address(userA), amount1, amount2);
    }

    function _init(address user_, uint amount1, uint amount2) internal {
        testToken1.mint(user_, amount1);
        testToken2.mint(user_, amount2);
        completed = true;
    }

    function _between(uint val, uint low, uint high) internal pure returns(uint) {
        return low + (val % (high-low +1));
    }


}
