require('util')

function tms_toggle(event)
    local player = game.players[event.player_index]

    if not player or not player.valid then
        return
    end

    if player.selected then
        if player.selected.train and player.selected.train.valid then
            local train = player.selected.train

            player.print(train.front_stock.name)

            if train.manual_mode == true then
                train.manual_mode = false
            else
                train.manual_mode = true
            end
        end
    else
        if player.cursor_stack and player.cursor_stack.valid and player.cursor_stack.valid_for_read and player.cursor_stack.name == "tms-switcher" then
            return
        end

        if not player.clear_cursor() then
            return
        end

        local inventory = player.get_main_inventory()
        if inventory then
            inventory.remove({name = "tms-switcher", count = 999})
        end

        local result = player.cursor_stack.set_stack({
            name = "tms-switcher",
            count = 1
        })
    end
end

function tms_selectiontool(event)
    local player = game.players[event.player_index]

    if not player or not player.valid then
        return
    end

    local trains_switched = {}
    for _, ent in pairs(event.entities) do
        if ent.valid then
            if ent.train and ent.train.valid then
                local train = ent.train

                if not trains_switched[train.id] then
                    if train.manual_mode == true then
                        train.manual_mode = false
                    else
                        train.manual_mode = true
                    end

                    trains_switched[train.id] = true
                end
            end
        end
    end
end

script.on_event(defines.events.on_player_selected_area, tms_selectiontool)
script.on_event("tms-toggle", tms_toggle)