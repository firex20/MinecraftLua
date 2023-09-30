local TransformationTime = 100
local x = 0
local y = 0

-- Function to count the quantity of specified items in a chest/inventory peripheral
local function countStone(chest, itemMatch)
  local count = 0
  for slot, item in pairs(chest.list())
  do
    if item.name == itemMatch then
      count = count + item.count
    end
  end
  return count
end

local function checkBlock(blockMatch)
  local result
  local block, data = turtle.inspect()

  if block then
    if data.name == blockMatch then
      result = true
    else
      result = false
    end
  else
    result = "NoBlock"
  end

  return result
end

local function placeBlockBehind(slot)
  turtle.turnLeft()
  turtle.turnLeft()
  turtle.select(slot)
  turtle.place()
  turtle.turnRight()
  turtle.turnRight()
end

while true
do
  -- Collect stone from chest
    -- Check if there is enough stone in the chest and take 16
  turtle.turnRight()
  turtle.select(16)
  turtle.place()
  sleep(1)

  local StoneChest = peripheral.wrap("left")
  local DummyChest = peripheral.wrap("front")
  local StoneCount = countStone(StoneChest, "minecraft:stone")
  local StoneOk = false
  print(StoneCount)

  while StoneOk == false do
    if StoneCount >= 16
    then
      local slot = 1
      while StoneOk == false do
        local item = StoneChest.getItemDetail(slot)
        if item.name == "minecraft:stone" and item.count >= 16
        then
          StoneChest.pushItems(peripheral.getName(DummyChest), slot, 16, 1)
          turtle.select(1)
          turtle.suck(16)
          turtle.select(16)
          turtle.dig()
          StoneOk = true
        else
          slot = slot + 1
        end
      end
    else
      sleep(10)
      StoneCount = countStone(StoneChest, "minecraft:stone")
    end
  end
  
  -- Start mining living stone and wood
  turtle.turnRight()
  turtle.forward()
  x = x+1

  while x ~= 2 and y ~= 1 do
    while x ~= 4 do
      local check = checkBlock("botania:livingrock")

      if check == "NoBlock" then
        turtle.forward()
        x = x+1
        if x > 2 then
          placeBlockBehind(1)
        end
      elseif check == true then
        turtle.select(2)
        turtle.dig()
        turtle.forward()
        x = x+1
        if x > 2 then
          placeBlockBehind(1)
        end
      else
        check = checkBlock("minecraft:stone")
        if check == true then
          check = checkBlock("botania:livingrock")
          while check == false do
            sleep(3)
            check = checkBlock("botania:livingrock")
          end
          turtle.select(2)
          turtle.dig()
          turtle.forward()
          x = x+1
          if x > 2 then
            placeBlockBehind(1)
          end
        end
      end

    end
  end

  sleep(TransformationTime)
end