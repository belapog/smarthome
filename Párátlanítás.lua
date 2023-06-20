--[[
%% properties
140 value
%% weather
%% events
%% globals
Alvas
--]]

--=================================================
-- Common functions
--=================================================
local debug = true
local function log(str) if debug then fibaro:debug(str); end; end
local function errorlog(str) fibaro:debug("<font color='red'>"..str.."</font>"); end
local function infolog(str) fibaro:debug("<font color='yellow'>"..str.."</font>"); end

--=================================================
-- Main
--=================================================
log("Páratartalanítás strated");
local paratartalom = tonumber(fibaro:getValue(140, "value"));
log ("páratartalom: " .. tostring(paratartalom));

if (
 ( paratartalom > 60 )
and
 ( fibaro:getGlobalValue("Alvas") == "Ébrenlét" )
)
then
    log("Páratartalanítás be");
	fibaro:call(193, "turnOn");
end

if (
 ( paratartalom < 55 )
or
 ( fibaro:getGlobalValue("Alvas") == "Alvás" )
)
then
    log("Páratartalanítás ki");
	fibaro:call(193, "turnOff");
end