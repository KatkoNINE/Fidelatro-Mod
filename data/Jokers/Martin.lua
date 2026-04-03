-- 1. Definición del Atlas (Sincronizado con el Joker)
SMODS.Atlas({
    key = "martinoli_atlas", 
    path = "Martinoli.png",
    px = 71,
    py = 95
})

-- 2. Definición del Joker Martinoli
SMODS.Joker({
    key = 'martinoli',
    loc_txt = {
        name = 'Martinoli',
        text = {
            "Reactiva todas las cartas",
            "jugadas {C:attention}#1#{} veces adicionales.",
            "Si la mano es un {C:attention}Póker{}, suma {C:attention}3{} usos.",
            "{C:inactive}(#2# usos restantes)"
        }
    },
    config = { extra = { retrigger = 3, remaining_uses = 20 } },
    rarity = 3,
    cost = 8,
    atlas = 'martinoli_atlas', -- Ahora coincide con la key de arriba
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    eternal_compat = false,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.retrigger, card.ability.extra.remaining_uses } }
    end,

    calculate = function(self, card, context)
        -- Reactivación de cartas individuales en la mesa
        if context.repetition and context.cardarea == G.play then
            return {
                message = '¡QUÉ!',
                repetitions = card.ability.extra.retrigger,
                card = card
            }
        end

        -- Lógica de usos y bonus por Póker (Four of a Kind)
        if context.after and not context.blueprint then
            if context.scoring_name == "Four of a Kind" then
                card.ability.extra.remaining_uses = card.ability.extra.remaining_uses + 3
                return {
                    message = '¡BALATROTASTICO!',
                    colour = G.C.GREEN
                }
            else
                card.ability.extra.remaining_uses = card.ability.extra.remaining_uses - 1
            end

            -- Si se acaban los usos, se destruye
            if card.ability.extra.remaining_uses <= 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card:start_dissolve() -- Mejor que remove() para que se vea la animación
                        return true
                    end
                }))
                return { message = '¡MÁTATE!' }
            end
        end
    end
})
