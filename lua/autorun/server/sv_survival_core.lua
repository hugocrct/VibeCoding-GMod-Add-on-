-- lua/autorun/server/sv_survival_core.lua

util.AddNetworkString("Survival_RainbowMsg")

-- Función global para enviar mensajes multicolores a la pantalla
function Survival_SendRainbowMessage(ply, text)
    if not IsValid(ply) then return end
    net.Start("Survival_RainbowMsg")
    net.WriteString(text)
    net.Send(ply)
end

local TICK_RATE = 2 
local MAX_STAT = 100

local AMMO_REWARDS = { "Pistol", "SMG1", "357", "Buckshot", "AR2", "XBowBolt", "SMG1_Grenade" }

hook.Add("PlayerSpawn", "Survival_InitStats", function(ply)
    ply:SetNW2Int("Survival_Gana", MAX_STAT)
    ply:SetNW2Int("Survival_Energia", MAX_STAT)
    
    ply.Survival_SecondsAlive = 0
    ply.Survival_DistanceWalked = 0
    ply.Survival_NextSpawnDistance = math.random(800, 1600) 
    ply.Survival_LastPosition = ply:GetPos()
    
    ply.Survival_Gana_TickCount = 0
    ply.Survival_Energia_TickCount = 0
end)

timer.Create("Survival_GameLoop", TICK_RATE, 0, function()
    local ply = Entity(1) 
    
    if IsValid(ply) and ply:Alive() then
        local gana = ply:GetNW2Int("Survival_Gana", MAX_STAT)
        local energia = ply:GetNW2Int("Survival_Energia", MAX_STAT)

        gana = math.max(gana - 1, 0)

        ply.Survival_Energia_TickCount = (ply.Survival_Energia_TickCount or 0) + 1
        if ply.Survival_Energia_TickCount >= 2 then
            energia = math.max(energia - 1, 0)
            ply.Survival_Energia_TickCount = 0
        end

        ply:SetNW2Int("Survival_Gana", gana)
        ply:SetNW2Int("Survival_Energia", energia)

        if gana <= 0 or energia <= 0 then
            ply:Kill()
            if gana <= 0 then
                Survival_SendRainbowMessage(ply, "💀 HAS MUERTO POR INANICIÓN EXTREMA 💀")
            else
                Survival_SendRainbowMessage(ply, "💀 HAS MUERTO POR COLAPSO FÍSICO 💀")
            end
            return
        end

        if energia <= 15 then
            ply:SetWalkSpeed(90)
            ply:SetRunSpeed(130)
        else
            ply:SetWalkSpeed(200)
            ply:SetRunSpeed(400)
        end

        ply.Survival_SecondsAlive = (ply.Survival_SecondsAlive or 0) + TICK_RATE
        ply:SetNW2Int("Survival_TimeSurvived", ply.Survival_SecondsAlive)

        local currentPos = ply:GetPos()
        local dist = currentPos:Distance(ply.Survival_LastPosition or currentPos)
        
        if dist > 0 and dist < 800 then
            ply.Survival_DistanceWalked = (ply.Survival_DistanceWalked or 0) + dist
            
            if ply.Survival_DistanceWalked >= ply.Survival_NextSpawnDistance then
                ply.Survival_DistanceWalked = 0
                ply.Survival_NextSpawnDistance = math.random(900, 2000) 
                
                if isfunction(Survival_TriggerExplorationEvent) then
                    Survival_TriggerExplorationEvent(ply)
                end
            end
        end
        ply.Survival_LastPosition = currentPos
    end
end)

hook.Add("OnNPCKilled", "Survival_AmmoReward", function(npc, attacker, inflictor)
    if IsValid(attacker) and attacker:IsPlayer() then
        attacker:EmitSound("items/ammo_pickup.wav", 75, 110)
        for _, ammoType in ipairs(AMMO_REWARDS) do
            local amount = math.random(10, 25)
            if ammoType == "Buckshot" then amount = math.random(4, 8) end
            if ammoType == "SMG1_Grenade" then amount = 1 end
            attacker:GiveAmmo(amount, ammoType, false)
        end
        Survival_SendRainbowMessage(attacker, "¡MUNICIÓN REABASTECIDA!")
    end
end)