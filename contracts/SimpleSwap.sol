// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import { ISimpleSwap } from "./interface/ISimpleSwap.sol";
import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import { UniswapV2Library } from "./library/UniswapV2Library.sol";

contract SimpleSwap is ISimpleSwap, ERC20 {

    address public token0;
    address public token1;
    
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
            return (0,0,0);
        }

    function removeLiquidity(uint256 liquidity) external override returns (uint256 amountA, uint256 amountB){
        return (0,0);
    }

    function getReserves() external override view returns (uint256 reserveA, uint256 reserveB) {
        return (0,0);
    }

    function getTokenA() external override view returns (address tokenA){
        return token0;
    }

    function getTokenB() external override view returns (address tokenB){
        return token1;
    }
}
