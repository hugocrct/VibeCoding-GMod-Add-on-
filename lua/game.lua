SurvivalGame = {}
SurvivalGame.__index = SurvivalGame

function SurvivalGame:new(player)
    local obj = {
        player = player,
        state = "RUNNING",
        currentEvent = nil,
        dificultat = 1
    }
    setmetatable(obj, self)
    return obj
end

function SurvivalGame:setState(state)
    self.state = state
end

function SurvivalGame:tick()
    if self.state ~= "RUNNING" then return end

    -- Stats decay
    self.player.gana = self.player.gana - 1
    self.player.energia = self.player.energia - 1

    -- Difficulty scaling
    self.dificultat = self.dificultat + 0.01

    -- Trigger events
    EventSystem:triggerRandom(self)

    -- Death check
    if self.player.salut <= 0 then
        print("[GAME] Has mort")
        self:setState("GAME_OVER")
    end
end

function SurvivalGame:resolveEvent(optionIndex)
    if not self.currentEvent then return end

    local option = self.currentEvent.options[optionIndex]
    if not option then return end

    option.effect(self.player)

    self.currentEvent = nil
    self:setState("RUNNING")
end
