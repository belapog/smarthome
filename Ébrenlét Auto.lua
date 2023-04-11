--[[
%% properties
%% weather
%% events
%% globals
Napszak
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
log ("Ébrenlét automata elindítva");

if (
 ( fibaro:getGlobalValue("Napszak") == "Nappal"  and  
 fibaro:getGlobalValue("Alvas") == "Alvás"  and  
 fibaro:getGlobalValue("OtthonVannak") == "Nincsenek" )
)
then
    infolog ("Ébrenlét);
    fibaro:setGlobal("Alvas", "Ébrenlét");
end