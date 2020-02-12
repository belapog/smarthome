--[[
%% properties
%% weather
%% events
%% globals
Napszak
Alvas
%% autostart
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

function ScheduledFuncFlowLamp()
    -- este 10 után kikapcs
    local currentDate = os.date("*t");
    local hour = tonumber(string.format("%02d", currentDate.hour));

    if ( hour >= 22 ) then
        fibaro:call(173, "turnOff");
    end

    setTimeout(ScheduledFuncFlowLamp, 60*1000)
end

debug("Virágkeltető világítás automata");

local sourceTrigger = fibaro:getSourceTrigger();

if (sourceTrigger["type"] == "autostart") then
    ScheduledFuncFlowLamp()
else

    local night = (fibaro:getGlobalValue("Napszak") == "Este");
    debug ("Napszak: " .. tostring(night));

    local ebrenlet = (fibaro:getGlobalValue("Alvas") ==  "Ébrenlét");
    debug ("ebrenlet: " .. tostring(ebrenlet));

    local currentDate = os.date("*t");
    local hour = tonumber(string.format("%02d", currentDate.hour));

    if (night and ebrenlet and (hour < 22)) then
        fibaro:call(173, "turnOn");
        debug ("turnOn");
    end

    if (night and not ebrenlet) then
        fibaro:call(173, "turnOff");
        debug ("turnOff 1");
    end

    if (not night) then
        fibaro:call(173, "turnOff");
        debug ("turnOff 2");
    end
end
