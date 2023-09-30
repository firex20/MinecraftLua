local TransformationTime = 100

local function countStone(chest, itemMatch)
  local count
  for slot, item in pairs(chest.list())
  do
    if item.name == itemMatch then
      count = count + item.count
    end
  end
  return count
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
  
  turtle.turnLeft()
  sleep(TransformationTime)
end