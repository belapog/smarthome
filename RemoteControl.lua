--[[
%% properties
%% weather
%% events
28 CentralSceneEvent 1 Pressed
28 CentralSceneEvent 2 Pressed
%% globals
--]]

local startSource = fibaro:getSourceTrigger();
local key = fibaro:get(28, "value");


if (startSource["type"] == "event" and startSource["event"]["type"] == "CentralSceneEvent" and key == 1 ) then
    	fibaro:startScene(32);
end


if(startSource["type"] == "other") then
	fibaro:startScene(32);
	fibaro:startScene(31);
else
if (( (startSource["type"] == "event" and startSource["event"]["type"] == "CentralSceneEvent") ) or ( (startSource["type"] == "event" and startSource["event"]["type"] == "CentralSceneEvent") )) then
setTimeout(function()

local delayedCheck0 = false;
local tempDeviceState0, deviceLastModification0 = fibaro:get(28, "value");
if (( (startSource["type"] == "event" and startSource["event"]["type"] == "CentralSceneEvent") ) and (os.time() - deviceLastModification0) >= 1) then
	delayedCheck0 = true;
end
setTimeout(function()
local delayedCheck1 = false;
local tempDeviceState1, deviceLastModification1 = fibaro:get(28, "value");
if (( (startSource["type"] == "event" and startSource["event"]["type"] == "CentralSceneEvent") ) and (os.time() - deviceLastModification1) >= 2) then
	delayedCheck1 = true;
end

local startSource = fibaro:getSourceTrigger();
if (
 ( delayedCheck0 == true  or  delayedCheck1 == true )
or
startSource["type"] == "other"
)
then
	fibaro:startScene(32);
	fibaro:startScene(31);
end
end, 2000)
end, 1000)
end
end


