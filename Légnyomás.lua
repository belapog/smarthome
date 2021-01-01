--[[
%% properties
159 value
%% weather
%% events
%% globals
--]]

--=================================================
-- Common functions
--=================================================
local debug = false
local function log(str) if debug then fibaro:debug(str); end; end
local function errorlog(str) fibaro:debug("<font color='red'>"..str.."</font>"); end

--=================================================
-- Main
--=================================================
log("Légnyomás statisztika elindítva");

local airPressure = tonumber(fibaro:getValue(159, "value"));
local airPressureMin = tonumber(fibaro:getGlobalValue("AirPressureMin"))
local airPressureMax = tonumber(fibaro:getGlobalValue("AirPressureMax"))

log("airPressure: " .. tostring(airPressure));
log("airPressureMin: " .. tostring(airPressureMax));
log("airPressureMax: " .. tostring(airPressureMax));

if airPressureMin > airPressure then
    fibaro:setGlobal("AirPressureMin", airPressure);
    log("Napi legnyomás minimum beállítva ");
end

if airPressure > airPressureMax then
    fibaro:setGlobal("AirPressureMax", airPressure);
    log("Napi legnyomás maximum beállítva ");
end
