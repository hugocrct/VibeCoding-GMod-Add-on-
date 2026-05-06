EventSystem = EventSystem or {}

EventSystem.events = {

    {
        name = "Trobes menjar sospitós",
        options = {
            {
                text = "Menjar-lo",
                effect = function(player)
                    if math.random(1,100) <= 50 then
                        player.gana = math.min(player.gana + 25, 100)
                        print("[EVENT] Menjar segur")
                    else
                        player.salut = player.salut - 15
                        print("[EVENT] Menjar en mal estat!")
                    end
                    player:addXP(20)
                end
            },
            {
                text = "Ignorar",
                effect = function(player)
                    print("[EVENT] Decideixes no arriscar-te")
                    player:addXP(5)
                end
            }
        }
    },

    {
        name = "Atac enemic",
        options = {
            {
                text = "Defensar-te",
                effect = function(player)
                    player.salut = player.salut - 10
                    print("[EVENT] Has sobreviscut a l'atac")
                    player:addXP(25)
                end
            },
            {
                text = "Fugir",
                effect = function(player)
                    player.energia = player.energia - 15
                    print("[EVENT] Escapes però estàs esgotat")
                    player:addXP(10)
                end
            }
        }
    }
}

function EventSystem:triggerRandom(game)
    if math.random(1, 100) <= 40 then
        local event = table.Random(self.events)

        game.currentEvent = event
        game:setState("EVENT")

        print("[EVENT] " .. event.name)
        for i, opt in ipairs(event.options) do
            print(i .. ". " .. opt.text)
        end
    end
end
