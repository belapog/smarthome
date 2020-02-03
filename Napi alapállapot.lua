--[[
%% autostart
--]]

function tempDailyCleanUpFunc()
    local currentDate = os.date("*t");
            
    if (string.format("%02d", currentDate.hour) .. ":" .. string.format("%02d", currentDate.min) == "00:00")
    then

      local minTem = fibaro:getGlobal("StatDailyMaxTemp2");
      local maxTemp = fibaro:getGlobal("StatDailyMinTemp2");
      local avgTemp = (maxTemp + minTem)/2;
      fibaro:setGlobal("StatAvgTemp2", avgTemp);
        
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
    
    setTimeout(tempDailyCleanUpFunc, 60*1000)
end

tempDailyCleanUpFunc();