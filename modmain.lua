PrefabFiles = {
	"valorie",
	"valorie_none",
}

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/valorie.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/valorie.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/valorie.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/valorie.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/valorie_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/valorie_silho.xml" ),

    Asset( "IMAGE", "bigportraits/valorie.tex" ),
    Asset( "ATLAS", "bigportraits/valorie.xml" ),
	
	Asset( "IMAGE", "images/map_icons/valorie.tex" ),
	Asset( "ATLAS", "images/map_icons/valorie.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_valorie.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_valorie.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_valorie.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_valorie.xml" ),
	
	Asset( "IMAGE", "images/avatars/self_inspect_valorie.tex" ),
    Asset( "ATLAS", "images/avatars/self_inspect_valorie.xml" ),
	
	Asset( "IMAGE", "images/names_valorie.tex" ),
    Asset( "ATLAS", "images/names_valorie.xml" ),
	
	Asset( "IMAGE", "images/names_gold_valorie.tex" ),
    Asset( "ATLAS", "images/names_gold_valorie.xml" ),
}

AddMinimapAtlas("images/map_icons/valorie.xml")

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS

-- The character select screen lines
STRINGS.CHARACTER_TITLES.valorie = "The Wet Butterfly"
STRINGS.CHARACTER_NAMES.valorie = "Valorietta"
STRINGS.CHARACTER_DESCRIPTIONS.valorie = "*Gets stronger while fighting\n*There is enough food in the world to be picky... Right?\n*Beigns are terrific... and terrible. Behaving around others is insufferable\n*Strong minded, weak bodied, hits hard and moves fast"
STRINGS.CHARACTER_QUOTES.valorie = "\"Moj but is lost, moja skarpeta is wet, moj dzien is ruined\""
STRINGS.CHARACTER_SURVIVABILITY.valorie = "Slim"
STRINGS.CHARACTER_ABOUTME.valorie = "Once, Valorietta, was the mighty princess of Starya-Angarya, she fought in the Angarian Civil War and somehow she ended up in a scientific fleet called The Black Fleet, there she met friends and went exploring the Universe... As well as crossing several troubling portals..."
STRINGS.CHARACTER_BIOS.valorie =
        {
            { title = "Birthday", desc = "May 28" },
            { title = "Favorite Food", desc = "Spaghetti" },
            { title = "Portal Surfing", desc = "She crossed a portal, things went wrong, crossed another portal and ended up here, far from her beloved fleet." },
        }


TUNING.valorie_HEALTH = 80
TUNING.valorie_HUNGER = 100
TUNING.valorie_SANITY = 300

TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT.valorie = {
    "flint",
    "flint",
    "twigs",
    "twigs",
}



-- Custom speech strings
STRINGS.CHARACTERS.VALORIE = require "speech_valorie"

-- The character's name as appears in-game 
STRINGS.NAMES.valorie = "Valorietta"
STRINGS.SKIN_NAMES.valorie_none = "Valorietta"

-- The skins shown in the cycle view window on the character select screen.
-- A good place to see what you can put in here is in skinutils.lua, in the function GetSkinModes
local skin_modes = {
    { 
        type = "ghost_skin",
        anim_bank = "ghost",
        idle_anim = "idle", 
        scale = 0.75, 
        offset = { 0, -25 } 
    },
}

-- Add mod character to mod character list. Also specify a gender. Possible genders are MALE, FEMALE, ROBOT, NEUTRAL, and PLURAL.
AddModCharacter("valorie", "FEMALE", skin_modes)
