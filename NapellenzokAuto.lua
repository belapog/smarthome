--[[
%% properties
67 value
66 value
24 value
%% weather
Temperature
Wind
WeatherCondition
%% events
%% globals
Napszak
Alvas
Futes
--]]

local idojarasOk = (tonumber(api.get('/weather')['Wind']) < tonumber(20) and 
    (api.get('/weather')['WeatherCondition'] == "clear" or
    api.get('/weather')['WeatherCondition'] == "cloudy"));

local nemKeziFelemeles = (fibaro:getGlobalValue("NapellenzoMozgatas") ~= "Kézi fel");

local kintMelegVan = (tonumber(api.get('/weather')['Temperature']) > 11);

local futesUzemmod = (fibaro:getGlobalValue("Futes") ~= "Fűtés")

local nappaliHomerseglet = tonumber(fibaro:getValue(67, "value"));
local termosztatHomerseglet = tonumber(fibaro:getValue(66, "value"));
local nemKellFutes = nappaliHomerseglet > termosztatHomerseglet;

local otthonVagyunk = (fibaro:getGlobalValue("Riaszto") == "Ki");
local estiArnyekolasKell = ((fibaro:getGlobalValue("Napszak") == "Este") and (fibaro:getGlobalValue("Alvas") == "Ébrenlét") and otthonVagyunk);

local napellenzokLeeresztve = (tonumber(fibaro:getValue(13, "value")) == 0  or  
    tonumber(fibaro:getValue(10, "value")) == 0  or  
    tonumber(fibaro:getValue(16, "value")) == 0  or  
    tonumber(fibaro:getValue(19, "value")) == 0
    )
local tulNagyAFeny; 
if (napellenzokLeeresztve and (tonumber(fibaro:getValue(24, "value")) > 200 )) or
    ((napellenzokLeeresztve == false) and (tonumber(fibaro:getValue(24, "value")) > 1000 ))
then
    tulNagyAFeny = true;
else
    tulNagyAFeny = false;
end

fibaro:debug (idojarasOk);
fibaro:debug (nemKeziFelemeles);
fibaro:debug (kintMelegVan);
fibaro:debug (nappaliHomerseglet);
fibaro:debug (termosztatHomerseglet);
fibaro:debug (nemKellFutes);
fibaro:debug (estiArnyekolasKell);
fibaro:debug (otthonVagyunk);
fibaro:debug (tulNagyAFeny);
fibaro:debug (tonumber(fibaro:getValue(24, "value")));

if (
    idojarasOk and 
    nemKeziFelemeles and
    (tulNagyAFeny or estiArnyekolasKell)
    )
then
    fibaro:startScene(51);
    fibaro:debug ('Auto le!');
    fibaro:setGlobal("NapellenzoMozgatas", "Auto le");
else
    fibaro:startScene(52);
    fibaro:debug ('Auto fel!');
    if (nemKeziFelemeles)
    then
        fibaro:setGlobal("NapellenzoMozgatas", "Auto fel");
    end
end