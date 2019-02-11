--[[
%% properties
92 secured
%% weather
%% events
%% globals
--]]

fibaro:debug ('Hazaérkezés elindítva')
local riasztoKikapcs = (tonumber(fibaro:getValue(92, "secured")) == 0 )

fibaro:call(22, "setArmed", "0");
fibaro:call(30, "setArmed", "0");
fibaro:call(31, "setArmed", "0");
fibaro:call(57, "setArmed", "0");
fibaro:call(76, "setArmed", "0");
fibaro:call(95, "setArmed", "0");
fibaro:call(96, "setArmed", "0");
fibaro:call(98, "setArmed", "0");
fibaro:call(104, "setArmed", "0");
fibaro:call(105, "setArmed", "0");
fibaro:call(107, "setArmed", "0");
fibaro:call(108, "setArmed", "0");

fibaro:call(92, "unsecure");

fibaro:setGlobal("Riaszto", "Ki");

fibaro:debug ('Riaszto kikapcsolva')
