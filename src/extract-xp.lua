#!/usr/bin/env lua

local lastXp, eventXp = -1, nil

IDX_TIME = 1
IDX_EVENT = 2
IDX_TX = 3


function extractXp(event)
   local eventXp

   if "PLAYER_XP_CHANGE" == event[IDX_EVENT] then
      eventXp = event[4]
   else
      eventXp = event[6]
   end

   return event[IDX_TIME], eventXp
end


loadfile(arg[1])()

for i, event in pairs(projectLootEvents) do
   if "PLAYER_LOGIN" == event[IDX_EVENT] or
      "PLAYER_LOGOUT" == event[IDX_EVENT] or
      "PLAYER_XP_CHANGE" == event[IDX_EVENT] then
      time, eventXp = extractXp(event)
      lastXp = lastXp or eventXp

      if eventXp ~= lastXp then
         print(time .. "," .. eventXp)
         lastXp = eventXp
      end
   end
end
