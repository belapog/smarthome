--[[
%% properties
140 value
%% weather
%% events
%% globals
Alvas
OtthonVannak
--]]

--=================================================
-- Common functions
--=================================================
local debug = false
local function log(str) if debug then fibaro:debug(str); end; end
local function errorlog(str) fibaro:debug("<font color='red'>"..str.."</font>"); end
local function infolog(str) fibaro:debug("<font color='yellow'>"..str.."</font>"); end

--=================================================
-- Main
--=================================================
log("Páratartalanítás strated");
local paratartalom = tonumber(fibaro:getValue(140, "value"));
log ("páratartalom: " .. tostring(paratartalom));

local alvas = fibaro:getGlobalValue("Alvas");
log ("alvas: " .. tostring(alvas));
local otthonVannak = fibaro:getGlobalValue("OtthonVannak");
log ("otthonVannak: " .. tostring(otthonVannak));

if (
 ( paratartalom > 60 )
and
 ( alvas == "Ébrenlét" )
and 
 ( otthonVannak == "Nincsenek" )

)
then
    log("Páratartalanítás be");
	fibaro:call(193, "turnOn");
end

if (
 ( paratartalom < 55 )
or
 ( alvas == "Alvás" )
or 
 ( otthonVannak == "Igen" )
)
then
    log("Páratartalanítás ki");
	fibaro:call(193, "turnOff");
end