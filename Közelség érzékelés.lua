--[[
%% properties
%% weather
%% events
184 GeofenceEvent 5
%% globals
--]]

function debug(message, level)
    if level == nil then
        level = 1;
    end
    local debugLevel = 1;
    if (level >= debugLevel) then
        fibaro:debug (message);
    end
end

local startSource = fibaro:getSourceTrigger();
local startSourceType = startSource["type"];

if (startSourceType == "event")
then
    if (startSource.event["type"] == "GeofenceEvent")
    then
        if(startSource.event.data["geofenceAction"] == "enter")
        then
            debug ("Hazaérkeztem");
            fibaro:call(184, "sendDefinedPushNotification", "9");
            fibaro:startScene(57);
        end
        if(startSource.event.data["geofenceAction"] == "leave")
        then
            debug ("Elmentem");
            fibaro:call(184, "sendDefinedPushNotification", "14");
            fibaro:startScene(56);
        end
    end
end