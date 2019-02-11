--[[
%% properties
57 value
31 value
98 value
22 value
76 value
96 value
108 value
105 value
57 armed
31 armed
98 armed
22 armed
76 armed
96 armed
108 armed
105 armed
%% weather
%% events
%% globals
--]]

local trigger = fibaro:getSourceTrigger();
local triggerDevice;
if (trigger['type'] == 'property') then
    triggerDevice = trigger['deviceID'];
else
    triggerDevice = "other";
end


if (
    (tonumber(fibaro:getValue(57, "value")) > 0 and tonumber(fibaro:getValue(57, "armed")) > 0) or 
    (tonumber(fibaro:getValue(31, "value")) > 0 and tonumber(fibaro:getValue(31, "armed")) > 0) or
    (tonumber(fibaro:getValue(98, "value")) > 0 and tonumber(fibaro:getValue(98, "armed")) > 0) or
    (tonumber(fibaro:getValue(22, "value")) > 0 and tonumber(fibaro:getValue(22, "armed")) > 0) or
    (tonumber(fibaro:getValue(76, "value")) > 0 and tonumber(fibaro:getValue(76, "armed")) > 0) or
    (tonumber(fibaro:getValue(96, "value")) > 0 and tonumber(fibaro:getValue(96, "armed")) > 0) or
    (tonumber(fibaro:getValue(108, "value")) > 0 and tonumber(fibaro:getValue(108, "armed")) > 0) or 
    (tonumber(fibaro:getValue(105, "value")) > 0 and tonumber(fibaro:getValue(105, "armed")) > 0)
)
then
	fibaro:call(4, "sendDefinedPushNotification", "5");
end


