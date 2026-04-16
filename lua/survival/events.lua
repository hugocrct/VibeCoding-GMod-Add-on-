EventSystem = EventSystem or {}

EventSystem.events = {

    function(player)
        print("[EVENT] Trobes menjar")
        player.gana = math.min(player.gana + 15, 100)
    end,

    function(player)
        print("[EVENT] Atac enemic")
        player.salut = math.max(player.salut - 20, 0)
    end,

    function(player)
        print("[EVENT] Descanses")
        player.energia = math.min(player.energia + 10, 100)
    end
}

function EventSystem:triggerRandom(game)
    if math.random(1, 100) <= 30 then
        local event = table.Random(self.events)

        game.currentEvent = event
        game:setState("EVENT")

        print("[EVENT] Activat")
    end
end