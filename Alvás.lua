--[[
%% autostart
--]]

function tempSleepFunc()    
    local currentDate = os.date("*t");
    local hour = tonumber(string.format("%02d", currentDate.hour));

    if ((hour >= 0) and (hour <= 7)) then
        fibaro:setGlobal("Alvas", "Alvás");
    else
        --fibaro:setGlobal("Alvas", "Ébrenlét");
    end

    setTimeout(tempSleepFunc, 60*1000)
end

--fibaro:debug ("Sleep started");
tempSleepFunc();