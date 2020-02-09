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

function TempSleepFunc()    
    local currentDate = os.date("*t");
    local hour = tonumber(string.format("%02d", currentDate.hour));
    debug ("TempSleepFunc");

    if ((hour >= 0) and (hour <= 1)) then
        fibaro:setGlobal("Alvas", "Alvás");
        debug ("Alvás");
    end

    setTimeout(TempSleepFunc, 60*1000)
end

TempSleepFunc();