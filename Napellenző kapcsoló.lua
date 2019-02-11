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

if (
    tonumber(fibaro:getValue(13, "sceneActivation")) == 16  or  
    tonumber(fibaro:getValue(10, "sceneActivation")) == 16  or 
    tonumber(fibaro:getValue(16, "sceneActivation")) == 16  or 
    tonumber(fibaro:getValue(19, "sceneActivation")) == 16 )
then
	fibaro:setGlobal("NapellenzoMozgatas", "Kézi fel");
end

if (
    tonumber(fibaro:getValue(13, "sceneActivation")) == 26  or  
    tonumber(fibaro:getValue(10, "sceneActivation")) == 26  or 
    tonumber(fibaro:getValue(16, "sceneActivation")) == 26  or 
    tonumber(fibaro:getValue(19, "sceneActivation")) == 26 )
then
	fibaro:setGlobal("NapellenzoMozgatas", "Kézi le");;
end