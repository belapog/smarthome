--[[
%% properties
%% weather
%% events
%% globals
--]]

local napellenzokFent = (tonumber(fibaro:getValue(13, "value")) > 0  or  
    tonumber(fibaro:getValue(10, "value")) > 0  or  
    tonumber(fibaro:getValue(16, "value")) > 0  or  
    tonumber(fibaro:getValue(19, "value")) > 0
    )

fibaro:debug (napellenzokFent);

if (
    napellenzokFent)
then
    if (
        tonumber(api.get('/weather')['Wind']) < tonumber(20))
    then
        fibaro:call(13, "close");
	      fibaro:call(10, "close");
        fibaro:call(16, "close");
        fibaro:call(19, "close");
        fibaro:debug ('Napellenző leeresztés');
    else
        fibaro:debug ('Szélvédelem');
    end
else
    fibaro:debug ('Napellenzők mind lent');
end