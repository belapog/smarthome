--[[
%% properties
76 value
76 armed
98 value
188 value
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
local timer = 120;
local currentDate = os.time();
--local offTime = 3;

log ("Kapcsoló automata elindítva");

--Mi triggerelte az eseményt /wc vagy előszoba mozgás érzékelő/
local trigger = fibaro:getSourceTrigger();
local triggerDevice = "other";
if (trigger['type'] == 'property') then
    local triggerDeviceId = trigger['deviceID'];
    log ("triggerDevice: " .. triggerDeviceId);
    if (triggerDeviceId == 76) then
        if (tonumber(fibaro:getValue(76, "value")) > 0 ) then
            triggerDevice = "WCMozgas";
        end
    elseif (triggerDeviceId == 98) then
        if (tonumber(fibaro:getValue(98, "value")) > 0 ) then
            triggerDevice = "EloszobaMozgas";
        end
    elseif (triggerDeviceId == 188) then
        triggerDevice = "WCAjtoNyitas";
    end
end
log ("triggerDevice: " .. triggerDevice);


if (triggerDevice == "WCMozgas") then
    if ((tonumber(fibaro:getValue(76, "value")) > 0) and (tonumber(fibaro:getValue(76, "armed")) == 0)) then
        fibaro:setGlobal("SwitchOn164",  tostring(currentDate));
        fibaro:call(164, "turnOn");
        log ("turnOn");

        setTimeout(function()
            local lastSwithOnDate = fibaro:getGlobalValue("SwitchOn164");
            local timeTakenLastSwitchOnDate = tonumber(os.difftime(os.time(), lastSwithOnDate));
            log("timeTakenLastSwitchOnDate: " .. tostring(timeTakenLastSwitchOnDate));
            if (timeTakenLastSwitchOnDate >= timer) then
                fibaro:call(164, "turnOff");
                log ("turnOff Auto");
            end
        end, timer * 1000)
    end
end


if (triggerDevice == "EloszobaMozgas") then
    --local lastSwithOnDate = fibaro:getGlobalValue("SwitchOn164");
    --local timeTakenLastSwitchOnDate = tonumber(os.difftime(os.time(), lastSwithOnDate));
    --log("timeTakenLastSwitchOnDate: " .. tostring(timeTakenLastSwitchOnDate));
    if (tonumber(fibaro:getValue(188, "value")) > 0) then
        fibaro:call(164, "turnOff");
        log ("turnOff Off Motion");
    end
end

if (triggerDevice == "WCAjtoNyitas") then
    if (
    ( tonumber(fibaro:getValue(188, "value")) > 0 )
    and
    ( tonumber(fibaro:getValue(164, "value")) > 0 )
    )
    then
        log("WC lámpa kikapcs");
        fibaro:call(164, "turnOff");
    end
end