SMODS.Atlas({
    key = "SergioAtlas",
    path = "sergio.png",
    px = 71,
    py = 95
})

SMODS.Voucher({
    key = 'sergio_purge',
    loc_txt = {
        name = 'Sergio',
        text = { 
            "Se traga todos tus jokers de comida,", 
            "{C:attention}Gordo ql{}." 
        }
    },
    atlas = "SergioAtlas",
    pos = { x = 0, y = 0 },
    cost = 10,
    unlocked = true,
    redeem = function(self, card)
        local food_jokers = {
            'j_gros_michel', 'j_egg', 'j_ice_cream', 'j_popcorn', 
            'j_ramen', 'j_seltz', 'j_turtle_bean', 'j_diet_cola', 'j_cavendish'
        }

        for _, v in ipairs(food_jokers) do
            if G.P_CENTERS[v] then
                G.P_CENTERS[v].in_pool = false
            end
        end

        for i = #G.jokers.cards, 1, -1 do
            local j = G.jokers.cards[i]
            local is_food = false
            for _, food_id in ipairs(food_jokers) do
                if j.config.center.key == food_id then is_food = true break end
            end
            if is_food then
                local new_card = create_card('Joker', G.jokers, nil, nil, nil, nil, nil, 'ser')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                j:remove()
            end
        end

        if G.shop_jokers and G.shop_jokers.cards then
            for i = #G.shop_jokers.cards, 1, -1 do
                local s = G.shop_jokers.cards[i]
                local is_food = false
                for _, food_id in ipairs(food_jokers) do
                    if s.config.center.key == food_id then is_food = true break end
                end
                if is_food then
                    local new_shop_card = create_card('Joker', G.shop_jokers, nil, nil, nil, nil, nil, 'ser')
                    G.shop_jokers:emplace(new_shop_card)
                    s:remove()
                end
            end
        end
    end
})
