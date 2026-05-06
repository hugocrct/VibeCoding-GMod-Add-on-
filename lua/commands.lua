concommand.Add("sg_event_opcio", function(_, _, args)
    local opt = tonumber(args[1])
    if not opt then return end

    if GAME then
        GAME:resolveEvent(opt)
    end
end)
