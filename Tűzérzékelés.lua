--[[
%% properties
181 value
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

debug ('Tűz van!')

local startSource = fibaro:getSourceTrigger();
if (
 ( tonumber(fibaro:getValue(181, "value")) > 0 )
or
startSource["type"] == "other"
)
then
	fibaro:call(4, "sendDefinedPushNotification", "13");
end


