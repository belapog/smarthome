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

local napellenzokNemLent = (tonumber(fibaro:getValue(13, "value")) < 99  or  
    --tonumber(fibaro:getValue(10, "value")) < 99  or  
    tonumber(fibaro:getValue(16, "value")) < 99 or  
    tonumber(fibaro:getValue(19, "value")) < 99
    )
log ("napellenzokLeeresztve" .. tostring(napellenzokNemLent));

if (napellenzokNemLent)
then
    fibaro:call(13, "open");
    --fibaro:call(10, "open");
    fibaro:call(16, "open");
    fibaro:call(19, "open");
    infolog ('Napellenzők felhúzás');
else
    infolog ('Napellenzők fent voltak');
end
