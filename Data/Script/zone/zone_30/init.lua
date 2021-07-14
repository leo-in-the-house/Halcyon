require 'common'

local zone_30 = {}
--------------------------------------------------
-- Map Callbacks
--------------------------------------------------
function zone_30.Init(zone)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  PrintInfo("=>> Init_zone_30")
  

end

function zone_30.AllyInteract(chara, target, zone)
  COMMON.DungeonInteract(chara, target, zone)
end

function zone_30.Rescued(zone, mail)
  COMMON.Rescued(zone, mail)
end

function zone_30.ExitSegment(zone, result, rescue, segmentID, mapID)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  PrintInfo("=>> ExitSegment_zone_30 result "..tostring(result).." segment "..tostring(segmentID))
  
  --first check for rescue flag; if we're in rescue mode then take a different path
  if rescue == true then
    COMMON.EndRescue(zone, result, segmentID)
  elseif result ~= RogueEssence.Data.GameProgress.ResultType.Cleared then
    COMMON.EndDungeonDay(result, SV.checkpoint.Zone, SV.checkpoint.Structure, SV.checkpoint.Map, SV.checkpoint.Entry)
  else
    if segmentID == 0 then
      COMMON.EndDungeonDay(result, 1, -1, 1, 0)
    else
      PrintInfo("No exit procedure found!")
    end
  end
  
end

return zone_30