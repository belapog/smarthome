--[[
%% properties
140 value
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

debug("Páratartalom figyelés strated");

local paratartalom = tonumber(fibaro:getValue(140, "value"));
debug ("páratartalom: " .. tostring(paratartalom));

if ((paratartalom > 60 ))
then
		debug("Nagy a páratartalom!", 2);
		fibaro:call(4, "sendDefinedPushNotification", "10");
end

if (( paratartalom < 40 ))
then
		debug("Alacsony a páratartalom!", 2);
		fibaro:call(4, "sendDefinedPushNotification", "11");
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
  fibaro:debug ("MaxHum set: " .. tostring(paratartalom));
end

if ((paratartalom < minHumNum) or (minHumNum == 0)) then
  fibaro:setGlobal("StatDailyMinHum", paratartalom);
  fibaro:setGlobal("StatMinHumDate", currenthour);
  fibaro:debug ("MinHum set: " .. tostring(paratartalom));
end
