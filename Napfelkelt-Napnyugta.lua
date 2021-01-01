--[[
%% autostart
--]]
--=================================================
-- Common functions
--=================================================
local debug = false
local function log(str) if debug then fibaro:debug(str); end; end
local function errorlog(str) fibaro:debug("<font color='red'>"..str.."</font>"); end

--=================================================
-- Main
--=================================================
log("Napfelkelte-napnyugtat elindítva");
function SunSetSunRiseFunc()
    log("Napfelkelte-napnyugtat időzített eljárás elindítva");
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

    log("sunrise: " .. sunrise);
    log("sunset: " .. sunset);
    log("current: " .. current);

    local actualSet = fibaro:getGlobalValue("Napszak");
    log("actualSet: " .. actualSet);

    if ((current >= sunrise) and (current <= sunset)) then
        log ("Napszak = Nappal");
        fibaro:setGlobal("Napszak", "Nappal");
        if (actualSet == "Este") then
            log ("NapellenzoMozgatas = Auto fel");
            fibaro:setGlobal("NapellenzoMozgatas", "Auto fel");
        end
    else
        log ("Napszak = Este");
        fibaro:setGlobal("Napszak", "Este");
        if (actualSet == "Nappal") then
            log ("NapellenzoMozgatas = Auto fel");
            fibaro:setGlobal("NapellenzoMozgatas", "Auto fel");
        end
    end

    setTimeout(SunSetSunRiseFunc, 60*1000);
end

SunSetSunRiseFunc();