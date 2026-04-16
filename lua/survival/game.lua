SurvivalGame = SurvivalGame or {}
SurvivalGame.__index = SurvivalGame

function SurvivalGame:new()
    local obj = {
        player = SurvivalPlayer:new(),
        enMarxa = false,
        tickRate = 5,

        gameState = "RUNNING",
        currentEvent = nil
    }

    setmetatable(obj, self)
    return obj
end

function SurvivalGame:setState(state)
    self.gameState = state
end

function SurvivalGame:resolveEvent(option)
    if not self.currentEvent then return end

    self.currentEvent(self.player, option)

    self.currentEvent = nil
    self:setState("RUNNING")
end

function SurvivalGame:start()
    if self.enMarxa then return end

    self.enMarxa = true
    print("[Joc] Joc iniciat")

    timer.Create("SurvivalGameLoop", self.tickRate, 0, function()
        if not self.enMarxa then return end
        if self.gameState ~= "RUNNING" then return end

        self.player:update()
        EventSystem:triggerRandom(self)

        print("[Tick] " .. self.player:getEstat())

        if self.player.salut < 30 then print("[WARNING] Salut crítica!") end
        if self.player.gana < 20 then print("[WARNING] Gana molt baixa!") end
        if self.player.energia < 20 then print("[WARNING] Energia molt baixa!") end

        if not self.player.viu then
            print("[Joc] Fi del joc")
            self:stop()
        end

        if SERVER then
            net.Start("SurvivalSync")
                net.WriteInt(self.player.salut, 16)
                net.WriteInt(self.player.gana, 16)
                net.WriteInt(self.player.energia, 16)
            net.Broadcast()
        end
    end)
end

function SurvivalGame:stop()
    self.enMarxa = false
    timer.Remove("SurvivalGameLoop")
    print("[Joc] Joc aturat")
end