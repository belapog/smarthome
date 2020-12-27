local ID = fibaro:getSelfId()
local minTemp = fibaro:getGlobal("StatMinTempDate") .. " " .. fibaro:getGlobal("StatDailyMinTemp") .. "°";
local maxTemp = fibaro:getGlobal("StatMaxTempDate") .. " " .. fibaro:getGlobal("StatDailyMaxTemp") .. "°";
local minHum = fibaro:getGlobal("StatMinHumDate") .. " " .. fibaro:getGlobal("StatDailyMinHum") .. "%";
local maxHum = fibaro:getGlobal("StatMaxHumDate") .. " " .. fibaro:getGlobal("StatDailyMaxHum") .. "%";
local minTemp2 = fibaro:getGlobal("StatMinTempDate2") .. " " .. fibaro:getGlobal("StatDailyMinTemp2") .. "°";
local maxTemp2 = fibaro:getGlobal("StatMaxTempDate2") .. " " .. fibaro:getGlobal("StatDailyMaxTemp2") .. "°";
local avgTemp2 = fibaro:getGlobal("StatAvgTemp2");
local airPressureAvg = fibaro:getGlobal("AirPressureAvg") .. " " .. fibaro:getGlobal("AirPressureChange") .. "%";
local Temp2 = fibaro:getValue(155, "value") .. "°";

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

fibaro:call(ID, "setProperty", "ui.lblStatTemp.value", minTemp .. " - " .. maxTemp);

fibaro:call(ID, "setProperty", "ui.lblStatTemp2.value", minTemp2  .. " - " .. maxTemp2);
fibaro:call(ID, "setProperty", "ui.lblStatAvg2.value", avgTemp2);


fibaro:call(ID, "setProperty", "ui.lblStatMinHum.value", minHum);
fibaro:call(ID, "setProperty", "ui.lblStatMaxHum.value", maxHum);
fibaro:call(ID, "setProperty", "ui.lblAirPressure.value", airPressureAvg);

fibaro:call(ID, "setProperty", "ui.lblTemp.value", Temp2);
fibaro:call(ID, "setProperty", "ui.lblWind.value", api.get('/weather')['Wind']);
fibaro:call(ID, "setProperty", "ui.lblHum.value", api.get('/weather')['Humidity']);
fibaro:call(ID, "setProperty", "ui.lblCondition.value", api.get('/weather')['WeatherCondition']);