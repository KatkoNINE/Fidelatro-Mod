-- Definición del Atlas
SMODS.Atlas {
    key = 'aberracion_atlas',
    path = 'aberracionhumana.png', 
    px = 71,
    py = 95
}

SMODS.Spectral {
    key = 'invocacion_aleatoria_papurris',
    atlas = 'aberracion_atlas',
    pos = { x = 0, y = 0 },
    rarity = 4,
    cost = 4,
    loc_txt = {
        name = 'Aberración Humana',
        text = {
            "Crea un {C:attention}Comodín{} aleatorio",
            "del {C:purple}Papurrisitos mod{}",
            "{C:inactive}(Debe haber espacio)"
        }
    },

    can_use = function(self, card)
        -- Verifica si hay espacio en la zona de Jokers
        return G.jokers and #G.jokers.cards < G.jokers.config.card_limit
    end,

    use = function(self, card, area, copier)
        local papurris_jokers = {}
        
        -- Recorremos todos los objetos del juego
        for k, v in pairs(G.P_CENTERS) do
            -- Busca CUALQUIER Joker que pertenezca a tu mod (prefijo azpr)
            -- Esto incluirá automáticamente a Tío Pino y Polvo si sus archivos están cargados
            if v.set == 'Joker' and string.find(k, "azpr") then
                table.insert(papurris_jokers, k)
            end
        end

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                -- Selecciona uno al azar de la lista (donde ya estarán Tío Pino y Polvo)
                local chosen_joker = #papurris_jokers > 0 and papurris_jokers[math.random(#papurris_jokers)] or 'j_joker'
                
                local _card = create_card('Joker', G.jokers, nil, nil, nil, nil, chosen_joker, 'aberracion')
                _card:add_to_deck()
                G.jokers:emplace(_card)
                
                -- Efecto visual
                _card:juice_up(0.3, 0.5)
                return true
            end
        }))
    end
}
