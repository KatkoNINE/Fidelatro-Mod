SMODS.Consumable({
    key = 'chuchetupico',
    set = 'Planet',
    atlas = 'chuchetupico_atlas',
    pos = { x = 0, y = 0 },
    config = { extra = 3 }, 
    loc_txt = {
        name = 'Chuchetupico',
        text = {
            "Eleva el nivel de {C:attention}Quintilla{},",
            "{C:attention}Póker{}, {C:attention}Escalera Corrida{},",
            "{C:attention}Color{} y {C:attention}Carta Mas Alta{}",
            "en {C:attention}+#1#{} niveles cada una."
        }
    },
    
    loc_vars = function(self, info_queue, card)
        return { vars = { (card and card.config and card.config.extra) or 3 } }
    end,

    use = function(self, card, area, copier)
        local manos = {
            ["Five of a Kind"] = true,
            ["Four of a Kind"] = true,
            ["Straight Flush"] = true,
            ["Flush"] = true,
            ["High Card"] = true
        }

        -- Actualizamos los niveles manualmente para evitar que Talisman rompa la animación
        for k, v in pairs(G.GAME.hands) do
            if manos[k] then
                -- Subimos el nivel directamente en la tabla del juego
                G.GAME.hands[k].level = math.max(0, G.GAME.hands[k].level + 3)
                -- Multiplicamos los stats base (esto es lo que hace level_up_hand por dentro)
                G.GAME.hands[k].mult = math.max(G.GAME.hands[k].mult + G.GAME.hands[k].l_mult * 3)
                G.GAME.hands[k].chips = math.max(G.GAME.hands[k].chips + G.GAME.hands[k].l_chips * 3)
            end
        end

        -- Mensaje simple en pantalla para confirmar que funcionó
        attention_text({
            text = '¡CHUCHETUPICO!',
            scale = 1.3, 
            hold = 1.4,
            major = card,
            backdrop_colour = G.C.SECONDARY_SET.Planet,
            align = 'cm',
            offset = {x = 0, y = -2}
        })
    end,

    can_use = function(self, card)
        return true
    end
})
