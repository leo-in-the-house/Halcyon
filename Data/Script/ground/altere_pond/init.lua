--[[
    init.lua
    Created: 06/15/2021 21:21:51
    Description: Autogenerated script file for the map altere_pond.
]]--
-- Commonly included lua functions and data
require 'common'
require 'PartnerEssentials'
require 'altere_pond_ch_1'

-- Package name
local altere_pond = {}

-- Local, localized strings table
-- Use this to display the named strings you added in the strings files for the map!
-- Ex:
--      local localizedstring = MapStrings['SomeStringName']
local MapStrings = {}

-------------------------------
-- Map Callbacks
-------------------------------
---altere_pond.Init
--Engine callback function
function altere_pond.Init(map)
	
	DEBUG.EnableDbgCoro()
	print('=>> Init_altere_pond <<=')
	MapStrings = COMMON.AutoLoadLocalizedStrings()
	COMMON.RespawnAllies()
	GROUND:AddMapStatus(6)
	PartnerEssentials.InitializePartnerSpawn()

end

---altere_pond.Enter
--Engine callback function
function altere_pond.Enter(map)

	if SV.ChapterProgression.Chapter == 1 and not SV.Chapter1.PartnerEnteredForest then
		altere_pond_ch_1.PrologueGoToRelicForest()
	elseif SV.ChapterProgression.Chapter == 1 and SV.Chapter1.PartnerEnteredForest and SV.PartnerCompletedForest then
		altere_pond_ch_1.WipedInForest()
	else
		GAME:FadeIn(20)
	end
end

---altere_pond.Exit
--Engine callback function
function altere_pond.Exit(map)


end

---altere_pond.Update
--Engine callback function
function altere_pond.Update(map)


end





-------------------------------
-- Map Transitions
-------------------------------

function altere_pond.North_Exit_Touch(obj, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  GAME:FadeOut(false, 20)
  GAME:EnterGroundMap("metano_altere_transition", "Metano_Altere_Transition_South_Entrance_Marker")
  SV.partner.Spawn = 'Metano_Altere_Transition_South_Entrance_Marker_Partner'
end



------------------
--NPCS 
----------------

function altere_pond.Relicanth_Action(chara, activator)
	UI:SetSpeaker(chara)
	UI:WaitShowDialogue(STRINGS:Format(MapStrings['test']))
end



function altere_pond.Teammate1_Action(chara, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  PartnerEssentials.GetPartnerDialogue(CH('Teammate1'))
end


return altere_pond
