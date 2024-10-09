module petpals_package::egg_v3 {
    use sui::tx_context::{sender};
    use std::string::{utf8, String};

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
    public struct EGG_V3 has drop {}

    fun init(otw: EGG_V3, ctx: &mut TxContext) {
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
            // Description is static for all `Hero` objects.
            utf8(b"A Collection of Genesis Eggs"),
            // Project URL is usually static
            utf8(b"https://suipets.io"),
            // Creator field can be any
            utf8(b"PetPals Foundation")
        ];

        // Claim the `Publisher` for the package!
        let publisher = package::claim(otw, ctx);

        // Get a new `Display` object for the `Hero` type.
        let mut display = display::new_with_fields<Egg>(
            &publisher, keys, values, ctx
        );

        // Commit first version of `Display` to apply changes.
        display::update_version(&mut display);

        transfer::public_transfer(publisher, sender(ctx));
        transfer::public_transfer(display, sender(ctx));
    }

    public fun mint(name: String, description: String, origin: String, pet_type: String, rarity: String,thumbnail_url: String, image_url: String, ctx: &mut TxContext): Egg {
        let id = object::new(ctx);
        Egg { id, name, description,origin,pet_type, rarity,thumbnail_url, image_url }
    }

}