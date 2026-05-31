-- lua/autorun/client/cl_survival_hud.lua

surface.CreateFont("SurvivalHUD_Bold", { font = "Roboto", size = 18, weight = 800, antialias = true })
surface.CreateFont("SurvivalHUD_3D", { font = "Roboto", size = 28, weight = 900, antialias = true }) -- Tamaño aumentado para el Rainbow

local lerpedHealth = 100
local lerpedGana = 100
local lerpedEnergia = 100

-- Variables para el Texto Rainbow
local rainbowMsg = ""
local rainbowTime = 0

-- Interceptar mensajes del servidor
net.Receive("Survival_RainbowMsg", function()
    rainbowMsg = net.ReadString()
    rainbowTime = CurTime() + 4 -- El mensaje dura 4 segundos
end)

hook.Add("HUDShouldDraw", "Survival_HideDefaultHUD", function(name)
    if name == "CHudHealth" or name == "CHudBattery" then return false end
end)

local function DrawStatBar(x, y, w, h, iconText, currentValue, maxValue, color)
    draw.RoundedBox(4, x, y, w, h, Color(30, 30, 30, 200))
    local barWidth = (currentValue / maxValue) * (w - 4)
    draw.RoundedBox(4, x + 2, y + 2, math.max(barWidth, 0), h - 4, color)
    draw.SimpleText(iconText .. " " .. math.Round(currentValue) .. "%", "SurvivalHUD_Bold", x + 10, y + (h / 2) - 9, color_white)
end

hook.Add("HUDPaint", "Survival_ModernHUD", function()
    local ply = LocalPlayer()
    if not IsValid(ply) or not ply:Alive() then return end

    -- Renderizar HUD Principal
    local hp = ply:Health()
    local gana = ply:GetNW2Int("Survival_Gana", 100)
    local energia = ply:GetNW2Int("Survival_Energia", 100)
    local totalSeconds = ply:GetNW2Int("Survival_TimeSurvived", 0)

    local mins = math.floor(totalSeconds / 60)
    local secs = totalSeconds % 60
    local timeString = string.format("TIEMPO VIVO: %02d:%02d", mins, secs)

    local frameTime = FrameTime() * 5
    lerpedHealth = Lerp(frameTime, lerpedHealth, hp)
    lerpedGana = Lerp(frameTime, lerpedGana, gana)
    lerpedEnergia = Lerp(frameTime, lerpedEnergia, energia)

    local baseX = 50
    local baseY = ScrH() - 160
    local barW = 250
    local barH = 28

    DrawStatBar(baseX, baseY, barW, barH, "❤ SALUD", lerpedHealth, ply:GetMaxHealth(), Color(220, 50, 50))
    DrawStatBar(baseX, baseY + 35, barW, barH, "🍗 HAMBRE", lerpedGana, 100, Color(220, 150, 50))
    DrawStatBar(baseX, baseY + 70, barW, barH, "⚡ ENERGÍA", lerpedEnergia, 100, Color(50, 150, 220))

    draw.RoundedBox(4, baseX, 40, barW, barH, Color(20, 20, 20, 180))
    draw.SimpleText("⏳ " .. timeString, "SurvivalHUD_Bold", baseX + 10, 45, Color(240, 240, 240))

    if gana <= 20 or energia <= 20 then
        local alpha = math.abs(math.sin(CurTime() * 5)) * 255
        draw.SimpleText("⚠ ¡ESTADO CRÍTICO DE SUPERVIVENCIA! ⚠", "SurvivalHUD_Bold", baseX, baseY - 25, Color(255, 40, 40, alpha))
    end

    -- ==========================================
    -- Renderizar Sistema de Mensajes Rainbow 🌈
    -- ==========================================
    if CurTime() < rainbowTime then
        local timeRemaining = rainbowTime - CurTime()
        local alpha = math.Clamp(timeRemaining * 255, 0, 255) -- Fade out para que desaparezca suavemente
        
        -- Color Rainbow rotatorio usando HSV
        local rainbowColor = HSVToColor((CurTime() * 150) % 360, 1, 1)
        rainbowColor.a = alpha

        local textX = ScrW() / 2
        local textY = ScrH() / 4 -- Dibuja el texto en la parte superior central de la pantalla

        -- Sombra negra para que sea legible
        draw.SimpleText(rainbowMsg, "SurvivalHUD_3D", textX + 2, textY + 2, Color(0, 0, 0, alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        
        -- Texto Multicolor
        draw.SimpleText(rainbowMsg, "SurvivalHUD_3D", textX, textY, rainbowColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
end)