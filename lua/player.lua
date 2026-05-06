SurvivalPlayer = {}
SurvivalPlayer.__index = SurvivalPlayer

function SurvivalPlayer:new()
    local obj = {
        salut = 100,
        gana = 100,
        energia = 100,
        nivell = 1,
        xp = 0
    }
    setmetatable(obj, self)
    return obj
end

function SurvivalPlayer:addXP(amount)
    self.xp = self.xp + amount

    if self.xp >= 100 then
        self.xp = 0
        self.nivell = self.nivell + 1

        print("[PROGRES] Has pujat a nivell " .. self.nivell)

        -- Mejora automática
        self.salut = self.salut + 10
    end
end
