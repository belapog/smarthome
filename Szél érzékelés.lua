--[[
%% properties
158 value
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
log("Szél érzékelés elindítva");

local wind = tonumber(fibaro:getValue(158, "value"));
local minHighWind = tonumber(fibaro:getGlobalValue("MinHighWind"));
local currentDate = os.time();

log("wind: " .. tostring(wind));
log("minHighWind: " .. tostring(minHighWind));
log("currentDate: " .. tostring(currentDate));

if (wind >= minHighWind ) then
	log ("Nagy a szél");
	fibaro:setGlobal("TooWindy", wind);
	fibaro:setGlobal("TooWindyTime", tostring(currentDate));
end