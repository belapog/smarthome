--[[
%% properties
140 value
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

debug("Páratartalom figyelés strated");

local paratartalom = tonumber(fibaro:getValue(140, "value"));
debug ("páratartalom: " .. tostring(paratartalom));

if ((paratartalom > 55 ))
then
		debug("Nagy a páratartalom!", 2);
		fibaro:call(4, "sendDefinedPushNotification", "10");
end

if (( paratartalom < 40 ))
then
		debug("Alacsony a páratartalom!", 2);
		fibaro:call(4, "sendDefinedPushNotification", "11");
end