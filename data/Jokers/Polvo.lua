SMODS.Joker {
    key = 'polvo',
    loc_txt = {
        name = 'Polvo',
        text = {
            "Otorga {C:mult}+1{} de Mult."
        }
    },
    config = { extra = { mult = 1 } },
    rarity = 1, -- Común
    cost = 1,
    blueprint_compat = true,
    atlas = 'polvo_atlas',
    pos = { x = 0, y = 0 },

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult_mod = card.ability.extra.mult,
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
            }
        end
    end
}
