--[[
%% properties
%% weather
%% events
%% globals
Napszak
Alvas
--]]


function debug(message, level)
    if level == nil then
        level = 1;
    end
    local debugLevel = 1;
    if (level >= debugLevel) then
        fibaro:debug (message);
    end
end

debug("Virágkeltető világítás automata");

local night = (fibaro:getGlobalValue("Napszak") == "Este");
debug ("Napszak: " .. tostring(night));

local ebrenlet = fibaro:getGlobalValue("Alvas") ==  "Ébrenlét";
debug ("ebrenlet: " .. tostring(ebrenlet));

if (night and ebrenlet)
then
	fibaro:call(173, "turnOn");
end

if (night and not ebrenlet)
then
	fibaro:call(173, "turnOff");
end

if (not night)
then
	fibaro:call(173, "turnOff");
end