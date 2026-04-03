SMODS.Enhancement({
    key = 'vidrio_estrellado', -- Esta key es la que usa Geometria para transformarlas
    atlas = 'vidrio_estrellado_atlas',
    pos = { x = 0, y = 0 },
    config = { bonus_chips = 67, bonus_mult = 67 }, 
    loc_txt = {
        name = 'Vidrio Estrellado',
        text = {
            "{C:chips}+#1#{} fichas y",
            "{C:mult}+#2#{} de Multi.",
            "{C:inactive}Un cristal forjado en las estrellas."
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.bonus_chips, self.config.bonus_mult } }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return {
                mult = self.config.bonus_mult,
                chips = self.config.bonus_chips
            }
        end
    end
})
