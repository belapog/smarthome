--[[
%% autostart
%% properties
%% weather
%% events
%% globals
--]]

--=================================================
-- Common functions
--=================================================
local debug = true
local function log(str) if debug then fibaro:debug(str); end; end
local function errorlog(str) fibaro:debug("<font color='red'>"..str.."</font>"); end
local function infolog(str) fibaro:debug("<font color='yellow'>"..str.."</font>"); end


--=================================================
-- Main
--=================================================

log("HomersegletAuto strated");

------------------------------------------------------------------------
--
-- Dew point calculation using Magnus formula: http://en.wikipedia.org/wiki/Dew_point
-- 
-- http://forum.micasaverde.com/index.php?topic=37464.0
--
function DewPoint (T, RH)
    -- a,b,c taken from a 1980 paper by David Bolton in the Monthly Weather Review
    --  local a = 6.112     -- a is not used in this approximation
    local b,c = 17.67, 243.5;
    RH = math.max (RH or 0, 1e-3);
    local gamma = math.log (RH/100) + b * T / (c + T);
    return c * gamma / (b - gamma);
end

function TempHomersegletAuto()
    local celHomerseglet = tonumber(fibaro:getGlobalValue("CelHomerseglet"));
    local heating = fibaro:getGlobalValue("Futes");
    local temperatureOutside = tonumber(fibaro:getValue(155, "value"));
    local napszak = fibaro:getGlobalValue("Napszak");
    local alvas = (fibaro:getGlobalValue("Alvas")  == "Alvás");
    local otthonVannak = fibaro:getGlobalValue("OtthonVannak");
    local weAreAtHome = ((otthonVannak== "Igen") or (otthonVannak == "Talán"));
    local aktualisCelhomerseglet = tonumber(fibaro:getValue(66, "targetLevel"));
    local currentDate = os.date("*t");
    local weekend = false;
    local dewPoint = DewPoint (tonumber(fibaro:getValue(67, "value")), tonumber(fibaro:getValue(140, "value")));

    local ejszakaiHomerseglet = 20.0;
    local ujHomerseglet = 23.5;
    local hatar = 1.4;

    if (currentDate.wday == 1 or currentDate.wday == 7) then
	    weekend = true;
    end


    log("celHomerseglet: " .. tostring(celHomerseglet));
    log("temperatureOutside: " .. tostring(temperatureOutside));
    log("napszak: " .. tostring(napszak));
    log("aktualisCelhomerseglet: " .. tostring(aktualisCelhomerseglet));
    log("weekend: " .. tostring(weekend));
    log("weAreAtHome: " .. tostring(weAreAtHome));
    log("heating: " .. tostring(heating));
    log("dewPoint: " .. tostring(dewPoint));
    
    ujHomerseglet = celHomerseglet;

    if alvas and heating == "Fűtés" then
        ujHomerseglet = ejszakaiHomerseglet;
        infolog("Éjszakai hőmérséglet fűtésnél");
    end

    if not weAreAtHome and heating == "Fűtés" then
        ujHomerseglet = ejszakaiHomerseglet;
        infolog("Nem vagyunk otthon, takarékosság fűtésnél");
    end

    if (celHomerseglet < temperatureOutside / hatar) then
        --felszabályozás ha túl meleg van
        ujHomerseglet = (temperatureOutside / hatar);
        if (ujHomerseglet < aktualisCelhomerseglet) then
            fibaro:call(184, "sendDefinedPushNotification", "15");
        end
        infolog("Túl meleg van kinn");
    end

    log("ujHomerseglet: " .. tostring(ujHomerseglet));

    fibaro:call(66, "setThermostatSetpoint", "1", ujHomerseglet);
    fibaro:call(61, "setThermostatSetpoint", "1", ujHomerseglet);
    fibaro:call(89, "setThermostatSetpoint", "1", ujHomerseglet);

    setTimeout(TempHomersegletAuto, 10*60*1000)
end

TempHomersegletAuto();