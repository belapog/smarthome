--[[
%% properties
124 secured
%% weather
%% events
%% globals
OtthonVannak
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

debug ("Távozás elindítva");

local trigger = fibaro:getSourceTrigger();
local triggerType = trigger['type'];
debug ("triggerType: " .. triggerType);

local atHome = fibaro:getGlobalValue("OtthonVannak");
debug ("atHome: " .. atHome, 1);

local autoRiaszto = fibaro:getGlobalValue("AutoRiaszto");
debug ("autoRiaszto: " .. autoRiaszto, 1);

local alarmReady = (
    (tonumber(fibaro:getValue(177, "value")) == 0) and  
    (tonumber(fibaro:getValue(178, "value")) == 0) and  
    (tonumber(fibaro:getValue(176, "value")) == 0) and 
    (tonumber(fibaro:getValue(175, "value")) == 0) );
debug ("alarmReady: " .. tostring(alarmReady));

local secured = (tonumber(fibaro:getValue(124, "secured")) == 255 );
debug ("secured: " .. tostring(secured));

--Automata riasztás
if ((triggerType == "global") and (atHome == "Nincsenek") and alarmReady and (autoRiaszto == "Igen")) then
    fibaro:call(124, "secure");
    secured = true;
    debug ("Automata riasztás bekapcsolása");
end

if ((triggerType ~= "global") and (atHome ~= "Nincsenek") and alarmReady) then
    fibaro:setGlobal("OtthonVannak", "Nincsenek");
    atHome = "Nincsenek";
    fibaro:call(124, "secure");
    secured = true;
    debug ("secured");
    debug ("OtthonVannak set to Nincsenek");
end
    
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
    debug("Riaszto aktiválva", 2);
end

if (not alarmReady and secured) then 
    fibaro:call(4, "sendDefinedPushNotification", "7");
    debug("Riaszto nem aktiválható, valamelyik ablak nyitva van");
end
