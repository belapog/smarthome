--[[
%% properties
57 value
22 value
98 value
142 value
148 value
76 value
180 value
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

function GetSourceTrigger ()
    local trigger = fibaro:getSourceTrigger();
    local triggerDevice;
    if (trigger['type'] == 'property') then
        triggerDevice = trigger['deviceID'];
    else
        triggerDevice = "other";
    end
    return triggerDevice;
end

function AtHomeDetection()
    Debug ("tempAtHomeDetection started");

    local tempAtHome = fibaro:getGlobalValue("OtthonVannak");
    if (tempAtHome == "Talán") then
        fibaro:setGlobal("OtthonVannak", "Nincsenek");
    end
end

Debug ("Otthon érzékelés elindítva" .. GetSourceTrigger());

--Actual value
local actualAtHome = fibaro:getGlobalValue("OtthonVannak");
Debug ("actualAtHome: " .. actualAtHome);

--Alarmed
local alarmed = (
    (tonumber(fibaro:getValue(22, "armed")) > 0) or
    (tonumber(fibaro:getValue(177, "armed")) > 0) or
    (tonumber(fibaro:getValue(178, "armed")) > 0) or
    (tonumber(fibaro:getValue(180, "armed")) > 0) or
    (tonumber(fibaro:getValue(57, "armed")) > 0) or
    (tonumber(fibaro:getValue(98, "armed")) > 0) or
    (tonumber(fibaro:getValue(142, "armed")) > 0) or
    (tonumber(fibaro:getValue(148, "armed")) > 0) or
    (tonumber(fibaro:getValue(175, "armed")) > 0 ) or
    (tonumber(fibaro:getValue(76, "armed")) > 0 ));
Debug ("alarmed: " .. tostring(alarmed));


--Nincs-e nyitva valami
local alarmReady = (
    (tonumber(fibaro:getValue(177, "value")) == 0) and
    (tonumber(fibaro:getValue(178, "value")) == 0) and
    (tonumber(fibaro:getValue(176, "value")) == 0) and
    (tonumber(fibaro:getValue(175, "value")) == 0) );
Debug ("alarmReady: " .. tostring(alarmReady));


--Mi triggerelte az eseményt /ajtó vagy mozgás érzékelő/
local trigger = fibaro:getSourceTrigger();
local triggerDeviceType;
if (trigger['type'] == 'property') then
    local triggerDeviceId = trigger['deviceID'];
    Debug ("triggerDeviceId: " .. triggerDeviceId);
    if (triggerDeviceId == 98 or triggerDeviceId == 22 or triggerDeviceId == 76  or triggerDeviceId == 142  or triggerDeviceId == 148) then
        triggerDeviceType = "Motion";
    else
        triggerDeviceType = "Door";
    end
else
    triggerDeviceType = "other";
end
Debug ("triggerDeviceType: " .. triggerDeviceType);

local newAtHome = "";
local mobileDeviceId = fibaro:getGlobalValue("MobileDeviceId");
if (triggerDeviceType == "Door") then
    local doorState = tonumber(fibaro:getValue(57, "value"));
    Debug ("doorState: " .. tostring(doorState));

    if ((actualAtHome == "Igen") and (doorState == 0)) then
        if alarmed then
            newAtHome = "Nincsenek";
        else
            newAtHome = "Talán";
            setTimeout(AtHomeDetection, 15*60*1000);
        end
        --Ha ablak vagy ajtó nyitva akkor üzenet
        if (not alarmReady) then
            fibaro:call(184, "sendDefinedPushNotification", "7");
            Debug("Valamelyik ablak nyitva van");
        end
    end
    if ((actualAtHome ~= "Igen") and (not alarmed) and (doorState > 0)) then
        newAtHome = "Igen";
    end
end

--ez az az eset, ha kódból iondítottuk el
if (triggerDeviceType == "other" and alarmReady and actualAtHome == "Igen") then
    Debug("Direkt indítás, allarm ready");
    newAtHome = "Talán";
    setTimeout(AtHomeDetection, 15*60*1000);
end

if ((triggerDeviceType == "Motion") and (actualAtHome == "Talán")) then
    newAtHome = "Igen";
end

--ez nem egy valószínű eset, csak ha az ajtó érzékelő nem működik jól
if ((triggerDeviceType == "Motion") and (actualAtHome == "Nincsenek") and (not alarmed)) then
    newAtHome = "Igen";
end

Debug ("newAtHome: " .. newAtHome);

if (newAtHome ~= "") then
    fibaro:setGlobal("OtthonVannak", newAtHome);
end