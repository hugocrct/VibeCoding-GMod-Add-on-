-- PLAYER MODULE

SurvivalPlayer = {}
SurvivalPlayer.__index = SurvivalPlayer

function SurvivalPlayer:new()
    local obj = {
        salut = 100,
        gana = 100,
        energia = 100,
        viu = true
    }
    setmetatable(obj, self)
    return obj
end

function SurvivalPlayer:update()
    if not self.viu then return end

    -- Degradació bàsica
    self.gana = math.max(self.gana - 2, 0)
    self.energia = math.max(self.energia - 1, 0)

    -- Penalització per gana
    if self.gana <= 0 then
        self.salut = math.max(self.salut - 5, 0)
        print("[Jugador] Gana crítica! Perds vida")
    end

    -- Mort
    if self.salut <= 0 then
        self.viu = false
        print("[Jugador] Has mort.")
    end
end

function SurvivalPlayer:menjar()
    self.gana = math.min(self.gana + 20, 100)
    print("[Jugador] Has menjat")
end

function SurvivalPlayer:dormir()
    self.energia = math.min(self.energia + 30, 100)
    print("[Jugador] Has dormit")
end

function SurvivalPlayer:getEstat()
    return string.format(
        "Salut: %d | Gana: %d | Energia: %d",
        self.salut, self.gana, self.energia
    )
end