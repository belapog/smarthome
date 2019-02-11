--[[
%% properties
57 value
98 value
22 value
76 value
%% weather
%% events
%% globals
--]]

--fibaro:debug ("AtHomeDetection started");

function tempAtHomeDetection()
    fibaro:debug ("tempAtHomeDetection started");
    
    local tempAtHome = fibaro:getGlobalValue("AtHome");
    if (tempAtHome == "Uncertain") then
        fibaro:setGlobal("AtHome", "No");
    end
end

--Actual value
local actualAtHome = fibaro:getGlobalValue("AtHome");
--fibaro:debug ("actualAtHome: " .. actualAtHome);

--Alarmed
local alarmed = false;
if (
    (tonumber(fibaro:getValue(57, "armed")) > 0) or
    (tonumber(fibaro:getValue(31, "armed")) > 0) or 
    (tonumber(fibaro:getValue(98, "armed")) > 0) or 
    (tonumber(fibaro:getValue(22, "armed")) > 0) or
    (tonumber(fibaro:getValue(76, "armed")) > 0) or
    (tonumber(fibaro:getValue(96, "armed")) > 0) or
    (tonumber(fibaro:getValue(108, "armed")) > 0)  or
    (tonumber(fibaro:getValue(105, "armed")) > 0 ))
then
    alarmed = true;
end
--fibaro:debug ("alarmed: " .. tostring(alarmed));

--Trigger
local trigger = fibaro:getSourceTrigger();
local triggerDevice;
if (trigger['type'] == 'property') then
    local triggerDeviceId = trigger['deviceID'];
    fibaro:debug ("triggerDeviceId: " .. triggerDeviceId);
    if (triggerDeviceId == 98 or triggerDeviceId == 22 or triggerDeviceId == 76) then
        if (tonumber(fibaro:getValue(triggerDeviceId, "value")) > 0) then
            triggerDevice = "Motion";
        else
            triggerDevice = "other motion";
        end
    else
        triggerDevice = "Door";
    end
else
    triggerDevice = "other";
end
fibaro:debug ("triggerDevice: " .. triggerDevice);

local newAtHome ="";
if (triggerDevice == "Door") then
    local doorState = tonumber(fibaro:getValue(57, "value"));
    --fibaro:debug ("doorState: " .. tostring(doorState));
    
    if ((actualAtHome == "Yes") and (doorState == 0)) then
        if alarmed then
            newAtHome = "No";
        else    
            newAtHome = "Uncertain";
            setTimeout(tempAtHomeDetection, 15*60*1000);
        end
    end
    if ((actualAtHome ~= "Yes") and (not alarmed) and (doorState > 0)) then
        newAtHome = "Yes";
    end
end


if ((triggerDevice == "Motion") and (actualAtHome == "Uncertain")) then
    newAtHome = "Yes";
end

fibaro:debug ("newAtHome: " .. newAtHome);

if (newAtHome ~= "") then
    fibaro:setGlobal("AtHome", newAtHome);
end