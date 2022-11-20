// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import { ISimpleSwap } from "./interface/ISimpleSwap.sol";
import { ERC20, IERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import { UniswapV2Library } from "./library/UniswapV2Library.sol";
import { Math } from './library/Math.sol';
import { SafeMath } from './library/SafeMath.sol';

contract SimpleSwap is ISimpleSwap, ERC20 {
    
    using SafeMath  for uint;
    address public token0;
    address public token1;

    uint256 private reserve0;
    uint256 private reserve1;
    uint public constant MINIMUM_LIQUIDITY = 0; // v2-core/contracts/UniswapV2Pair.sol#L15 10**3
    
    constructor(address _tokenA, address _tokenB) ERC20("SimpleSwap", "SSLP") {
        // forces error, when tokenA is not a contract
        require(_tokenA.code.length > 0, "SimpleSwap: TOKENA_IS_NOT_CONTRACT");
        // forces error, when tokenB is not a contract
        require(_tokenB.code.length > 0, "SimpleSwap: TOKENB_IS_NOT_CONTRACT");
        // forces error, when tokenA is the same as tokenB
        require(_tokenA != _tokenB, "SimpleSwap: TOKENA_TOKENB_IDENTICAL_ADDRESS");
        // tokenA's address should be less than tokenB's address
        (token0, token1) = UniswapV2Library.sortTokens(_tokenA, _tokenB);
    }

    // Implement core logic here
    function swap(
        address tokenIn,
        address tokenOut,
        uint256 amountIn
    ) external override returns (uint256 amountOut){
        return 0;
    }

    function addLiquidity(uint256 amountAIn, uint256 amountBIn)
        external override
        returns (
            uint256 amountA,
            uint256 amountB,
            uint256 liquidity
        ){
            // forces error, when tokenA amount is zero
            require(!(amountAIn == 0), "SimpleSwap: INSUFFICIENT_INPUT_AMOUNT");
            // forces error, when tokenB amount is zero
            require(!(amountBIn == 0), "SimpleSwap: INSUFFICIENT_INPUT_AMOUNT");

            // transferFrom(from, to, amount): tokenA, tokenB into this contract
            IERC20(token0).transferFrom(msg.sender, address(this), amountAIn);
            IERC20(token1).transferFrom(msg.sender, address(this), amountBIn);
            
            uint _totalSupply = totalSupply();

            if (_totalSupply == 0) {
                liquidity = Math.sqrt(amountAIn.mul(amountBIn)).sub(MINIMUM_LIQUIDITY);
                amountA = amountAIn;
                amountB = amountBIn;
            } else {
                // ref: https://github.com/Uniswap/v2-core/blob/master/contracts/UniswapV2Pair.sol#L110
                // 造成池子中多少 % 的變化
                liquidity = Math.min(amountAIn.mul(_totalSupply) / reserve0, amountBIn.mul(_totalSupply) / reserve1);
                // 實際上用到的數量
                amountA = (liquidity * reserve0)/_totalSupply;
                if (amountAIn > amountA) {
                    IERC20(token0).transfer(msg.sender, (amountAIn - amountA));
                } else if (amountBIn > amountB) {
                    amountB = (liquidity * reserve1)/_totalSupply;
                     IERC20(token1).transfer(msg.sender, (amountBIn - amountB));
                }
            }

             // mint LP token
             _mint(msg.sender, liquidity);

             // 更新 reserve0 reserve1
             reserve0 = IERC20(token0).balanceOf(address(this));
             reserve1 = IERC20(token1).balanceOf(address(this));

             emit AddLiquidity(msg.sender, amountA, amountB, liquidity);
        }
  
    function removeLiquidity(uint256 liquidity) external override returns (uint256 amountA, uint256 amountB){
        // forces error, when lp token amount is zero
        require(liquidity > 0, "SimpleSwap: INSUFFICIENT_LIQUIDITY_BURNED");
        
        _transfer(msg.sender, address(this), liquidity); // send liquidity to pair
        // burn ref: https://github.com/Uniswap/v2-core/blob/master/contracts/UniswapV2Pair.sol#L134
        // uint balance0 = IERC20(token0).balanceOf(address(this)); -> reserve0
        // uint balance1 = IERC20(token1).balanceOf(address(this)); -> reserve1
        uint _totalSupply = totalSupply();

        amountA = liquidity.mul(reserve0) / _totalSupply; // using balances ensures pro-rata distribution
        amountB = liquidity.mul(reserve1) / _totalSupply; // using balances ensures pro-rata distribution
        require(amountA > 0 && amountB > 0, 'UniswapV2: INSUFFICIENT_LIQUIDITY_BURNED');

        // burn LP token
        _burn(address(this), liquidity);

        IERC20(token0).transfer(msg.sender, amountA);
        IERC20(token1).transfer(msg.sender, amountB);

        // 更新 reserve0 reserve1
        reserve0 = IERC20(token0).balanceOf(address(this));
        reserve1 = IERC20(token1).balanceOf(address(this));

        emit RemoveLiquidity(msg.sender, amountA, amountB, liquidity);
    }

    function getReserves() external override view returns (uint256 reserveA, uint256 reserveB) {
        reserveA = reserve0;
        reserveB = reserve1;
    }

    function getTokenA() external override view returns (address tokenA){
        return token0;
    }

    function getTokenB() external override view returns (address tokenB){
        return token1;
    }

    function _update() internal {

    }
}
