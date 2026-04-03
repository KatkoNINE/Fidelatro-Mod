SMODS.Atlas {
    key = "CristianVidal",
    path = "CristianVidal.png",
    px = 71,
    py = 95,
    px2 = 142,
    py2 = 190
}

SMODS.Joker{
    key = "cristian_vidal",
    loc_txt = {
        name = "Cristian Vidal",
        text = {
            "{X:mult,C:white}X5{} Mult",
            "mmm no mejor hoy"
        }
    },
    rarity = 3,
    cost = 7,
    atlas = "CristianVidal",
    pos = { x = 0, y = 0 },

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                x_mult = 5,
                message = "X5 Mult",
                colour = G.C.MULT
            }
        end
    end
}