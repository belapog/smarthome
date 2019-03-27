--[[
%% properties
%% weather
Temperature
%% events
%% globals
CelHomerseglet
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

debug("HomersegletAuto strated");

local celHomerseglet = tonumber(fibaro:getGlobalValue("CelHomerseglet"));
local temperatureOutside = tonumber(api.get('/weather')['Temperature']);
debug("celHomerseglet: " .. tostring(celHomerseglet));
debug("temperatureOutside: " .. tostring(temperatureOutside));
local ujHomerseglet = 23.5;

if (celHomerseglet < temperatureOutside / 1.2) then
    ujHomerseglet = (temperatureOutside / 1.2);
    debug("Túl meleg van kinn");
else
    ujHomerseglet = celHomerseglet;
    debug("Hőmérséglet beállítva");
end

debug("ujHomerseglet: " .. tostring(ujHomerseglet));



fibaro:call(66, "setThermostatSetpoint", "1", celHomerseglet);
fibaro:call(61, "setThermostatSetpoint", "1", celHomerseglet);
fibaro:call(89, "setThermostatSetpoint", "1", celHomerseglet);


