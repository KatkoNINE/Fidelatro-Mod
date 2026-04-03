-- 1. Definición del Atlas (Sincronizado con la Key que pide el error)
SMODS.Atlas({
    key = "joker_naranja_atlas", -- Ahora es igual a atlas = 'joker_naranja_atlas'
    path = "Naranja.png",
    px = 71,
    py = 95
})

-- 2. Definición del Joker Naranja
SMODS.Joker({
    key = 'joker_naranja',
    loc_txt = {
        name = 'Joker Naranja',
        text = {
            "{X:mult,C:white}X#1#{} Multi.",
            "Ser mítico de alta glucosa.",
            "El {C:red}Rey Katko{} sigue debiéndole a la",
            "{C:purple}Mai{} este poderosísimo fruto."
        }
    },
    config = { extra = { x_mult = 14 } }, -- Cambiado a 14 para que coincida con el texto
    rarity = 4,
    cost = 20,
    atlas = 'joker_naranja_atlas', -- Coincide con la key de arriba
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 0 },
    blueprint_compat = true,
    
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult } }
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                x_mult = card.ability.extra.x_mult,
                message = 'X' .. card.ability.extra.x_mult
            }
        end
    end
})
