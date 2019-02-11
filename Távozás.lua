--[[
%% properties
92 secured
%% weather
%% events
%% globals
OtthonVannak
--]]

fibaro:debug ("Távozás otthonról elindítva")

local trigger = fibaro:getSourceTrigger();
local triggerType = trigger['type'];

fibaro:debug ("triggerType" .. triggerType);

local notAtHome = (fibaro:getGlobalValue("OtthonVannak") == "Nem");
if (notAtHome)
    fibaro:call(92, "secure");
end

local riasztoBekapcs = (tonumber(fibaro:getValue(92, "secured")) == 255 )

if (tonumber(fibaro:getValue(31, "value")) > 0 or
    tonumber(fibaro:getValue(96, "value")) > 0 or  
    tonumber(fibaro:getValue(105, "value")) > 0 or  
    tonumber(fibaro:getValue(108, "value")) > 0 ) then
        fibaro:call(4, "sendDefinedPushNotification", "7");
        fibaro:debug("Riaszto nem aktiválható, valamelyik ablak nyitva van");
else   
    fibaro:call(22, "setArmed", "1");
    fibaro:call(30, "setArmed", "1");
    fibaro:call(31, "setArmed", "1");
    fibaro:call(76, "setArmed", "1");
    fibaro:call(95, "setArmed", "1");
    fibaro:call(96, "setArmed", "1");
    fibaro:call(104, "setArmed", "1");
    fibaro:call(105, "setArmed", "1");
    fibaro:call(107, "setArmed", "1");
    fibaro:call(108, "setArmed", "1");
    fibaro:call(57, "setArmed", "1");
    fibaro:call(98, "setArmed", "1");
    
    fibaro:call(92, "secure");
    
    fibaro:setGlobal("Riaszto", "Be");
    fibaro:debug("Riaszto aktiválva");
end