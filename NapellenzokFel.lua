--[[
%% properties
%% weather
%% events
%% globals
--]]


local napellenzokLeeresztve = (tonumber(fibaro:getValue(13, "value")) == 0  or  
    tonumber(fibaro:getValue(10, "value")) == 0  or  
    tonumber(fibaro:getValue(16, "value")) == 0  or  
    tonumber(fibaro:getValue(19, "value")) == 0
    )

fibaro:debug (napellenzokLeeresztve);

if (napellenzokLeeresztve)
then
    fibaro:call(13, "open");
    fibaro:call(10, "open");
    fibaro:call(16, "open");
    fibaro:call(19, "open");
    fibaro:debug ('Napellenzők felhúzás');
else
    fibaro:debug ('Napellenzők fent voltak');
end
