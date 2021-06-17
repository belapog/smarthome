--[[
%% properties
13 sceneActivation
10 sceneActivation
16 sceneActivation
19 sceneActivation
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
log("Napellentő kapcsoló stzarted");
if (
    tonumber(fibaro:getValue(13, "sceneActivation")) == 16  or  
    tonumber(fibaro:getValue(10, "sceneActivation")) == 16  or 
    tonumber(fibaro:getValue(16, "sceneActivation")) == 16  or 
    tonumber(fibaro:getValue(19, "sceneActivation")) == 16 )
then
	fibaro:setGlobal("NapellenzoStatus", "Kézi fel");
    infolog("Kézi fel")
end

if (
    tonumber(fibaro:getValue(13, "sceneActivation")) == 26  or  
    tonumber(fibaro:getValue(10, "sceneActivation")) == 26  or 
    tonumber(fibaro:getValue(16, "sceneActivation")) == 26  or 
    tonumber(fibaro:getValue(19, "sceneActivation")) == 26 )
then
	fibaro:setGlobal("NapellenzoStatus", "Kézi le");
    infolog("Kézi fel");
end