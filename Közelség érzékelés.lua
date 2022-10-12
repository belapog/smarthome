--[[
%% properties
%% weather
%% events
191 GeofenceEvent 5
%% globals
--]]

--=================================================
-- Common functions
--=================================================
local debug = true
local function log(str) if debug then fibaro:debug(str); end; end
local function errorlog(str) fibaro:debug("<font color='red'>"..str.."</font>"); end
local function infolog(str) fibaro:debug("<font color='yellow'>"..str.."</font>"); end


--=================================================
-- Main
--=================================================
local startSource = fibaro:getSourceTrigger();
local startSourceType = startSource["type"];
local mobileDeviceId = fibaro:getGlobalValue("MobileDeviceId");

log ("Közelség érzékelő elindítva");

if (startSourceType == "event")
then
    if (startSource.event["type"] == "GeofenceEvent")
    then
        if(startSource.event.data["geofenceAction"] == "enter")
        then
            log ("Hazaérkeztem");
            fibaro:call(mobileDeviceId, "sendDefinedPushNotification", "9");
            fibaro:startScene(57);
        end
        if(startSource.event.data["geofenceAction"] == "leave")
        then
            log ("Elmentem");
            fibaro:call(mobileDeviceId, "sendDefinedPushNotification", "14");
            fibaro:startScene(79);
        end
    end
end