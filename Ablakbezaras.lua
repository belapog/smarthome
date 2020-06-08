--[[
%% autostart
--]]

function debug(message, level)
    if level == nil then
        level = 2;
    end
    local debugLevel = 2;
    if (level >= debugLevel) then
        fibaro:debug (message);
    end
end

function CloseTheWindowNotFunc()
    local currentDate = os.time();
    debug (tostring(currentDate));
    
    if ((( tonumber(fibaro:getValue(96, "value")) > 0 ) or 
            ( tonumber(fibaro:getValue(108, "value")) > 0 ) or 
            ( tonumber(fibaro:getValue(105, "value")) > 0 ) or 
            ( tonumber(fibaro:getValue(31, "value")) > 0 )) and 
        (fibaro:getGlobalValue("Futes") == "Hűtés") and 
        (tonumber(fibaro:getValue(155, "value")) > tonumber(fibaro:getGlobalValue("CelHomerseglet"))))
    then
        debug ("Lehet hogy be kellene csukni az ablakot.");

        local lastCloseTheWindowNot = fibaro:getGlobalValue("CloseTheWindowNot");
        debug (tostring(lastCloseTheWindowNot));

        local timeTakenLastNot = tonumber(os.difftime(os.time(), lastCloseTheWindowNot));
        debug (tostring(timeTakenLastNot));

        if (timeTakenLastNot >= (60 * 5)) 
        then
            debug ("Be kellene csukni az ablakot!");
            fibaro:call(4, "sendDefinedPushNotification", "12");
        end
    else
        debug ("Nem kell becsukni az ablakot.");
        fibaro:setGlobal("CloseTheWindowNot", tostring(currentDate));
    end
end

CloseTheWindowNotFunc();