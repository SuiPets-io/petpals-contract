module petpals_package::pps {

   use sui::coin;
   use sui::url;

   public struct PPS has drop {}

   fun init(witness: PPS, ctx: &mut TxContext) {
       let coin_url = url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmZNJFLGduYVuENr8GDSF87UcM2DwxNMU4KZd6BePFoPCq");
       let (mut treasury, metadata) = coin::create_currency(witness, 3, b"PPS", b"PetPals Token", b"PetPals Token", option::some(coin_url), ctx);
       transfer::public_freeze_object(metadata);
       coin::mint_and_transfer(&mut treasury, 10000000000000, tx_context::sender(ctx), ctx);
       transfer::public_transfer(treasury, tx_context::sender(ctx))
   }

   public entry fun mint(
       treasury: &mut coin::TreasuryCap<PPS>, amount: u64, recipient: address, ctx: &mut TxContext
   ) {
       coin::mint_and_transfer(treasury, amount, recipient, ctx)
   }

   public entry fun burn(treasury: &mut coin::TreasuryCap<PPS>, coin: coin::Coin<PPS>) {
       coin::burn(treasury, coin);
   }
}