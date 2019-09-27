--[[
%% properties
67 value
155 value
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

debug ("Hőmérséglet stat elindítva");


local actualTemp = tonumber(fibaro:getValue(67, "value"));
local actualTemp2 = tonumber(fibaro:getValue(155, "value"));

local minTemp = fibaro:getGlobal("StatDailyMinTemp");
local maxTemp = fibaro:getGlobal("StatDailyMaxTemp");
local minTempNum = tonumber(minTemp);
local maxTempNum = tonumber(maxTemp);

local minTemp2 = fibaro:getGlobal("StatDailyMinTemp2");
local maxTemp2 = fibaro:getGlobal("StatDailyMaxTemp2");
local minTempNum2 = tonumber(minTemp2);
local maxTempNum2 = tonumber(maxTemp2);

local currentDate = os.date("*t");
local currenthour = string.format("%02d", currentDate.hour) .. ":" .. string.format("%02d", currentDate.min);

debug ("currenthour: " .. currenthour);
debug ("actualTemp: " .. actualTemp);
debug ("minTemp: " .. minTempNum);
debug ("maxTemp: " .. maxTempNum);
debug ("actualTemp2: " .. actualTemp2);
debug ("minTemp2: " .. minTempNum2);
debug ("maxTemp2: " .. maxTempNum2);

if ((actualTemp > maxTempNum) or (maxTempNum == 0)) then
  fibaro:setGlobal("StatDailyMaxTemp", actualTemp);
  fibaro:setGlobal("StatMaxTempDate", currenthour);
  fibaro:debug ("MaxTemp set: " .. actualTemp);
end

if ((actualTemp < minTempNum) or (minTempNum == 0)) then
  fibaro:setGlobal("StatDailyMinTemp", actualTemp);
  fibaro:setGlobal("StatMinTempDate", currenthour);
  fibaro:debug ("MinTemp set: " .. actualTemp);
end

if ((actualTemp2 > maxTempNum2) or (maxTempNum2 == -100)) then
  fibaro:setGlobal("StatDailyMaxTemp2", actualTemp2);
  fibaro:setGlobal("StatMaxTempDate2", currenthour);
  debug ("MaxTemp2 set: " .. actualTemp2);
end

if ((actualTemp2 < minTempNum2) or (minTempNum2 == -100)) then
  fibaro:setGlobal("StatDailyMinTemp2", actualTemp2);
  fibaro:setGlobal("StatMinTempDate2", currenthour);
  fibaro:debug ("MinTemp2 set: " .. actualTemp2);
end