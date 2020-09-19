data:extend{
    {
        name = "inline-furnace-control",
        type = "electric-energy-interface",
        energy_source = {
            type = "electric",
            usage_priority = "secondary-input"
        },
        collision_box = {{-0.5, -0.5}, {0.5, 0.0}},
        collision_mask = {},
        picture = {
            filename = "__inlinefurnace__/graphics/entities/inline_furnace_control.png",
            width = 1,
            height = 1,
            frame_count = 1,
            scale = 0.5,
            shift = {0, -0.75}
          },
    }
}