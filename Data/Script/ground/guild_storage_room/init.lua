--[[
    init.lua
    Created: 06/30/2021 02:00:36
    Description: Autogenerated script file for the map guild_storage_room.
]]--
-- Commonly included lua functions and data
require 'common'
require 'PartnerEssentials'

-- Package name
local guild_storage_room = {}

-- Local, localized strings table
-- Use this to display the named strings you added in the strings files for the map!
-- Ex:
--      local localizedstring = MapStrings['SomeStringName']
local MapStrings = {}

-------------------------------
-- Map Callbacks
-------------------------------
---guild_storage_room.Init
--Engine callback function
function guild_storage_room.Init(map)
	DEBUG.EnableDbgCoro()
	print('=>> Init_guild_storage_room<<=')
	MapStrings = COMMON.AutoLoadLocalizedStrings()
	COMMON.RespawnAllies()
	PartnerEssentials.InitializePartnerSpawn()

end

---guild_storage_room.Enter
--Engine callback function
function guild_storage_room.Enter(map)

  GAME:FadeIn(20)

end

---guild_storage_room.Exit
--Engine callback function
function guild_storage_room.Exit(map)


end

---guild_storage_room.Update
--Engine callback function
function guild_storage_room.Update(map)


end

-------------------------------
-- Entities Callbacks
-------------------------------
function guild_storage_room.Teammate1_Action(chara, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  PartnerEssentials.GetPartnerDialogue(CH('Teammate1'))
end

---------------------------
-- Map Transitions
---------------------------
function guild_storage_room.Left_Exit_Touch(obj, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  GAME:FadeOut(false, 20)
  GAME:EnterGroundMap("guild_storage_hallway", "Guild_Storage_Hallway_Right_Marker")
  SV.partner.Spawn = 'Guild_Storage_Hallway_Right_Marker_Partner'
end

return guild_storage_room