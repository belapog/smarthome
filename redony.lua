--[[
%% properties
%% weather
%% events
%% globals
Napszak
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

debug("Automata redőny");

local bedroomRollerShutterPositionDown = (tonumber(fibaro:getValue(115, "value")) == 0);
local smallRoomRollerShutterPositionDown = (tonumber(fibaro:getValue(121, "value")) == 0);
local livingRoomRollerShutterPositionDown = (tonumber(fibaro:getValue(129, "value")) == 0);

local night = (fibaro:getGlobalValue("Napszak") == "Este");

debug ("bedroomRollerShutterPositionDown: " .. tostring(bedroomRollerShutterPositionDown));
debug ("smallRoomRollerShutterPositionDown: " .. tostring(smallRoomRollerShutterPositionDown));
debug ("livingRoomRollerShutterPositionDown: " .. tostring(livingRoomRollerShutterPositionDown));

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

if (night and
    not livingRoomRollerShutterPositionDown)
then
	fibaro:call(129, "close");
end