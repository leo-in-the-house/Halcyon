--[[
    init.lua
    Created: 01/01/2022 02:00:40
    Description: Autogenerated script file for the map ledian_dojo.
]]--
-- Commonly included lua functions and data
require 'common'
require 'PartnerEssentials'
require 'ground.ledian_dojo.ledian_dojo_ch_2'


-- Package name
local ledian_dojo = {}

-- Local, localized strings table
-- Use this to display the named strings you added in the strings files for the map!
-- Ex:
--      local localizedstring = MapStrings['SomeStringName']
local MapStrings = {}

-------------------------------
-- Map Callbacks
-------------------------------
---ledian_dojo.Init
--Engine callback function
function ledian_dojo.Init(map)
	DEBUG.EnableDbgCoro()
	print('=>> Init_ledian_dojo <<=')
	MapStrings = COMMON.AutoLoadLocalizedStrings()
	COMMON.RespawnAllies()
	PartnerEssentials.InitializePartnerSpawn()

	GROUND:AddMapStatus(50)--darkness

end

---ledian_dojo.Enter
--Engine callback function
function ledian_dojo.Enter(map)

  ledian_dojo.PlotScripting()

end

---ledian_dojo.Exit
--Engine callback function
function ledian_dojo.Exit(map)


end

---ledian_dojo.Update
--Engine callback function
function ledian_dojo.Update(map)


end

---ledian_dojo.GameSave
--Engine callback function
function ledian_dojo.GameSave(map)
	PartnerEssentials.SaveGamePartnerPosition(CH('Teammate1'))
end

---ledian_dojo.GameLoad
--Engine callback function
function ledian_dojo.GameLoad(map)
	PartnerEssentials.LoadGamePartnerPosition(CH('Teammate1'))
	ledian_dojo.PlotScripting()
end

function ledian_dojo.PlotScripting()
	--if a generic ending has been flagged, prioritize that
	if SV.Dojo.LessonCompletedGeneric or SV.Dojo.TrainingCompletedGeneric or SV.Dojo.TrialCompletedGeneric or SV.Dojo.LessonFailedGeneric or SV.Dojo.TrainingFailedGeneric or SV.Dojo.TrialFailedGeneric then
		

	elseif SV.ChapterProgression.Chapter == 2 then
		if not SV.Chapter2.StartedTraining then--Cutscene for entering the dojo for the first time
			ledian_dojo_ch_2.PreTrainingCutscene()
		elseif not SV.Chapter2.FinishedTraining then--Cutscene for dying in first lesson/maze. cutscene function has logic for appropriate scene
			ledian_dojo_ch_2.FailedTrainingCutscene()
		elseif not SV.Chapter2.FinishedDojoCutscenes then--Cutscene for finishing first lesson/maze. cutscene function has logic for appropriate scene
			ledian_dojo_ch_2.PostTrainingCutscene()
		else 
			ledian_dojo_ch_2.SetupGround()
		end
	else
		GAME:FadeIn(20)	
	end 
end


function ledian_dojo.Ledian_Action(chara, activator)
	DEBUG.EnableDbgCoro()
	local state = 0
	local repeated = false
	local ledian = CH('Sensei')


	UI:SetSpeaker(ledian)
	local olddir = ledian.Direction
	GROUND:CharTurnToChar(ledian, CH('PLAYER'))
			
	while state > -1 do
		local msg = STRINGS:Format(MapStrings['Dojo_Intro'])
		if repeated == true then
			msg = STRINGS:Format(MapStrings['Dojo_Intro_Return'])
		end
		local dojo_choices = {STRINGS:Format(MapStrings['Dojo_Menu_Training']),
		STRINGS:Format(MapStrings['Dojo_Menu_Lesson']),
		STRINGS:Format(MapStrings['Dojo_Menu_Trials']),
		STRINGS:FormatKey("MENU_EXIT")}
		UI:BeginChoiceMenu(msg, dojo_choices, 1, 4)
		UI:WaitForChoice()
		local result = UI:ChoiceResult()
		repeated = true
		if result == 1 then
			UI:WaitShowDialogue(STRINGS:Format(MapStrings['Dojo_Training_Info_001']))
			UI:WaitShowDialogue(STRINGS:Format(MapStrings['Dojo_Training_Info_002']))
			UI:WaitShowDialogue(STRINGS:Format(MapStrings['Dojo_Training_Info_003']))
			UI:WaitShowDialogue(STRINGS:Format(MapStrings['Dojo_Training_Info_004']))
			UI:WaitShowDialogue(STRINGS:Format(MapStrings['Dojo_Training_Info_005']))
		elseif result == 2 then
			UI:WaitShowDialogue(STRINGS:Format(MapStrings['Dojo_Lesson_Info_001']))
			UI:WaitShowDialogue(STRINGS:Format(MapStrings['Dojo_Lesson_Info_002']))
			UI:WaitShowDialogue(STRINGS:Format(MapStrings['Dojo_Lesson_Info_003']))
			UI:WaitShowDialogue(STRINGS:Format(MapStrings['Dojo_Lesson_Info_004']))
			UI:WaitShowDialogue(STRINGS:Format(MapStrings['Dojo_Lesson_Info_005']))

		elseif result == 3 then
			UI:WaitShowDialogue(STRINGS:Format(MapStrings['Dojo_Trial_Info_001']))
			UI:WaitShowDialogue(STRINGS:Format(MapStrings['Dojo_Trial_Info_002']))
			UI:WaitShowDialogue(STRINGS:Format(MapStrings['Dojo_Trial_Info_003']))
			UI:WaitShowDialogue(STRINGS:Format(MapStrings['Dojo_Trial_Info_004']))
			UI:WaitShowDialogue(STRINGS:Format(MapStrings['Dojo_Trial_Info_005']))
		else
			UI:WaitShowDialogue(STRINGS:Format(MapStrings['Dojo_Goodbye']))
			state = -1
		end
	end
	
	GROUND:EntTurn(ledian, olddir)
end 

--modified version of common's ShowDestinationMenu. Has no capability for grounds, and sets risk to None if the dungeon chosen is a tutorial level
function ledian_dojo.ShowMazeMenu(dungeon_entrances)
  --check for unlock of dungeons
  local open_dests = {}
  for ii = 1,#dungeon_entrances,1 do
    if GAME:DungeonUnlocked(dungeon_entrances[ii]) then
	  local zone_summary = _DATA.DataIndices[RogueEssence.Data.DataManager.DataType.Zone].Entries[dungeon_entrances[ii]]
	  local zone_name = zone_summary:GetColoredName()
      table.insert(open_dests, { Name=zone_name, Dest=RogueEssence.Dungeon.ZoneLoc(dungeon_entrances[ii], 0, 0, 0) })
	end
  end
  
  local dest = RogueEssence.Dungeon.ZoneLoc.Invalid
  if #open_dests == 1 then
      --single dungeon entry
      UI:ResetSpeaker()
      SOUND:PlaySE("Menu/Skip")
	  UI:DungeonChoice(open_dests[1].Name, open_dests[1].Dest)
      UI:WaitForChoice()
      if UI:ChoiceResult() then
	    dest = open_dests[1].Dest
	  end
  elseif #open_dests > 1 then
    
    UI:ResetSpeaker()
    SOUND:PlaySE("Menu/Skip")
    UI:DestinationMenu(open_dests)
	UI:WaitForChoice()
	dest = UI:ChoiceResult()
  end
  
  if dest:IsValid() then
	local risk = RogueEssence.Data.GameProgress.DungeonStakes.Risk
	--set risk to none if chosen level is a lesson
	if dest.ID == 51 then risk = RogueEssence.Data.GameProgress.DungeonStakes.None end
    SOUND:PlayBGM("", true)
    GAME:FadeOut(false, 20)
	GAME:EnterDungeon(dest.ID, dest.StructID.Segment, dest.StructID.ID, dest.EntryPoint, risk, true, false)
  end
end
		
		
		
function ledian_dojo.GenericTrainingSuccess()
	local partner = CH('Teammate1')
	local hero = CH('PLAYER')
	local ledian = CH('Sensei')
	GAME:CutsceneMode(true)
	AI:DisableCharacterAI(partner)
	GROUND:CharSetAnim(ledian, "Idle", true)	
	
	--GROUND:TeleportTo(hero, 208, 208, Direction.Up)	
	--GROUND:TeleportTo(partner, 184, 208, Direction.Up)
	--GeneralFunctions.CenterCamera({ledian, hero})
	local zone = _DATA.DataIndices[RogueEssence.Data.DataManager.DataType.Zone].Entries[SV.Dojo.LastZone]
	GAME:FadeIn(20)
		
	GAME:WaitFrames(20)
	GeneralFunctions.EmoteAndPause(ledian, 'Exclaim', true)
	UI:SetSpeaker(ledian)
	UI:SetSpeakerEmotion("Normal")
	UI:WaitShowDialogue("Hoiyah![pause=0] You did it![pause=0] You successfully completed the " .. zone:GetColoredName() .."!")
	UI:SetSpeakerEmotion("Shouting")
	local coro1 = TASK:BranchCoroutine(function()	ledian_dojo_ch_2.Hwacha(ledian) end)
	local coro2 = TASK:BranchCoroutine(function() UI:WaitShowTimedDialogue("HWACHA!", 40) end)
	local coro3 = TASK:BranchCoroutine(function() GAME:WaitFrames(10)
									GROUND:CharSetEmote(hero, 3, 1) end)	
	local coro4 = TASK:BranchCoroutine(function() GAME:WaitFrames(10)
									GeneralFunctions.Recoil(partner) end)
	TASK:JoinCoroutines({coro1, coro2, coro3, coro4})

	GAME:WaitFrames(20)

	UI:WaitShowDialogue("But this is only the beginning of your journey!")
	UI:WaitShowDialogue("Hwacha![pause=0] There is still so much training for you ahead!")
	UI:WaitShowDialogue("Wahtah![pause=0] Be sure to keep giving it your all!")

	--GeneralFunctions.PanCamera(200, 200)

	AI:EnableCharacterAI(partner)
	AI:SetCharacterAI(partner, "ai.ground_partner", CH('PLAYER'), partner.Position)
	GAME:CutsceneMode(false)			
end
		
function ledian_dojo.GenericLessonSuccess()
	--for now, all 3 generic finishes will be the same
	ledian_dojo.GenericTrainingFinish()
end
	
function ledian_dojo.GenericTrialSuccess()
	--for now, all 3 generic finishes will be the same	
	ledian_dojo.GenericTrainingSuccess()
end
		
function ledian_dojo.GenericTrainingFailure()
	
end
		
function ledian_dojo.GenericLessonFailure()
			
end
		
function ledian_dojo.GenericTrialFailure()
			
end
-------------------------------
-- Map Transition
-------------------------------

function ledian_dojo.Dojo_Exit_Touch(obj, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  GAME:FadeOut(false, 20)
  GAME:EnterGroundMap("metano_town", "Dojo_Entrance_Marker")
  SV.partner.Spawn = 'Dojo_Entrance_Marker_Partner'
end

function ledian_dojo.Dungeon_Entrance_Touch(obj, activator)
	DEBUG.EnableDbgCoro() --Enable debugging this coroutine

	UI:ResetSpeaker()
	UI:BeginChoiceMenu("Which would you like to do?", {"Training", "Lesson", "Trial", "Cancel"}, 1, 4)
	UI:WaitForChoice()
	local result = UI:ChoiceResult()
	
	if result == 1 then
		--training mazes
		local dungeon_entrances = {52}
	elseif result == 2 then
		--lessons
		local dungeon_entrances = {51}
	elseif result == 3 then
		--trials
		local dungeon_entrances = {}
		if #dungeon_entrances == 0 then 
			UI:WaitShowDialogue("There aren't any trials available to you now. Come back later!")
			return
		end
	else
		--cancel
		return
	end
	--set the dungeons we can choose from based on whether we are choosing to do a lesson, a training maze, or a trial
	ledian_dojo.ShowMazeMenu(dungeon_entrances)

end

-------------------------------
-- Entities Callbacks
-------------------------------

function ledian_dojo.Teammate1_Action(chara, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  PartnerEssentials.GetPartnerDialogue(CH('Teammate1'))
end

return ledian_dojo

