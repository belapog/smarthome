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

debug ("Alvás elindult");

function ScheduledFuncSleep()    
    local currentDate = os.date("*t");
    local hour = tonumber(string.format("%02d", currentDate.hour));
    debug ("TempSleepFunc");

    if ((hour >= 0) and (hour <= 1)) then
        fibaro:setGlobal("Alvas", "Alvás");
        debug ("Alvás");
    end

    setTimeout(ScheduledFuncSleep, 60*1000)
end

if (sourceTrigger["type"] == "autostart") then
    ScheduledFuncSleep();
else
    fibaro:setGlobal("Alvas", "Alvás");
    debug ("Alvás");
end