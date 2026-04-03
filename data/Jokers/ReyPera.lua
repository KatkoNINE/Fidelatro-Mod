--- ReyPera.lua
SMODS.Joker {
    key = 'reypera',
    loc_txt = {
        name = 'Rey Pera',
        text = {
            "Otorga {C:mult}+#1#{} de Multi,",
            "pierde {C:red}-#2#{} de Multi",
            "al finalizar cada ronda.",
            "{C:inactive}(Esas guatonas quieren pura pera){}"
        }
    },
    -- 507 / 13 = 39 exactos por ronda
    config = { extra = { mult = 507, loss = 39 } },
    rarity = 3, 
    pos = { x = 0, y = 0 },
    atlas = 'reypera_atlas',
    cost = 10,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,

    -- Variables para el texto dinámico
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.loss } }
    end,

    -- Lógica de juego
    calculate = function(self, card, context)
        -- Sumar Multi durante el juego de la mano
        if context.joker_main then
            return {
                mult_mod = card.ability.extra.mult,
                message = '+' .. card.ability.extra.mult .. ' Multi'
            }
        end

        -- Reducción y Destrucción al final de la ronda
        if context.end_of_round and not context.blueprint and not context.repetition then
            -- Restamos 39 al multiplicador
            card.ability.extra.mult = math.max(0, card.ability.extra.mult - card.ability.extra.loss)
            
            -- Si llega a 0 (al final de la ronda 13), se destruye
            if card.ability.extra.mult <= 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card:juice_up(0.3, 0.5)
                        card:start_dissolve()
                        return true
                    end
                }))
                return {
                    message = "¡Se acabó la Pera!",
                    colour = G.C.RED
                }
            else
                -- Notificar la pérdida de multi (-39)
                return {
                    message = '-' .. card.ability.extra.loss .. ' Multi',
                    colour = G.C.RED
                }
            end
        end
    end
}

-- Definición de texturas (reypera.png y reypera2.png)
SMODS.Atlas {
    key = "reypera_atlas",
    path = "reypera.png", 
    px = 71,
    py = 95
}
