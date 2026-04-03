-- Definición del Atlas (Cambiamos la key para que coincida con el Joker)
SMODS.Atlas({
    key = "burger_atlas", 
    path = "Burger.png",
    px = 71,
    py = 95
})

SMODS.Joker({
    key = 'burger',
    loc_txt = {
        name = 'Burger',
        text = {
            "{C:chips}+1000{} fichas.",
            "El peor enemigo de {C:red}Gabriel Mendoza{}.",
            "No los juntes, aunque es bueno juntarlos,",
            "lo mejor es no {C:red}arriesgarse{}."
        }
    },
    config = { extra = { chips = 1000 } },
    rarity = 3,
    cost = 6,
    atlas = 'burger_atlas', -- Ahora sí coincide con la key de arriba
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
})
