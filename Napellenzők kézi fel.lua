
--[[
%% properties
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
fibaro:startScene(52);
fibaro:setGlobal("NapellenzoStatus", "Kézi fel");
