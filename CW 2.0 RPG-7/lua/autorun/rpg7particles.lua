AddCSLuaFile("autorun/rpg7particles.lua")

game.AddParticles("particles/rpg7_particles.pcf")

PrecacheParticleSystem("rpg7_smoke_full")
PrecacheParticleSystem("rpg7_muzzle_full")
PrecacheParticleSystem("rpg7_sparks")
PrecacheParticleSystem("rpg7_explosion_full")

CustomizableWeaponry:registerAmmo("RPG-7", "RPG-7 Ammo", 0, 0)

if SERVER then
	hook.Add("EntityTakeDamage", "RPG7CLAMP", function(target, dmginfo)
		if !target:IsPlayer() then return end
		if !dmginfo:IsExplosionDamage() then return end
		local inflictor = dmginfo:GetInflictor()
		if !inflictor.CLAMPDAMAGE then return end
		dmginfo:SetDamage( math.min( dmginfo:GetDamage(), 70 ) )
	end)
end