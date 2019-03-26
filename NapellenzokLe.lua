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

local napellenzokFent = (tonumber(fibaro:getValue(13, "value")) > 0  or  
    tonumber(fibaro:getValue(10, "value")) > 0  or  
    tonumber(fibaro:getValue(16, "value")) > 0  or  
    tonumber(fibaro:getValue(19, "value")) > 0
    )
debug ("napellenzokFent: " .. tostring(napellenzokFent));

local weatherGoodCondition = (tonumber(api.get('/weather')['Wind']) < tonumber(18));
debug ("weatherGoodCondition: " .. tostring(weatherGoodCondition));


if (napellenzokFent and weatherGoodCondition)
then
    fibaro:call(13, "close");
    fibaro:call(10, "close");
    fibaro:call(16, "close");
    fibaro:call(19, "close");
    debug ('Napellenző leeresztés');
else
    debug ('Napellenzők mind lent vagy szél van', 2 );
end