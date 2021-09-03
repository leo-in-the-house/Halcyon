--[[
    init.lua
    Created: 06/29/2021 10:19:56
    Description: Autogenerated script file for the map guild_second_floor.
]]--
-- Commonly included lua functions and data
require 'common'
require 'PartnerEssentials'
require 'ground.guild_second_floor.guild_second_floor_ch_1'

-- Package name
local guild_second_floor = {}

local MapStrings = {}

-------------------------------
-- Map Callbacks
-------------------------------
---guild_second_floor.Init
function guild_second_floor.Init(map)
	DEBUG.EnableDbgCoro()
	print('=>> Init_guild_second_floor<<=')
	MapStrings = COMMON.AutoLoadLocalizedStrings()
	COMMON.RespawnAllies()
	PartnerEssentials.InitializePartnerSpawn()

end

---guild_second_floor.Enter
function guild_second_floor.Enter(map)
	DEBUG.EnableDbgCoro()
	print('Enter_guild_second_floor')
	UI:ResetSpeaker()
	if SV.ChapterProgression.Chapter == 1 then
		if SV.Chapter1.TeamCompletedForest and not SV.Chapter1.TeamJoinedGuild then 
			guild_second_floor_ch_1.MeetNoctowl()
		else
			guild_second_floor_ch_1.SetupGround()
		end
	else
		GAME:FadeIn(20)
	end
end

---guild_second_floor.Exit
function guild_second_floor.Exit(map)


end

---guild_second_floor.Update
function guild_second_floor.Update(map)


end





--[[
Markers used for generic NPC spawning (i.e. where flavor NPCs should be going)

Teams gathered around the left message board 
Left_Trio_1, 2, 3 
Left_Duo_1, 2
Left_Solo

Teams gathered around the right message board
Right_Trio_1, 2, 3 
Right_Duo_1, 2
Right_Solo

Teams having a conversation:
Generic_Spawn_Duo_1, 2, 3 ,4
TODO: Add a couple sets of trio spawn markers 

Generic Spawns:
Generic_Spawn_1, 2, 3, 4, 5, 6, 7, 8
]]--










-------------------------------
-- Entities Callbacks
-------------------------------
function guild_second_floor.Teammate1_Action(chara, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  PartnerEssentials.GetPartnerDialogue(CH('Teammate1'))
end



function guild_second_floor.Cleffa_Action(chara, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  assert(pcall(load("guild_second_floor_ch_" .. tostring(SV.ChapterProgression.Chapter) .. ".Cleffa_Action(...,...)"), chara, activator))
end

function guild_second_floor.Aggron_Action(chara, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  assert(pcall(load("guild_second_floor_ch_" .. tostring(SV.ChapterProgression.Chapter) .. ".Aggron_Action(...,...)"), chara, activator))
end

function guild_second_floor.Zigzagoon_Action(chara, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  assert(pcall(load("guild_second_floor_ch_" .. tostring(SV.ChapterProgression.Chapter) .. ".Zigzagoon_Action(...,...)"), chara, activator))
end

function guild_second_floor.Marill_Action(chara, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  assert(pcall(load("guild_second_floor_ch_" .. tostring(SV.ChapterProgression.Chapter) .. ".Marill_Action(...,...)"), chara, activator))
end

function guild_second_floor.Spheal_Action(chara, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  assert(pcall(load("guild_second_floor_ch_" .. tostring(SV.ChapterProgression.Chapter) .. ".Spheal_Action(...,...)"), chara, activator))
end

function guild_second_floor.Jigglypuff_Action(chara, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  assert(pcall(load("guild_second_floor_ch_" .. tostring(SV.ChapterProgression.Chapter) .. ".Jigglypuff_Action(...,...)"), chara, activator))
end











---------------------------
-- Map Transitions
---------------------------
function guild_second_floor.Upwards_Stairs_Exit_Touch(obj, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  GAME:FadeOut(false, 20)
  GAME:EnterGroundMap("guild_third_floor_lobby", "Main_Entrance_Marker")
  SV.partner.Spawn = 'Default'
end


function guild_second_floor.Downwards_Stairs_Exit_Touch(obj, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  GAME:FadeOut(false, 20)
  GAME:EnterGroundMap("guild_first_floor", "Guild_First_Floor_Stairs_Marker")
  SV.partner.Spawn = 'Guild_First_Floor_Stairs_Marker_Partner'
end

return guild_second_floor