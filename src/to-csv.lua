#!/usr/bin/env lua

dofile(arg[1])

for i, event in pairs(projectLootEvents) do
   print(table.concat(event, ","))
end
