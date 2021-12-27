--[[
    init.lua
    Created: 06/28/2021 23:00:22
    Description: Autogenerated script file for the map guild_Top_Left_bedroom.
]]--
-- Commonly included lua functions and data
require 'common'
require 'PartnerEssentials'

-- Package name
local guild_Top_Left_bedroom = {}

-- Local, localized strings table
-- Use this to display the named strings you added in the strings files for the map!
-- Ex:
--      local localizedstring = MapStrings['SomeStringName']
local MapStrings = {}

-------------------------------
-- Map Callbacks
-------------------------------
---guild_Top_Left_bedroom.Init
--Engine callback function
function guild_Top_Left_bedroom.Init(map)
	DEBUG.EnableDbgCoro()
	print('=>> Init_guild_Top_Left_bedroom<<=')
	MapStrings = COMMON.AutoLoadLocalizedStrings()
	COMMON.RespawnAllies()
	PartnerEssentials.InitializePartnerSpawn()

end

---guild_Top_Left_bedroom.Enter
--Engine callback function
function guild_Top_Left_bedroom.Enter(map)
	guild_Top_Left_bedroom.PlotScripting()
end

---guild_Top_Left_bedroom.Exit
--Engine callback function
function guild_Top_Left_bedroom.Exit(map)


end

---guild_Top_Left_bedroom.Update
--Engine callback function
function guild_Top_Left_bedroom.Update(map)


end

function guild_Top_Left_bedroom.GameLoad(map)
	PartnerEssentials.LoadGamePartnerPosition(CH('Teammate1'))
	guild_Top_Left_bedroom.PlotScripting()
end

function guild_Top_Left_bedroom.GameSave(map)
	PartnerEssentials.SaveGamePartnerPosition(CH('Teammate1'))
end

function guild_Top_Left_bedroom.PlotScripting()
	GAME:FadeIn(20)
end

-------------------------------
-- Entities Callbacks
-------------------------------
function guild_Top_Left_bedroom.Teammate1_Action(chara, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  PartnerEssentials.GetPartnerDialogue(CH('Teammate1'))
end

---------------------------
-- Map Transitions
---------------------------
function guild_Top_Left_bedroom.Bedroom_Exit_Touch(obj, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  GAME:FadeOut(false, 20)
  GAME:EnterGroundMap("guild_bedroom_hallway", "Guild_Bedroom_Hallway_Top_Left_Marker")
  SV.partner.Spawn = 'Guild_Bedroom_Hallway_Top_Left_Marker_Partner'
end

return guild_Top_Left_bedroom

