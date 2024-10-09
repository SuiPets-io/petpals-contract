module petpals_package::egg {

    use std::string::String;

    public struct Genesis has key, store {
        id: UID,
        name: String,
        egg_type: String,
        rarity: String,
        url: String
    }

    public struct Normal has key, store {
        id: UID,
        name: String,
        egg_type: String,
        rarity: String,
        url: String
    }

    public fun mint_genesis(
        name: String,
        egg_type: String,
        rarity: String,
        url: String,
        ctx: &mut TxContext
    ): Genesis {
        let id = object::new(ctx);
        Genesis { id, name, egg_type, rarity, url }
    }

    public fun mint_normal(
        name: String,
        egg_type: String,
        rarity: String,
        url: String,
        ctx: &mut TxContext
    ): Normal {
        let id = object::new(ctx);
        Normal { id, name, egg_type, rarity, url }
    }

    public fun name_genesis(egg: &Genesis): String { egg.name }

    public fun name_normal(egg: &Normal): String { egg.name }

    public fun set_url_genesis(egg: &mut Genesis, url: String) {
        egg.url = url;
    }

    public fun set_url_normal(egg: &mut Normal, url: String) {
        egg.url = url;
    }

    public fun url_genesis(egg: &Genesis): String { egg.url }

    public fun url_normal(egg: &Normal): String { egg.url }

}