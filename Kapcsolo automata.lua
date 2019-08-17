--[[
%% properties
76 value
76 armed
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

debug("Kapcsoló automata strated");
debug("value" .. tostring(fibaro:getValue(76, "value")));

local currentDate = os.time();
debug (tostring(currentDate));

if ((tonumber(fibaro:getValue(76, "value")) > 0) and (tonumber(fibaro:getValue(76, "armed")) == 0)) then
    fibaro:setGlobal("SwitchOn164",  tostring(currentDate));
    fibaro:call(164, "turnOn");

    setTimeout(function()
        local lastSwithOnDate = fibaro:getGlobalValue("SwitchOn164");
        local timeTakenLastSwitchOnDate = tonumber(os.difftime(os.time(), lastSwithOnDate));
        debug("timeTakenLastSwitchOnDate: " .. tostring(timeTakenLastSwitchOnDate));
        if (timeTakenLastSwitchOnDate >= 20) then
            fibaro:call(164, "turnOff");
        end
    end, 20000)
end
