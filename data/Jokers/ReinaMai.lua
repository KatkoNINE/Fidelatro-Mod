-- 1. Definición del Atlas (Sincronizado con la Key que pide el error)
SMODS.Atlas({
    key = "reina_mai_atlas", -- Ahora coincide con atlas = 'reina_mai_atlas'
    path = "ReinaMai.png",
    px = 71,
    py = 95
})

-- 2. Definición de Mai
SMODS.Joker({
    key = 'reina_mai',
    loc_txt = {
        name = 'Mai',
        text = {
            "{X:mult,C:white}X#1#{} Multi y {C:chips}+#2#{} Fichas.",
            "Crea un {C:attention}Joker Naranja Negativo{} al",
            "jugar una {C:attention}Quintilla{}.",
            "{C:inactive}Sigue pidiéndole naranjas a Katko.{}"
        }
    },
    config = { extra = { x_mult = 15, chips = 500 } },
    rarity = 4,
    cost = 20,
    atlas = 'reina_mai_atlas', -- Coincide con la key de arriba
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 0 },
    blueprint_compat = true,
    
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult, card.ability.extra.chips } }
    end,
    
    calculate = function(self, card, context)
        -- Bonus de puntos
        if context.joker_main then
            return {
                x_mult = card.ability.extra.x_mult,
                chips = card.ability.extra.chips,
                message = 'X' .. card.ability.extra.x_mult .. ' +500'
            }
        end

        -- Crear Joker Naranja Negativo al jugar Quintilla (Five of a Kind)
        if context.before and not context.blueprint then
            if context.scoring_name == "Five of a Kind" then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        -- Usamos el prefijo 'azpr' que vimos en tus errores
                        local orange_id = "j_azpr_joker_naranja"
                        local new_card = create_card('Joker', G.jokers, nil, nil, nil, nil, orange_id, 'mai_spawn')
                        new_card:set_edition({negative = true}, true)
                        new_card:add_to_deck()
                        G.jokers:emplace(new_card)
                        return true
                    end
                }))
                return {
                    message = '¡Naranja!',
                    colour = G.C.ORANGE,
                    card = card
                }
            end
        end
    end
})
