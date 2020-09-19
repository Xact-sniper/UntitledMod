local belt = table.deepcopy(data.raw["transport-belt"]["transport-belt"])
belt.name = "inline-furnace-belt"
belt.collision_mask = {}
belt.next_upgrade = nil
belt.minable = nil
data:extend({belt})
