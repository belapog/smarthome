--[[
%% properties
101 value
25 value
79 value
%% weather
%% events
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

debug("Földrengés érzékelés elindítva");

if (
    tonumber(fibaro:getValue(101, "value")) > 0  or
    tonumber(fibaro:getValue(25, "value")) > 0  or
    tonumber(fibaro:getValue(79, "value")) > 0)
then
    debug("Földrengés!!!");
    fibaro:call(184, "sendDefinedPushNotification", "8");
end