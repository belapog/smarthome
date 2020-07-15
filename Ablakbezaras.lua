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
    debug ("currentDate" .. tostring(currentDate));
    
    if ((( tonumber(fibaro:getValue(177, "value")) > 0 ) or 
            ( tonumber(fibaro:getValue(178, "value")) > 0 ) or 
            ( tonumber(fibaro:getValue(176, "value")) > 0 ) or 
            ( tonumber(fibaro:getValue(175, "value")) > 0 )) and 
        (fibaro:getGlobalValue("Futes") == "Hűtés") and 
        (tonumber(fibaro:getValue(155, "value")) > tonumber(fibaro:getGlobalValue("CelHomerseglet"))))
    then
        debug ("Lehet hogy be kellene csukni az ablakot.");

        local lastCloseTheWindowNot = fibaro:getGlobalValue("CloseTheWindowNot");
        debug ("lastCloseTheWindowNot" .. tostring(lastCloseTheWindowNot));

        local timeTakenLastNot = tonumber(os.difftime(os.time(), lastCloseTheWindowNot));
        debug ("timeTakenLastNot" .. tostring(timeTakenLastNot));

        if ((timeTakenLastNot >= (60 * 5)) and (tonumber(lastCloseTheWindowNot)  ~= 0))
        then
            debug ("Be kellene csukni az ablakot!");
            fibaro:call(4, "sendDefinedPushNotification", "12");
      		fibaro:setGlobal("CloseTheWindowNot", tostring(currentDate));
        end
    	if (tonumber(lastCloseTheWindowNot)  == 0)
    	then
    		fibaro:setGlobal("CloseTheWindowNot", tostring(currentDate));
    	end
    else
        debug ("Nem kell becsukni az ablakot.");
        fibaro:setGlobal("CloseTheWindowNot", "0");
    end

    if (( tonumber(fibaro:getValue(96, "value")) == 0 ) and 
            ( tonumber(fibaro:getValue(108, "value")) == 0 ) and 
            ( tonumber(fibaro:getValue(105, "value")) == 0 ) and 
            ( tonumber(fibaro:getValue(31, "value")) == 0 ))
    then
        debug ("Minden ablak csukva");
        fibaro:setGlobal("CloseTheWindowNot", "0");
    end

    setTimeout(CloseTheWindowNotFunc, 60*1000)
end

CloseTheWindowNotFunc();