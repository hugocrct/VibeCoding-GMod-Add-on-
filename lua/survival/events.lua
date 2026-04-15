-- EVENT SYSTEM

EventSystem = {}

EventSystem.events = {
    function(player)
        print("[Esdeveniment] Trobes menjar")
        player.gana = math.min(player.gana + 15, 100)
    end,

    function(player)
        print("[Esdeveniment] Atac enemic")
        player.salut = math.max(player.salut - 20, 0)
    end,

    function(player)
        print("[Esdeveniment] Descanses una mica")
        player.energia = math.min(player.energia + 10, 100)
    end
}

function EventSystem:triggerRandom(player)
    local probabilitat = math.random(1, 100)

    if probabilitat <= 30 then
        local event = table.Random(self.events)
        event(player)
    end
end