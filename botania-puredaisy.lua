local TransformationTime = 10

while true
do
  local StoneChest = peripheral.find("minecraft:chest")
  local StoneCount = 0
  for slot, item in pairs(StoneChest.list())
  do
    if item.name == "minecraft:stone" then
      StoneCount = StoneCount + item.count
    end
  end
  print(StoneCount)
  sleep(TransformationTime)
end