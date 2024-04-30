--[[
%% autostart
--]]

-- Common functions
--=================================================
local debug = true
local function log(str) if debug then fibaro:debug(str); end; end
local function errorlog(str) fibaro:debug("<font color='red'>"..str.."</font>"); end
local function infolog(str) fibaro:debug("<font color='yellow'>"..str.."</font>"); end

--=================================================
-- Main
--=================================================

function DailyCleanUpFunc()
    local currentDate = os.date("*t");

    log ("DailyCleanUpFunc started: " .. tostring(currentDate));
            
    if (string.format("%02d", currentDate.hour) .. ":" .. string.format("%02d", currentDate.min) == "00:00")
    then

      log ("Éjfél van");

      local minTem = fibaro:getGlobal("StatDailyMaxTemp2");
      local maxTemp = fibaro:getGlobal("StatDailyMinTemp2");
      local avgTemp = (maxTemp + minTem)/2;
      fibaro:setGlobal("StatAvgTemp2", avgTemp);

      if (avgTemp > 15) then
        fibaro:setGlobal("Futes", "Hűtés")
      else
        fibaro:setGlobal("Futes", "Fűtés")
      end

      local airPressure = tonumber(fibaro:getValue(159, "value"));
      local airPressureMax = fibaro:getGlobal("AirPressureMin");
      local airPressureMin = fibaro:getGlobal("AirPressureMax");
      local airPressureAvg = (airPressureMin + airPressureMin)/2;
      local lastAirPressureAvg = fibaro:getGlobal("AirPressureAvg");
      local airPressureChange =  airPressureAvg / lastAirPressureAvg * 100;
      fibaro:setGlobal("AirPressureAvg", airPressureAvg);
      fibaro:setGlobal("AirPressureChange", airPressureChange);
      fibaro:setGlobal("AirPressureMin", airPressure);
      fibaro:setGlobal("AirPressureMax", airPressure);

			fibaro:setGlobal("StatDailyMaxTemp", "0");
			fibaro:setGlobal("StatDailyMinTemp", "0");
			fibaro:setGlobal("StatMaxTempDate", "");
			fibaro:setGlobal("StatMinTempDate", "");
      fibaro:setGlobal("StatDailyMaxTemp2", "-100");
			fibaro:setGlobal("StatDailyMinTemp2", "-100");
			fibaro:setGlobal("StatMaxTempDate2", "");
			fibaro:setGlobal("StatMinTempDate2", "");
      fibaro:setGlobal("NapellenzoStatus", "Auto fel");
			fibaro:setGlobal("StatDailyMaxHum", "0");
			fibaro:setGlobal("StatDailyMinHum", "0");
			fibaro:setGlobal("StatMaxHumDate", "");
			fibaro:setGlobal("StatMinHumDate", "");
      
    end
    
    setTimeout(DailyCleanUpFunc, 60*1000)
end

DailyCleanUpFunc();