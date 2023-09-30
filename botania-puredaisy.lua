local TransformationTime = 40
local x = 0
local y = 0
local axe = "left"
local pickaxe = "right"

-- Function to count the quantity of specified items in a chest/inventory peripheral
local function countItem(chest, itemMatch)
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
  -- Refuel if needed
  local bucket = turtle.getItemDetail(15)

  if bucket.name == "minecraft:lava_bucket" then
    local fuelLevel = turtle.getFuelLevel()
    if fuelLevel <= 100 then
      turtle.select(15)
      turtle.refuel(1)
    end
  end

  -- Collect stone from chest
    -- Check if there is enough stone in the chest and take 16
  turtle.turnRight()
  turtle.select(16)
  turtle.place()
  sleep(1)

  local StoneChest = peripheral.wrap("left")
  local DummyChest = peripheral.wrap("front")
  local StoneCount = countItem(StoneChest, "minecraft:stone")
  local StoneOk = false

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
          turtle.dig(axe)
          StoneOk = true
        else
          slot = slot + 1
        end
      end
    else
      sleep(10)
      StoneCount = countItem(StoneChest, "minecraft:stone")
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
        turtle.dig(pickaxe)
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
          turtle.dig(pickaxe)
          turtle.forward()
          x = x+1
          if x > 2 then
            placeBlockBehind(1)
          end
        end
      end
    end
    turtle.turnLeft()
    while y ~= 5 do
      local check = checkBlock("botania:livingrock")

      if check == "NoBlock" then
        turtle.forward()
        y = y+1
        if y > 0 then
          placeBlockBehind(1)
        end
      elseif check == true then
        turtle.select(2)
        turtle.dig(pickaxe)
        turtle.forward()
        y = y+1
        if y > 0 then
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
          turtle.dig(pickaxe)
          turtle.forward()
          y = y+1
          if y > 0 then
            placeBlockBehind(1)
          end
        end
      end

      if y == 2 or y == 3 then
        turtle.turnLeft()
        check = checkBlock("botania:livingrock")

        if check == "NoBlock" then
          turtle.select(1)
          turtle.place()
        elseif check == true then
          turtle.select(2)
          turtle.dig(pickaxe)
          turtle.select(1)
          turtle.place()
        else
          check = checkBlock("minecraft:stone")
          if check == true then
            check = checkBlock("botania:livingrock")
            while check == false do
              sleep(3)
              check = checkBlock("botania:livingrock")
            end
            turtle.select(2)
            turtle.dig(pickaxe)
            turtle.select(1)
            turtle.place()
          end
        end
        turtle.turnRight()
      end
    end
    turtle.turnLeft()
    while x ~= 2 do
      local check = checkBlock("botania:livingrock")

      if check == "NoBlock" then
        turtle.forward()
        x = x-1
        if x > 1 then
          placeBlockBehind(1)
        end
      elseif check == true then
        turtle.select(2)
        turtle.dig(pickaxe)
        turtle.forward()
        x = x-1
        if x > 1 then
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
          turtle.dig(pickaxe)
          turtle.forward()
          x = x-1
          if x > 1 then
            placeBlockBehind(1)
          end
        end
      end
    end
    turtle.turnLeft()
    while y ~= 1 do
      local check = checkBlock("botania:livingrock")
      if check == "NoBlock" then
        turtle.forward()
        y = y-1
        if y > 0 then
          placeBlockBehind(1)
        end
      elseif check == true then
        turtle.select(2)
        turtle.dig(pickaxe)
        turtle.forward()
        y = y-1
        if y > 0 then
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
          turtle.dig(pickaxe)
          turtle.forward()
          y = y-1
          if y > 0 then
            placeBlockBehind(1)
          end
        end
      end
    end
  end

  turtle.turnRight()
  turtle.forward()
  x = x-1
  placeBlockBehind(1)
  turtle.turnLeft()

  while y ~= -1 do
    turtle.forward()
    y = y-1
  end
  turtle.turnLeft()
  while x ~= 8 do
    turtle.forward()
    x = x+1
  end
  turtle.turnLeft()
  while y ~= 3 do
    turtle.forward()
    y = y+1
  end
  turtle.turnRight()
  turtle.forward()
  x = x+1

  -- Recolect lava bucket if empty
  local bucket = turtle.getItemDetail(15)

  if bucket.name == "minecraft:bucket" then
    turtle.turnRight()
    turtle.select(16)
    turtle.place()
    sleep(1)

    local LavaChest = peripheral.wrap("left")
    local DummyChest = peripheral.wrap("front")
    local LavaCount = countItem(LavaChest, "minecraft:lava_bucket")
    local LavaOk = false

    while LavaOk == false do
      if LavaCount >= 1
      then
        local slot = 1
        while LavaOk == false do
          local item = LavaChest.getItemDetail(slot)
          if item.name == "minecraft:lava_bucket" and item.count >= 1
          then
            turtle.select(15)
            turtle.drop(1)
            DummyChest.pushItems(peripheral.getName(LavaChest), 1, 1, slot+1)
            LavaChest.pushItems(peripheral.getName(DummyChest), slot, 1, 1)
            turtle.suck(1)
            turtle.select(16)
            turtle.dig(axe)
            LavaOk = true
          else
            slot = slot + 1
          end
        end
      else
        sleep(10)
        LavaCount = countItem(LavaChest, "minecraft:lava_bucket")
      end
    end
    turtle.turnLeft()
  end
  turtle.turnLeft()
  while y ~= 5 do
    turtle.forward()
    y = y+1
  end
  turtle.turnRight()

  -- Collect wood from chest
    -- Check if there is enough wood in the chest and take 16
    turtle.turnRight()
    turtle.select(16)
    turtle.place()
    sleep(1)
  
    local WoodChest = peripheral.wrap("left")
    local DummyChest = peripheral.wrap("front")
    local WoodCount = countItem(WoodChest, "minecraft:oak_log")
    local WoodOk = false
  
    while WoodOk == false do
      if WoodCount >= 16
      then
        local slot = 1
        while WoodOk == false do
          local item = WoodChest.getItemDetail(slot)
          if item.name == "minecraft:oak_log" and item.count >= 16
          then
            WoodChest.pushItems(peripheral.getName(DummyChest), slot, 16, 1)
            turtle.select(3)
            turtle.suck(16)
            turtle.select(16)
            turtle.dig(axe)
            WoodOk = true
          else
            slot = slot + 1
          end
        end
      else
        sleep(10)
        WoodCount = countItem(WoodChest, "minecraft:oak_log")
      end
    end

-- Start collecting living wood
  turtle.turnRight()
  turtle.forward()
  x = x-1

  while x ~= 7 and y ~= 4 do
    while x ~= 4 do
      local check = checkBlock("botania:livingwood_log")

      if check == "NoBlock" then
        turtle.forward()
        x = x-1
        if x < 7 then
          placeBlockBehind(3)
        end
      elseif check == true then
        turtle.select(4)
        turtle.dig(axe)
        turtle.forward()
        x = x-1
        if x < 7 then
          placeBlockBehind(3)
        end
      else
        check = checkBlock("minecraft:oak_log")
        if check == true then
          check = checkBlock("botania:livingwood_log")
          while check == false do
            sleep(3)
            check = checkBlock("botania:livingwood_log")
          end
          turtle.select(4)
          turtle.dig(axe)
          turtle.forward()
          x = x-1
          if x < 7 then
            placeBlockBehind(3)
          end
        end
      end
    end
    turtle.turnLeft()
    turtle.turnLeft()
    while y ~= 0 do
      local check = checkBlock("botania:livingwood_log")

      if check == "NoBlock" then
        turtle.forward()
        y = y-1
        if y < 5 then
          placeBlockBehind(3)
        end
      elseif check == true then
        turtle.select(4)
        turtle.dig(axe)
        turtle.forward()
        y = y-1
        if y < 5 then
          placeBlockBehind(3)
        end
      else
        check = checkBlock("minecraft:oak_log")
        if check == true then
          check = checkBlock("botania:livingwood_log")
          while check == false do
            sleep(3)
            check = checkBlock("botania:livingwood_log")
          end
          turtle.select(4)
          turtle.dig(axe)
          turtle.forward()
          y = y-1
          if y < 5 then
            placeBlockBehind(3)
          end
        end
      end

      if y == 2 or y == 3 then
        turtle.turnLeft()
        check = checkBlock("botania:livingwood_log")

        if check == "NoBlock" then
          turtle.select(3)
          turtle.place()
        elseif check == true then
          turtle.select(4)
          turtle.dig(axe)
          turtle.select(3)
          turtle.place()
        else
          check = checkBlock("minecraft:oak_log")
          if check == true then
            check = checkBlock("botania:livingwood_log")
            while check == false do
              sleep(3)
              check = checkBlock("botania:livingwood_log")
            end
            turtle.select(4)
            turtle.dig(axe)
            turtle.select(3)
            turtle.place()
          end
        end
        turtle.turnRight()
      end
    end
    turtle.turnLeft()
    while x ~= 7 do
      local check = checkBlock("botania:livingwood_log")

      if check == "NoBlock" then
        turtle.forward()
        x = x+1
        if x > 5 then
          placeBlockBehind(3)
        end
      elseif check == true then
        turtle.select(4)
        turtle.dig(axe)
        turtle.forward()
        x = x+1
        if x > 5 then
          placeBlockBehind(3)
        end
      else
        check = checkBlock("minecraft:oak_log")
        if check == true then
          check = checkBlock("botania:livingwood_log")
          while check == false do
            sleep(3)
            check = checkBlock("botania:livingwood_log")
          end
          turtle.select(4)
          turtle.dig(axe)
          turtle.forward()
          x = x+1
          if x > 5 then
            placeBlockBehind(3)
          end
        end
      end
    end
    turtle.turnLeft()
    while y ~= 4 do
      local check = checkBlock("botania:livingwood_log")
      if check == "NoBlock" then
        turtle.forward()
        y = y+1
        if y > 0 then
          placeBlockBehind(3)
        end
      elseif check == true then
        turtle.select(4)
        turtle.dig(axe)
        turtle.forward()
        y = y+1
        if y > 0 then
          placeBlockBehind(3)
        end
      else
        check = checkBlock("minecraft:oak_log")
        if check == true then
          check = checkBlock("botania:livingwood_log")
          while check == false do
            sleep(3)
            check = checkBlock("botania:livingwood_log")
          end
          turtle.select(4)
          turtle.dig(axe)
          turtle.forward()
          y = y+1
          if y > 0 then
            placeBlockBehind(3)
          end
        end
      end
    end
  end
  turtle.turnRight()
  turtle.forward()
  x = x+1
  placeBlockBehind(3)
  turtle.forward()
  x = x+1
  turtle.turnRight()
  while y ~= 2 do
    turtle.forward()
    y = y-1
  end
  turtle.turnLeft()
  turtle.up()

  -- deposit livingstone
  turtle.select(2)
  turtle.drop()

  turtle.turnRight()
  turtle.forward()
  y = y-1
  turtle.turnLeft()

  -- deposit livingwood
  turtle.select(4)
  turtle.drop()

  turtle.down()

  -- Delete exces
  turtle.select(1)
  turtle.dropDown()
  turtle.select(2)
  turtle.dropDown()
  turtle.select(3)
  turtle.dropDown()
  turtle.select(4)
  turtle.dropDown()

  -- Back to start
  turtle.turnRight()
  turtle.forward()
  y = y-1
  turtle.turnRight()
  while x ~= 0 do
    turtle.forward()
    x = x-1
  end

  sleep(TransformationTime)
end