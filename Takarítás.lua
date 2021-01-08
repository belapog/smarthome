--[[
%% properties
%% events
%% globals
--]]

--=================================================
-- Common functions
--=================================================
local debug = true
local function log(str) if debug then fibaro:debug(str); end; end
local function errorlog(str) fibaro:debug("<font color='red'>"..str.."</font>"); end
local function infolog(str) fibaro:debug("<font color='yellow'>"..str.."</font>"); end

local function IFTTTWebhooks(eventName, key)
    local httpClient = net.HTTPClient({timeout=3000});
    httpClient:request('https://maker.ifttt.com/trigger/'..eventName..'/with/key/'..key, {
      options={
        method = 'GET',
        timeout = 3000
      },
      success = function(response)
        log(response.status .. " " .. response.data)
    end, 
      error = function(error) 
        errorlog('ERROR: '..error)
      end
    })
end

--=================================================
-- Main
--=================================================
log("Takarítás elindítva");

if (fibaro:countScenes() > 1) then
    errorlog("The scene is already running")
    fibaro:abort()
end

local function startMopping ()
  IFTTTWebhooks("Start_Mop", fibaro:getGlobalValue("IFTTTWebhookKey"));
  log("MOP indíthjató");
end

IFTTTWebhooks("Start_Cleaning", fibaro:getGlobalValue("IFTTTWebhookKey"));
log("Porszívó elindítva");
setTimeout(startMopping, 100*60*1000);