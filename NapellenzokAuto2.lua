--[[
%% properties
67 value
66 value
24 value
%% weather
Temperature
Wind
WeatherCondition
%% events
%% globals
Napszak
Alvas
Futes
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

local targetRollerShutterPosition = "";

--AtHome detection
local weAreAtHome = (fibaro:getGlobalValue("OtthonVannak") == "Igen");
debug ("weAreAtHome: " .. tostring(weAreAtHome));

--Weather
local weatherCloudy = api.get('/weather')['WeatherCondition']:lower() == "cloudy";
local weatherMostlyCloudy = api.get('/weather')['WeatherCondition']:lower() == "mostly cloudy"
    or api.get('/weather')['WeatherCondition']:lower() == "partly cloudy";
local weatherClear = api.get('/weather')['WeatherCondition']:lower() == "clear" 
    or api.get('/weather')['WeatherCondition']:lower() == "sunny";
local weatherWindy = tonumber(api.get('/weather')['Wind']) >= tonumber(22);

debug ("WeatherCondition: " .. api.get('/weather')['WeatherCondition']:lower());
debug ("Wind: " .. api.get('/weather')['Wind']);
debug ("weatherGoodCondition: " .. tostring(weatherGoodCondition));
debug ("weatherCloudy: " .. tostring(weatherCloudy));
debug ("weatherMostlyCloudy: " .. tostring(weatherMostlyCloudy));
debug ("weatherClear: " .. tostring(weatherClear));
debug ("weatherWindy: " .. tostring(weatherWindy));

local weatherGoodCondition = False;
if weAreAtHome then
    weatherGoodCondition = (not weatherWindy);
else
    weatherGoodCondition = (not weatherWindy and not weatherCloudy and (weatherClear or weatherMostlyCloudy));
end
    

--Climate
local isCooling = (fibaro:getGlobalValue("Futes") == "Hűtés");
local isHeating = (fibaro:getGlobalValue("Futes") == "Fűtés");
local temperatureInside = tonumber(fibaro:getValue(67, "value"));
local temperatureTarget = tonumber(fibaro:getValue(66, "value"));
local needHeating = (isHeating and (temperatureTarget < temperatureInside));
local needCooling = (isCooling and (temperatureTarget > temperatureInside));
debug ("isCooling: " .. tostring(isCooling));
debug ("isHeating: " .. tostring(isHeating));
debug ("temperatureInside: " .. tostring(temperatureInside));
debug ("temperatureTarget: " .. tostring(temperatureTarget));
debug ("needHeating: " .. tostring(needHeating));
debug ("needCooling: " .. tostring(needCooling));

--roller shutter position
local rollerShutterPositionDown = (tonumber(fibaro:getValue(13, "value")) == 0  or  
    tonumber(fibaro:getValue(10, "value")) == 0  or  
    tonumber(fibaro:getValue(16, "value")) == 0  or  
    tonumber(fibaro:getValue(19, "value")) == 0
    )
local rollerShutterPositionManualDown = (fibaro:getGlobalValue("NapellenzoMozgatas") == "Kézi le");
local rollerShutterPositionManualUp = (fibaro:getGlobalValue("NapellenzoMozgatas") == "Kézi fel");
debug ("rollerShutterPositionDown: " .. tostring(rollerShutterPositionDown));
debug ("rollerShutterPositionManualUp: " .. tostring(rollerShutterPositionManualUp));
debug ("rollerShutterPositionManualDown: " .. tostring(rollerShutterPositionManualDown));

local dayLight = fibaro:getGlobalValue("Napszak");
local sleepMode = fibaro:getGlobalValue("Alvas");
local needEveningShade = ((dayLight == "Este") and (sleepMode == "Ébrenlét") and weAreAtHome);
local needLateNightMode = ((dayLight == "Este") and (sleepMode == "Alvás"));
debug ("dayLight: " .. tostring(dayLight));
debug ("sleepMode: " .. tostring(sleepMode));
debug ("needEveningShade: " .. tostring(needEveningShade));
debug ("needLateNightMode: " .. tostring(needLateNightMode));

--sun
local light = tonumber(fibaro:getValue(24, "value"));
local sunnyDay = weatherClear and 
    (((rollerShutterPositionDown == true) and (light > 200 )) or
    ((rollerShutterPositionDown == false) and (light > 1000 )));
debug ("sunnyDay: " .. tostring(sunnyDay));
debug ("light: " .. tostring(light));

if (not weatherGoodCondition) then
    targetRollerShutterPosition = "Up";
    debug ("Target position Up - Bad weater condition");
else
    --Night options
    if ((dayLight == "Este")) then
        if (needLateNightMode) then
            targetRollerShutterPosition = "Up";
            debug ("Target position Up - Late night mode");
        end
        if (needEveningShade and (not rollerShutterPositionManualUp)) then
            targetRollerShutterPosition = "Down";
            debug ("Target position Down - Evening Shade");
        end
    end
    
    --Daylight options
    if ((dayLight == "Nappal")) then
        if (isHeating and not weAreAtHome and (not rollerShutterPositionManualDown)) then
            targetRollerShutterPosition = "Up";
            debug ("Target position Up - Heating and we are not at home");
        end
        if (isCooling and (temperatureInside > temperatureTarget) and sunnyDay and (not rollerShutterPositionManualUp)) then
            targetRollerShutterPosition = "Down";
            debug ("Target position Down - Temperature is to hot, support cooling");
        end
        if (weAreAtHome and sunnyDay and (not rollerShutterPositionManualUp)) then
            targetRollerShutterPosition = "Down";
            debug ("Target position Down - Sunny day and we are at home");
        end
        if (targetRollerShutterPosition == "" and rollerShutterPositionManualDown and weAreAtHome) then
            targetRollerShutterPosition = "Down"
            debug ("Target position down - Roller Shutter Position Manual Down");
        end
        if (targetRollerShutterPosition == "" and rollerShutterPositionManualUp) then
            targetRollerShutterPosition = "Up"
            debug ("Target position down - Roller Shutter Position Manual Up");
        end       
    end
    
end

if (targetRollerShutterPosition == "Down") then
    fibaro:startScene(51);
    debug ('Auto down');
    if (not rollerShutterPositionManualDown) then
        fibaro:setGlobal("NapellenzoMozgatas", "Auto le");
    end
else
    fibaro:startScene(52);
    debug ('Auto Up!');
    if (not rollerShutterPositionManualUp) then
        fibaro:setGlobal("NapellenzoMozgatas", "Auto fel");
    end
end