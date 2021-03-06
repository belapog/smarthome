--[[
%% autostart
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

function SunSetSunRiseFunc()
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

    debug("sunrise: " .. sunrise);
    debug("sunset: " .. sunset);
    debug("current: " .. current);

    local actualSet = fibaro:getGlobalValue("Napszak");
    debug("actualSet: " .. actualSet);

    if ((current >= sunrise) and (current <= sunset)) then
        fibaro:setGlobal("Napszak", "Nappal");
        if (actualSet == "Este") then
            fibaro:setGlobal("NapellenzoMozgatas", "Auto fel");
        end
    else
        fibaro:setGlobal("Napszak", "Este");
        if (actualSet == "Nappal") then
            fibaro:setGlobal("NapellenzoMozgatas", "Auto fel");
        end
    end

    setTimeout(SunSetSunRiseFunc, 60*1000);
end

SunSetSunRiseFunc();