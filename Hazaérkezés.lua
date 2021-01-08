--[[
%% properties
124 secured
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

log ('Hazaérkezés elindítva')

local secured = (tonumber(fibaro:getValue(124, "secured")) == 0 )
log ("secured: " .. tostring(secured));

if secured then
    fibaro:call(124, "unsecure");
end

fibaro:call(22, "setArmed", "0");
fibaro:call(177, "setArmed", "0");
fibaro:call(178, "setArmed", "0");
fibaro:call(180, "setArmed", "0");
fibaro:call(57, "setArmed", "0");
fibaro:call(98, "setArmed", "0");
fibaro:call(142, "setArmed", "0");
fibaro:call(176, "setArmed", "0");
fibaro:call(148, "setArmed", "0");
fibaro:call(175, "setArmed", "0");
fibaro:call(76, "setArmed", "0");

infolog ('Riaszto kikapcsolva')
