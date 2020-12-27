--[[
%% properties
159 value
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

debug("HomersegletAuto strated");

local airPressure = tonumber(fibaro:getValue(159, "value"));
local airPressureMin = tonumber(fibaro:getGlobalValue("AirPressureMin"))
local airPressureMax = tonumber(fibaro:getGlobalValue("AirPressureMax"))

debug("airPressure: " .. tostring(airPressure));
debug("airPressureMin: " .. tostring(airPressureMax));
debug("airPressureMax: " .. tostring(airPressureMax));

if airPressureMin > airPressure then
    fibaro:setGlobal("AirPressureMin", airPressure)
end

if airPressure > airPressureMax then
    fibaro:setGlobal("AirPressureMax", airPressure)
end
