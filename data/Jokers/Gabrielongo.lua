SMODS.Joker({ -- Añadido paréntesis
    key = "Gabrielongo", -- Cambiada la key para que coincida con el nombre del archivo si es posible
    loc_txt = {
        name = "Gabrielongo (Cacahuete)",
        text = {
            "{C:mult}+1000{} de Multi.",
            "Cacahuete te ofrece su milagro.",
            "{C:inactive}(Funciona aún mejor con {C:attention}Cristian Vidal{C:inactive})"
        }
    },
    rarity = 4,
    cost = 10,
    atlas = "Gabrielongo", -- Coincide con la key en tu main.lua
    pos = { x = 0, y = 0 },

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult_mod = 1000, -- Usamos mult_mod para que se sume correctamente
                message = "+1000 CACAHUETES",
                colour = G.C.MULT
            }
        end
    end
}) -- Añadido paréntesis
