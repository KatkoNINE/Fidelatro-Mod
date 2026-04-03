SMODS.Joker {
    key = 'SinNombre',
    config = { extra = { mult_per_card = 4 } },
    rarity = 2,
    cost = 6,
    atlas = 'SinNombre', -- CAMBIADO: Antes decía 'einstein', ahora coincide con tu SMODS.Atlas
    pos = { x = 0, y = 0 },
    loc_txt = {
        name = 'Sin Nombre', -- CAMBIADO: Nombre que aparecerá en el juego
        text = {
            "Otorga {C:mult}+#1#{} de Multi por cada",
            "{C:attention}2, 3, 4, 5, 6, 7, 8, 9{} o {C:attention}As{}",
            "que {C:attention}puntee{} en la mano jugada."
        }
    },
    
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult_per_card } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local valid_ranks = {['2']=true, ['3']=true, ['4']=true, ['5']=true, 
                                 ['6']=true, ['7']=true, ['8']=true, ['9']=true, ['Ace']=true}
            
            if valid_ranks[context.other_card.base.value] then
                return {
                    mult = card.ability.extra.mult_per_card,
                    card = card
                }
            end
        end
    end
}
