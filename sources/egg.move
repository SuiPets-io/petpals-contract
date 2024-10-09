module petpals_package::egg {
    use sui::tx_context::{sender};
    use std::string::{utf8, String};
    use sui::package::Publisher;

    // The creator bundle: these two packages often go together.
    use sui::package;
    use sui::display;

    public struct Egg has key, store {
        id: UID,
        name: String,
        description: String,
        origin: String,
        pet_type: String,
        rarity: String,
        thumbnail_url: String,
        image_url: String,
    }

    /// One-Time-Witness for the module.
    public struct EGG has drop {}

    fun init(otw: EGG, ctx: &mut TxContext) {
        let keys = vector[
            utf8(b"name"),
            utf8(b"link"),
            utf8(b"image_url"),
            utf8(b"description"),
            utf8(b"project_url"),
            utf8(b"creator"),
        ];

        let values = vector[

            utf8(b"{name}"),

            utf8(b"https://suipets.io"),

            utf8(b"{image_url}"),

            utf8(b"A Collection of Genesis Eggs"),
            // Project URL is usually static
            utf8(b"https://suipets.io"),
            // Creator field can be any
            utf8(b"PetPals Foundation")
        ];

        // Claim the `Publisher` for the package!
        let publisher = package::claim(otw, ctx);

        let mut display = display::new_with_fields<Egg>(
            &publisher, keys, values, ctx
        );

        // Commit first version of `Display` to apply changes.
        display::update_version(&mut display);

        transfer::public_transfer(publisher, sender(ctx));
        transfer::public_transfer(display, sender(ctx));
    }

    public fun mint(cap: &Publisher, name: String, description: String, origin: String, pet_type: String, rarity: String,thumbnail_url: String, image_url: String, ctx: &mut TxContext): Egg {
        assert!(cap.from_module<Egg>(), 0);
        let id = object::new(ctx);
        Egg { id, name, description,origin,pet_type, rarity,thumbnail_url, image_url }
    }

    public fun destroy(obj: Egg) {
        let Egg { id, name: _, description: _, origin: _, pet_type: _, rarity: _, thumbnail_url: _, image_url: _ } = obj;
        object::delete(id);
    }

}