--[[
%% properties
2 Location
%% weather
%% events
4 GeofenceEvent 5
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

local distance = fibaro:calculateDistance(fibaro:getValue(2, "Location"), "47.60;19.06");
local previousDistance = fibaro:calculateDistance(fibaro:getValue(2, "PreviousLocation"), "47.60;19.06");
local location = fibaro:getValue(2, "Location");

debug ("distance: " .. tostring(distance));
debug ("previousDistance: " .. tostring(previousDistance));

debug ("location: " .. tostring(location));