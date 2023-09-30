local TransformationTime = 100

while true
do
  -- Collect stone from chest
    -- Check if there is enough stone in the chest
  turtle.turnRight()
  turtle.select(16)
  turtle.place()
  sleep(1)

  local StoneChest = peripheral.wrap("left")
  local DummyChest = peripheral.wrap("front")
  local StoneCount = 0
  local StoneOk = false


  for slot, item in pairs(StoneChest.list())
  do
    if item.name == "minecraft:stone" then
      StoneCount = StoneCount + item.count
    end
  end
  while StoneOk == false do
    if StoneCount >= 16
    then
      local slot = 1
      while StoneOk == false do
        local item = StoneChest.getItemDetail(slot)
        if item.name == "minecraft:stone" and item.count >= 16
        then
          StoneChest.pushItems(peripheral.getName(DummyChest), slot, 16, 1)
          turtle.select(2)
          turtle.suck(16)
          turtle.select(16)
          turtle.dig()
          StoneOk = true
        else
          slot = slot + 1
        end
      end
    end
  end
  
  turtle.turnLeft()
  sleep(TransformationTime)
end