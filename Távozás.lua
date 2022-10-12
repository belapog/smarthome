--[[
%% properties
124 secured
%% weather
%% events
%% globals
OtthonVannak
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
log ("Távozás elindítva");

local trigger = fibaro:getSourceTrigger();
local triggerType = trigger['type'];
log ("triggerType: " .. triggerType);

local atHome = fibaro:getGlobalValue("OtthonVannak");
log ("atHome: " .. atHome);

local autoRiaszto = fibaro:getGlobalValue("AutoRiaszto");
log ("autoRiaszto: " .. autoRiaszto);

local alarmReady = (
    (tonumber(fibaro:getValue(177, "value")) == 0) and  
    (tonumber(fibaro:getValue(178, "value")) == 0) and  
    (tonumber(fibaro:getValue(176, "value")) == 0) and 
    (tonumber(fibaro:getValue(175, "value")) == 0) );
log ("alarmReady: " .. tostring(alarmReady));

local secured = (tonumber(fibaro:getValue(124, "secured")) == 255 );
log ("secured: " .. tostring(secured));

local mobileDeviceId = fibaro:getGlobalValue("MobileDeviceId");

--Automata riasztás esete (nincsenek otthon)
if ((triggerType == "global") and (atHome == "Nincsenek") and alarmReady and (autoRiaszto == "Igen")) then
    fibaro:call(124, "secure");
    secured = true;
    log ("Automata riasztás bekapcsolása");
end

--Kézi indítás esete
if ((triggerType ~= "global") and (atHome ~= "Nincsenek") and alarmReady) then
    fibaro:setGlobal("OtthonVannak", "Nincsenek");
    atHome = "Nincsenek";
    fibaro:call(124, "secure");
    secured = true;
    log ("secured");
    log ("OtthonVannak set to Nincsenek");
end

--Riasztó bekapcsolás
if (alarmReady and secured) then
    fibaro:call(22, "setArmed", "1");
    fibaro:call(57, "setArmed", "1");
    fibaro:call(76, "setArmed", "1");
    fibaro:call(98, "setArmed", "1");
    fibaro:call(142, "setArmed", "1");
	fibaro:call(148, "setArmed", "1");
    fibaro:call(175, "setArmed", "1");
    fibaro:call(176, "setArmed", "1");
	fibaro:call(177, "setArmed", "1");
	fibaro:call(178, "setArmed", "1");
	fibaro:call(180, "setArmed", "1");

    fibaro:call(124, "secure");

    if (atHome ~= "Nincsenek") then
        fibaro:setGlobal("OtthonVannak", "Nincsenek");
    end
    log("Riaszto aktiválva", 2);
end

if (not alarmReady and secured) then 
    fibaro:call(mobileDeviceId, "sendDefinedPushNotification", "7");
    log("Riaszto nem aktiválható, valamelyik ablak nyitva van");
end