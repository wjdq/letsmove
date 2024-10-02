// Module: move_coin
module move_coin::move_coin {
    //依赖
    use sui::coin::{Self, TreasuryCap};

    //结构体
    public struct MOVE_COIN has drop {}

    fun init(witness: MOVE_COIN, ctx: &mut TxContext) {
        let (treasuryCap, coinMetadata) = 
            coin::create_currency(
                witness,
                9,
                b"MC",
                b"MoveCoin",
                b"my move coin",
                option::none(),
                ctx,
            );
        transfer::public_freeze_object(coinMetadata);
        transfer::public_transfer(treasuryCap, ctx.sender());
    }

    public entry fun my_move_coin_mint(treasuryCap: &mut TreasuryCap<MOVE_COIN>, amount: u64, recipient: address, ctx: &mut TxContext){
        coin::mint_and_transfer(treasuryCap, amount, recipient, ctx);
        //or  transfer::public_transfer(coin::mint(treasuryCap, amount, ctx), recipient);
    }

}
