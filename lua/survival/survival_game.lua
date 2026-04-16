print("[SurvivalGame] Carregant addon...")

-- 📦 1. Cargar lógica base (sin dependencias)
include("survival/player.lua")
include("survival/events.lua")
include("survival/game.lua")

-- 🧠 2. Crear instancia global ANTES de comandos
GAME = SurvivalGame:new()

-- 🎮 3. Ahora sí cargar sistemas que usan GAME
include("survival/commands.lua")

-- 🖥️ 4. HUD (cliente)
include("survival/hud.lua") -- 🔥 NUEVO

print("[SurvivalGame] Addon carregat correctament")