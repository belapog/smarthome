--[[
%% properties
22 value
57 value
76 value
98 value
142 value
148 value
175 value
176 value
177 value
178 value
180 value
22 armed
57 armed
76 armed
98 armed
142 armed
148 armed
175 armed
176 armed
177 armed
178 armed
180 armed
%% weather
%% events
%% globals
--]]

function Debug(message, level)
    if level == nil then
        level = 1;
    end
    local debugLevel = 1;
    if (level >= debugLevel) then
        fibaro:debug (message);
    end
end

function GetSourceTrigger ()
    local trigger = fibaro:getSourceTrigger();
    local triggerDevice;
    if (trigger['type'] == 'property') then
        triggerDevice = trigger['deviceID'];
    else
        triggerDevice = "other";
    end
    return triggerDevice;
end

Debug ("Riasztás vége: " .. GetSourceTrigger());

if (
    (tonumber(fibaro:getValue(22, "armed")) == 0)  and  
    (tonumber(fibaro:getValue(142, "armed")) == 0) and  
    (tonumber(fibaro:getValue(76, "armed")) == 0) and
    (tonumber(fibaro:getValue(148, "armed")) == 0)  and  
    (tonumber(fibaro:getValue(177, "armed")) == 0)  and  
    (tonumber(fibaro:getValue(176, "armed")) == 0)  and
    (tonumber(fibaro:getValue(175, "armed")) == 0)  and
    (tonumber(fibaro:getValue(178, "armed")) == 0)  and
    (tonumber(fibaro:getValue(180, "armed")) == 0) and
    (tonumber(fibaro:getValue(183, "value")) > 0 )
)
then
    Debug ("Riasztó kikapcsolás", 2);
    fibaro:call(183, "turnOff");
end

