--[[
%% autostart
--]]

function DailyCleanUpFunc()
    local currentDate = os.date("*t");
            
    if (string.format("%02d", currentDate.hour) .. ":" .. string.format("%02d", currentDate.min) == "00:00")
    then

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
      fibaro:setGlobal("NapellenzoMozgatas", "Auto fel");
			fibaro:setGlobal("StatDailyMaxHum", "0");
			fibaro:setGlobal("StatDailyMinHum", "0");
			fibaro:setGlobal("StatMaxHumDate", "");
			fibaro:setGlobal("StatMinHumDate", "");
      
    end
    
    setTimeout(DailyCleanUpFunc, 60*1000)
end

DailyCleanUpFunc();