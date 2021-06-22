--[[
%% properties
%% weather
%% events
%% globals
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

local napellenzokNemLent = (tonumber(fibaro:getValue(13, "value")) > 0  or  
    tonumber(fibaro:getValue(10, "value")) > 0  or  
    tonumber(fibaro:getValue(16, "value")) > 0  or  
    tonumber(fibaro:getValue(19, "value")) > 0
    )
log ("napellenzokNemLent: " .. tostring(napellenzokNemLent));
log ("1: " .. tostring(tonumber(fibaro:getValue(13, "value"))));
log ("2: " .. tostring(tonumber(fibaro:getValue(10, "value"))));
log ("3: " .. tostring(tonumber(fibaro:getValue(16, "value"))));
log ("4: " .. tostring(tonumber(fibaro:getValue(19, "value"))));

if (napellenzokNemLent and weatherGoodCondition)
then
    fibaro:call(13, "close");
    fibaro:call(10, "close");
    fibaro:call(16, "close");
    fibaro:call(19, "close");
    log ('Napellenző leeresztés');
else
    infolog ('Napellenzők nem erszthetők le mert már lent vannak vagy időjárási okok miatt');
end