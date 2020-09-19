require("inline_furnace/mouth")
require("inline_furnace/control")
require("inline_furnace/belt")


data:extend{
    {
        type = "simple-entity",
        name = "inline-furnace",
        collision_box = {
          {
            -1.3,
            -1.5
          },
          {
            1.3,
            1.5
          }
        },
        selection_box = {
          {
            -1.5,
            -1.5
          },
          {
            1.5,
            1.5
          }
        },
        collision_mask = {"item-layer", "object-layer", "player-layer", "water-tile"},
        picture = {
          filename = "__inlinefurnace__/graphics/entities/furnace.png",
          frame_count = 1,
          height = 219,
          
          priority = "high",
          scale = 0.5,
          shift = {
            -0.1,
            0.0
          },
          width = 239
        },





          





    }
}