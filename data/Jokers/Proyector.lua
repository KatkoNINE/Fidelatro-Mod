-- 1. Definición del Atlas (Sincronizado con la Key que pide el error)
SMODS.Atlas({
    key = "ProyectorAtlas", 
    path = "Proyector.png",
    px = 71,
    py = 95
})

-- 2. Definición del Joker
SMODS.Joker({
    key = 'proyector',
    loc_txt = {
        name = 'Proyector',
        text = { 
            "Gana {C:chips}+10{} Fichas y {C:mult}+10{} Mult.",
            "si la mano jugada es un {C:attention}Color{}",
            "{C:inactive}(Actual: {C:chips}+#1#{} Fichas, {C:mult}+#2#{} Mult.)"
        }
    },
    config = { extra = { current_chips = 0, current_mult = 0 } },
    rarity = 2,
    cost = 4,
    atlas = "ProyectorAtlas", -- ¡ESTO DEBE SER IGUAL A LA KEY DEL ATLAS!
    pos = { x = 0, y = 0 },
    blueprint_compat = true,

    -- Variables para mostrar los números actuales en el texto de la carta
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.current_chips, card.ability.extra.current_mult } }
    end,

    calculate = function(self, card, context)
        -- 1. Aplicar el bono acumulado al puntaje de la mano
        if context.joker_main then
            if card.ability.extra.current_chips > 0 or card.ability.extra.current_mult > 0 then
                return {
                    chip_mod = card.ability.extra.current_chips,
                    mult_mod = card.ability.extra.current_mult,
                    message = '¡Proyectado!',
                    colour = G.C.CHIPS
                }
            end
        end

        -- 2. Mejorar estadísticas si la mano es un Color (Flush)
        -- Usamos 'context.before' para que suba antes de calcular el puntaje final
        if context.before and not context.blueprint then
            if context.scoring_name == 'Flush' then
                card.ability.extra.current_chips = card.ability.extra.current_chips + 10
                card.ability.extra.current_mult = card.ability.extra.current_mult + 10
                
                -- Efecto visual de subida
                return {
                    message = '¡Mejora!',
                    colour = G.C.MULT,
                    card = card
                }
            end
        end
    end
})
