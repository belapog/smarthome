--[[
%% properties
124 secured
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

debug ('Hazaérkezés elindítva')

local secured = (tonumber(fibaro:getValue(124, "secured")) == 0 )
debug ("secured: " .. tostring(secured));

if secured then
    fibaro:call(124, "unsecure");
end

fibaro:call(22, "setArmed", "0");
fibaro:call(177, "setArmed", "0");
fibaro:call(178, "setArmed", "0");
fibaro:call(180, "setArmed", "0");
fibaro:call(57, "setArmed", "0");
fibaro:call(98, "setArmed", "0");
fibaro:call(142, "setArmed", "0");
fibaro:call(176, "setArmed", "0");
fibaro:call(148, "setArmed", "0");
fibaro:call(175, "setArmed", "0");
fibaro:call(76, "setArmed", "0");

debug ('Riaszto kikapcsolva', 2)
