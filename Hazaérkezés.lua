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
fibaro:call(30, "setArmed", "0");
fibaro:call(31, "setArmed", "0");
fibaro:call(57, "setArmed", "0");
fibaro:call(76, "setArmed", "0");
fibaro:call(95, "setArmed", "0");
fibaro:call(96, "setArmed", "0");
fibaro:call(98, "setArmed", "0");
fibaro:call(104, "setArmed", "0");
fibaro:call(105, "setArmed", "0");
fibaro:call(107, "setArmed", "0");
fibaro:call(108, "setArmed", "0");
fibaro:call(142, "setArmed", "0");
fibaro:call(148, "setArmed", "0");

fibaro:setGlobal("Riaszto", "Ki");
debug ('Riaszto kikapcsolva', 2)
