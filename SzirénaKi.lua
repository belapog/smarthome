--[[
%% properties
57 armed
176 armed
175 armed
188 armed
177 armed
178 armed
98 armed
142 armed
148 armed
76 armed
22 armed
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
local function infolog(str) fibaro:debug("<font color='yellow'>"..str.."</font>"); end

--=================================================
-- Main
--=================================================
log ("Sziréna leállítás elindítva");

local startSource = fibaro:getSourceTrigger();
if (
    ( tonumber(fibaro:getValue(57, "armed")) == 0  and  
    tonumber(fibaro:getValue(176, "armed")) == 0  and  
    tonumber(fibaro:getValue(175, "armed")) == 0  and  
    tonumber(fibaro:getValue(188, "armed")) == 0  and  
    tonumber(fibaro:getValue(177, "armed")) == 0  and  
    tonumber(fibaro:getValue(178, "armed")) == 0  and  
    tonumber(fibaro:getValue(98, "armed")) == 0  and  
    tonumber(fibaro:getValue(142, "armed")) == 0  and  
    tonumber(fibaro:getValue(148, "armed")) == 0  and  
    tonumber(fibaro:getValue(76, "armed")) == 0  and  
    tonumber(fibaro:getValue(22, "armed")) == 0 )
    or
    startSource["type"] == "other"
)
then
	fibaro:call(183, "turnOff");
    infolog ("Sziréna ki")
end