-- 1. Definición del Atlas (DEBE IR ARRIBA)
SMODS.Atlas {
    key = 'brandon_atlas',
    path = 'BrandonTitan.png', 
    px = 71,
    py = 95
}

-- 2. Definición del Tarot
SMODS.Tarot {
    key = 'BrandonTitan',
    name = "Brandon el Titán",
    config = { extra = { money_loss = 10 } }, 
    pos = { x = 0, y = 0 },
    atlas = 'brandon_atlas',
    loc_txt = {
        name = 'Brandon el Titán',
        text = {
            "Pierdes {C:money}-$#1#{}",
            "Crea un {C:attention}Comodín Raro{}",
            "{C:inactive}(Debe haber espacio)"
        }
    },

    -- Función para mostrar el valor de pérdida de dinero en el texto
    loc_vars = function(self, info_queue, card)
        return { vars = { (card and card.ability and card.ability.extra) and card.ability.extra.money_loss or self.config.extra.money_loss } }
    end,

    -- Solo se puede usar si tienes espacio para un Joker más
    can_use = function(self, card)
        return G.jokers and #G.jokers.cards < G.jokers.config.card_limit
    end,

    use = function(self, card, area, copier)
        -- Restar los 10 de dinero
        local loss = (card and card.ability and card.ability.extra) and card.ability.extra.money_loss or 10
        ease_dollars(-loss)
        
        -- Evento para crear el Joker Raro
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                -- rarity 0.99 asegura prácticamente un Joker Raro (Rarity 3)
                local _card = create_card('Joker', G.jokers, nil, 0.99, nil, nil, nil, 'brandon_titan_spawn')
                _card:add_to_deck()
                G.jokers:emplace(_card)
                -- Efecto visual para que se vea que apareció
                _card:juice_up(0.3, 0.5)
                return true
            end
        }))
    end
}
