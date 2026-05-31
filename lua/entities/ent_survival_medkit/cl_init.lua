include("shared.lua")

function ENT:Draw()
    self:DrawModel()

    -- Ajustamos altura del holograma flotante para el tamaño del botiquín
    local pos = self:GetPos() + Vector(0, 0, 18)
    local ang = EyeAngles()
    ang:RotateAroundAxis(ang:Up(), -90)
    ang:RotateAroundAxis(ang:Forward(), 90)

    cam.Start3D2D(pos, ang, 0.07)
        draw.SimpleText("[ E ] RECOGER BOTIQUÍN MÉDICO", "SurvivalHUD_3D", 0, -10, Color(50, 220, 100), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText("+40% Puntos de Salud", "SurvivalHUD_Bold", 0, 15, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    cam.End3D2D()
end