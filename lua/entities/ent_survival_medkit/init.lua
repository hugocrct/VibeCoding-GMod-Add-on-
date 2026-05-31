AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/Items/HealthKit.mdl") -- Modelo oficial de botiquín de HL2
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    
    local phys = self:GetPhysicsObject()
    if IsValid(phys) then phys:Wake() end
end

function ENT:Use(activator, caller)
    if IsValid(activator) and activator:IsPlayer() then
        local maxHP = activator:GetMaxHealth()
        local currentHP = activator:Health()
        
        if currentHP >= maxHP then
            activator:PrintMessage(HUD_PRINTCENTER, "Tu salud ya está completamente al máximo.")
            return
        end

        -- Cura 40 puntos de vida sin sobrepasar el límite máximo del jugador
        activator:SetHealth(math.min(currentHP + 40, maxHP))
        activator:EmitSound("items/smallmedkit1.wav", 75, 100)
        self:Remove()
    end
end