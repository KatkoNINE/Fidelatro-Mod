--- Mod Papurrisitos
--- Autor: KATKONINE

-------------------------------------------------------
-- 2. REGISTRO DE ATLAS
-------------------------------------------------------
-- Daniel primero en los Atlas
SMODS.Atlas({ key = "dan_at", path = "Daniel.png", px = 71, py = 95 })

SMODS.Atlas({ key = "brandon_atlas", path = "BrandonTitan.png", px = 71, py = 95 })
SMODS.Atlas({ key = "aberracion_atlas", path = "aberracionhumana.png", px = 71, py = 95 })
SMODS.Atlas({ key = "gato_void_atlas", path = "GatoVoid.png", px = 71, py = 95 })
SMODS.Atlas({ key = "katko_atlas", path = "katko.png", px = 71, py = 95 })
SMODS.Atlas({ key = "martinoli_atlas", path = "Martinoli.png", px = 71, py = 95 })
SMODS.Atlas({ key = "joker_naranja_atlas", path = "Naranja.png", px = 71, py = 95 })
SMODS.Atlas({ key = "reina_mai_atlas", path = "ReinaMai.png", px = 71, py = 95 })
SMODS.Atlas({ key = "BrandonVoidAtlas", path = "BrandonVoid.png", px = 71, py = 95 })
SMODS.Atlas({ key = "ProyectorAtlas", path = "Proyector.png", px = 71, py = 95 })
SMODS.Atlas({ key = "burger_atlas", path = "Burger.png", px = 71, py = 95 })
SMODS.Atlas({ key = "SergioAtlas", path = "sergio.png", px = 71, py = 95 })
SMODS.Atlas({ key = "Gabrielongo", path = "Gabrielongo.png", px = 71, py = 95 })
SMODS.Atlas({ key = "CristianVidal", path = "CristianVidal.png", px = 71, py = 95 })
SMODS.Atlas({ key = "SinNombre", path = "SinNombre.png", px = 71, py = 95 })
SMODS.Atlas({ key = "chuchetupico_atlas", path = "chuchetupico.png", px = 71, py = 95 })
SMODS.Atlas({ key = "geometria_atlas", path = "Geometria.png", px = 71, py = 95 })
SMODS.Atlas({ key = "vidrio_estrellado_atlas", path = "VidrioEstrellado.png", px = 71, py = 95 })

-- Nuevos Atlas añadidos
SMODS.Atlas({ key = "tiopino_atlas", path = "TioPino.png", px = 71, py = 95 })
SMODS.Atlas({ key = "polvo_atlas", path = "Polvo.png", px = 71, py = 95 })
SMODS.Atlas({ key = "reypera_atlas", path = "reypera.png", px = 71, py = 95 }) -- Registro del Atlas para Rey Pera

-------------------------------------------------------
-- 3. CARGA DE ARCHIVOS LUA
-------------------------------------------------------

SMODS.load_file("data/jokers/DanielWeko.lua")()
SMODS.load_file("data/jokers/VidrioEstrellado.lua")()
SMODS.load_file("data/jokers/Geometria.lua")()
SMODS.load_file("data/jokers/BrandonTitan.lua")()
SMODS.load_file("data/jokers/AberracionHumana.lua")()
SMODS.load_file("data/jokers/GatoVoid.lua")()
SMODS.load_file("data/jokers/Katko.lua")()
SMODS.load_file("data/jokers/Martin.lua")()
SMODS.load_file("data/jokers/Naranja.lua")()
SMODS.load_file("data/jokers/ReinaMai.lua")()
SMODS.load_file("data/jokers/BrandonVoid.lua")()
SMODS.load_file("data/jokers/Proyector.lua")()
SMODS.load_file("data/jokers/Burger.lua")()
SMODS.load_file("data/jokers/Sergio.lua")()
SMODS.load_file("data/jokers/Gabrielongo.lua")()
SMODS.load_file("data/jokers/CristianVidal.lua")()
SMODS.load_file("data/jokers/SinNombre.lua")()
SMODS.load_file("data/jokers/Chuchetupico.lua")()

SMODS.load_file("data/jokers/TioPino.lua")()
SMODS.load_file("data/jokers/Polvo.lua")()
SMODS.load_file("data/jokers/ReyPera.lua")()
