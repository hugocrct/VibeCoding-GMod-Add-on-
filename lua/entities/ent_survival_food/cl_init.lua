include("shared.lua")
function ENT:Draw()
    self:DrawModel()
    local pos = self:GetPos() + Vector(0, 0, 15)
    local ang = EyeAngles()
    ang:RotateAroundAxis(ang:Up(), -90)
    ang:RotateAroundAxis(ang:Forward(), 90)

    cam.Start3D2D(pos, ang, 0.08)
        draw.SimpleText("[ E ] INTERACTUAR PARA COMER", "SurvivalHUD_3D", 0, -10, Color(230, 160, 40), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText("+35% Hambre", "SurvivalHUD_Bold", 0, 15, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    cam.End3D2D()
end