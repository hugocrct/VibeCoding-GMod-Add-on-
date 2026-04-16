if CLIENT then

    SurvivalData = SurvivalData or {
        salut = 100,
        gana = 100,
        energia = 100
    }

    net.Receive("SurvivalSync", function()
        SurvivalData.salut = net.ReadInt(16)
        SurvivalData.gana = net.ReadInt(16)
        SurvivalData.energia = net.ReadInt(16)
    end)

    surface.CreateFont("SurvivalHUDFont", {
        font = "Arial",
        size = 22,
        weight = 800
    })

    hook.Add("HUDPaint", "SurvivalHUD", function()

        local d = SurvivalData
        if not d then return end

        draw.SimpleText("SALUT: " .. d.salut, "SurvivalHUDFont", 50, 50, Color(255,80,80))
        draw.SimpleText("GANA: " .. d.gana, "SurvivalHUDFont", 50, 80, Color(255,200,80))
        draw.SimpleText("ENERGIA: " .. d.energia, "SurvivalHUDFont", 50, 110, Color(80,200,255))

        if d.salut <= 30 then
            draw.SimpleText("⚠ SALUT CRÍTICA ⚠", "SurvivalHUDFont", 50, 150, Color(255,0,0))
        end

        -- 🎮 UI DE EVENTO
        if GAME and GAME.gameState == "EVENT" then
            draw.SimpleText("⚠ EVENT ACTIU ⚠", "SurvivalHUDFont", 50, 200, Color(255,0,0))
            draw.SimpleText("1 - Opció A", "SurvivalHUDFont", 50, 230, color_white)
            draw.SimpleText("2 - Opció B", "SurvivalHUDFont", 50, 260, color_white)
        end

    end)
end