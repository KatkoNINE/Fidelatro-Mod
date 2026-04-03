SMODS.Consumable({
    key = 'geometria',
    set = 'Tarot',
    atlas = 'geometria_atlas',
    pos = { x = 0, y = 0 },
    config = { max_highlighted = 2 }, 
    loc_txt = {
        name = 'Geometría',
        text = {
            "Transforma hasta {C:attention}2{} cartas",
            "seleccionadas en",
            "{C:attention}Vidrio Estrellado{}."
        }
    },

    loc_vars = function(self, info_queue, card)
        -- Buscamos la mejora para mostrar el tooltip al lado
        local mejora_encontrada = nil
        for k, v in pairs(G.P_CENTERS) do
            if k:find("vidrio_estrellado") and v.set == 'Enhanced' then
                mejora_encontrada = v
                break
            end
        end
        if mejora_encontrada then info_queue[#info_queue+1] = mejora_encontrada end
        return { vars = { 2 } }
    end,

    use = function(self, card, area, copier)
        -- BUSCADOR INTELIGENTE DE MEJORA
        local mejora_final = nil
        for k, v in pairs(G.P_CENTERS) do
            -- Buscamos cualquier llave que tenga "vidrio_estrellado" y sea una mejora
            if k:find("vidrio_estrellado") and v.set == 'Enhanced' then
                mejora_final = v
                break
            end
        end

        if mejora_final then
            for i = 1, #G.hand.highlighted do
                local highlighted_card = G.hand.highlighted[i]
                -- Aplicamos la mejora encontrada
                highlighted_card:set_ability(mejora_final, nil, true)
                highlighted_card:juice_up()
            end
        else
            -- Si no la encuentra, te avisará en la consola de DebugPlus
            sendDebugMessage("GEOMETRÍA ERROR: No se encontró ninguna mejora con 'vidrio_estrellado'")
        end
    end,

    can_use = function(self, card)
        return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= 2
    end
})
