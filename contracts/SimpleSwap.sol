// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import { ISimpleSwap } from "./interface/ISimpleSwap.sol";
import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SimpleSwap is ISimpleSwap, ERC20 {

    address owner;
    
    constructor(string memory name, string memory symbol) ERC20(name, symbol) {
        owner = msg.sender;
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
        return address(0);
    }

    function getTokenB() external override view returns (address tokenB){
        return address(0);
    }
}
