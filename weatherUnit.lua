local ID = fibaro:getSelfId()
local minTemp = fibaro:getGlobal("StatMinTempDate") .. " - " .. fibaro:getGlobal("StatDailyMinTemp") .. "°";
local maxTemp = fibaro:getGlobal("StatMaxTempDate") .. " - " .. fibaro:getGlobal("StatDailyMaxTemp") .. "°";

function Round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

fibaro:call(ID, "setProperty", "ui.lblStatMin.value", minTemp);
fibaro:call(ID, "setProperty", "ui.lblStatMax.value", maxTemp);
fibaro:call(ID, "setProperty", "ui.lblTemp.value", Round(api.get('/weather')['Temperature'], 2) .. "°");
fibaro:call(ID, "setProperty", "ui.lblWind.value", api.get('/weather')['Wind']);
fibaro:call(ID, "setProperty", "ui.lblHum.value", api.get('/weather')['Humidity']);
fibaro:call(ID, "setProperty", "ui.lblCondition.value", api.get('/weather')['WeatherCondition']);