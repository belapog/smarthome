--[[
%% properties
115 sceneActivation
%% weather
%% events
%% globals
--]]

function debug(message, level)
    if level == nil then
        level = 1;
    end
    local debugLevel = 2;
    if (level >= debugLevel) then
        fibaro:debug (message);
    end
end

debug ("Ébredés érzékelés aktiválva");

local trigger = fibaro:getSourceTrigger();
local triggerSceneActivationID;

--local sceneActivation = tonumber(fibaro:getValue(115, "sceneActivation"));
if trigger["type"] == "other" then
    triggerSceneActivationID = 16;
    debug ("manual");
else
    local triggerDeviceId = trigger['deviceID'];
    if triggerDeviceId == 115 then
        triggerSceneActivationID = tonumber(fibaro:getValue(triggerDeviceId, "sceneActivation"));
    end
end
    
debug ("sceneActivation: " .. tostring(triggerSceneActivationID));

if ( tonumber(triggerSceneActivationID) == 16 ) then
    fibaro:setGlobal("Alvas", "Ébrenlét");
    debug ("Ébrenlét");
end