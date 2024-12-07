--[[
%% properties
%% weather
%% events
%% globals
Napszak
Alvas
%% autostart
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
log ("Virágautomata elindítva");

local trigger = fibaro:getSourceTrigger();
local triggerType = trigger['type'];
log ("triggerType: " .. triggerType);

function ScheduledFuncFlowLamp()
    -- este 10 után kikapcs
    local currentDate = os.date("*t");
    local hour = tonumber(string.format("%02d", currentDate.hour));

    if ( hour >= 22 ) then
        fibaro:call(200, "turnOff");
    end

    setTimeout(ScheduledFuncFlowLamp, 60*1000)
end

log("Virágkeltető világítás automata");

local sourceTrigger = fibaro:getSourceTrigger();

if (sourceTrigger["type"] == "autostart") then
    ScheduledFuncFlowLamp()
else

    local night = (fibaro:getGlobalValue("Napszak") == "Este");
    log ("Napszak: " .. tostring(night));

    local ebrenlet = (fibaro:getGlobalValue("Alvas") ==  "Ébrenlét");
    log ("ebrenlet: " .. tostring(ebrenlet));

    local currentDate = os.date("*t");
    local hour = tonumber(string.format("%02d", currentDate.hour));

    if (night and ebrenlet and (hour < 22)) then
        fibaro:call(200, "turnOn");
        log ("turnOn");
    end

    if (night and not ebrenlet) then
        fibaro:call(200, "turnOff");
        log ("turnOff 1");
    end

    if (not night) then
        fibaro:call(200, "turnOff");
        log ("turnOff 2");
    end
end
