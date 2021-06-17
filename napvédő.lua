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
    fibaro:startScene(51);
    log ("rollerShutterPosition: " .. tostring(fibaro:getValue(10, "value")));

    --várakozás, hogy elindúlt-e lefelé a napvédő?
    local start = os.time()
    repeat until os.time() > start + 30
    local rollerShutterPositionNotUp = (tonumber(fibaro:getValue(13, "value")) < 99  or  
    tonumber(fibaro:getValue(10, "value")) < 99  or  
    tonumber(fibaro:getValue(16, "value")) < 99  or  
    tonumber(fibaro:getValue(19, "value")) < 99
    )
    log ("rollerShutterPosition: " .. tostring(fibaro:getValue(10, "value")));
    log ("rollerShutterPositionNotUp: " .. tostring(rollerShutterPositionNotUp));

    if rollerShutterPositionNotUp then
        infolog("Hővédelem aktív")
        fibaro:setGlobal("NapellenzoStatus", "Hővédelem");
    end
end
