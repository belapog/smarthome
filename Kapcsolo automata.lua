--[[
%% properties
76 value
76 armed
98 value
%% weather
%% events
%% globals
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

local timer = 120;
local currentDate = os.time();
local offTime = 3;

--Mi triggerelte az eseményt /wc vagy előszoba mozgás érzékelő/
local trigger = fibaro:getSourceTrigger();
local triggerDevice = "other";
if (trigger['type'] == 'property') then
    local triggerDeviceId = trigger['deviceID'];
    if (triggerDeviceId == 76) then
        if (tonumber(fibaro:getValue(76, "value")) > 0 ) then
            triggerDevice = "OnMotion";
        end
    elseif (triggerDeviceId == 98) then
        if (tonumber(fibaro:getValue(98, "value")) > 0 ) then
            triggerDevice = "OffMotion";
        end
    end
end
debug ("triggerDevice: " .. triggerDevice);


if (triggerDevice == "OnMotion") then
    if ((tonumber(fibaro:getValue(76, "value")) > 0) and (tonumber(fibaro:getValue(76, "armed")) == 0)) then
        fibaro:setGlobal("SwitchOn164",  tostring(currentDate));
        fibaro:call(164, "turnOn");
        debug ("turnOn");

        setTimeout(function()
            local lastSwithOnDate = fibaro:getGlobalValue("SwitchOn164");
            local timeTakenLastSwitchOnDate = tonumber(os.difftime(os.time(), lastSwithOnDate));
            debug("timeTakenLastSwitchOnDate: " .. tostring(timeTakenLastSwitchOnDate));
            if (timeTakenLastSwitchOnDate >= timer) then
                fibaro:call(164, "turnOff");
                debug ("turnOff Auto");
            end
        end, timer * 1000)
    end
end

if (triggerDevice == "OffMotion") then
    local lastSwithOnDate = fibaro:getGlobalValue("SwitchOn164");
    local timeTakenLastSwitchOnDate = tonumber(os.difftime(os.time(), lastSwithOnDate));
    debug("timeTakenLastSwitchOnDate: " .. tostring(timeTakenLastSwitchOnDate));
    if (timeTakenLastSwitchOnDate <= offTime) then
        fibaro:call(164, "turnOff");
        debug ("turnOff Off Motion");
    end
end