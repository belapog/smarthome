local hueLightID = 0000000000; 
local hueIP = "192.163.1.20";
local huePort = "80";
local sliderValue = 1;
local hueBrightness = 0.1;
local hueOn = true;

if (sliderValue == 0) then
  hueBrightness = sliderValue;
  hueOn = false;
else
  hueBrightness = math.floor(sliderValue * 2.54);
  hueOn = true;
end

local Hue = net.FHttp(hueIP,huePort);
Hue:PUT('/api/00000/lights/'..hueLightID..'/state', '{\"on\":'..tostring(hueOn)..',\"bri\":'..hueBrightness..'}');


--Hue:PUT('/api/0000/lights/'..hueLightID..'/state', '{\"ct\":'.. vHue .. '}')","buttonIcon":1047,"favourite":false,"main":false},{"id":3,"lua":true,"waitForResponse":false,"caption":"2700k","name":"button_1_0","empty":false,"msg":"local hueLightID = 0000000000; 
--local vHue = 270; 

--Hue:PUT('/api/0000/lights/'..hueLightID..'/state', '{\"ct\":'.. vHue .. '}')","buttonIcon":1048,"favourite":false,"main":false},{"id":4,"lua":true,"waitForResponse":false,"caption":"4000k","name":"button_1_1","empty":false,"msg":"local hueLightID = 0000000000; 
--local vHue = 1; 


--Hue:PUT('/api/0000/lights/'..hueLightID..'/state', '{\"ct\":'.. vHue .. '}')","buttonIcon":1049,"favourite":false,"main":false}]}]},"actions":{"pressButton":1,"setSlider":2,"setProperty":2}}


