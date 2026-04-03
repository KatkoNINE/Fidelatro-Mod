SMODS.Joker({
    key = 'gato_void',
    loc_txt = {
        name = 'Gato Void',
        text = {
            "Copia la habilidad del {C:attention}comodín{}",
            "en el extremo {C:attention}derecho{}.",
            "Otorga siempre {X:mult,C:white}X4{} de Multi.",
            "{C:inactive}(Objetivo: #1#)"
        }
    },
    config = { extra = { x_mult = 4 } }, -- Ajustado a X4
    rarity = 4,
    cost = 20,
    atlas = 'gato_void_atlas',
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 0 },
    blueprint_compat = false, 

    loc_vars = function(self, info_queue, card)
        local target_name = "{C:red}Ninguno{}"
        if G.jokers and G.jokers.cards and #G.jokers.cards > 0 then
            local target = G.jokers.cards[#G.jokers.cards]
            if target == card then
                target_name = "{C:inactive}Él mismo{}"
            else
                target_name = "{C:green}" .. (target.ability.name or "Comodín") .. "{}"
            end
        end
        return { vars = { target_name } }
    end,
    
    calculate = function(self, card, context)
        -- 1. LOCALIZAR AL JOKER DEL EXTREMO DERECHO
        local extreme_right_joker = G.jokers.cards[#G.jokers.cards]

        -- 2. LÓGICA DE COPIA (Si no es el propio Gato Void)
        if extreme_right_joker and extreme_right_joker ~= card then
            context.blueprint = (context.blueprint or 0) + 1
            local copy = extreme_right_joker:calculate_joker(context)
            context.blueprint = context.blueprint - 1
            
            if copy then
                -- Si es el momento de puntuar, aplicamos el X4 sobre el efecto copiado
                if context.joker_main then
                    copy.Xmult_mod = (copy.Xmult_mod or 1) * card.ability.extra.x_mult
                    copy.message = '¡Void X' .. card.ability.extra.x_mult .. '!'
                end
                copy.card = card
                return copy
            end
        end

        -- 3. EFECTO BASE (Si no hay copia o es él mismo, da su X4)
        if context.joker_main then
            return {
                message = 'X' .. card.ability.extra.x_mult,
                Xmult_mod = card.ability.extra.x_mult
            }
        end
    end
})
