if SERVER then
    util.AddNetworkString("SurvivalSync")
    util.AddNetworkString("SurvivalSound")
end
print("[SurvivalGame] Carregant addon...")

include("survival/game.lua")
include("survival/player.lua")
include("survival/events.lua")

GAME = SurvivalGame:new()

include("survival/commands.lua")
include("survival/hud.lua")
if SERVER then
    util.AddNetworkString("SurvivalSync")
end

SurvivalData = SurvivalData or {}
print("[SurvivalGame] Addon carregat correctament")