#!/usr/bin/env lua

math.randomseed(os.time())

magicPct = 0.22
seed = {
   1394595918,
   1.0,
   0.0,
   0.0,
}
stats = seed

RidingSkill = {cost = 50000000, trained = false, level = nil}
function RidingSkill:new(o)
   o = o or {}
   setmetatable(o, self)
   self.__index = self
   return o
end

function RidingSkill:qualified(level)
   return level >= self.level and not self.trained
end

function RidingSkill:affordable(copper)
   return copper >= self.cost
end

function RidingSkill:train()
   self.trained = true
   return -1 * self.cost
end

artisan = RidingSkill:new{level = 70}
master = RidingSkill:new{level = 80}

function calcChange(copper, level)
   if 0 == copper then
      return 10
   elseif artisan:qualified(level) and artisan:affordable(copper) then
      artisan:train()
      return -1 * artisan.cost
   elseif master:qualified(level) and master:affordable(copper) then
      master:train()
      return -1 * master.cost
   else
      return math.ceil(copper * math.random() * magicPct)
   end
end

function cap(copper)
   return math.min(copper, 9999999999)
end

function nextEvent(stats)
   local ts, level, copper, earned = unpack(stats)
   local change = calcChange(copper, level)

   return {ts + 100, level + math.random(), cap(copper + change), cap(earned + math.max(0, change))}
end

while stats[2] <= 90 do
   print(table.concat(stats, "\t"))
   stats = nextEvent(stats)
end
