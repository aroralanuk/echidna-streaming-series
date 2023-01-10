pragma solidity ^0.6.0;

import "./Setup.sol";

contract EchidnaTest is Setup {
    event logUints(uint unit1, uint unit2);
    event BalancePair(uint r0, uint r1);
    // function testProvideLiquidity(uint amount1, uint amount2) public {
    //     //Preconditions:
    //     amount1 = _between(amount1, 1000, uint(-1));
    //     amount2 = _between(amount2, 1000, uint(-1));

    //     if(!completed) {
    //         _init(amount1, amount2);
    //     }
    //     uint lpTokenBalanceBefore = pair.balanceOf(address(userA));
    //     (uint reserve0Before, uint reserve1Before,) = pair.getReserves();
    //     uint kBefore = reserve0Before * reserve1Before;

    //     (bool success1,) = userA.proxy(address(testToken1),abi.encodeWithSelector(testToken1.transfer.selector, address(pair),amount1));
    //     (bool success2,) = userA.proxy(address(testToken2),abi.encodeWithSelector(testToken2.transfer.selector, address(pair),amount2));
    //     require(success1 && success2);

    //     //Action:
    //     (bool success3,) = userA.proxy(address(pair),abi.encodeWithSelector(bytes4(keccak256("mint(address)")), address(userA)));

    //     //Postconditions:
    //     if(success3) {
    //         uint lpTokenBalanceAfter = pair.balanceOf(address(userA));
    //         (uint reserve0After, uint reserve1After,) = pair.getReserves();
    //         uint kAfter = reserve0After * reserve1After;
    //         assert(lpTokenBalanceBefore < lpTokenBalanceAfter);
    //         assert(kBefore < kAfter);

    //     }

    // }

    function testProvideMoreLiquidity(uint amount1, uint amount2) public {
        //Preconditions:
        amount1 = _between(amount1, 1000, uint(-1));
        amount2 = _between(amount2, 1000, uint(-1));
        uint amount3 = (amount2 * 90)/100;

        if(!completed) {
            _init(amount1, amount2);
            _init(address(userB), amount1, amount3);
        }
        uint lpTokenBalanceBeforeA = pair.balanceOf(address(userA));
        (uint reserve0Before, uint reserve1Before,) = pair.getReserves();
        uint kBefore = reserve0Before * reserve1Before;

        // Action:
        (bool successA1,) = userA.proxy(address(testToken1),abi.encodeWithSelector(testToken1.transfer.selector, address(pair),amount1));
        (bool successA2,) = userA.proxy(address(testToken2),abi.encodeWithSelector(testToken2.transfer.selector, address(pair),amount2));
        require(successA1 && successA2);

        (bool successA3,) = userB.proxy(address(pair),abi.encodeWithSelector(bytes4(keccak256("mint(address)")), address(userA)));

        (uint reserve0After, uint reserve1After,) = pair.getReserves();

        emit BalancePair(reserve0After - reserve0Before, reserve1After - reserve1Before);

        (reserve0Before, reserve1Before) = (reserve0After, reserve1After);

        (bool successB1,) = userB.proxy(address(testToken1),abi.encodeWithSelector(testToken1.transfer.selector, address(pair),amount1));
        (bool successB2,) = userB.proxy(address(testToken2),abi.encodeWithSelector(testToken2.transfer.selector, address(pair),amount3));
        require(successB1 && successB2);

        //Action:
        (bool successB3,) = userB.proxy(address(pair),abi.encodeWithSelector(bytes4(keccak256("mint(address)")), address(userB)));

        (reserve0After, reserve1After,) = pair.getReserves();
        emit BalancePair(reserve0After - reserve0Before, reserve1After - reserve1Before);

        //Postconditions:
        if(successA3 && successB3) {
            uint lpTokenBalanceAfterA = pair.balanceOf(address(userA));
            uint lpTokenBalanceAfterB = pair.balanceOf(address(userB));
            emit logUints(lpTokenBalanceAfterA, lpTokenBalanceAfterB);

            assert(lpTokenBalanceAfterA >= lpTokenBalanceAfterB);
        }

    }

    // function testSwap(uint amount1, uint amount2) public {

    //     if(!completed) {
    //         _init(amount1, amount2);
    //     }

    //     //Preconditions
    //     pair.sync(); // we matched the balances with reserves
    //     require(pair.balanceOf(address(user)) > 0); //there is liquidity for the swap
    //     //Call:
    //     (bool success1,) = user.proxy(address(pair), abi.encodeWithSelector(pair.swap.selector, amount1,amount2,address(user),""));

    //     //Postcondition:
    //     assert(!success1); //call should never succeed



    // }
}
