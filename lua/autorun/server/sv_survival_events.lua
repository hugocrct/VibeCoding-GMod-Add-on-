-- lua/autorun/server/sv_survival_events.lua

local function FindSpawnPoint(ply, min_dist, max_dist)
    local plyPos = ply:GetPos()
    
    -- Aumentamos a 10 intentos para buscar zonas limpias
    for i = 1, 10 do
        local angle = math.random(0, 360)
        local rad = math.rad(angle)
        local dist = math.random(min_dist, max_dist)
        local targetPos = plyPos + Vector(math.cos(rad) * dist, math.sin(rad) * dist, 45)
        
        local trHorizontal = util.TraceHull({
            start = plyPos + Vector(0, 0, 32), endpos = targetPos,
            mins = Vector(-16, -16, 0), maxs = Vector(16, 16, 72), filter = ply
        })
        
        -- EVITA SPAWNEAR ENCIMA DEL JUGADOR (Sin usar "continue")
        if not (trHorizontal.Hit and trHorizontal.HitPos:Distance(plyPos) < 120) then
            local safePos = trHorizontal.HitPos
            if trHorizontal.Hit then safePos = safePos - trHorizontal.Normal * 35 end
            
            local trVertical = util.TraceHull({
                start = safePos, endpos = safePos - Vector(0, 0, 600),
                mins = Vector(-16, -16, 0), maxs = Vector(16, 16, 72), filter = ply
            })
            
            local spawnPos = trVertical.HitPos + Vector(0, 0, 10)
            
            -- Doble comprobación: Suelo sólido Y debe estar lejos de ti
            if trVertical.Hit and not trVertical.StartSolid and util.IsInWorld(spawnPos) then
                if spawnPos:Distance(plyPos) >= 120 then
                    return spawnPos
                end
            end
        end
    end
    
    -- FALLBACK ANTI-BUGS MEJORADO: Trazamos un rayo hacia adelante para no atravesar la pared que mires
    local forward = ply:GetForward()
    forward.z = 0
    forward:Normalize()
    
    local trFallback = util.TraceLine({
        start = plyPos + Vector(0, 0, 32),
        endpos = plyPos + forward * 200 + Vector(0, 0, 32),
        filter = ply
    })
    
    -- Si choca con una pared delante de ti, retrocede para dejarlo en el suelo a tus pies
    local finalFallbackPos = trFallback.HitPos
    if trFallback.Hit then
        finalFallbackPos = finalFallbackPos - trFallback.Normal * 30
    end
    
    return finalFallbackPos - Vector(0, 0, 20)
end

local function GetProgressiveNPC(currentMinute)
    if currentMinute >= 4 then return table.Random({"npc_antlionguard", "npc_fastzombie", "npc_poisonzombie"})
    elseif currentMinute == 3 then return table.Random({"npc_fastzombie", "npc_poisonzombie", "npc_zombie_fast"})
    elseif currentMinute == 2 then return table.Random({"npc_zombie", "npc_headcrab_fast", "npc_fastzombie"})
    elseif currentMinute == 1 then return table.Random({"npc_zombie", "npc_headcrab_fast"})
    else return table.Random({"npc_zombie", "npc_headcrab"}) end
end

function Survival_TriggerExplorationEvent(ply)
    if not IsValid(ply) or not ply:Alive() then return end
    local secondsAlive = ply.Survival_SecondsAlive or 0
    local currentMinute = math.floor(secondsAlive / 60)

    local maxChance = 100
    if ply:Health() >= 50 then maxChance = 95 end

    local chance = math.random(1, maxChance)

    if chance <= 50 then
        local spawnCount = 1
        if currentMinute >= 1 then spawnCount = math.random(1, math.min(1 + currentMinute, 4)) end
        local spawnedAny = false

        for i = 1, spawnCount do
            local npcClass = GetProgressiveNPC(currentMinute)
            local pos = FindSpawnPoint(ply, 240, 520) 
            local npc = ents.Create(npcClass)
            if IsValid(npc) then
                npc:SetPos(pos)
                npc:Spawn()
                npc:SetTarget(ply)
                if npc:IsNPC() then 
                    npc:SetEnemy(ply) 
                    npc:UpdateEnemyMemory(ply, ply:GetPos())
                    if currentMinute >= 2 then
                        npc:SetMaxHealth(npc:GetMaxHealth() + (currentMinute * 25))
                        npc:SetHealth(npc:GetMaxHealth())
                    end
                end
                spawnedAny = true
            end
        end
        if spawnedAny then
            ply:EmitSound("ambient/creatures/town_moan1.wav", 85, 90 + math.min(currentMinute * 3, 20))
            if spawnCount > 1 then 
                Survival_SendRainbowMessage(ply, "¡UNA JAURÍA DE " .. spawnCount .. " CRIATURAS TE EMBOSCA!")
            else 
                Survival_SendRainbowMessage(ply, "¡TUS PASOS HAN ALERTADO A UNA CRIATURA!") 
            end
        end
        
    elseif chance > 50 and chance <= 80 then
        local pos = FindSpawnPoint(ply, 120, 350)
        local food = ents.Create("ent_survival_food")
        if IsValid(food) then
            food:SetPos(pos)
            food:Spawn()
            Survival_SendRainbowMessage(ply, "¡HAS ENCONTRADO RACIONES DE COMIDA!")
        end
        
    elseif chance > 80 and chance <= 95 then
        local pos = FindSpawnPoint(ply, 120, 350)
        local bed = ents.Create("ent_survival_bed")
        if IsValid(bed) then
            bed:SetPos(pos)
            bed:Spawn()
            Survival_SendRainbowMessage(ply, "¡UN COLCHÓN ABANDONADO A LA VISTA!")
        end
        
    else
        local pos = FindSpawnPoint(ply, 100, 300)
        local medkit = ents.Create("ent_survival_medkit")
        if IsValid(medkit) then
            medkit:SetPos(pos)
            medkit:Spawn()
            ply:EmitSound("items/suitchargeok1.wav", 75, 100)
            Survival_SendRainbowMessage(ply, "¡SUERTE EXTREMA! BOTIQUÍN MILITAR LOCALIZADO")
        end
    end
end