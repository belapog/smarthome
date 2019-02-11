--[[
%% properties
115 sceneActivation
%% weather
%% events
%% globals
--]]

local trigger = fibaro:getSourceTrigger();
local triggerSceneActivationID;
local debug = true;

--local sceneActivation = tonumber(fibaro:getValue(115, "sceneActivation"));
if trigger["type"] == "other" then
    triggerSceneActivationID = 16;
    if debug then fibaro:debug ("manual"); end;
else
    local triggerDeviceId = trigger['deviceID'];
    if triggerDeviceId = 115 then
        triggerSceneActivationID = tonumber(fibaro:getValue(triggerDeviceId, "sceneActivation"));
    end
end
    
if debug then fibaro:debug ("sceneActivation: " .. tostring(triggerSceneActivationID)); end

if ( tonumber(triggerSceneActivationID) == 16 ) then
    fibaro:setGlobal("Alvas", "Ébrenlét");
    if debug then fibaro:debug ("Ébrenlét"); end
end