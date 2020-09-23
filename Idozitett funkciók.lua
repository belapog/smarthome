--[[
%% autostart
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

function TimerFunc()
    local currentDate = os.date("*t");
    local currentHour = currentDate.hour;
    local currentMin = currentDate.min;
    local current = currentHour * 60 + currentMin;

    debug("current: " .. current);


    -----------------------------
    -- időzítetten futó eljárások
    -----------------------------

    -- Redönyök fel reggel ha nincs otthon senki
    local morningTime = 8 * 60;
    local weAreAtHome = ((fibaro:getGlobalValue("OtthonVannak") == "Igen") or (fibaro:getGlobalValue("OtthonVannak") == "Talán"));
    local sleepMode = fibaro:getGlobalValue("Alvas");

    debug ("weAreAtHome: " .. tostring(weAreAtHome));
    if ((current == morningTime) and not weAreAtHome and sleepMode == "Alvás") then
        fibaro:gsetGlobalValue("Alvas", "Ébrenlét");
    end
    setTimeout(TimerFunc, 60*1000);
end

TimerFunc();