-- Definición del Atlas (Cambiamos la KEY para que coincida con el Joker)
SMODS.Atlas({
    key = "katko_atlas", -- Ahora coincide con atlas = 'katko_atlas'
    path = "katko.png",
    px = 71,
    py = 95
})

SMODS.Joker({
    key = 'katko',
    loc_txt = {
        name = 'Rey Katko',
        text = {
            "{C:chips}+300{} fichas, {C:mult}+150{} Multi,",
            "y {X:mult,C:white}X3{} Multi.",
            "Gana {C:money}$10{} al final de la ronda.",
            "{C:green}Funciona de maravilla con {C:red}CACAHUETE{}",
            "{C:green}y {C:red}Cristian Vidal{}",
            "{C:orange}Aunque fue creado para jugar un color,{}",
            "{C:orange}sirve en todas tus jugadas.{}",
            "{C:red}Todavia no sabe cuando le dara naranjas a la {C:purple}Mai{}",
            "{E:1,C:purple}El Rey Del Color{}"
        }
    },
    config = { extra = { chips = 300, mult = 150, x_mult = 3, money = 10 } },
    rarity = 4,
    cost = 15,
    atlas = 'katko_atlas', -- Coincide con la key de arriba
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 0 },
    blueprint_compat = true,
    
    calculate = function(self, card, context)
        -- Efecto principal en la mano
        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult,
                Xmult_mod = card.ability.extra.x_mult,
                message = '¡El Inteligente!'
            }
        end

        -- Efecto de dinero al final de la ronda
        if context.end_of_round and not context.blueprint and not context.repetition then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    ease_dollars(card.ability.extra.money)
                    card:juice_up()
                    play_sound('coin1')
                    return true
                end
            }))
            return {
                message = '¡$' .. card.ability.extra.money .. '!',
                colour = G.C.MONEY
            }
        end
    end
})
