require 'common'
require 'PartnerEssentials'
require 'GeneralFunctions'
require 'CharacterEssentials'

guild_heros_room_ch_2 = {}




function guild_heros_room_ch_2.FirstMorning()
	GAME:FadeOut(false, 1)
	local hero = CH('PLAYER')
	local partner = CH('Teammate1')
	GAME:CutsceneMode(true)
	AI:DisableCharacterAI(partner)
	UI:ResetSpeaker()
	SOUND:StopBGM()
	GROUND:CharSetAnim(hero, 'EventSleep', true)
	GROUND:CharSetAnim(partner, 'EventSleep', true)
	GROUND:Hide('Bedroom_Exit')--disable map transition object
	GROUND:Hide("Save_Point")--disable bed saving
	local hero_bed = MRKR('Hero_Bed')
	local partner_bed = MRKR('Partner_Bed')
	GROUND:TeleportTo(CH('PLAYER'), hero_bed.Position.X, hero_bed.Position.Y, Direction.Down)
	GROUND:TeleportTo(CH('Teammate1'), partner_bed.Position.X, partner_bed.Position.Y, Direction.Down)
	GeneralFunctions.CenterCamera({hero, partner})
	SV.guild.JustWokeUp = true

	local audino =
		CharacterEssentials.MakeCharactersFromList({
			{"Audino", 120, 204, Direction.UpRight},
		})

	local coro1 = TASK:BranchCoroutine(function() UI:WaitShowTitle("Chapter 2\n\nTo be determined\n", 20)
												  GAME:WaitFrames(180)
												  UI:WaitHideTitle(20) end)
	local coro2 = TASK:BranchCoroutine(function() UI:WaitShowBG("Chapter_1", 180, 20)
												  GAME:WaitFrames(180)
												  UI:WaitHideBG(20) end)
	TASK:JoinCoroutines({coro1, coro2})
	
	GAME:WaitFrames(120)

	UI:SetAutoFinish(true)
	UI:WaitShowVoiceOver("The next morning...\n\n", -1)
	UI:SetAutoFinish(false)
	
	GAME:WaitFrames(60)
	SOUND:PlayBattleSE("DUN_Heal_Bell")
	GAME:WaitFrames(90)
	UI:SetSpeaker(STRINGS:Format("\\uE040"), true, -1, -1, -1, RogueEssence.Data.Gender.Unknown)
	UI:WaitShowDialogue("Good morning![pause=0] It's time to get up!")
	GAME:FadeIn(20)
	
	--sleepyheads
	GAME:WaitFrames(20)
	UI:SetSpeaker('', true, -1, -1, -1, RogueEssence.Data.Gender.Unknown)
	UI:WaitShowDialogue(".........")
	GAME:WaitFrames(40)
	
	UI:SetSpeaker(audino)
	UI:SetSpeakerEmotion("Happy")
	UI:WaitShowDialogue("Wake up sleepyheads![pause=0] It's a bright new day!")
	GAME:WaitFrames(20)
	
	GROUND:CharAnimateTurnTo(audino, Direction.Down, 4)
	GAME:WaitFrames(10)
	SOUND:PlayBattleSE("DUN_Heal_Bell")
	GROUND:CharPoseAnim(audino, "Pose")
	GAME:WaitFrames(100)
	GROUND:CharSetAnim(audino, 'None', true)
	GROUND:CharAnimateTurnTo(audino, Direction.UpRight, 4)
	
	--todo: add shakes
	GAME:WaitFrames(20)
	UI:SetSpeaker(partner:GetDisplayName(), true, -1, -1, -1, RogueEssence.Data.Gender.Unknown)
	UI:WaitShowDialogue("Snorfle...[pause=0] Huh?")
	GAME:WaitFrames(20)
	
	coro1 = TASK:BranchCoroutine(function () GAME:WaitFrames(10)
											 GeneralFunctions.DoAnimation(hero, 'Wake') 
											 GROUND:CharAnimateTurnTo(hero, Direction.Down, 4) 
											 GAME:WaitFrames(20)
											 GeneralFunctions.LookAround(hero, 2, 4, false, false, false, Direction.DownLeft) end)
	coro2 = TASK:BranchCoroutine(function () GeneralFunctions.DoAnimation(partner, 'Wake') 
											 GROUND:CharAnimateTurnTo(partner, Direction.Down, 4)
											 GAME:WaitFrames(20)
											 GeneralFunctions.LookAround(partner, 2, 4, false, false, false, Direction.DownLeft) end)
	TASK:JoinCoroutines({coro1, coro2})

	GAME:WaitFrames(20)
	GeneralFunctions.EmoteAndPause(partner, "Notice", true)
	UI:SetSpeaker(partner)
	UI:WaitShowDialogue("Oh,[pause=10] good morning,[pause=10] " .. audino:GetDisplayName() .."!")
	GAME:WaitFrames(20)
	
	SOUND:PlayBGM("Wigglytuff's Guild.ogg", true)
	UI:SetSpeaker(audino)
	UI:SetSpeakerEmotion("Happy")
	UI:WaitShowDialogue("Good morning![pause=0] Nothing like a Heal Bell to w-wake you up,[pause=10] huh?")
	
	GAME:WaitFrames(20)
	UI:SetSpeakerEmotion("Normal")
	UI:WaitShowDialogue("It's time for the m-morning meeting![pause=0] Don't be late,[pause=10] especially on your first day!")
	
	GAME:WaitFrames(20)
	UI:SetSpeaker(partner)
	GeneralFunctions.EmoteAndPause(partner, "Question", true)
	UI:SetSpeakerEmotion("Worried")
	UI:WaitShowDialogue("Huh?[pause=0] Morning meeting?")
	
	GAME:WaitFrames(20)
	UI:SetSpeaker(audino)
	UI:SetSpeakerEmotion("Happy")
	UI:WaitShowDialogue("Yup![pause=0] The guild gathers for a briefing every morning!")
	UI:WaitShowDialogue("J-just come over to the lobby area and you'll see!")
	
	GAME:WaitFrames(20)
	GROUND:CharAnimateTurnTo(audino, Direction.Left, 4)
	GAME:WaitFrames(40)
	GROUND:CharAnimateTurnTo(audino, Direction.UpRight, 4)
	
	UI:SetSpeakerEmotion("Normal")
	UI:WaitShowDialogue("Looks like the meeting is about to start![pause=0] D-don't dawdle too long!")
	GAME:WaitFrames(20)
	
	GROUND:MoveToPosition(audino, 0, 204, false, 2)
	GAME:GetCurrentGround():RemoveTempChar(audino)
	GAME:WaitFrames(20)
	
	--good morning, hero!
	GROUND:CharTurnToCharAnimated(partner, hero, 4)
	GROUND:CharTurnToCharAnimated(hero, partner, 4)
	GAME:WaitFrames(12)
	UI:SetSpeaker(partner)
	UI:SetSpeakerEmotion("Happy")
	UI:WaitShowDialogue("Good morning,[pause=10] " .. hero:GetDisplayName() .. "![pause=0] Hope you slept well!")	
	UI:SetSpeakerEmotion("Normal")
	UI:WaitShowDialogue("We'd better get over to the lobby before we miss the meeting![pause=0] C'mon!")
	
	GAME:WaitFrames(20)
	GeneralFunctions.PanCamera(208, 156)
	GAME:WaitFrames(20)
	GROUND:CharEndAnim(hero)
	GROUND:CharEndAnim(partner)
	GROUND:Unhide("Bedroom_Exit")
	GROUND:Unhide("Save_Point")
	SV.Chapter1.TeamJoinedGuild = true
	AI:EnableCharacterAI(partner)
	AI:SetCharacterAI(partner, "ai.ground_partner", CH('PLAYER'), partner.Position)

	GAME:CutsceneMode(false)
		

end

function guild_heros_room_ch_2.FirstNightBedtalk()
	GAME:FadeOut(false, 1)
	local hero = CH('PLAYER')
	local partner = CH('Teammate1')
	GAME:CutsceneMode(true)
	guild_heros_room.Bedtime(false)
	UI:ResetSpeaker()
	GROUND:CharSetAnim(hero, 'Laying', true)
	GROUND:CharSetAnim(partner, 'Laying', true)
	
	--wait a bit after the transition from dinner scene before starting this one
	GAME:WaitFrames(60)
	--characters commenting on the dinner they just had while the screen is still faded out
	UI:SetSpeaker(CharacterEssentials.GetCharacterName('Tropius'), true, -1, -1, -1, RogueEssence.Data.Gender.Unknown)
	UI:WaitShowDialogue("Great meal as always,[pause=10] " .. CharacterEssentials.GetCharacterName('Snubbull') .. "![pause=0] I can't eat another bite!")
	GAME:WaitFrames(20)
	
	UI:SetSpeaker(CharacterEssentials.GetCharacterName('Breloom'), true, -1, -1, -1, RogueEssence.Data.Gender.Unknown)
	UI:WaitShowDialogue("Yeah,[pause=10] my stomach's so full of " .. '"art"' .. " you could call it a museum!")
	GAME:WaitFrames(20)
	
	UI:SetSpeaker(CharacterEssentials.GetCharacterName('Mareep'), true, -1, -1, -1, RogueEssence.Data.Gender.Unknown)
	UI:WaitShowDialogue("Ba-a-a-a...[pause=0] It's getting late...[pause=0] Time to hit the\nha-a-a-ay![pause=0] Goodnight everyone!")
	GAME:WaitFrames(20)
	
	UI:SetSpeaker(CharacterEssentials.GetCharacterName('Zigzagoon'), true, -1, -1, -1, RogueEssence.Data.Gender.Unknown)
	UI:WaitShowDialogue("Yup![pause=0] See you all in the morning!")
	GAME:WaitFrames(60)
	
	GAME:FadeIn(60)
	GAME:WaitFrames(40)

	SOUND:PlayBGM("Goodnight.ogg", true)
	UI:SetSpeaker(partner:GetDisplayName(), true, -1, -1, -1, RogueEssence.Data.Gender.Unknown)
	UI:WaitShowDialogue("..." .. hero:GetDisplayName() .. ",[pause=10] still up?")
	GAME:WaitFrames(20)
	
	UI:WaitShowDialogue("Today wasn't as exciting as I would have liked,[pause=10] but I guess we have to start somewhere.")
	UI:WaitShowDialogue("We did get to learn a lot from Sensei " .. CharacterEssentials.GetCharacterName('Ledian') .. " though.")
	UI:WaitShowDialogue("I hope she can teach us more...[br]We're going to need to learn and train as much as we can if we want to become great adventurers some day!")
	
	GAME:WaitFrames(40)
	UI:WaitShowDialogue("Yawn...[pause=0] Well,[pause=10] staying up all night isn't going to help with that.[pause=0] Let's get some rest.")
	UI:WaitShowDialogue("Here's hoping tomorrow is another great day.")
	UI:WaitShowDialogue("Good night,[pause=10] " .. hero:GetDisplayName() .. ".")
	
	GAME:WaitFrames(20)
	GROUND:CharSetAnim(partner, 'EventSleep', true)
	GAME:WaitFrames(10)
	GROUND:CharSetAnim(hero, 'EventSleep', true)
	GAME:WaitFrames(180)
	SOUND:FadeOutBGM()
	GAME:FadeOut(false, 120)
	GAME:WaitFrames(60)
	SV.Chapter2.FinishedFirstDay = true
	SV.ChapterProgression.DaysPassed = SV.ChapterProgression.DaysPassed + 1
	SV.TemporaryFlags.Morning = true
	GAME:EnterGroundMap("guild_heros_room", "Main_Entrance_Marker")
end