

function build_furnace(event)

    game.surfaces["nauvis"].create_entity({name = "inline-furnace-mouth", position = {event.created_entity.position.x, event.created_entity.position.y + 1}})

    if game.surfaces["nauvis"].find_entity("inline-furnace", {event.created_entity.position.x, event.created_entity.position.y + 3}) == nil then
        local control = game.surfaces["nauvis"].create_entity({name = "inline-furnace-control", position = {event.created_entity.position.x, event.created_entity.position.y}})
        local in_belt = game.surfaces["nauvis"].create_entity({name = "inline-furnace-belt", position = {event.created_entity.position.x, event.created_entity.position.y + 1}})
        local out_belt = {}
        
        local above = game.surfaces["nauvis"].find_entity("inline-furnace", {event.created_entity.position.x, event.created_entity.position.y - 3})
        if above == nil then
            out_belt = game.surfaces["nauvis"].create_entity({name = "inline-furnace-belt", position = {event.created_entity.position.x, event.created_entity.position.y - 1}})
            global.furnaces[event.created_entity] = {power = control, contents = {max = 36, current = 0, items = {}}, input = in_belt, output = out_belt}
        else 
            if global.furnaces[above] then
                global.furnaces[event.created_entity] = global.furnaces[above]
                global.furnaces[above] = nil
                global.furnaces[event.created_entity].power = control
                global.furnaces[event.created_entity].input = in_belt
                global.furnaces[event.created_entity].contents.max = global.furnaces[event.created_entity].contents.max + 36
            end
        end
    end
        
end

function destroy_furnace(event)
    game.surfaces["nauvis"].find_entity("inline-furnace-left", {event.entity.position.x - 1, event.entity.position.y}).destroy()
    game.surfaces["nauvis"].find_entity("inline-furnace-right", {event.entity.position.x + 1, event.entity.position.y}).destroy()
    game.surfaces["nauvis"].find_entity("inline-furnace-top", {event.entity.position.x, event.entity.position.y - 1}).destroy()

    if game.surfaces["nauvis"].find_entity("inline-furnace-mouth", {event.entity.position.x, event.entity.position.y}) then
        game.surfaces["nauvis"].find_entity("inline-furnace-mouth", {event.entity.position.x, event.entity.position.y}).destroy()
    end

    if game.surfaces["nauvis"].find_entity("inline-furnace-belt", {event.entity.position.x, event.entity.position.y - 1}) then
        game.surfaces["nauvis"].create_entity({name = "inline-furnace-mouth", position = {event.entity.position.x, event.entity.position.y - 1}})
    end
end


script.on_event(defines.events.on_built_entity, function(event)
    if global.furnaces then
    else global.furnaces = {} end
    if event.created_entity.name == "inline-furnace" then
        build_furnace(event)
    end
end)

script.on_event({defines.events.on_player_mined_entity, defines.events.on_robot_mined_entity}, function(event)
    if global.furnaces then
    else global.furnaces = {} end
    if event.entity.name == "inline-furnace-belt" then
        destroy_furnace(event)
    end
end)





script.on_event(defines.events.on_tick, function(event)
    if global.furnaces then 
        for k, furnace in pairs(global.furnaces) do
            if furnace.contents.current < furnace.contents.max then
                for i = 1, furnace.input.get_max_transport_line_index() do
                    local line = furnace.input.get_transport_line(i)
                    local contents = line.get_contents()
                    line.clear()
                    for item, count in pairs(contents) do
                        if furnace.contents.items[item] then
                            furnace.contents.items[item] = furnace.contents.items[item] + count
                            furnace.contents.current = furnace.contents.current + count
                        else
                            furnace.contents.items[item] = count
                        end
                    end
                end
            end


            for i = 1, furnace.output.get_max_transport_line_index() do
                local line = furnace.output.get_transport_line(i)
                for item, count in pairs(furnace.contents.items) do
                    if furnace.contents.items[item] > 0 then
                        local new = item
                        local stop = false
                        for name, recipe in pairs(k.force.recipes) do
                            if stop == true then break end
                            if recipe.category == "smelting" then
                                for i = 1, #recipe.ingredients do
                                    if recipe.ingredients[i].name == item then
                                        new = recipe.products[1]
                                        stop = true
                                        break
                                    end
                                end
                            end
                        end
                        if line.insert_at(1, new) then
                            furnace.contents.items[new] = count - 1
                            furnace.contents.current = furnace.contents.current - 1
                        end
                    end
                end
            end
            

        end
    end
end)