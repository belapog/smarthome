--[[
%% autostart
%% properties
%% weather
%% events
%% globals
--]]

function debug(message, level)
    if level == nil then
        level = 1;
    end
    local debugLevel = 1;
    if (level >= debugLevel) then
        fibaro:debug (message);
    end
end

debug("HomersegletAuto strated");

function TempHomersegletAuto()
    local celHomerseglet = tonumber(fibaro:getGlobalValue("CelHomerseglet"));
    --local temperatureOutside = tonumber(api.get('/weather')['Temperature']);
    local temperatureOutside = tonumber(fibaro:getValue(155, "value"));
    local napszak = fibaro:getGlobalValue("Napszak");
    local alvas = (fibaro:getGlobalValue("Alvas")  == "Alvás");
    local otthonVannak = fibaro:getGlobalValue("OtthonVannak");
    local weAreAtHome = ((otthonVannak== "Igen") or (otthonVannak == "Talán"));
    local aktualisCelhomerseglet = tonumber(fibaro:getValue(61, "targetLevel"));
    local currentDate = os.date("*t");
    local weekend = false;

    local ejszakaiHomerseglet = 20.0;
    local ujHomerseglet = 23.5;
    local hatar = 1.4;

    if (currentDate.wday == 1 or currentDate.wday == 7) then
	    weekend = true;
    end


    debug("celHomerseglet: " .. tostring(celHomerseglet));
    debug("temperatureOutside: " .. tostring(temperatureOutside));
    debug("napszak: " .. tostring(napszak));
    debug("aktualisCelhomerseglet: " .. tostring(aktualisCelhomerseglet));
    debug("weekend: " .. tostring(weekend));
    debug("weAreAtHome: " .. tostring(weAreAtHome));

    ujHomerseglet = celHomerseglet;

    if alvas then
        ujHomerseglet = ejszakaiHomerseglet;
    end

    if not weAreAtHome then
        ujHomerseglet = ejszakaiHomerseglet;
    end

    if (celHomerseglet < temperatureOutside / hatar) then
        --felszabályozás ha túl meleg van
        ujHomerseglet = (temperatureOutside / hatar);
        if (ujHomerseglet < aktualisCelhomerseglet) then
            fibaro:call(184, "sendDefinedPushNotification", "15");
        end
        debug("Túl meleg van kinn");
    end

    debug("ujHomerseglet: " .. tostring(ujHomerseglet));

    fibaro:call(66, "setThermostatSetpoint", "1", ujHomerseglet);
    fibaro:call(61, "setThermostatSetpoint", "1", ujHomerseglet);
    fibaro:call(89, "setThermostatSetpoint", "1", ujHomerseglet);

    setTimeout(TempHomersegletAuto, 10*60*1000)
end

TempHomersegletAuto();