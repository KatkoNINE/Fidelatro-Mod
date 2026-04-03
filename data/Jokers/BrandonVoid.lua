SMODS.Atlas({
    key = "BrandonVoid",
    path = "BrandonVoid.png",
    px = 71,
    py = 95
})

SMODS.Joker({
    key = 'brandon_void',
    loc_txt = {
        name = 'BrandonVoid',
        text = { 
            "Copia el Joker de la {C:attention}izquierda{}", 
            "y el Joker de la {C:attention}derecha{}.",
            "{C:inactive}Izquierda: #1#{}",
            "{C:inactive}Derecha: #2#{}"
        }
    },
    rarity = 3,
    cost = 10,
    blueprint_compat = true,
    atlas = "BrandonVoidAtlas",
    pos = { x = 0, y = 0 },

    loc_vars = function(self, info_queue, card)
        local left_status = "{C:red}Incompatible{}"
        local right_status = "{C:red}Incompatible{}"

        if G.jokers and G.jokers.cards then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    local left_target = G.jokers.cards[i - 1]
                    local right_target = G.jokers.cards[i + 1]
                    if left_target and left_target ~= card then left_status = "{C:green}Compatible{}" end
                    if right_target and right_target ~= card then right_status = "{C:green}Compatible{}" end
                    break
                end
            end
        end

        return { vars = { left_status, right_status } }
    end,

    calculate = function(self, card, context)
        if context.blueprint_card then return end
        
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] == card then
                local left_target = G.jokers.cards[i - 1]
                local right_target = G.jokers.cards[i + 1]
                
                if left_target and left_target ~= card then
                    context.blueprint = (context.blueprint or 0) + 1
                    local check_left = left_target:calculate_joker(context)
                    context.blueprint = context.blueprint - 1
                    if check_left then 
                        check_left.card = card
                        SMODS.calculate_effect(check_left, card)
                    end
                end

                if right_target and right_target ~= card then
                    context.blueprint = (context.blueprint or 0) + 1
                    local check_right = right_target:calculate_joker(context)
                    context.blueprint = context.blueprint - 1
                    if check_right then 
                        check_right.card = card
                        return check_right
                    end
                end
            end
        end
    end
})
