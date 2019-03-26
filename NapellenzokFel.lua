--[[
%% properties
%% weather
%% events
%% globals
--]]

function debug(message, level)
    if level == nil then
        level = 1;
    end
    local debugLevel = 2;
    if (level >= debugLevel) then
        fibaro:debug (message);
    end
end

local napellenzokLeeresztve = (tonumber(fibaro:getValue(13, "value")) == 0  or  
    tonumber(fibaro:getValue(10, "value")) == 0  or  
    tonumber(fibaro:getValue(16, "value")) == 0  or  
    tonumber(fibaro:getValue(19, "value")) == 0
    )
debug ("napellenzokLeeresztve" .. tostring(napellenzokLeeresztve));

if (napellenzokLeeresztve)
then
    fibaro:call(13, "open");
    fibaro:call(10, "open");
    fibaro:call(16, "open");
    fibaro:call(19, "open");
    debug ('Napellenzők felhúzás');
else
    debug ('Napellenzők fent voltak');
end
