--[[
%% properties
181 value
%% weather
%% events
%% globals
--]]

--=================================================
-- Common functions
--=================================================
local debug = false
local function log(str) if debug then fibaro:debug(str); end; end
local function errorlog(str) fibaro:debug("<font color='red'>"..str.."</font>"); end

--=================================================
-- Main
--=================================================
log ('Tűz van!');

local startSource = fibaro:getSourceTrigger();
local mobileDeviceId = fibaro:getGlobalValue("MobileDeviceId");

if (
    ( tonumber(fibaro:getValue(181, "value")) > 0 )
    or startSource["type"] == "other"
)
then
    log ('Tűz van!');
	fibaro:call(mobileDeviceId, "sendDefinedPushNotification", "13");
end