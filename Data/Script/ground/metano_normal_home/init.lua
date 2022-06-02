--[[
    init.lua
    Created: 03/21/2021 22:07:39
    Description: Autogenerated script file for the map metano_normal_home.
]]--
-- Commonly included lua functions and data
require 'common'
require 'PartnerEssentials'
require 'ground.metano_normal_home.metano_normal_home_ch_2'

-- Package name
local metano_normal_home = {}

-- Local, localized strings table
-- Use this to display the named strings you added in the strings files for the map!
-- Ex:
--      local localizedstring = MapStrings['SomeStringName']
local MapStrings = {}

-------------------------------
-- Map Callbacks
-------------------------------
---metano_normal_home.Init
--Engine callback function
function metano_normal_home.Init(map, time)

	DEBUG.EnableDbgCoro()
	print('=>> Init_metano_normal_home <<=')
	MapStrings = COMMON.AutoLoadLocalizedStrings()
	COMMON.RespawnAllies()
	PartnerEssentials.InitializePartnerSpawn()
end

---metano_normal_home.Enter
--Engine callback function
function metano_normal_home.Enter(map, time)

	metano_normal_home.PlotScripting()

end

---metano_normal_home.Exit
--Engine callback function
function metano_normal_home.Exit(map, time)


end

---metano_normal_home.Update
--Engine callback function
function metano_normal_home.Update(map, time)


end

function metano_normal_home.GameLoad(map)
	PartnerEssentials.LoadGamePartnerPosition(CH('Teammate1'))
	metano_normal_home.PlotScripting()
end

function metano_normal_home.GameSave(map)
	PartnerEssentials.SaveGamePartnerPosition(CH('Teammate1'))
end


function metano_normal_home.PlotScripting()
	if SV.ChapterProgression.Chapter == 2 then 
		metano_normal_home_ch_2.SetupGround()
	else
		GAME:FadeIn(20)
	end
end

-------------------------------
-- Map Transitions
-------------------------------

function metano_normal_home.Normal_Home_Entrance_Touch(obj, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  GAME:FadeOut(false, 20)
  GAME:EnterGroundMap("metano_town", "Normal_Home_Entrance_Marker")
  SV.partner.Spawn = 'Normal_Home_Entrance_Marker_Partner'
end



------------------
--NPCS 
----------------
function metano_normal_home.Furret_Action(chara, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  assert(pcall(load("metano_normal_home_ch_" .. tostring(SV.ChapterProgression.Chapter) .. ".Furret_Action(...,...)"), chara, activator))
end

function metano_normal_home.Linoone_Action(chara, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  assert(pcall(load("metano_normal_home_ch_" .. tostring(SV.ChapterProgression.Chapter) .. ".Linoone_Action(...,...)"), chara, activator))
end

function metano_normal_home.Zigzagoon_Action(chara, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  assert(pcall(load("metano_normal_home_ch_" .. tostring(SV.ChapterProgression.Chapter) .. ".Zigzagoon_Action(...,...)"), chara, activator))
end

function metano_normal_home.Sentret_Action(chara, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  assert(pcall(load("metano_normal_home_ch_" .. tostring(SV.ChapterProgression.Chapter) .. ".Sentret_Action(...,...)"), chara, activator))
end


function metano_normal_home.Teammate1_Action(chara, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  PartnerEssentials.GetPartnerDialogue(CH('Teammate1'))end

return metano_normal_home
