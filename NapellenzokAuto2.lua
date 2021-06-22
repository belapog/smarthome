--[[
%% properties
67 value
66 value
24 value
158 value
%% weather
Temperature
Wind
WeatherCondition
%% events
%% globals
Napszak
Alvas
Futes
TooWindyTime
OtthonVannak
--]]

--=================================================
-- Common functions
--=================================================
local debug = true
local function log(str) if debug then fibaro:debug(str); end; end
local function errorlog(str) fibaro:debug("<font color='red'>"..str.."</font>"); end
local function infolog(str) fibaro:debug("<font color='yellow'>"..str.."</font>"); end

--=================================================
-- Main
--=================================================
local targetRollerShutterPosition = "";

--AtHome detection
local weAreAtHome = ((fibaro:getGlobalValue("OtthonVannak") == "Igen") or (fibaro:getGlobalValue("OtthonVannak") == "Talán"));
log ("weAreAtHome: " .. tostring(weAreAtHome));

--Weather
local minHighWind = tonumber(fibaro:getGlobalValue("MinHighWind"));
local wind = tonumber(fibaro:getValue(158, "value"));
local tooWindy = fibaro:getGlobalValue("TooWindyTime");
local timeTakenLastTooWindy = tonumber(os.difftime(os.time(), tooWindy));

-- szeles az idő ha az elmúlt negyed órában volt nagy széllőkés
local weatherWindy = ((timeTakenLastTooWindy <= (60 * 15)) or (wind >= minHighWind));
local weatherCondition = api.get('/weather')['WeatherCondition']:lower();
local weatherCloudy = (weatherCondition == "cloudy");
local weatherRain = (weatherCondition == "rain");

log ("Wind: " .. tostring(wind));
log ("timeTakenLastTooWindy: " .. tostring(timeTakenLastTooWindy));
log ("WeatherCondition: " .. weatherCondition);
log ("weatherWindy: " .. tostring(weatherWindy));

local weatherGoodCondition = (not weatherWindy and not weatherRain);
log ("weatherGoodCondition: " .. tostring(weatherGoodCondition));


--Climate
local isCooling = (fibaro:getGlobalValue("Futes") == "Hűtés");
local isHeating = (fibaro:getGlobalValue("Futes") == "Fűtés");
local temperatureInside = tonumber(fibaro:getValue(67, "value"));
local temperatureTarget = tonumber(fibaro:getValue(66, "value"));
local needHeating = (isHeating and (temperatureTarget < temperatureInside));
local needCooling = (isCooling and (temperatureTarget > temperatureInside));
log ("isCooling: " .. tostring(isCooling));
log ("isHeating: " .. tostring(isHeating));
log ("temperatureInside: " .. tostring(temperatureInside));
log ("temperatureTarget: " .. tostring(temperatureTarget));
log ("needHeating: " .. tostring(needHeating));
log ("needCooling: " .. tostring(needCooling));

--roller shutter position
local rollerShutterPositionDown = (tonumber(fibaro:getValue(13, "value")) == 0  or
    tonumber(fibaro:getValue(10, "value")) == 0  or
    tonumber(fibaro:getValue(16, "value")) == 0  or
    tonumber(fibaro:getValue(19, "value")) == 0
    )
local rollerShutterPositionManualDown = (fibaro:getGlobalValue("NapellenzoStatus") == "Kézi le");
local rollerShutterPositionManualUp = (fibaro:getGlobalValue("NapellenzoStatus") == "Kézi fel");
local rollerShutterPositionTempGuard = (fibaro:getGlobalValue("NapellenzoStatus") == "Hővédelem");
--napvédő középtályon
local rollerShutterPositionHalfState = not rollerShutterPositionDown;
if not rollerShutterPositionDown then
    rollerShutterPositionHalfState = (tonumber(fibaro:getValue(13, "value")) < 99  or
    tonumber(fibaro:getValue(10, "value")) < 99  or
    tonumber(fibaro:getValue(16, "value")) < 99  or
    tonumber(fibaro:getValue(19, "value")) < 99
    )
end
log ("rollerShutterPositionDown: " .. tostring(rollerShutterPositionDown));
log ("rollerShutterPositionManualUp: " .. tostring(rollerShutterPositionManualUp));
log ("rollerShutterPositionManualDown: " .. tostring(rollerShutterPositionManualDown));
log ("rollerShutterPositionTempGuard: " .. tostring(rollerShutterPositionTempGuard));
log ("rollerShutterPositionHalfState: " .. tostring(rollerShutterPositionHalfState));

local dayLight = fibaro:getGlobalValue("Napszak");
local sleepMode = fibaro:getGlobalValue("Alvas");
local needEveningShade = ((dayLight == "Este") and (sleepMode == "Ébrenlét") and weAreAtHome);
local needLateNightMode = ((dayLight == "Este") and (sleepMode == "Alvás"));
log ("dayLight: " .. tostring(dayLight));
log ("sleepMode: " .. tostring(sleepMode));
log ("needEveningShade: " .. tostring(needEveningShade));
log ("needLateNightMode: " .. tostring(needLateNightMode));

--sun
local light = tonumber(fibaro:getValue(24, "value"));
local sunnyDay = (((rollerShutterPositionDown == true) and (light > 200 )) or
    ((rollerShutterPositionDown == false) and (light > 1000 )));
    log ("sunnyDay: " .. tostring(sunnyDay));
    log ("light: " .. tostring(light));

if (not weatherGoodCondition) then
    targetRollerShutterPosition = "Up";
    infolog ("Target position Up - Bad weater condition");
else
    --Night options
    if ((dayLight == "Este")) then
        if (needLateNightMode) then
            targetRollerShutterPosition = "Up";
            infolog ("Target position Up - Late night mode");
        end
        if (needEveningShade and (not rollerShutterPositionManualUp)) then
            targetRollerShutterPosition = "Down";
            infolog ("Target position Down - Evening Shade");
        end
    end

    --Daylight options
    if ((dayLight == "Nappal")) then
        if (isHeating and not weAreAtHome and (not rollerShutterPositionManualDown)) then
            targetRollerShutterPosition = "Up";
            infolog ("Target position Up - Heating and we are not at home");
        end
        if (isCooling and (temperatureInside > temperatureTarget) and sunnyDay and (not rollerShutterPositionManualUp)) then
            targetRollerShutterPosition = "Down";
            infolog ("Target position Down - Temperature is to hot, support cooling");
        end
        if (weAreAtHome and sunnyDay and (not rollerShutterPositionManualUp)) then
            targetRollerShutterPosition = "Down";
            infolog ("Target position Down - Sunny day and we are at home");
        end
        if (targetRollerShutterPosition == "" and rollerShutterPositionManualDown and weAreAtHome) then
            targetRollerShutterPosition = "Down"
            infolog ("Target position down - Roller Shutter Position Manual Down");
        end
        if rollerShutterPositionTempGuard then
            targetRollerShutterPosition = "Down"
            infolog ("Target position down - Roller Shutter Temp Guard");
        end
        if (targetRollerShutterPosition == "" and rollerShutterPositionManualUp) then
            targetRollerShutterPosition = "Up"
            infolog ("Target position Up - Roller Shutter Position Manual Up");
        end
    end
end

if (targetRollerShutterPosition == "Down") then
    -- csak akkor ha nincs féltávon megállítva
    if (not rollerShutterPositionManualDown) and (not rollerShutterPositionHalfState) then
        fibaro:startScene(51);
        infolog ('Le!');
    else
        infolog ('Félig van leeresztve, nem eresztjük le tovább!');
    end

    if (not rollerShutterPositionManualDown) and (not rollerShutterPositionTempGuard) then
        infolog ('Auto down!');
        fibaro:setGlobal("NapellenzoStatus", "Auto le");
    end
else
    if (not rollerShutterPositionManualUp) and (not rollerShutterPositionHalfState) then
        fibaro:startScene(52);
        infolog ('Fel!');
    else
        infolog ('Félig van leeresztve, nem huzzuk fel!');
    end

    if (not rollerShutterPositionManualUp) then
        fibaro:setGlobal("NapellenzoStatus", "Auto fel");
    end
end