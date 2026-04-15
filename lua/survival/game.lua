-- GAME MODULE

SurvivalGame = {}
SurvivalGame.__index = SurvivalGame

function SurvivalGame:new()
    local obj = {
        player = SurvivalPlayer:new(),
        enMarxa = false,
        tickRate = 5
    }
    setmetatable(obj, self)
    return obj
end

function SurvivalGame:start()
    if self.enMarxa then return end

    self.enMarxa = true
    print("[Joc] Joc iniciat")

    timer.Create("SurvivalGameLoop", self.tickRate, 0, function()
        if not self.enMarxa then return end

        self.player:update()
        EventSystem:triggerRandom(self.player)

        print("[Tick] " .. self.player:getEstat())

        if not self.player.viu then
            print("[Joc] Fi del joc")
            self:stop()
        end
    end)
end

function SurvivalGame:stop()
    self.enMarxa = false
    timer.Remove("SurvivalGameLoop")
    print("[Joc] Joc aturat")
end

function SurvivalGame:restart()
    print("[Joc] Reiniciant joc...")
    self:stop()
    self.player = SurvivalPlayer:new()
    self:start()
end

-- Instància global
GAME = SurvivalGame:new()