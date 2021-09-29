local MakePlayerCharacter = require "prefabs/player_common"

local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
}

-- Your character's stats
TUNING.valorie_HEALTH = 80
TUNING.valorie_HUNGER = 100
TUNING.valorie_SANITY = 300
x,y,z = 0,0,0
ents = 0
stacks = 0
onCombat = false
local Buffs = {}
-- Custom starting inventory
TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT.valorie = {
	"flint",
	"flint",
	"twigs",
	"twigs",
}

local start_inv = {}
for k, v in pairs(TUNING.GAMEMODE_STARTING_ITEMS) do
    start_inv[string.lower(k)] = v.valorie
end
local prefabs = FlattenTree(start_inv, true)

-- When the character is revived from human
local function onbecamehuman(inst)
	-- Set speed when not a ghost (optional)
	inst.components.locomotor:SetExternalSpeedMultiplier(inst, "valorie_speed_mod", 1)
end

local function onbecameghost(inst)
	-- Remove speed modifier when becoming a ghost
   inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "valorie_speed_mod")
end

-- When loading or spawning the character
local function onload(inst)
    inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)
    inst:ListenForEvent("ms_becameghost", onbecameghost)

    if inst:HasTag("playerghost") then
        onbecameghost(inst)
    else
        onbecamehuman(inst)
    end
end


-- This initializes for both the server and client. Tags can be added here.
local common_postinit = function(inst) 
	-- Minimap icon
	inst.MiniMapEntity:SetIcon( "valorie.tex" )
end





local function ValorieDeathsBallet(inst)
	if inst.attackPeriodic ~= nil then
		inst.attackPeriodic:Cancel()
	end
	inst.vida2 = inst.components.health.currenthealth

	stacks = stacks + 1
	onCombat = true
	x,y,z = inst.Transform:GetWorldPosition()
	ents = TheSim:FindEntities(x, y, z, 5, {"player"}, {"playerghost", "INLIMBO"}, nil)

	if ents ~= nil then
		inst.components.locomotor:SetExternalSpeedMultiplier(inst, "ValorieDeathsBalletSpeed", 1.20)
	end

	inst.components.health:SetMaxHealth(80 + (2 * stacks))
	inst.components.health:DoDelta(inst.vida2 - (80 + (2 * (stacks - 1))))
	inst.components.health:DoDelta(2, false)
	inst.components.combat.externaldamagemultipliers:SetModifier(inst, 1.0 + ((2 * stacks)/100), "ValorieDeathsBalletDamage")

	inst.attackPeriodic = inst:DoTaskInTime(10.0, function(inst)
		inst.vida = inst.components.health.currenthealth
		inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "ValorieDeathsBalletSpeed")
		inst.components.health:SetMaxHealth(80)
		inst.components.health:DoDelta(inst.vida - 80, false)
		inst.components.combat.externaldamagemultipliers:RemoveModifier(inst, "ValorieDeathsBalletDamage")
		onCombat = false
	end)

end








-- This initializes for the server only. Components are added here.
local master_postinit = function(inst)
	-- Set starting inventory
    inst.starting_inventory = start_inv[TheNet:GetServerGameMode()] or start_inv.default
	
	-- choose which sounds this character will play
	inst.soundsname = "wathgrithr"
	-- Uncomment if "wathgrithr"(Wigfrid) or "webber" voice is used
    inst.talker_path_override = "dontstarve_DLC001/characters/"

	inst:DoPeriodicTask(1.0, function(inst)
		if inst.components.health:IsDead() or inst:HasTag("playerghost") then
			return
		end
		x,y,z = inst.Transform:GetWorldPosition()
		ents = TheSim:FindEntities(x, y, z, 5, {"player"}, {"playerghost", "INLIMBO"}, nil)
		for i, v in ipairs(ents) do
			if v and v:IsValid() and v ~= inst then
				inst.components.sanity:DoDelta(-3, true) 
			end
		end
	end)

	inst:DoPeriodicTask(1.0, function(inst)
		if inst.components.health:IsDead() or inst:HasTag("playerghost") then
			return
		end
		if not onCombat then
			stacks = 0
		end

	end)

	--masterpostinit
	local _Eat = inst.components.eater.Eat --backup original function
	inst.components.eater.Eat = function(self, food, feeder, ...) --override original function
		if food and food.components.edible and food.components.edible.foodtype ~= "MEAT" then
	    	self.healthabsorption = 0 --lower our healthabsorption to 0 so we get no health from nonmeats
	    end
		local result = _Eat(self, food, feeder,...) --call backuped function copy of original
		self.healthabsorption = 1 --return it to default
		return result --return the results from _Eat
	end

	inst:ListenForEvent("onattackother", ValorieDeathsBallet)



	-- Stats	
	inst.components.health:SetMaxHealth(TUNING.valorie_HEALTH)
	inst.components.hunger:SetMax(TUNING.valorie_HUNGER)
	inst.components.sanity:SetMax(TUNING.valorie_SANITY)
	
	-- Damage multiplier (optional)
    inst.components.combat.damagemultiplier = 1.2
	
	-- Hunger rate (optional)
	inst.components.hunger.hungerrate = 1 * TUNING.WILSON_HUNGER_RATE

	inst.components.sanity.night_drain_mult = 0.8
	inst.components.sanity.dapperness = 0.05
	inst.components.locomotor.walkspeed = 5
	
	inst.OnLoad = onload
    inst.OnNewSpawn = onload

	
end

return MakePlayerCharacter("valorie", prefabs, assets, common_postinit, master_postinit, prefabs)
