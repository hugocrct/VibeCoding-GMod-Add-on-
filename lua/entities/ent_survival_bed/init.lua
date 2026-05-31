AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/props_c17/FurnitureMattress001a.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    
    local phys = self:GetPhysicsObject()
    if IsValid(phys) then phys:Wake() end
end

function ENT:Use(activator, caller)
    if IsValid(activator) and activator:IsPlayer() then
        local current_energy = activator:GetNW2Int("Survival_Energia", 100)
        
        if current_energy >= 100 then
            activator:PrintMessage(HUD_PRINTCENTER, "Tu cuerpo no se encuentra cansado.")
            return
        end

        activator:SetNW2Int("Survival_Energia", math.min(current_energy + 45, 100))
        activator:EmitSound("vo/npc/male01/moan01.wav", 70, 100)
        activator:ScreenFade(SCREENFADE.IN, Color(0, 0, 0, 255), 0.8, 0.8)
        self:Remove()
    end
end