/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */
import type { BaseContract, BigNumber, Signer, utils } from "ethers";
import type { EventFragment } from "@ethersproject/abi";
import type { Listener, Provider } from "@ethersproject/providers";
import type {
  TypedEventFilter,
  TypedEvent,
  TypedListener,
  OnEvent,
  PromiseOrValue,
} from "../../../common";

export interface ISimpleSwapEventInterface extends utils.Interface {
  functions: {};

  events: {
    "AddLiquidity(address,uint256,uint256,uint256)": EventFragment;
    "RemoveLiquidity(address,uint256,uint256,uint256)": EventFragment;
    "Swap(address,address,address,uint256,uint256)": EventFragment;
  };

  getEvent(nameOrSignatureOrTopic: "AddLiquidity"): EventFragment;
  getEvent(nameOrSignatureOrTopic: "RemoveLiquidity"): EventFragment;
  getEvent(nameOrSignatureOrTopic: "Swap"): EventFragment;
}

export interface AddLiquidityEventObject {
  sender: string;
  amountA: BigNumber;
  amountB: BigNumber;
  liquidity: BigNumber;
}
export type AddLiquidityEvent = TypedEvent<
  [string, BigNumber, BigNumber, BigNumber],
  AddLiquidityEventObject
>;

export type AddLiquidityEventFilter = TypedEventFilter<AddLiquidityEvent>;

export interface RemoveLiquidityEventObject {
  sender: string;
  amountA: BigNumber;
  amountB: BigNumber;
  liquidity: BigNumber;
}
export type RemoveLiquidityEvent = TypedEvent<
  [string, BigNumber, BigNumber, BigNumber],
  RemoveLiquidityEventObject
>;

export type RemoveLiquidityEventFilter = TypedEventFilter<RemoveLiquidityEvent>;

export interface SwapEventObject {
  sender: string;
  tokenIn: string;
  tokenOut: string;
  amountIn: BigNumber;
  amountOut: BigNumber;
}
export type SwapEvent = TypedEvent<
  [string, string, string, BigNumber, BigNumber],
  SwapEventObject
>;

export type SwapEventFilter = TypedEventFilter<SwapEvent>;

export interface ISimpleSwapEvent extends BaseContract {
  connect(signerOrProvider: Signer | Provider | string): this;
  attach(addressOrName: string): this;
  deployed(): Promise<this>;

  interface: ISimpleSwapEventInterface;

  queryFilter<TEvent extends TypedEvent>(
    event: TypedEventFilter<TEvent>,
    fromBlockOrBlockhash?: string | number | undefined,
    toBlock?: string | number | undefined
  ): Promise<Array<TEvent>>;

  listeners<TEvent extends TypedEvent>(
    eventFilter?: TypedEventFilter<TEvent>
  ): Array<TypedListener<TEvent>>;
  listeners(eventName?: string): Array<Listener>;
  removeAllListeners<TEvent extends TypedEvent>(
    eventFilter: TypedEventFilter<TEvent>
  ): this;
  removeAllListeners(eventName?: string): this;
  off: OnEvent<this>;
  on: OnEvent<this>;
  once: OnEvent<this>;
  removeListener: OnEvent<this>;

  functions: {};

  callStatic: {};

  filters: {
    "AddLiquidity(address,uint256,uint256,uint256)"(
      sender?: PromiseOrValue<string> | null,
      amountA?: null,
      amountB?: null,
      liquidity?: null
    ): AddLiquidityEventFilter;
    AddLiquidity(
      sender?: PromiseOrValue<string> | null,
      amountA?: null,
      amountB?: null,
      liquidity?: null
    ): AddLiquidityEventFilter;

    "RemoveLiquidity(address,uint256,uint256,uint256)"(
      sender?: PromiseOrValue<string> | null,
      amountA?: null,
      amountB?: null,
      liquidity?: null
    ): RemoveLiquidityEventFilter;
    RemoveLiquidity(
      sender?: PromiseOrValue<string> | null,
      amountA?: null,
      amountB?: null,
      liquidity?: null
    ): RemoveLiquidityEventFilter;

    "Swap(address,address,address,uint256,uint256)"(
      sender?: PromiseOrValue<string> | null,
      tokenIn?: PromiseOrValue<string> | null,
      tokenOut?: PromiseOrValue<string> | null,
      amountIn?: null,
      amountOut?: null
    ): SwapEventFilter;
    Swap(
      sender?: PromiseOrValue<string> | null,
      tokenIn?: PromiseOrValue<string> | null,
      tokenOut?: PromiseOrValue<string> | null,
      amountIn?: null,
      amountOut?: null
    ): SwapEventFilter;
  };

  estimateGas: {};

  populateTransaction: {};
}
