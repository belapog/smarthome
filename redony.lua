--[[
%% properties
%% weather
%% events
%% globals
Napszak
--]]

local bedroomRollerShutterPositionDown = (tonumber(fibaro:getValue(115, "value")) == 0);
local smallRoomRollerShutterPositionDown = (tonumber(fibaro:getValue(121, "value")) == 0);
local night = (fibaro:getGlobalValue("Napszak") == "Este");

fibaro:debug ("bedroomRollerShutterPositionDown: " .. tostring(bedroomRollerShutterPositionDown));
fibaro:debug ("smallRoomRollerShutterPositionDown: " .. tostring(smallRoomRollerShutterPositionDown));

if (night and
    not bedroomRollerShutterPositionDown)
then
	fibaro:call(115, "close");
end

if (night and
    not smallRoomRollerShutterPositionDown)
then
	fibaro:call(121, "close");
end