--[[
%% properties
188 value
%% weather
%% events
%% globals
--]]

function debug(message, level)
    if level == nil then
        level = 1;
    end
    local debugLevel = 1;
    if (level >= debugLevel) then
        fibaro:debug (message);
    end
end

debug("WC Ajtó");

if (
 ( tonumber(fibaro:getValue(188, "value")) > 0 )
and
 ( tonumber(fibaro:getValue(164, "value")) > 0 )
)
then
    debug("WC lámpa kikapcs");
	fibaro:call(164, "turnOff");
end