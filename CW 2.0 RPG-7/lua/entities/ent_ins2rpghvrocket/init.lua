AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

local phys, vel, owner, pos, DotProduct, traceDir, trace, ownerVel, aimVec, randomShake, random, ED, distance, relation, forceDir, pos2
local td = {}

ENT.CLAMPDAMAGE = true

function ENT:Initialize()
	self:SetModel("models/khrcw2/ins2rpg7hvrocket.mdl") 
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_FLYGRAVITY)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_NPC)
	self:SetGravity(0.2)
	self:SetDTInt(0, 1)
	self.RocketSpeed = 4250
	self.DamageM = 1
	phys = self:GetPhysicsObject()

	if phys and phys:IsValid() then
		phys:Wake()
	end
	
	self.RocketSound = CreateSound(self, "weapons/ins2rpg7/rpg_rocket_loop.wav")
	self.RocketSound:SetSoundLevel(95)
	self.RocketSound:Play()
	
	timer.Simple(4.5, function()
		if IsValid(self) then
			self:SetDTInt(0, 0) -- oh fuck, we're out of fuel!
			vel = self:GetVelocity()
			
			self:PhysicsInit(SOLID_VPHYSICS)
			self:SetMoveType(MOVETYPE_VPHYSICS)
			self:SetSolid(SOLID_VPHYSICS)
			self:SetCollisionGroup(COLLISION_GROUP_NPC)
			phys = self:GetPhysicsObject()

			if phys and phys:IsValid() then
				phys:Wake()
				phys:SetMass(5)
				phys:SetVelocity(vel)
			end
			
			self.RocketSound:FadeOut(0.3)
			
			owner = self:GetOwner()
			
			if IsValid(owner) and owner:Alive() then
				owner.CanReload = true
			end
		end
	end)
	
	spd = physenv.GetPerformanceSettings()
    spd.MaxVelocity = 4528
	
    physenv.SetPerformanceSettings(spd)
end

function ENT:OnTakeDamage(dmginfo)
	return false
end

function ENT:Use(activator, caller)
	return false
end

function ENT:Think()
	if SERVER then
		if self:GetDTInt(0) == 1  then
			owner = self:GetOwner()
			pos = self:GetPos()
			
			if self.MissileType == 1 then
				self.RocketSpeed = 4750
				
				if not self.TargetedEntity then
					for k, v in pairs(ents.FindInSphere(pos, 2048)) do
						if (v:IsPlayer() and v:Alive()) or v:IsNPC() then
							pos2 = v:GetPos()
							DotProduct = self:GetForward():DotProduct((pos2 - pos):GetNormal())
							
							if DotProduct >= 0.7 and v != owner then
								traceDir = (pos2 - pos):GetNormal()
								td.start = pos
								td.endpos = td.start + traceDir * 2048 + Vector(0, 0, 0) -- make sure we're not running the trace at the entity's feet
								td.filter = {}
								
								for k2, v2 in pairs(ents.FindByClass("trigger_soundscape")) do
									table.insert(td.filter, v2)
								end
								
								table.insert(td.filter, self)
								
								trace = util.TraceLine(td)
								
								if trace.Entity == v then
									self.TargetedEntity = v
									break
								end
							end
						end
					end
				end
				
				if not self.TargetedEntity or self.TargetedEntity:GetClass() != "ent_ins2rpghvrocket" then
					for k, v in pairs(ents.FindInSphere(pos, 1024)) do
						if v:GetClass() == "ent_ins2rpghvrocket" and v != self then
							pos2 = v:GetPos()
							DotProduct = self:GetForward():DotProduct((pos2 - pos):GetNormal())
							
							if DotProduct >= 0.6 then
								traceDir = (pos2 - pos):GetNormal()
								
								td.start = pos
								td.endpos = td.start + traceDir * 1024 + Vector(0, 0, 30) -- make sure we're not running the trace at the entity's feet
								td.filter = {}
								
								for k2, v2 in pairs(ents.FindByClass("trigger_soundscape")) do
									table.insert(td.filter, v2)
								end
								
								table.insert(td.filter, self)
								
								trace = util.TraceLine(td)
								
								if trace.Entity == v then
									self.TargetedEntity = v
									self.RocketSpeed = 4528
									break
								end
							end
						end
					end
				end
				
				if IsValid(self.TargetedEntity) then
					if not self.Velocity then
						self.Velocity = self:GetVelocity()
					else
						self.Velocity = LerpVector(0.4, self.Velocity, (self.TargetedEntity:GetPos() - pos):GetNormal() * self.RocketSpeed)
					end
					
					self:SetLocalVelocity(self.Velocity)
				end
				
				if self.TargetedEntity and not IsValid(self.TargetedEntity) then
					self.TargetedEntity = nil
					self.MissileType = 0
					end
				end		
			end
		end
	end

function ENT:Touch(ent)
	owner = self:GetOwner()
	
	if ent != owner and !string.StartWith(ent:GetClass(), "trigger_") then
		self.MissileType = 0
		if ent:IsVehicle() then self.DamageM = 2 end
		self:Explode()
	end
end

function ENT:PhysicsCollide(data, physobj)
	self.MissileType = 0
	self:Explode()
end

function ENT:OnRemove()
	self.RocketSound:Stop()
	util.ScreenShake( self:GetPos(), 130, 50, 1.75, 770 )
end

function ENT:Explode()
	if self.BlewUp then
		return
	end
	
	owner = self:GetOwner()
	pos = self:GetPos()
	ED = EffectData()
	ED:SetOrigin(pos)
	
	util.Effect("Explosion", ED)
	
	ParticleEffect("rpg7_explosion_full", pos, Angle(0, 0, 0), nil)
	
	if IsValid(owner) and owner:Alive() then
		owner.CanReload = true
	end
	
	for k, v in pairs(ents.FindInSphere(pos, 256)) do
		if IsValid(v) then
			if not v:IsPlayer() or not v:IsNPC() and (v:GetClass() == "prop_physics" or v:GetClass() == "prop_ragdoll") then
				phys = v:GetPhysicsObject()
				
				if not v.ReceivedExplosiveForce then
					v.ReceivedExplosiveForce = 300
				else
					v.ReceivedExplosiveForce = v.ReceivedExplosiveForce + 300
				end
				
				if IsValid(phys) then
					pos2 = v:GetPos()
					distance = pos:Distance(pos2)
					relation = math.Clamp(((256 - distance) / 256) / (phys:GetMass() * 0.005), 0, 1)
					forceDir = ((pos2 - pos):GetNormal() * 5000) * relation
					
					if phys:IsMoveable() then
						phys:AddAngleVelocity(Vector(1000, 1000, 200) * relation)
						phys:SetVelocity(forceDir)
					end
					
					if v.ReceivedExplosiveForce >= phys:GetMass() then
						
						phys:Wake()
						
						phys:AddAngleVelocity(Vector(1000, 1000, 200) * relation)
						phys:SetVelocity(forceDir)
						
						v.ReceivedExplosiveForce = 0
					end
				end
				
			end
		end
	end
	
	util.BlastDamage(self, owner, pos + -(self:GetForward() * 5), 360, 2000 * self.DamageM)
	debugoverlay.Cross(pos + -(self:GetForward() * 5), 10, 10)
	SafeRemoveEntity(self)
end