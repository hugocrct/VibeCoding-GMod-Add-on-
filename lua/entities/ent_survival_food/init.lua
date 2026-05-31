AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/props_junk/garbage_takeoutcarton001a.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    local phys = self:GetPhysicsObject()
    if IsValid(phys) then phys:Wake() end
end

function ENT:Use(activator, caller)
    if IsValid(activator) and activator:IsPlayer() then
        local current_hunger = activator:GetNW2Int("Survival_Gana", 100)
        activator:SetNW2Int("Survival_Gana", math.min(current_hunger + 35, 100))
        activator:EmitSound("npc/barnacle/barnacle_crunch2.wav", 75, 100)
        self:Remove()
    end
end