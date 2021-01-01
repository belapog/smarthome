--[[
%% properties
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

--=================================================
-- Main
--=================================================

log("Éjszakai riasztó elindítva");

if (
 ( fibaro:getGlobalValue("Alvas") == "Alvás" )
and
 ( fibaro:getGlobalValue("OtthonVannak") == "Igen" )
)
then
    fibaro:call(57, "setArmed", "1");
    log("Éjszakai riasztás be");
end

if (
 ( fibaro:getGlobalValue("Alvas") == "Ébrenlét" )
and
 ( fibaro:getGlobalValue("OtthonVannak") == "Igen" )
)
then
    fibaro:call(57, "setArmed", "0");
    log("Éjszakai riasztás ki");
end


