--[[
    scriptvars.lua
      This file contains all the default values for the script variables. AKA on a new game this file is loaded!
      Script variables are stored in a table  that gets saved when the game is saved.
      Its meant to be used for scripters to add data to be saved and loaded during a playthrough.
      
      You can simply refer to the "SV" global table like any other table in any scripts!
      You don't need to write a default value in this lua script to add a new value.
      However its good practice to set a default value when you can!
      
    --Examples:
    SV.SomeVariable = "Smiles go for miles!"
    SV.AnotherVariable = 2526
    SV.AnotherVariable = { something={somethingelse={} } }
    SV.AnotherVariable = function() print('lmao') end
]]--
print('Loading default script variable values..')
-----------------------------------------------
-- Services Defaults
-----------------------------------------------
SV.Services =
{
  --Anything that applies to services should be put in here, or assigned to this or a subtable of this in the service's definition script
}

-----------------------------------------------
-- General Defaults
-----------------------------------------------
SV.General =
{
  Rescue = nil
  --Anything that applies to more than a single level, and that is too small to make a sub-table for, should be put in here ideally, or a sub-table of this
}

SV.checkpoint = 
{
  Zone    = 1, Structure  = -1,
  Map  = 1, Entry  = 0,
}

SV.partner = 
{
	Spawn = 'Default',
	Dialogue = 'Default'

}



-------------------------------------------------
-- Temporary Flags - Flags that reset at the end of the day or on screen transition are saved here
-------------------------------------------------
--todo, move existing daily flags here
--These flags are to be reset to their initial values at the end of the day.
SV.DailyFlags = 
{
  RedMerchantItem = -1,
  RedMerchantBought = false,
  GreenMerchantItem = -1,
  GreenMerchantBought = false
}

--Flags that are reset once you leave the current map 
--maybe replace with LTBL? see example in test_grounds
SV.TemporaryFlags = 
{

}


-----------------------------------------------
-- Level Specific Defaults
-----------------------------------------------

--todo: cleanup a lot of these
SV.metano_town = 
{
  WooperIntro = false,
  LuxioIntro = false,
  AggronGuided = false,
  KecIntro = false,
}

SV.metano_cafe =
{
  CafeSpecial = -1,
  BoughtSpecial = false,
  FermentedItem = 2500, 
  ItemFinishedFermenting = true,
  ExpeditionPreparation = true,
  GaveFreeExpeditionItem = false
}


SV.guild = 
{
	JustWokeUp = false--Did the duo JUST wake up on a new day?
}


-----------------------------------------------------------------------------
-- Chapter / Cutscenes flags. Flags that control the state of the story are stored here
----------------------------------------------------------------------------


--Keeps track of 
SV.ChapterProgression = 
{
	DaysPassed = 0,--total number of in game days played in the game
	DaysToReach = -1, --Used to figure out what day needs to be reached to continue the story
	Chapter = 1
}


SV.Chapter1 = 
{
	PlayedIntroCutscene = false,
	PartnerEnteredForest = false,--Did partner go into the forest yet?
	PartnerCompletedForest = false,--Did partner complete solo run of first dungeon?
	PartnerMetHero = false,--Finished partner meeting hero cutscene in the relic forest?
	TeamCompletedForest = false --completed backtrack to town?
}







--base game stuff
SV.test_grounds =
{
  SpokeToPooch = false,
  AcceptedPooch = false
}


SV.base_camp = 
{
  IntroComplete    = false,
  ExpositionComplete  = false,
  FirstTalkComplete  = false
}

SV.base_shop = {
	{ Index = 1, Hidden = 0, Price = 50},
	{ Index = 2, Hidden = 0, Price = 150},
	{ Index = 6, Hidden = 0, Price = 500},
	{ Index = 9, Hidden = 0, Price = 80},
	{ Index = 11, Hidden = 0, Price = 80}
}
SV.base_trades = {
	{ Item=902, ReqItem={-1,-1}},
	{ Item=908, ReqItem={-1,-1}},
	{ Item=914, ReqItem={-1,-1}}
}

SV.base_town = 
{
  Song    = "1 - Base Town.ogg"
}

SV.forest_camp = 
{
  ExpositionComplete  = false
}

SV.cliff_camp = 
{
  ExpositionComplete  = false,
  TeamRetreatIntro = false
}

SV.canyon_camp = 
{
  ExpositionComplete  = false
}

SV.rest_stop = 
{
  ExpositionComplete  = false
}

SV.final_stop = 
{
  ExpositionComplete  = false
}

SV.guildmaster_summit = 
{
  ExpositionComplete  = false,
  BattleComplete = false
}


----------------------------------------------
print('Script variables default values loaded!')