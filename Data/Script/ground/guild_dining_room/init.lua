--[[
    init.lua
    Created: 06/28/2021 23:45:55
    Description: Autogenerated script file for the map guild_dining_room.
]]--
-- Commonly included lua functions and data
require 'common'
require 'PartnerEssentials'
require 'ground.guild_dining_room.guild_dining_room_ch_1'


-- Package name
local guild_dining_room = {}

-- Local, localized strings table
-- Use this to display the named strings you added in the strings files for the map!
-- Ex:
--      local localizedstring = MapStrings['SomeStringName']
local MapStrings = {}

-------------------------------
-- Map Callbacks
-------------------------------
---guild_dining_room.Init
--Engine callback function
function guild_dining_room.Init(map)
	DEBUG.EnableDbgCoro()
	print('=>> Init_guild_dining_room<<=')
	MapStrings = COMMON.AutoLoadLocalizedStrings()
	COMMON.RespawnAllies()
	PartnerEssentials.InitializePartnerSpawn()
end

---guild_dining_room.Enter
--Engine callback function
function guild_dining_room.Enter(map)
	guild_dining_room.PlotScripting()
end

---guild_dining_room.Exit
--Engine callback function
function guild_dining_room.Exit(map)


end

---guild_dining_room.Update
--Engine callback function
function guild_dining_room.Update(map)


end

function guild_dining_room.GameLoad(map)
	PartnerEssentials.LoadGamePartnerPosition(CH('Teammate1'))
	guild_dining_room.PlotScripting()
end

function guild_dining_room.GameSave(map)
	PartnerEssentials.SaveGamePartnerPosition(CH('Teammate1'))
end

function guild_dining_room.PlotScripting()
	--plot scripting
	if SV.ChapterProgression.Chapter == 1 then
		guild_dining_room_ch_1.SetupGround()
	else
		GAME:FadeIn(20)
	end
end

-------------------------------
-- Entities Callbacks
-------------------------------
function guild_dining_room.Teammate1_Action(chara, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  PartnerEssentials.GetPartnerDialogue(CH('Teammate1'))
end

function guild_dining_room.Snubbull_Action(chara, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
 assert(pcall(load("guild_dining_room_ch_" .. tostring(SV.ChapterProgression.Chapter) .. ".Snubbull_Action(...,...)"), chara, activator))
end

---------------------------
-- Map Transitions
---------------------------
function guild_dining_room.Right_Exit_Touch(obj, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  GAME:FadeOut(false, 20)
  GAME:EnterGroundMap("guild_third_floor_lobby", "Guild_Third_Floor_Lobby_Left_Marker")
  SV.partner.Spawn = 'Guild_Third_Floor_Lobby_Left_Marker_Partner'
end

return guild_dining_room