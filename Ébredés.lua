--[[
%% properties
115 sceneActivation
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

debug ("Ébredés érzékelés aktiválva");

local trigger = fibaro:getSourceTrigger();
local triggerSceneActivationID;

if trigger["type"] == "other" then
    debug ("manual");
    fibaro:setGlobal("Alvas", "Ébrenlét");
else
    local triggerDeviceId = trigger['deviceID'];
    if triggerDeviceId == 115 then
        triggerSceneActivationID = tonumber(fibaro:getValue(triggerDeviceId, "sceneActivation"));
    end

    debug ("sceneActivation: " .. tostring(triggerSceneActivationID));

    if ( tonumber(triggerSceneActivationID) == 16 ) then
        --csak napkelte után, hogy éjszakai redőny felnyitás ne nyissa ki az összes redőnyt
        local sunriseTime = fibaro:getValue(1, "sunriseHour");
        local sunriseHour = tonumber(string.sub(sunriseTime,1,2));
        local sunriseMin = tonumber(string.sub(sunriseTime,4, 6));
        local sunrise = sunriseHour * 60 + sunriseMin;

        local sunsetTime = fibaro:getValue(1, "sunsetHour");
        local sunsetHour = tonumber(string.sub(sunsetTime,1,2));
        local sunsetMin = tonumber(string.sub(sunsetTime,4, 6));
        local sunset = sunsetHour * 60 + sunsetMin;

        local currentDate = os.date("*t");
        local currentHour = currentDate.hour;
        local currentMin = currentDate.min;
        local current = currentHour * 60 + currentMin;

        if ((current >= sunrise) and (current < sunset)) then
            fibaro:setGlobal("Alvas", "Ébrenlét");
            debug ("Ébrenlét");
        else
            debug ("Még nincs reggel");
        end
    end
end