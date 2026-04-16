-- COMMAND HANDLER
print("[DEBUG] commands.lua carregat")
concommand.Add("sg_iniciar", function()
    if not GAME then
        print("[ERROR] GAME no existe aún (fallo de carga)")
        return
    end

    GAME:start()
end)

concommand.Add("sg_aturar", function()
    GAME:stop()
end)

concommand.Add("sg_estat", function()
    print(GAME.player:getEstat())
end)

concommand.Add("sg_menjar", function()
    GAME.player:menjar()
end)

concommand.Add("sg_dormir", function()
    GAME.player:dormir()
end)

concommand.Add("sg_explorar", function()
    print("[Acció] Explores...")
    EventSystem:triggerRandom(GAME.player)
end)

concommand.Add("sg_reiniciar", function()
    GAME:restart()
end)

-- TESTING

concommand.Add("sg_forcar_event", function()
    print("[TEST] Forçant esdeveniment")
    EventSystem:triggerRandom(GAME.player)
end)

concommand.Add("sg_set_stat", function(_, _, args)
    local stat = args[1]
    local valor = tonumber(args[2])

    if GAME.player[stat] and valor then
        GAME.player[stat] = valor
        print("[TEST] " .. stat .. " canviat a " .. valor)
    else
        print("[TEST] Ús: sg_set_stat <salut|gana|energia> <valor>")
    end
end)
concommand.Add("event_1", function()
    if GAME and GAME.gameState == "EVENT" then
        GAME:resolveEvent(1)
    end
end)

concommand.Add("event_2", function()
    if GAME and GAME.gameState == "EVENT" then
        GAME:resolveEvent(2)
    end
end)