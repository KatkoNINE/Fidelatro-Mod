SMODS.Joker {
    key = 'tiopino',
    loc_txt = {
        name = 'Tío Pino',
        text = {
            "Otorga {X:mult,C:white}X6{} de Mult.",
            "{C:green}#1# en #2#{} de probabilidades de",
            "convertirse en {C:attention}Polvo{}",
            "al finalizar la ronda."
        }
    },
    config = { extra = { x_mult = 6, odds = 14 } },
    rarity = 3, -- Rara
    cost = 8,
    blueprint_compat = true,
    atlas = 'tiopino_atlas',
    pos = { x = 0, y = 0 },

    -- Esto define las variables para el texto (el 1 en 14)
    loc_vars = function(self, info_queue, card)
        return { vars = { G.GAME.probabilities.normal or 1, card.ability.extra.odds } }
    end,

    -- TODA la lógica debe ir dentro de esta función
    calculate = function(self, card, context)
        -- 1. Efecto de Multiplicador X6 durante la mano
        if context.joker_main then
            return {
                message = 'X' .. card.ability.extra.x_mult,
                Xmult_mod = card.ability.extra.x_mult
            }
        end

        -- 2. Lógica de transformación al FINAL de la ronda
        if context.end_of_round and not context.blueprint and not context.repetition then
            -- Verificación de probabilidad (afectada por dados/Solo Seises)
            if pseudorandom('tiopino_transform') < G.GAME.probabilities.normal / card.ability.extra.odds then
                
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        -- Creamos el Polvo usando tu prefijo 'azpr'
                        local new_card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_azpr_polvo', 'tiopino_conversion')
                        
                        new_card:add_to_deck()
                        G.jokers:emplace(new_card)
                        
                        -- Eliminamos al Tío Pino
                        card:remove()
                        
                        -- Efectos visuales y sonido
                        play_sound('tarot1')
                        new_card:juice_up(0.3, 0.5)
                        
                        return true
                    end
                }))
                return {
                    message = "¡Hecho Polvo!",
                    colour = G.C.PURPLE
                }
            end
        end
    end
}
