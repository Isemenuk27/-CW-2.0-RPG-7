AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
AddCSLuaFile("sh_soundscript.lua")
include("sh_sounds.lua")
include("sh_soundscript.lua")

	CustomizableWeaponry.firemodes:registerFiremode("rpgsingle", "SINGLE-SHOT", false, 0, 1)

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "RPG-7"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.SelectIcon = surface.GetTextureID("vgui/inventory/weapon_rpg7")
	killicon.Add( "doi_ins2_rpg7", "vgui/inventory/weapon_rpg7", Color(255, 80, 0, 0))
	
	SWEP.MuzzleEffect = "muzzleflash_ak74"
	SWEP.PosBasedMuz = true
	SWEP.SightWithRail = true
	SWEP.CrosshairParts = {left = true, right = true, upper = false, lower = true}
	SWEP.HUD_MagText = "TUBE: "

	SWEP.IronsightPos = Vector(-2.12, 0, -1.021)
	SWEP.IronsightAng = Vector(2.77, -0.26, 7.034)
	
	SWEP.KobraPos = Vector(-2.1335, 0, -0.788)
	SWEP.KobraAng = Vector(2.77, -0.26, 7.034)

	SWEP.AimpointPos = Vector(-2.12, 0, -0.9233)
	SWEP.AimpointAng = Vector(2.77, -0.26, 7.034)

	SWEP.SprintPos = Vector(2, 0, -1)
	SWEP.SprintAng = Vector(-15.478, 20.96, -15)
	
	SWEP.CustomizePos = Vector(5.75, 1.627, -1.821)
	SWEP.CustomizeAng = Vector(20.009, 30.971, 16.669)

	SWEP.AlternativePos = Vector(-.15, 0, -.225)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.SwimPos = Vector(6.3158, -17.8947, 0)
	SWEP.SwimAng = Vector(79.5789, 0, 11.3684)
	
	SWEP.PronePos = Vector(0, 0, -5.1579)
	SWEP.ProneAng = Vector(-10, 42.7368, -50.9474)
	
	SWEP.MoveType = 0
	SWEP.ViewModelMovementScale = 1.2
	SWEP.OverallMouseSens = .65
	SWEP.DisableSprintViewSimulation = false
	
	SWEP.CustomizationMenuScale = 0.017

	SWEP.M82AxisAlign = {right = .02, up = -.015, forward = 0}
	SWEP.LuaVMRecoilAxisMod = {vert = 10, hor = 0, roll = .35, forward = 1.5, pitch = .45}
	SWEP.INS2AxisAlign = {right = 0, up = 0, forward = 0}
end

SWEP.BodyBGs = {main = 1, off = 0, on = 1}
SWEP.WarheadBGs = {main = 2, heat = 0, hv = 1, he = 2, hvat = 3}

SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = true
SWEP.FullAimViewmodelRecoil = true
SWEP.AimBreathingEnabled = true
SWEP.CanRestOnObjects = false

SWEP.Attachments = {
	["+reload"] = {
		header = "Projectile",
		offset = {-415, 100}, 
		atts = {
			"ins2_atow_hvrocket",
			"ins2_atow_hvatrocket"
		}
	}
}

SWEP.Animations = {fire = {"base_fire"},
	fire_aim = {"iron_fire"},
	reload = "base_reload",
	idle = "base_idle",
	draw = "base_draw"}
	

SWEP.SpeedDec = 60

SWEP.Slot = 4
SWEP.SlotPos = 0
SWEP.NormalHoldType = "rpg"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"rpgsingle"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0"

SWEP.Author			= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 65
SWEP.AimViewModelFOV = 65
SWEP.ZoomAmount = 20
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/khrcw2/ins2rpg7.mdl"
SWEP.WorldModel		= "models/khrcw2/w_ins2rpg7.mdl"

SWEP.DrawTraditionalWorldModel = false
SWEP.WM = "models/khrcw2/w_ins2rpg7.mdl"
SWEP.WMPos = Vector(-1.05, 7.35, 2)
SWEP.WMAng = Vector(-10, 0, 180)

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 1
SWEP.Primary.DefaultClip	= 1
SWEP.Primary.Automatic		= false
SWEP.Chamberable			= false
SWEP.Primary.Ammo			= "RPG-7"

SWEP.FireDelay = 60/915
SWEP.FireSound = "INS2RPG7_FIRE"
SWEP.Recoil = 1
SWEP.FOVPerShot = 20

SWEP.HipSpread = 0.05
SWEP.AimSpread = 0
SWEP.VelocitySensitivity = 1.5
SWEP.MaxSpreadInc = 0
SWEP.SpreadPerShot = 0
SWEP.SpreadCooldown = 0
SWEP.Shots = 1
SWEP.Damage = 225
SWEP.DeployTime = .85
SWEP.HolsterTime = .75

SWEP.ADSFireAnim = true

SWEP.RecoilToSpread = 1.25

SWEP.ReloadSpeed = 1.1
SWEP.ReloadTime = 4.65
SWEP.ReloadHalt = 4.65
SWEP.ReloadTime_Empty = 4.65
SWEP.ReloadHalt_Empty = 4.65

SWEP.OldBG = 0
--{main = 2, heat = 0, hv = 1, he = 2, hvat = 3}
function SWEP:IndividualThink()
	local a = self:GetBodygroup(self.WarheadBGs.main)
	if self:Clip1() > 0 || self:isReloading() then
		if self.ActiveAttachments["ins2_atow_hvrocket"] then
			self.OldBG = 1
		elseif self.ActiveAttachments["ins2_atow_hvatrocket"] then 
			self.OldBG = 3
		end
		self:setBodygroup(self.WarheadBGs.main, self.OldBG) --WarheadBGs.on
	else
		if a != 4 then self.OldBG = a end
		self:setBodygroup(self.WarheadBGs.main, 4)
	end
end

function SWEP:fireAnimFunc()
	clip = self:Clip1()
	cycle = 0
	rate = 1
	anim = "safe"
	prefix = ""
	suffix = ""
	
	if self:isAiming() then
		suffix = suffix .. "_aim"
		cycle = self.ironFireAnimStartCycle
	end
	
	self:sendWeaponAnim(prefix .. "fire" .. suffix, rate, cycle)
end

local simpleTextColor = Color(255, 210, 0, 255)
local mod = 25

function SWEP:DrawWeaponSelection(x, y, wide, tall, alpha)
	if self.SelectIcon then
		surface.SetTexture(self.SelectIcon)
		
		wide = wide - mod
		
		x = x + (mod / 2)
		y = y + (mod / 4) + (wide / 8)
		
		surface.SetDrawColor(255, 255, 255, alpha)
		
		surface.DrawTexturedRect(x, y, wide, (wide / 2))
	else
		simpleTextColor.a = alpha
		draw.SimpleText(self.IconLetter, self.SelectFont, x + wide / 2, y + tall * 0.2, simpleTextColor, TEXT_ALIGN_CENTER)
	end
end

if CLIENT then
	SWEP.RoundBeltBoneNames = {
		"RPG_Warhead",
	}
	
	local function removeRoundMeshes(wep) -- we hide all rounds left in the belt on a non-empty reload because if we don't we're left with ghost meshes moving around (bullets with no link to the mag get moved back to it)
		wep:adjustVisibleRounds(0)
	end
	
	local function adjustMeshByMaxAmmo(wep)
		wep:adjustVisibleRounds(wep.Owner:GetAmmoCount(wep.Primary.Ammo) + wep:Clip1())
	end
	
	SWEP.Sounds.base_reload[1].callback = adjustMeshByMaxAmmo
end

function SWEP:IndividualInitialize()
	if CLIENT then
		self:initBeltBones()
	end
end

function SWEP:initBeltBones()
	local vm = self.CW_VM
	self.roundBeltBones = {}

	for key, boneName in ipairs(self.RoundBeltBoneNames) do
		local bone = vm:LookupBone(boneName)
		self.roundBeltBones[key] = bone
	end
end

function SWEP:postPrimaryAttack()
	if CLIENT then
		self:adjustVisibleRounds()
	end
end

local fullSize = Vector(1, 1, 1)
local invisible = Vector(0, 0, 0)

function SWEP:adjustVisibleRounds(curMag)
	if not self.roundBeltBones then
		self:initBeltBones()
	end
	
	local curMag = curMag or self:Clip1()
	local boneCount = #self.roundBeltBones
	local vm = self.CW_VM
	
	for i = 1, boneCount do
		local roundID = boneCount - (i - 1)
		local element = self.roundBeltBones[roundID]
		
		local scale = curMag >= roundID and fullSize or invisible
		vm:ManipulateBoneScale(element, scale)
	end
end

function SWEP:PrimaryAttack()
	if not self:canFireWeapon(1) then
			return
	end

	if not self:canFireWeapon(2) then
		return
	end
	
	if self.dt.Safe then
		self:CycleFiremodes()
		return
	end
	
	if not self:canFireWeapon(3) then
		return
	end
	
	mag = self:Clip1()
	CT = CurTime()
	
	Dist = self.Owner:GetShootPos():Distance(self.Owner:GetEyeTrace().HitPos)
	
	if Dist <= 50 then
		return
	end

	if mag == 0 then
		self:EmitSound("CW_EMPTY", 100, 100)
		self:SetNextPrimaryFire(CT + 0.25)
		return
	end
	
	if self.BurstAmount and self.BurstAmount > 0 then
		if self.dt.Shots >= self.BurstAmount then
			return
		end
		
		self.dt.Shots = self.dt.Shots + 1
	end
	
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	
	if IsFirstTimePredicted() then
		local muzzleData = EffectData()
		muzzleData:SetEntity(self)
		util.Effect("cw_muzzleflash", muzzleData)
		
		if self.dt.Suppressed then
			self:EmitSound(self.FireSoundSuppressed, 105, 100)
		else
			self:EmitSound(self.FireSound, 105, 100)
		end
		
		if self.fireAnimFunc then
			self:fireAnimFunc()
		else
			if self.dt.State == CW_AIMING then
				if self.ADSFireAnim then
					self:playFireAnim()
				end
			else
				self:playFireAnim()
			end
		end
	end

	if self:Clip1() == 0 then
		return
	end

	aimVec = self.Owner:GetAimVector()
		
		local pos = self.Owner:GetShootPos()
		local eyeAng = self.Owner:EyeAngles()
		local forward = eyeAng:Forward()
		local offset = forward * 30 + eyeAng:Right() * 3.5 - eyeAng:Up() * 2.5
		
		if self:isAiming() then offset = forward * 35 + eyeAng:Right() * 0.5 - eyeAng:Up() * 2.5
		end
	
		if SERVER and not self.ActiveAttachments.ins2_atow_hvrocket and not self.ActiveAttachments.ins2_atow_herocket and not self.ActiveAttachments.ins2_atow_hvatrocket and not self.ActiveAttachments.ins2_atow_dudrocket then
		missile = ents.Create("ent_ins2rpgrocket")
		missile:SetPos(pos + offset)
		missile:SetAngles(eyeAng)
		missile:Spawn()
		missile:Activate()
		missile:SetOwner(self.Owner)
		local phys = missile:GetPhysicsObject()
		
		if IsValid(phys) then
			missile:SetVelocity(forward * 2996)
		end
	end
		
	if SERVER and self.ActiveAttachments.ins2_atow_hvrocket then
		missile = ents.Create("ent_ins2rpghvrocket")
		missile:SetPos(pos + offset)
		missile:SetAngles(eyeAng)
		missile:Spawn()
		missile:Activate()
		missile:SetOwner(self.Owner)
		local phys = missile:GetPhysicsObject()
		
	
		if IsValid(phys) then
			missile:SetVelocity(forward * 2996)
		end
	end

	if SERVER and self.ActiveAttachments.ins2_atow_herocket then
		missile = ents.Create("ent_ins2rpgherocket")
		missile:SetPos(pos + offset)
		missile:SetAngles(eyeAng)
		missile:Spawn()
		missile:Activate()
		missile:SetOwner(self.Owner)
		local phys = missile:GetPhysicsObject()
		
	
		if IsValid(phys) then
			missile:SetVelocity(forward * 2996)
		end
	end

	if SERVER and self.ActiveAttachments.ins2_atow_hvatrocket then
		missile = ents.Create("ent_ins2rpghvatrocket")
		missile:SetPos(pos + offset)
		missile:SetAngles(eyeAng)
		missile:Spawn()
		missile:Activate()
		missile:SetOwner(self.Owner)
		local phys = missile:GetPhysicsObject()
		
	
		if IsValid(phys) then
			missile:SetVelocity(forward * 2996)
		end
	end

		if SERVER and self.ActiveAttachments.ins2_atow_dudrocket then
		missile = ents.Create("ent_ins2rpgdudrocket")
		missile:SetPos(pos + offset)
		missile:SetAngles(eyeAng)
		missile:Spawn()
		missile:Activate()
		missile:SetOwner(self.Owner)
		local phys = missile:GetPhysicsObject()
		
	
	if IsValid(phys) then
		missile:SetVelocity(forward * 2996)
	end
end
	
	self:delayEverything(.65)
	self:setGlobalDelay(.65)
	
	self.Owner:ViewPunch(Angle(-2, 0, 1))
	
	
	self:SetClip1(0)
	
end
