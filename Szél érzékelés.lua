--[[
%% properties
158 value
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

debug("Szél érzékelés");

local wind = tonumber(fibaro:getValue(158, "value"));
local minHighWind = tonumber(fibaro:getGlobalValue("MinHighWind"));;
local currentDate = os.time();

debug (tostring(currentDate));

if (wind >= minHighWind ) then
	debug ("Too windy");
	fibaro:setGlobal("TooWindy", wind);
	fibaro:setGlobal("TooWindyTime", tostring(currentDate));
end