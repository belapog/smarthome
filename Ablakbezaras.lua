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
local mobileDeviceId = fibaro:getGlobalValue("MobileDeviceId");


--=================================================
-- Main
--=================================================

infolog("Ablakbezárás strated");


function CloseTheWindowNotFunc()
    local currentDate = os.time();
    log ("currentDate: " .. tostring(currentDate));
    local mobileDeviceId = fibaro:getGlobalValue("MobileDeviceId");

    local isWindowOpened = (( tonumber(fibaro:getValue(177, "value")) > 0 ) or 
    ( tonumber(fibaro:getValue(178, "value")) > 0 ) or 
    ( tonumber(fibaro:getValue(176, "value")) > 0 ) or 
    ( tonumber(fibaro:getValue(175, "value")) > 0 ));
    log ("isWindowOpened: " .. tostring(isWindowOpened));

    local coolingMode = fibaro:getGlobalValue("Futes");
    log ("coolingMode: " .. tostring(coolingMode));

    local externalTemperature = tonumber(fibaro:getValue(155, "value"));
    log ("externalTemperature: " .. tostring(externalTemperature));

    local targetTemperature = tonumber(fibaro:getGlobalValue("CelHomerseglet"));
    log ("targetTemperature: " .. tostring(targetTemperature));

    local lastCloseTheWindowNot = fibaro:getGlobalValue("CloseTheWindowNot");
    log ("lastCloseTheWindowNot: " .. tostring(lastCloseTheWindowNot));

    local timeTakenLastNot = tonumber(os.difftime(os.time(), lastCloseTheWindowNot));
    log ("timeTakenLastNot: " .. tostring(timeTakenLastNot));

    local beClosed = false;
    if (((coolingMode == "Hűtés") and (externalTemperature > targetTemperature)) or
        ((coolingMode == "Fűtés") and (externalTemperature < targetTemperature)))
    then
        beClosed = true;
    end
    log ("beClosed: " .. tostring(beClosed));
    
    

    if ( isWindowOpened and beClosed)
    then
        log ("Lehet hogy be kellene csukni az ablakot.");

        if ((timeTakenLastNot >= (60 * 5)) and (tonumber(lastCloseTheWindowNot)  ~= 0))
        then
            log ("Be kellene csukni az ablakot!");
            fibaro:call(mobileDeviceId, "sendDefinedPushNotification", "12");
      		fibaro:setGlobal("CloseTheWindowNot", tostring(currentDate));
        end
    	if (tonumber(lastCloseTheWindowNot)  == 0)
    	then
    		fibaro:setGlobal("CloseTheWindowNot", tostring(currentDate));
    	end
    else
        log ("Nem kell becsukni az ablakot.");
        fibaro:setGlobal("CloseTheWindowNot", "0");
    end

    if (( tonumber(fibaro:getValue(96, "value")) == 0 ) and 
            ( tonumber(fibaro:getValue(108, "value")) == 0 ) and 
            ( tonumber(fibaro:getValue(105, "value")) == 0 ) and 
            ( tonumber(fibaro:getValue(31, "value")) == 0 ))
    then
        log ("Minden ablak csukva");
        fibaro:setGlobal("CloseTheWindowNot", "0");
    end

    setTimeout(CloseTheWindowNotFunc, 60*1000)
end

CloseTheWindowNotFunc();