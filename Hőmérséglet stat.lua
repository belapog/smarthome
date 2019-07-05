--[[
%% properties
67 value
%% weather
%% events
%% globals
--]]

local actualTemp = tonumber(fibaro:getValue(67, "value"));
local minTemp = fibaro:getGlobal("StatDailyMinTemp");
local maxTemp = fibaro:getGlobal("StatDailyMaxTemp");
local minTempNum = tonumber(minTemp);
local maxTempNum = tonumber(maxTemp);
local currentDate = os.date("*t");
local currenthour = string.format("%02d", currentDate.hour) .. ":" .. string.format("%02d", currentDate.min);

--fibaro:debug ("currenthour: " .. currenthour);
--fibaro:debug ("actualTemp: " .. actualTemp);
--fibaro:debug ("minTemp: " .. minTempNum);
--fibaro:debug ("maxTemp: " .. maxTempNum);

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




