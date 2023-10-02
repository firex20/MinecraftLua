local DummyChest = peripheral.wrap("bottom")

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

-- Take items from inventory
local function takeItem(chest, itemMatch, quantity)
    local slot = 1
    local match = false

    while match == false do
        local item = chest.getItemDetail(slot)
        if item.name == itemMatch and item.count >= quantity then
            chest.pushItems(peripheral.getName(DummyChest), slot, quantity, 1)
            turtle.suckDown(quantity)
            match = true
        else
            slot = slot + 1
        end
    end
end

while true do

    local TntBarrel = peripheral.wrap("front")
    local SandChest = peripheral.wrap("back")
    local GunpowderBarrel = peripheral.wrap("top")
    local TntCount = countItem(TntBarrel, "minecraft:gunpowder")

    if TntCount < 128 then
        -- Craft the tnt and drop it in the barrel
        turtle.select(1)
        takeItem(SandChest, "minecraft:sand", 16)
        turtle.select(3)
        takeItem(SandChest, "minecraft:sand", 16)
        turtle.select(6)
        takeItem(SandChest, "minecraft:sand", 16)
        turtle.select(9)
        takeItem(SandChest, "minecraft:sand", 16)
        turtle.select(11)
        takeItem(SandChest, "minecraft:sand", 16)
        turtle.select(2)
        takeItem(GunpowderBarrel, "minecraft:gunpowder", 16)
        turtle.select(5)
        takeItem(GunpowderBarrel, "minecraft:gunpowder", 16)
        turtle.select(7)
        takeItem(GunpowderBarrel, "minecraft:gunpowder", 16)
        turtle.select(10)
        takeItem(GunpowderBarrel, "minecraft:gunpowder", 16)
        turtle.select(16)
        turtle.craft(16)
        turtle.drop(16)
    end
    sleep(10)
end