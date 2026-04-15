-- COMMAND HANDLER

concommand.Add("sg_iniciar", function()
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