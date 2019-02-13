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

function debug(message, level)
    if level == nil then
        level = 1;
    end
    local debugLevel = 2;
    if (level >= debugLevel) then
        fibaro:debug (message);
    end
end

function tempAtHomeDetection()
    fibaro:debug ("tempAtHomeDetection started");
    
    local tempAtHome = fibaro:getGlobalValue("OtthonVannak");
    if (tempAtHome == "Talán") then
        fibaro:setGlobal("OtthonVannak", "Nincsenek");
    end
end

debug ("Otthon érzékelés elindítva");

--Actual value
local actualAtHome = fibaro:getGlobalValue("OtthonVannak");
debug ("actualAtHome: " .. actualAtHome);

--Alarmed
local alarmed = (
    (tonumber(fibaro:getValue(57, "armed")) > 0) or
    (tonumber(fibaro:getValue(31, "armed")) > 0) or 
    (tonumber(fibaro:getValue(98, "armed")) > 0) or 
    (tonumber(fibaro:getValue(22, "armed")) > 0) or
    (tonumber(fibaro:getValue(76, "armed")) > 0) or
    (tonumber(fibaro:getValue(96, "armed")) > 0) or
    (tonumber(fibaro:getValue(108, "armed")) > 0)  or
    (tonumber(fibaro:getValue(105, "armed")) > 0 ));
debug ("alarmed: " .. tostring(alarmed));

--Trigger
local trigger = fibaro:getSourceTrigger();
local triggerDevice;
if (trigger['type'] == 'property') then
    local triggerDeviceId = trigger['deviceID'];
    debug ("triggerDeviceId: " .. triggerDeviceId);
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
debug ("triggerDevice: " .. triggerDevice);

local newAtHome = "";
if (triggerDevice == "Door") then
    local doorState = tonumber(fibaro:getValue(57, "value"));
    debug ("doorState: " .. tostring(doorState));
    
    if ((actualAtHome == "Igen") and (doorState == 0)) then
        if alarmed then
            newAtHome = "Nincsenek";
        else    
            newAtHome = "Talán";
            setTimeout(tempAtHomeDetection, 15*60*1000);
        end
    end
    if ((actualAtHome ~= "Igen") and (not alarmed) and (doorState > 0)) then
        newAtHome = "Igen";
    end
end

if ((triggerDevice == "Motion") and (actualAtHome == "Talán")) then
    newAtHome = "Igen";
end

debug ("newAtHome: " .. newAtHome);

if (newAtHome ~= "") then
    fibaro:setGlobal("OtthonVannak", newAtHome);
end