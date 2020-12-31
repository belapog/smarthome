--[[
%% properties
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

Debug ("Sziréna leállítva: ");

fibaro:call(183, "turnOff");
