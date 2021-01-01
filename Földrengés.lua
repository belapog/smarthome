--[[
%% properties
101 value
25 value
79 value
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
log("Földrengés érzékelés elindítva");

if (
    tonumber(fibaro:getValue(101, "value")) > 0  or
    tonumber(fibaro:getValue(25, "value")) > 0  or
    tonumber(fibaro:getValue(79, "value")) > 0)
then
    errorlog("Földrengés!!!");
    fibaro:call(184, "sendDefinedPushNotification", "8");
end