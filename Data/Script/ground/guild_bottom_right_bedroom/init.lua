--[[
    init.lua
    Created: 06/28/2021 23:00:22
    Description: Autogenerated script file for the map guild_bottom_right_bedroom.
]]--
-- Commonly included lua functions and data
require 'common'
require 'PartnerEssentials'
require 'CharacterEssentials'
require 'ground.guild_bottom_right_bedroom.guild_bottom_right_bedroom_ch_3'

-- Package name
local guild_bottom_right_bedroom = {}

-- Local, localized strings table
-- Use this to display the named strings you added in the strings files for the map!
-- Ex:
--      local localizedstring = MapStrings['SomeStringName']
local MapStrings = {}

-------------------------------
-- Map Callbacks
-------------------------------
---guild_bottom_right_bedroom.Init
--Engine callback function
function guild_bottom_right_bedroom.Init(map)
	DEBUG.EnableDbgCoro()
	print('=>> Init_guild_bottom_right_bedroom<<=')
	MapStrings = COMMON.AutoLoadLocalizedStrings()
	COMMON.RespawnAllies()
	PartnerEssentials.InitializePartnerSpawn()

end

---guild_bottom_right_bedroom.Enter
--Engine callback function
function guild_bottom_right_bedroom.Enter(map)
	guild_bottom_right_bedroom.PlotScripting()
end

---guild_bottom_right_bedroom.Exit
--Engine callback function
function guild_bottom_right_bedroom.Exit(map)


end

---guild_bottom_right_bedroom.Update
--Engine callback function
function guild_bottom_right_bedroom.Update(map)


end

function guild_bottom_right_bedroom.GameLoad(map)
	PartnerEssentials.LoadGamePartnerPosition(CH('Teammate1'))
	guild_bottom_right_bedroom.PlotScripting()
end

function guild_bottom_right_bedroom.GameSave(map)
	PartnerEssentials.SaveGamePartnerPosition(CH('Teammate1'))
end

function guild_bottom_right_bedroom.PlotScripting()
	if SV.ChapterProgression.Chapter == 3 then 
		guild_bottom_right_bedroom_ch_3.SetupGround()
	else
		GAME:FadeIn(20)
	end
end


-------------------------------
-- Entities Callbacks
-------------------------------
function guild_bottom_right_bedroom.Teammate1_Action(chara, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  PartnerEssentials.GetPartnerDialogue(CH('Teammate1'))
end

function guild_bottom_right_bedroom.Zigzagoon_Action(chara, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  assert(pcall(load("guild_bottom_right_bedroom_ch_" .. tostring(SV.ChapterProgression.Chapter) .. ".Zigzagoon_Action(...,...)"), chara, activator))
end

function guild_bottom_right_bedroom.Growlithe_Action(chara, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  assert(pcall(load("guild_bottom_right_bedroom_ch_" .. tostring(SV.ChapterProgression.Chapter) .. ".Growlithe_Action(...,...)"), chara, activator))
end

--function guild_bottom_right_bedroom.Almanac_Action(chara, activator)
	--UI:ResetSpeaker(false)
	--UI:WaitShowDialogue("This is Almotz's almanac (along with the books/papers on the floor)")
	--UI:WaitShowDialogue("But there's a lot of work that needs to go into this almanac...")
	--UI:WaitShowDialogue("Which will be done at a later date.[pause=0] It'll have some lore,[pause=10] gameplay tips,[pause=10] etc.")
	--UI:WaitShowDialogue("So look forward to it!")
--end



--[[
local AlmanacMenu = Class('AlmanacMenu')

function AlmanacMenu:initialize(items)
  assert(self, "ExampleMenu:initialize(): Error, self is nil!")
  self.menu = RogueEssence.Menu.ScriptableMenu(24, 24, 196, 128, function(input) self:Update(input) end)
  self.cursor = RogueEssence.Menu.MenuCursor(self.menu)
  self.menu.MenuElements:Add(self.cursor)
  for i = 1, #items, 1 do 
	self.menu.MenuElements:Add(RogueEssence.Menu.MenuText(items[i], RogueElements.Loc(16, 8 + 14 * (i-1))))
  end
  self.total_items = #items
  self.current_item = 0
  self.cursor.Loc = RogueElements.Loc(8, 8)

end

function AlmanacMenu:Update(input)
    assert(self, "BaseState:Begin(): Error, self is nil!")
	if input:JustPressed(RogueEssence.FrameInput.InputType.Confirm) then
    _GAME:SE("Menu/Confirm")
  elseif input:JustPressed(RogueEssence.FrameInput.InputType.Cancel) then
    _GAME:SE("Menu/Cancel")
    _MENU:RemoveMenu()
  else
    moved = false
    if RogueEssence.Menu.InteractableMenu.IsInputting(input, LUA_ENGINE:MakeLuaArray(Dir8, { Dir8.Down, Dir8.DownLeft, Dir8.DownRight })) then
      moved = true
      self.current_item = (self.current_item + 1) % self.total_items
    elseif RogueEssence.Menu.InteractableMenu.IsInputting(input, LUA_ENGINE:MakeLuaArray(Dir8, { Dir8.Up, Dir8.UpLeft, Dir8.UpRight })) then
      moved = true
      self.current_item = (self.current_item + self.total_items - 1) % self.total_items
    end
    if moved then
      _GAME:SE("Menu/Select")
      self.cursor:ResetTimeOffset()
      self.cursor.Loc = RogueElements.Loc(8, 8 + 14 * self.current_item)
    end
  end
end 

--]]




function guild_bottom_right_bedroom.Team_Almanac_Action(obj, activator)
	UI:ResetSpeaker(false)
	UI:SetCenter(true)
	UI:SetAutoFinish(true)
	local hero = CH('PLAYER')
	local partner = CH('Teammate1')
	partner.IsInteracting = true
	GROUND:CharSetAnim(partner, 'None', true)
	GROUND:CharSetAnim(hero, 'None', true)		
    GeneralFunctions.TurnTowardsLocation(hero, obj.Position.X + obj.Width // 2, obj.Position.Y + obj.Height // 2)
    GeneralFunctions.TurnTowardsLocation(partner, obj.Position.X + obj.Width // 2, obj.Position.Y + obj.Height // 2)
	
	local zig_name = CharacterEssentials.GetCharacterName("Zigzagoon")
	local choices = {'Round', 'Cadence', 'Starlight', 'Rivals', 'Flutter', 'Flight'}
	
	--local team_name_length = string.len(GAME:GetTeamName())
	--local player_team_name = string.sub(GAME:GetTeamName(), 16, team_name_length - 7)

	--add player's team and team style in chapter 2	
	if SV.ChapterProgression.Chapter >= 2 then 
		table.insert(choices, #choices + 1, 'Style')
		table.insert(choices, #choices + 1, GAME:GetTeamName()) 
	end
	
	--cancel goes at end of choice list always
	table.insert(choices, #choices + 1, 'Never Mind')
	
	--Don't read his books until he tells you you can.
	if not SV.Chapter1.MetZigzagoon then
		UI:WaitShowDialogue("This appears to be someone else's book.\nBest not read it without their permission.")
		UI:SetCenter(false)
		UI:SetAutoFinish(false)
		partner.IsInteracting = false
		GROUND:CharEndAnim(partner)
		GROUND:CharEndAnim(hero)
		return
	end
	
	UI:ChoiceMenuYesNo("This is one of " .. zig_name .. "'s almanacs.\nIt's entitled " .. '"Adventuring Teams". Read it?')
	UI:WaitForChoice()
	local result = UI:ChoiceResult()
	UI:SetAutoFinish(false)
	if result then 
		  GROUND:ObjectSetDefaultAnim(obj, 'Diary_Red_Opening', 0, 0, 0, Direction.Right)	  
	      GROUND:ObjectSetAnim(obj, 6, 0, 3, Direction.Right, 1)
		  GROUND:ObjectSetDefaultAnim(obj, 'Diary_Red_Opening', 0, 3, 3, Direction.Right)
		  GAME:WaitFrames(40)
		  UI:BeginMultiPageMenu(24, 24, 196, "Team Almanac", choices, 8, 1, #choices)		  
		  UI:WaitForChoice()
		  
		  local entry = choices[UI:ChoiceResult()]
		  
		  if entry == 'Round' then
			local marill_species = _DATA:GetMonster('marill'):GetColoredName()
			local puff_species = _DATA:GetMonster('jigglypuff'):GetColoredName()
			local spheal_species = _DATA:GetMonster('spheal'):GetColoredName()
			local move = _DATA.DataIndices[RogueEssence.Data.DataManager.DataType.Skill]:Get("round")--

			UI:WaitShowDialogue(zig_name .. "'s Almanac\n Team Entry: [color=#FFA5FF]Round[color]")
			UI:SetCenter(false)
			UI:WaitShowDialogue("Team [color=#FFA5FF]Round[color] is a local team that usually takes work from the Job Bulletin Board and consists of three members.")
			UI:WaitShowDialogue("First,[pause=10] there's " .. CharacterEssentials.GetCharacterName("Jigglypuff") .. ".[pause=0] She's a " .. puff_species .. "![pause=0] She's very kind and tries to be helpful to any Pokémon she meets.")
			UI:WaitShowDialogue("Then there's the " .. spheal_species .. " named " .. CharacterEssentials.GetCharacterName("Spheal") .. ".[pause=0] I get the feeling he thinks with his stomach more than with his brain...")
			UI:WaitShowDialogue("Lastly,[pause=10] there's " .. CharacterEssentials.GetCharacterName("Marill") .. ",[pause=10] who's a " .. marill_species .. ".[pause=0] He's the leader of the team and is a pleasant and optimistic Pokémon!")
			UI:WaitShowDialogue("He's also the one who came up with the name for their team.")
			UI:WaitShowDialogue("He claims that it's because they're adept at using the move " .. move:GetColoredName() .. " together,[pause=10] which is true,[pause=10] but...")
			UI:WaitShowDialogue("Um...[pause=0] Most Pokémon think their team name has more to do with their body types than anything else...")
			UI:WaitShowDialogue("...I guess it's hard to blame them.[pause=0] I thought the same thing at first,[pause=10] too.")
			UI:WaitShowDialogue("Anyways,[pause=10] they're one of the nicer and more easy-going teams.[pause=0] I wish more teams were like them!")
		  
		  elseif entry == 'Cadence' then
		    local ludicolo_species = _DATA:GetMonster('ludicolo'):GetColoredName()
			local roselia_species = _DATA:GetMonster('roselia'):GetColoredName()
			local spinda_species = _DATA:GetMonster('spinda'):GetColoredName()

			UI:WaitShowDialogue(zig_name .. "'s Almanac\n Team Entry: [color=#FFA5FF]Cadence[color]")
			UI:SetCenter(false)
			UI:WaitShowDialogue("Team [color=#FFA5FF]Cadence[color] has three members,[pause=10] usually all found dancing somewhere in town.")
			UI:WaitShowDialogue("Their members include a " .. ludicolo_species .. " named " .. CharacterEssentials.GetCharacterName("Ludicolo") .. ",[pause=10] a " .. spinda_species .. " named " .. CharacterEssentials.GetCharacterName("Spinda") .. ",[pause=10] and their leader,[pause=10] " .. CharacterEssentials.GetCharacterName("Roselia") .. " the " .. roselia_species .. ".")
			UI:WaitShowDialogue("They all have cheery dispositions and are skilled adventurers![pause=0] They often egg others on to dance with them.")
			UI:WaitShowDialogue("I know they are a proficient adventuring team,[pause=10] but...[pause=0] It seems to me they dance more than they adventure.")
			UI:WaitShowDialogue("They're very good at both though![pause=0] They use all sorts of dancing attacks and techniques on their adventures.")
			UI:WaitShowDialogue("It must take a lot of coordination and skill to use dancing effectively on adventures!")
			UI:WaitShowDialogue("It would be cool to come along on one of their adventures just to observe how they do it!")

			
		  elseif entry == 'Flutter' then
		    local caterpie_species = _DATA:GetMonster('caterpie'):GetColoredName()
			local wurmple_species = _DATA:GetMonster('wurmple'):GetColoredName()
			local silcoon_species = _DATA:GetMonster('silcoon'):GetColoredName()
			local metapod_species = _DATA:GetMonster('metapod'):GetColoredName()

			UI:WaitShowDialogue(zig_name .. "'s Almanac\n Team Entry: [color=#FFA5FF]Flutter[color]")
			UI:SetCenter(false)
			UI:WaitShowDialogue("Team [color=#FFA5FF]Flutter[color] does a lot of the low level jobs that come into the guild.")
			UI:WaitShowDialogue("The team has two members: " .. CharacterEssentials.GetCharacterName("Silcoon") .. " the " .. silcoon_species .. " and " ..CharacterEssentials.GetCharacterName("Metapod") .. " the " .. metapod_species .. ".")
			UI:WaitShowDialogue("For the longest time these two were actually a " .. wurmple_species .. " and a " .. caterpie_species .. ",[pause=10] but they recently decided to evolve.")
			UI:WaitShowDialogue("They've told me they're planning on evolving again soon too.")
			UI:WaitShowDialogue("I asked them why,[pause=10] and they told me they wanted to finally live up to their team name.")
			UI:WaitShowDialogue("They also wanted to start doing higher level jobs,[pause=10] and evolving would help with that too.")
			UI:WaitShowDialogue("Hmm.[pause=0] Evolving twice in such a short time is wild to me,[pause=10] but I imagine their current forms are hard to move around as.")
			UI:WaitShowDialogue("I wouldn't want to be stuck as a cocoon for long either if I was them!")
		  
		  elseif entry == 'Starlight' then
			local aggron_species = _DATA:GetMonster('aggron'):GetColoredName()
			local cleffa_species = _DATA:GetMonster('cleffa'):GetColoredName()
			UI:WaitShowDialogue(zig_name .. "'s Almanac\n Team Entry: [color=#FFA5FF]Starlight[color]")
			UI:SetCenter(false)
			UI:WaitShowDialogue("Team [color=#FFA5FF]Starlight[color] consists of two members.[pause=0] They're a bit of an odd duo,[pause=10] though...")
			UI:WaitShowDialogue("The leader is a " .. cleffa_species .. " named " .. CharacterEssentials.GetCharacterName("Cleffa") .. ",[pause=10] but she isn't very nice and she has a large ego for someone so small.")
			UI:WaitShowDialogue("The other member is an " .. aggron_species .. " who goes by " .. CharacterEssentials.GetCharacterName("Aggron") .. ".[pause=0] He's really timid and takes a lot of lip from " .. CharacterEssentials.GetCharacterName("Cleffa") .. ".")
			UI:WaitShowDialogue("It's a bit strange seeing a large Pokémon like that being bossed around by a tiny little " .. cleffa_species .. ",[pause=10] I must admit.")
			UI:WaitShowDialogue("They take all sorts of different jobs,[pause=10] but it seems like they don't have much success.")
			UI:WaitShowDialogue("Hmm.[pause=0] I bet they'd do a lot better if " .. CharacterEssentials.GetCharacterName("Cleffa") .. " learned to work with her partner better...")
         
		   elseif entry == 'Rivals' then
			local zangoose_species = _DATA:GetMonster('zangoose'):GetColoredName()
			local seviper_species = _DATA:GetMonster('seviper'):GetColoredName()
			UI:WaitShowDialogue(zig_name .. "'s Almanac\n Team Entry: [color=#FFA5FF]Rivals[color]")
			UI:SetCenter(false)
			UI:WaitShowDialogue("Team [color=#FFA5FF]Rivals[color] has two members that are,[pause=10] unsurprising given the name,[pause=10] fierce rivals with each other.")
			UI:WaitShowDialogue("The team is made up of a " .. zangoose_species .. " named " .. CharacterEssentials.GetCharacterName("Zangoose") .. " and a " .. seviper_species .. " named " .. CharacterEssentials.GetCharacterName("Seviper") .. ".")
			UI:WaitShowDialogue("When I asked them who the leader was,[pause=10] they both insisted it was themself and not their partner.")
			UI:WaitShowDialogue("They started bickering with each other after that and I couldn't ask any other questions...")
			UI:WaitShowDialogue("However,[pause=10] one time I noticed they were leaning on each other for support after coming back from a tough mission.")
			UI:WaitShowDialogue("They both were concerned for each others' well-being more than anything else,[pause=10] though they tried to act coy about it.")
			UI:WaitShowDialogue("Despite their rivalry, it seems they do care for each other,[pause=10] even if they don't like to show it!")
		
		  elseif entry == 'Flight' then
			local doduo_species = _DATA:GetMonster('doduo'):GetColoredName()
			local bagon_species = _DATA:GetMonster('bagon'):GetColoredName()

			UI:WaitShowDialogue(zig_name .. "'s Almanac\n Team Entry: [color=#FFA5FF]Flight[color]")
			UI:SetCenter(false)
			UI:WaitShowDialogue("Team [color=#FFA5FF]Flight[color] has got two members on the team.[pause=0] A " .. doduo_species .. " named " .. CharacterEssentials.GetCharacterName("Doduo") .. " and a " .. bagon_species .. " named " .. CharacterEssentials.GetCharacterName("Bagon") .. ".")
			UI:WaitShowDialogue(CharacterEssentials.GetCharacterName("Bagon") .. " is spunky and optimistic,[pause=10] but " .. CharacterEssentials.GetCharacterName("Doduo") .. " comes off as dodgy and nervous to me.[pause=0] He's a bit strange...")
			UI:WaitShowDialogue("What's stranger though is their name,[pause=10] given that neither of them should be able to fly...")
			UI:WaitShowDialogue(CharacterEssentials.GetCharacterName("Doduo") .. " claims to be able to fly,[pause=10] but I've never seen him do it.[pause=0] He's convinced " .. CharacterEssentials.GetCharacterName("Bagon") .. " that he's able to fly,[pause=10] though.")
			UI:WaitShowDialogue("I'd sure like to see at least one of them fly one day,[pause=10] anyway.")
			
		  elseif entry == 'Style' then 
			local luxio_species = _DATA:GetMonster('luxio'):GetColoredName()
			local glameow_species = _DATA:GetMonster('glameow'):GetColoredName()
			local cacnea_species = _DATA:GetMonster('cacnea'):GetColoredName()

			UI:WaitShowDialogue(zig_name .. "'s Almanac\n Team Entry: [color=#FFA5FF]Style[color]")
			UI:SetCenter(false)
			UI:WaitShowDialogue("I don't know much about Team [color=#FFA5FF]Style[color].[pause=0] Maybe they're a new team?")
			UI:WaitShowDialogue("All I do know is that the team consists of a " .. luxio_species .. ",[pause=10] a " .. glameow_species .. ",[pause=10] and a " .. cacnea_species .. ".")
			UI:WaitShowDialogue("Once I learn more about them,[pause=10] I'd like to write a more detailed entry here![pause=0] They could be a really cool team!")

          elseif entry == GAME:GetTeamName() then
		  	local hero = CH('PLAYER')
			local partner = CH('Teammate1')
			local hero_species = _DATA:GetMonster(hero.CurrentForm.Species):GetColoredName()
			local partner_species = _DATA:GetMonster(partner.CurrentForm.Species):GetColoredName()

			
			
			UI:WaitShowDialogue(zig_name .. "'s Almanac\n Team Entry: " .. GAME:GetTeamName())
			UI:SetCenter(false)
			UI:WaitShowDialogue("Team " .. GAME:GetTeamName() .. " are the newest members of the guild![pause=0] They're also a pretty new team.")
			UI:WaitShowDialogue("The team consists of " .. hero:GetDisplayName() .. " the " .. hero_species .. " and " .. partner:GetDisplayName() .. " the " .. partner_species .. ".")
			UI:WaitShowDialogue("Because they're so new,[pause=10] they haven't done a lot of adventuring yet...")
			UI:WaitShowDialogue("But I'm excited to see what kind of team they turn out to be!")
			UI:WaitShowDialogue("Team " .. GAME:GetTeamName() .. ",[pause=10] if you're reading this,[pause=10] know that I'm rooting for you all the way!")
		 end
		GROUND:ObjectSetDefaultAnim(obj, 'Diary_Red_Closing', 0, 0, 0, Direction.Right)
		GROUND:ObjectSetAnim(obj, 6, 0, 3, Direction.Right, 1)
		GROUND:ObjectSetDefaultAnim(obj, 'Diary_Red_Closing', 0, 3, 3, Direction.Right)	  
    end
	UI:SetCenter(false)
	partner.IsInteracting = false
	GROUND:CharEndAnim(partner)
	GROUND:CharEndAnim(hero)	
end


function guild_bottom_right_bedroom.Tips_Almanac_Action(obj, activator)
	UI:ResetSpeaker(false)
	UI:SetCenter(true)
	UI:SetAutoFinish(true)
	local hero = CH('PLAYER')
	local partner = CH('Teammate1')
	partner.IsInteracting = true
	GROUND:CharSetAnim(partner, 'None', true)
	GROUND:CharSetAnim(hero, 'None', true)		
    GeneralFunctions.TurnTowardsLocation(hero, obj.Position.X + obj.Width // 2, obj.Position.Y + obj.Height // 2)
    GeneralFunctions.TurnTowardsLocation(partner, obj.Position.X + obj.Width // 2, obj.Position.Y + obj.Height // 2)
	
	local zig_name = CharacterEssentials.GetCharacterName("Zigzagoon")
	local choices = {'Using Attacks to Move', 'Tough Opponents', 'Basic Attacks', 'Never Mind'}
		
	--Don't read his books until he tells you you can.
	if not SV.Chapter1.MetZigzagoon then
		UI:WaitShowDialogue("This appears to be someone else's book.\nBest not read it without their permission.")
		UI:SetCenter(false)
		UI:SetAutoFinish(false)
		partner.IsInteracting = false
		GROUND:CharEndAnim(partner)
		GROUND:CharEndAnim(hero)
		return
	end
	
	--todo: Different mons use different AI types
	UI:ChoiceMenuYesNo("This is one of " .. zig_name .. "'s almanacs.\nIt's entitled " .. '"Adventuring Tips". Read it?')
	UI:WaitForChoice()
	local result = UI:ChoiceResult()
	UI:SetAutoFinish(false)
	if result then 
		  GROUND:ObjectSetDefaultAnim(obj, 'Diary_Blue_Opening', 0, 0, 0, Direction.Right)	  
	      GROUND:ObjectSetAnim(obj, 6, 0, 3, Direction.Right, 1)
		  GROUND:ObjectSetDefaultAnim(obj, 'Diary_Blue_Opening', 0, 3, 3, Direction.Right)
		  GAME:WaitFrames(40)
		  UI:BeginMultiPageMenu(24, 24, 196, "Tips Almanac", choices, 8, 1, #choices)		  
		  UI:WaitForChoice()
		  
		  local entry = choices[UI:ChoiceResult()]
		  
		  if entry == 'Using Attacks to Move' then
			local quick_attack = _DATA.DataIndices[RogueEssence.Data.DataManager.DataType.Skill]:Get("quick_attack")
			local headbutt = _DATA.DataIndices[RogueEssence.Data.DataManager.DataType.Skill]:Get("headbutt")
			UI:WaitShowDialogue(zig_name .. "'s Almanac\n Tips Entry: Using Attacks to Move")
			UI:SetCenter(false)
			UI:WaitShowDialogue("Some attacks cause the user to move when used.[pause=0] Sometimes more than they normally could in a single turn!")
			UI:WaitShowDialogue("This is useful for closing the gaps on opponents,[pause=10] but there are other applications too!")
			UI:WaitShowDialogue("Depending on the distance an attack moves the user,[pause=10] using it to reposition can be more effective than walking.")
			UI:WaitShowDialogue("You can even hop over terrain you'd normally be unable to stay on top of like water or lava!")
			UI:WaitShowDialogue(quick_attack:GetColoredName() .. " is a common move that comes to mind for this purpose,[pause=10] but other moves should work too!")
			UI:WaitShowDialogue("For me,[pause=10] " .. headbutt:GetColoredName() .. " would work,[pause=10] though it doesn't go quite as far as " .. quick_attack:GetColoredName() .. ".")
		  elseif entry == 'Tough Opponents' then
		    UI:WaitShowDialogue(zig_name .. "'s Almanac\n Tips Entry: Tough Opponents")
			UI:SetCenter(false)
			UI:WaitShowDialogue("Now and then in my adventures,[pause=10] I've come across enemies that were just too strong for me to deal with directly.")
			UI:WaitShowDialogue("This could be because I was worn down,[pause=10] or that opponent was simply stronger than I was...")
			UI:WaitShowDialogue("Anyway,[pause=10] even if I'm weaker than my opponent,[pause=10] there are strategies I've learned to help me come out on top.")
			UI:WaitShowDialogue("One is to use items like Orbs and Wands to disable the opponent so they can't attack me as effectively or at all.")
			UI:WaitShowDialogue("It doesn't matter if they're stronger if they can't fight back that well!")
			UI:WaitShowDialogue("Another strategy is to simply just run away.[pause=0] You don't have to beat every opponent you find after all!")
			UI:WaitShowDialogue("If they have moves that help them chase you down though,[pause=10] this probably won't work very well.")
			UI:WaitShowDialogue("One last strategy I've come up with is to have " .. CharacterEssentials.GetCharacterName("Growlithe") .. " fight the enemy with me.")
			UI:WaitShowDialogue("We're a team after all![pause=0] We should work together whenever possible to make things easier.")
		    UI:WaitShowDialogue("Of course,[pause=10] I don't need his help for every opponent.")
			UI:WaitShowDialogue("But there are times where a team needs to work together to overcome obstacles!")
			UI:WaitShowDialogue("As for which strategy the situation calls for...")
			UI:WaitShowDialogue("Well,[pause=10] that depends on the opponent,[pause=10] what items we have,[pause=10] my and " .. CharacterEssentials.GetCharacterName("Growlithe") .. "'s health,[pause=10] and so many other factors...")
			UI:WaitShowDialogue("I guess knowing which option to choose in a tough spot is part of what it takes to be a great adventurer,[pause=10] hmm.")
			UI:WaitShowDialogue("Either way,[pause=10] it's good to know what my options are before I have to choose one while out on an adventure!")
		  elseif entry == 'Basic Attacks' then
			local headbutt = _DATA.DataIndices[RogueEssence.Data.DataManager.DataType.Skill]:Get("headbutt")
			local aron_species = _DATA:GetMonster('aron'):GetColoredName()
			UI:WaitShowDialogue(zig_name .. "'s Almanac\n Tips Entry: Basic Attacks")
			UI:SetCenter(false)
			UI:WaitShowDialogue("Basic attacks are something all Pokémon can perform,[pause=10] regardless of what moves they know!")
			UI:WaitShowDialogue("They're weak compared to most moves,[pause=10] and you won't get any EXP if you only use basic attacks to defeat an enemy...")
			UI:WaitShowDialogue("But you don't need energy to perform them,[pause=10] so even when you've exhausted your moves,[pause=10] you still have basic attacks!")
			UI:WaitShowDialogue("This makes them perfect for conserving energy you need to perform regular moves!")
			UI:WaitShowDialogue("For example,[pause=10] if my " .. headbutt:GetColoredName() .. " barely misses the mark of knocking out my opponent...")
			UI:WaitShowDialogue("I can use a basic attack to finish them off instead of wasting more energy performing another " .. headbutt:GetColoredName() .. "!")
			UI:WaitShowDialogue("Something else that's great about basic attacks is they're typeless![pause=0] That means no type is weak to or resists them!")
			UI:WaitShowDialogue("So sometimes,[pause=10] if your opponent resists all of your moves,[pause=10] basic attacks can be the strongest option you have!")
			UI:WaitShowDialogue("My " .. headbutt:GetColoredName() .. " for example would barely scratch an " .. aron_species .. ",[pause=10] since Steel and Rock resist Normal...")
			UI:WaitShowDialogue("But a basic attack would do more damage than " .. headbutt:GetColoredName() .. " since basic attacks can't be resisted!")
			UI:WaitShowDialogue("A lot of Pokémon think that basic attacks aren't worth using,[pause=10] but that's not true!")
			UI:WaitShowDialogue("They're just something you need to know when to use to get the most out of them!")

		  end
		  
		  
			 
			 
		GROUND:ObjectSetDefaultAnim(obj, 'Diary_Blue_Closing', 0, 0, 0, Direction.Right)
		GROUND:ObjectSetAnim(obj, 6, 0, 3, Direction.Right, 1)
		GROUND:ObjectSetDefaultAnim(obj, 'Diary_Blue_Closing', 0, 3, 3, Direction.Right)	  
    end
	UI:SetCenter(false)
	partner.IsInteracting = false
	GROUND:CharEndAnim(partner)
	GROUND:CharEndAnim(hero)	
end

function guild_bottom_right_bedroom.Data_Almanac_Action(obj, activator)
	UI:ResetSpeaker(false)
	UI:SetCenter(true)
	UI:SetAutoFinish(true)
	
	local hero = CH('PLAYER')
	local partner = CH('Teammate1')
	partner.IsInteracting = true
	GROUND:CharSetAnim(partner, 'None', true)
	GROUND:CharSetAnim(hero, 'None', true)		
    GeneralFunctions.TurnTowardsLocation(hero, obj.Position.X + obj.Width // 2, obj.Position.Y + obj.Height // 2)
    GeneralFunctions.TurnTowardsLocation(partner, obj.Position.X + obj.Width // 2, obj.Position.Y + obj.Height // 2)


	local zig_name = CharacterEssentials.GetCharacterName("Zigzagoon")
	local choices = {'Gummi Stats', "Same Type Attack Bonus", "Type Matchups", "Stat Changes", "Never Mind"}
	--todos: Critical hit mechanics, belly mechanics and specifics
		
	--Don't read his books until he tells you you can.
	if not SV.Chapter1.MetZigzagoon then
		UI:WaitShowDialogue("This appears to be someone else's book.\nBest not read it without their permission.")
		UI:SetCenter(false)
		UI:SetAutoFinish(false)
		partner.IsInteracting = false
		GROUND:CharEndAnim(partner)
		GROUND:CharEndAnim(hero)
		return
	end
	
	UI:ChoiceMenuYesNo("This is one of " .. zig_name .. "'s almanacs.\nIt's entitled " .. '"Measurements and Calculations". Read it?')
	UI:WaitForChoice()
	local result = UI:ChoiceResult()
	UI:SetAutoFinish(false)
	if result then 
		  GROUND:ObjectSetDefaultAnim(obj, 'Diary_Blue_Opening', 0, 0, 0, Direction.Left)	  
	      GROUND:ObjectSetAnim(obj, 6, 0, 3, Direction.Left, 1)
		  GROUND:ObjectSetDefaultAnim(obj, 'Diary_Blue_Opening', 0, 3, 3, Direction.Left)
		  GAME:WaitFrames(40)
		  UI:BeginMultiPageMenu(24, 24, 196, "Data Almanac", choices, 8, 1, #choices)		  
		  UI:WaitForChoice()
		  
		  local entry = choices[UI:ChoiceResult()]
		  
		  if entry == 'Gummi Stats' then
			local gummi = RogueEssence.Dungeon.InvItem("gummi_white")--stick
			UI:WaitShowDialogue(zig_name .. "'s Almanac\n Data Entry: Gummi Stats")
			UI:SetCenter(false)
			UI:WaitShowDialogue("Gummis are colored,[pause=10] tasty treats![pause=0] They're a bit hard to get,[pause=10] but they're worth the search!")
			UI:WaitShowDialogue("There's 18 types of Gummis,[pause=10] one for every Pokémon type.[pause=0] They even permanently raise your stats when eaten!")
			UI:WaitShowDialogue("What stats they raise depends on the Pokémon type the Gummi represents relative to the type of the eater.")
			UI:WaitShowDialogue("If the Gummi's type has no effect or is not very effective on the eater,[pause=10] then their Attack and Sp. Attack will increase.")
			UI:WaitShowDialogue("If the Gummi's type is super effective on the eater,[pause=10] then their Defense and Sp. Defense will increase.")
			UI:WaitShowDialogue("If the Gummi's type is neutral on the eater,[pause=10] then their HP and Speed will increase.")
			UI:WaitShowDialogue("Lastly,[pause=10] if the Gummi's type matches one of the types of the eater,[pause=10] then all their stats increase!")
			UI:WaitShowDialogue("Hmm.[pause=0] I guess I should share Gummis I find with others whose type it matches so the most benefit can be had.")
			UI:WaitShowDialogue("Hopefully they'll do the same and give me any " .. gummi:GetDisplayName() .. " they find!")
		  elseif entry == 'Same Type Attack Bonus' then
			local headbutt = _DATA.DataIndices[RogueEssence.Data.DataManager.DataType.Skill]:Get("headbutt")
			local hydro_pump = _DATA.DataIndices[RogueEssence.Data.DataManager.DataType.Skill]:Get("hydro_pump")
			UI:WaitShowDialogue(zig_name .. "'s Almanac\n Data Entry: Same Type Attack Bonus")
			UI:SetCenter(false)
			UI:WaitShowDialogue("Many Pokémon forget that moves that are the same type as the user are more powerful than moves of other types!")
			UI:WaitShowDialogue("That means if a Water-type uses " .. hydro_pump:GetColoredName() .. ",[pause=10] it would be stronger than if a Dragon-type used it!")
			UI:WaitShowDialogue("At the dojo they call it Same Type Attack Bonus,[pause=10] but I like to to shorten it to STAB.")
			UI:WaitShowDialogue("After many hours testing with Sensei " .. CharacterEssentials.GetCharacterName("Ledian") .. ",[pause=10] I think I figured out just how much stronger moves are with STAB.")
			UI:WaitShowDialogue("Seems like moves do four-thirds (4/3) more damage if the user has STAB.")
			UI:WaitShowDialogue("For me,[pause=10] that means my " .. headbutt:GetColoredName() .. " is four-thirds stronger than other Pokémon that aren't Normal-type like me!")
			UI:WaitShowDialogue("Hopefully this knowledge will help me know which move is best to use against any enemies I encounter on adventures!")

		  
		  elseif entry == 'Type Matchups' then
			UI:WaitShowDialogue(zig_name .. "'s Almanac\n Data Entry: Type Matchups")
			UI:SetCenter(false)
			UI:WaitShowDialogue("As everyone's aware,[pause=10] different types of moves are stronger against different types of Pokémon.")
			UI:WaitShowDialogue("But what I bet not many Pokémon know is just how much more effective or ineffective those types of moves are!")
			UI:WaitShowDialogue("After tons of testing at Ledian Dojo,[pause=10] I've figured out how much type matchups affect a move's strength!")
			UI:WaitShowDialogue("If one of the defender's types is immune to the attack's type,[pause=10] then the move will have no effect at all!")
			UI:WaitShowDialogue("A Fighting move on a Steel/Ghost Pokémon deals no damage,[pause=10] as Ghost is immune to Fighting despite Steel's weakness!")
			UI:WaitShowDialogue("If the attacking move's type isn't effective on both of the defender's types,[pause=10] then the move deals one-fourth damage.")
			UI:WaitShowDialogue("A Normal move on a Steel/Rock Pokémon only deals one-fourth damage,[pause=10] as both Rock and Steel resist Normal!")
		  	UI:WaitShowDialogue("If the attacking move's type is not very effective on one of the defender's types,[pause=10] then the move deals half damage.")
			UI:WaitShowDialogue("A Grass move on a Fire/Dark Pokémon only deals half damage,[pause=10] as Fire resists Grass but Dark is neutral to Grass.")
		  	UI:WaitShowDialogue("If the attacking move's type is overall neutral to the defender's types,[pause=10] then the move will deal regular damage.")
			UI:WaitShowDialogue("A Water move on a Rock/Grass Pokémon will deal regular damage,[pause=10] as Rock is weak to Water but Grass resists it.")
			UI:WaitShowDialogue("If the attacking move's type is super effective on one of the defender's types,[pause=10] the move deals three-halves damage.")
			UI:WaitShowDialogue("A Fire move on a Ice/Dark Pokémon deals three-halves damage,[pause=10] as Ice is weak to Fire and Dark is neutral to Fire.")
		    UI:WaitShowDialogue("If the attacking move's type is super effective on both of the defender's types,[pause=10] then the move deals double damage.")
			UI:WaitShowDialogue("An Ice type will deal double damage to a Dragon/Ground Pokémon,[pause=10] as both Dragon and Ground are weak to Ice!")
			UI:WaitShowDialogue("Things get a bit more complicated when Abilities get involved...[pause=0] But this is a good guideline to work off of!")
			UI:WaitShowDialogue("It's a lot to remember,[pause=10] but knowing damage bonuses and the type-matchup chart will help me on my adventures!")
		  
		  elseif entry == 'Stat Changes' then
		 	local belly_drum = _DATA.DataIndices[RogueEssence.Data.DataManager.DataType.Skill]:Get("belly_drum")
			local zone = _DATA.DataIndices[RogueEssence.Data.DataManager.DataType.Zone]:Get("beginner_lesson")
			UI:WaitShowDialogue(zig_name .. "'s Almanac\n Data Entry: Stat Changes")
			UI:SetCenter(false)
			UI:WaitShowDialogue("There are all sorts of moves that can temporarily change a Pokémon's stats.")
			UI:WaitShowDialogue("These include moves that can raise a user's stats or lower an enemy's stats.")
			UI:WaitShowDialogue("Some moves even take so much power that they actually lower the user's stats!")
			UI:WaitShowDialogue("But to what extent do these stat changes affect a Pokémon's stats?")
			UI:WaitShowDialogue("I wanted to know so I could make better decisions on adventures.")
			UI:WaitShowDialogue("So,[pause=10] I went to Ledian Dojo to test things out,[pause=10] and I learned a lot about how stat changes work!")
			UI:WaitShowDialogue("Hmm.[pause=0] Things might get a bit mathy here,[pause=10] so hopefully this will all makes sense!")
			UI:WaitShowDialogue("For all stats that can be temporarily modified,[pause=10] they can be changed in degrees called stages.")
			UI:WaitShowDialogue("These stages can be either negative or positive,[pause=10] but a stat can only go in one direction up to 6 times.")
			UI:WaitShowDialogue('So if a stat was lowered to the minimum,[pause=10] it would be at\n"-6" and would not be able to go any lower than that!')
			UI:WaitShowDialogue('On the flip,[pause=10] at the absolute maximum a stat would be at "+6" and would not be able to go any higher!')
			UI:WaitShowDialogue("When a stat gets changed,[pause=10] it usually gets changed by 1,[pause=10] 2,[pause=10] or 3 stages at a time.")
			UI:WaitShowDialogue("If it changes slightly,[pause=10] it goes up or down 1 stage.")
			UI:WaitShowDialogue("If it changes sharply or harshly,[pause=10] it goes up or down 2 stages.")
			UI:WaitShowDialogue("If it changes drastically,[pause=10] it goes up or down 3 stages.")
			UI:WaitShowDialogue("There are some moves like " .. belly_drum:GetColoredName() .. " that can change stats by more than 3 stages,[pause=10] but they're exceptions.")
			UI:WaitShowDialogue("Once you know how many stages a stat's been modified,[pause=10] you need to figure out the amount that the stat changes!")
			UI:WaitShowDialogue("To do this...[pause=0] Erm,[pause=10] it's a bit complicated,[pause=10] so bear with me...")
			UI:WaitShowDialogue("Start with the fraction 4/4.[pause=0] Then,[pause=10] if your stat stage is positive,[pause=10] add the number of stages to the top number.")
			UI:WaitShowDialogue("So if you're at " .. '"+6" Attack,[pause=10] that ratio would be (4+6)/4 which is 10/4.')
			UI:WaitShowDialogue("If the stat stage is negative,[pause=10] then you add the number of stages to the number on the bottom.")
			UI:WaitShowDialogue("So if I'm at " .. '"-3" Defense,[pause=10] then my ratio would be 4/(4+3) which is 4/7.')
			UI:WaitShowDialogue("Of course,[pause=10] if you have no stat change in a stat,[pause=10] this ratio should just stay at 4/4.")
			UI:WaitShowDialogue("Anyways,[pause=10] once you get that ratio,[pause=10] you multiply your stat with that ratio to get your new effective stat!")
			UI:WaitShowDialogue("So a Pokémon at +6 Attack hits two-and-a-half times as hard!")
			UI:WaitShowDialogue('And a Pokémon at -6 Defense would get hurt two-and-a-half times as hard!')
			UI:WaitShowDialogue("This all applies to Attack,[pause=10] Defense,[pause=10] Special Attack,[pause=10] and Special Defense.")
			UI:WaitShowDialogue("Accuracy and Evasion are a bit different.[pause=0] Start with 2/2 as the base ratio,[pause=10] but otherwise do the rest the same.")
			UI:WaitShowDialogue("So a Pokémon with +6 Evasion would have the ratio be (2+6)/2,[pause=10] which is 8/2.")
			UI:WaitShowDialogue("With that ratio,[pause=10] they'd only get hit one-fourth of the time they normally would!")
		    UI:WaitShowDialogue("On the other side,[pause=10] a Pokémon with -3 Accuracy would have the ratio 2/(2+3) which is 2/5.")
			UI:WaitShowDialogue("With a ratio of 2/5,[pause=10] they would only hit 40 percent of the normal rate!")
			UI:WaitShowDialogue("Though,[pause=10] I don't think I've ever seen a Pokémon miss two attacks in a row,[pause=10] so keep that in mind.")
			UI:WaitShowDialogue("Lastly,[pause=10] Speed doesn't get changed like other stats do,[pause=10] so I think I'll leave that for a different entry.")
			UI:WaitShowDialogue("I think Ledian Dojo's " .. zone:GetColoredName() .. " has the information on how that works anyway...")
			UI:WaitShowDialogue("...And I think that covers it.[pause=0] My paw and my brain hurts a bit after writing all this...")
			UI:WaitShowDialogue("Still,[pause=10] it's good that I write this all down,[pause=10] especially after I did all that work to figure it all out!")
			UI:WaitShowDialogue("After all,[pause=10] who knows when this sort of information could come in handy!")
		  end
			
			 
		GROUND:ObjectSetDefaultAnim(obj, 'Diary_Blue_Closing', 0, 0, 0, Direction.Left)
		GROUND:ObjectSetAnim(obj, 6, 0, 3, Direction.Left, 1)
		GROUND:ObjectSetDefaultAnim(obj, 'Diary_Blue_Closing', 0, 3, 3, Direction.Left)	  
    end
	UI:SetCenter(false)
	partner.IsInteracting = false
	GROUND:CharEndAnim(partner)
	GROUND:CharEndAnim(hero)		

end


---------------------------
-- Map Transitions
---------------------------
function guild_bottom_right_bedroom.Bedroom_Exit_Touch(obj, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  GAME:FadeOut(false, 20)
  GAME:EnterGroundMap("guild_bedroom_hallway", "Guild_Bedroom_Hallway_Bottom_Right_Marker")
  SV.partner.Spawn = 'Guild_Bedroom_Hallway_Bottom_Right_Marker_Partner'
end

return guild_bottom_right_bedroom

