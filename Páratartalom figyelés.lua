--[[
%% properties
140 value
%% weather
%% events
%% globals
--]]

--=================================================
-- Common functions
--=================================================
local debug = false
local function log(str) if debug then fibaro:debug(str); end; end
local function errorlog(str) fibaro:debug("<font color='red'>"..str.."</font>"); end
local function infolog(str) fibaro:debug("<font color='yellow'>"..str.."</font>"); end

--=================================================
-- Main
--=================================================
log("Páratartalom figyelés strated");

local paratartalom = tonumber(fibaro:getValue(140, "value"));
log ("páratartalom: " .. tostring(paratartalom));
local mobileDeviceId = fibaro:getGlobalValue("MobileDeviceId");

--Páratartalom figyelmeztetések
if ((paratartalom > 70 ))
then
  infolog("Nagy a páratartalom!");
	fibaro:call(mobileDeviceId, "sendDefinedPushNotification", "10");
end

if (( paratartalom < 30 ))
then
  infolog("Alacsony a páratartalom!");
	fibaro:call(mobileDeviceId, "sendDefinedPushNotification", "11");
end

--Napi statisztika
local minHum = fibaro:getGlobal("StatDailyMinHum");
local maxHum = fibaro:getGlobal("StatDailyMaxHum");
local minHumNum = tonumber(minHum);
local maxHumNum = tonumber(maxHum);
local currentDate = os.date("*t");
local currenthour = string.format("%02d", currentDate.hour) .. ":" .. string.format("%02d", currentDate.min);

if ((paratartalom > maxHumNum) or (maxHumNum == 0)) then
  fibaro:setGlobal("StatDailyMaxHum", paratartalom);
  fibaro:setGlobal("StatMaxHumDate", currenthour);
  log ("MaxHum set: " .. tostring(paratartalom));
end

if ((paratartalom < minHumNum) or (minHumNum == 0)) then
  fibaro:setGlobal("StatDailyMinHum", paratartalom);
  fibaro:setGlobal("StatMinHumDate", currenthour);
  log ("MinHum set: " .. tostring(paratartalom));
end
