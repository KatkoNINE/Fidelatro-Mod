--- Carta Espectral: Daniel Weko
--- Ubicación: data/jokers/DanielWeko.lua

SMODS.Consumable {
    key = "daniel_weko",
    set = "Spectral",
    atlas = "dan_at",
    pos = {x = 0, y = 0},
    cost = 0,
    
    -- Fuerza el valor a 0 desde el inicio
    set_ability = function(self, card, initial, delay_sprites)
        card.sell_cost = 0
        card.ability.extra_value = 0
    end,

    loc_txt = {
        name = "Daniel Weko",
        text = {
            "{C:red}Destruye{} todos tus {C:attention}Comodines.",
            "{C:white}Es una completa mierda, la mejor opcion es deshacerte de ella vendiendola a la puta mierda, basura inmunda.{}",       
            "{C:inactive,E:1}Si no quieres vender esta puta mierda de los cojones,{}",
            "{C:inactive,E:1}Usalo elimina todos tus putos comodines de mierda este tonto culiao hijo de la perra.{}",
            "{C:inactive,E:1}y ademas pedazo culiao por que comprariai esta wea inservible aweonao culiao.{}"
        }
    },

    -- Bloqueos de venta
    can_sell = function(self, card) return false end,
    sell = function(self, card) return false end,

    -- Solo usable si hay Jokers para evitar errores
    can_use = function(self, card)
        return G.jokers and #G.jokers.cards > 0
    end,

    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('slice1', 0.96, 0.5)
                
                -- Destrucción masiva de Jokers
                local jokers_to_destroy = {}
                for _, j in ipairs(G.jokers.cards) do
                    table.insert(jokers_to_destroy, j)
                end
                for _, j in ipairs(jokers_to_destroy) do
                    j:start_dissolve()
                end
                return true
            end
        }))
    end
}
