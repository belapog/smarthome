--[[
%% autostart
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
log("Időzítések strated");

function TimerFunc()
    local currentDate = os.date("*t");
    local currentHour = currentDate.hour;
    local currentMin = currentDate.min;
    local current = currentHour * 60 + currentMin;

    log("current: " .. tostring(current));

    -----------------------------
    -- időzítetten futó eljárások
    -----------------------------

    -- Redönyök fel reggel ha nincs otthon senki
    local morningTime = 8 * 60;
    local midday = 12 * 60;
    local weAreAtHome = (fibaro:getGlobalValue("OtthonVannak") == "Igen");
    local sleepMode = fibaro:getGlobalValue("Alvas");

    log ("weAreAtHome: " .. tostring(weAreAtHome));

    if ((current == morningTime) and not weAreAtHome and (sleepMode == "Alvás")) then
        fibaro:setGlobal("Alvas", "Ébrenlét");
        infolog("Ébrenétre kapcsolás nincs itthon senki");
    end

    if ((current == midday) and weAreAtHome and (sleepMode == "Alvás")) then
        fibaro:setGlobal("Alvas", "Ébrenlét");
        infolog("Ébrenétre kapcsolás itthon van valaki");
    end


    setTimeout(TimerFunc, 60*1000);
end

TimerFunc();