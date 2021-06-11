--[[
%% properties
67 value
%% weather
%% events
%% globals
Futes
CelHomerseglet
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
log ("Napvédő elindítva");
local heating = fibaro:getGlobalValue("Futes");
local targetTemperature = tonumber(fibaro:getGlobalValue("CelHomerseglet"));
local temperature = tonumber(fibaro:getValue(67, "value"));
local weAreAtHome = ((fibaro:getGlobalValue("OtthonVannak") == "Igen") or (fibaro:getGlobalValue("OtthonVannak") == "Talán"));
local trigger = fibaro:getSourceTrigger();
local manual = (trigger['type'] == "other")


log ("futes: " .. tostring(heating));
log ("celHomerseglet: " .. tostring(targetTemperature));
log ("homerseglet: " .. tostring(temperature));
log ("weAreAtHome: " .. tostring(weAreAtHome));
log ("manual: " .. tostring(manual));

if ((heating == "Hűtés")  and  (temperature > targetTemperature+1) and (not weAreAtHome)) or manual then
    infolog ("Napvédelem kell");
    fibaro:call(121, "setValue", "30");
    fibaro:call(115, "setValue", "30");
    fibaro:call(129, "setValue", "30");
    fibaro:startScene(31);
end
