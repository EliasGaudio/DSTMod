local assets =
{
	Asset( "ANIM", "anim/valorie.zip" ),
	Asset( "ANIM", "anim/ghost_valorie_build.zip" ),
}

local skins =
{
	normal_skin = "valorie",
	ghost_skin = "ghost_valorie_build",
}

return CreatePrefabSkin("valorie_none",
{
	base_prefab = "valorie",
	type = "base",
	assets = assets,
	skins = skins, 
	skin_tags = {"valorie", "CHARACTER", "BASE"},
	build_name_override = "valorie",
	rarity = "Character",
})