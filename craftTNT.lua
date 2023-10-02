local DummyChest = peripheral.wrap("bottom")
local Trash = peripheral.wrap("right")
local tntCraftNumber = 32

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
    local checkSlot = DummyChest.getItemDetail(1)

    if checkSlot ~= nil then
        DummyChest.pushItems(peripheral.getName(Trash), 1, 64, 1)
    end

    while match == false do
        local item = chest.getItemDetail(slot)
        if item ~= nil then
            if item.name == itemMatch and item.count >= quantity then
                chest.pushItems(peripheral.getName(DummyChest), slot, quantity, 1)
                turtle.suckDown(quantity)
                match = true
            end
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
        takeItem(GunpowderBarrel, "minecraft:gunpowder", tntCraftNumber)
        turtle.select(3)
        takeItem(GunpowderBarrel, "minecraft:gunpowder", tntCraftNumber)
        turtle.select(6)
        takeItem(GunpowderBarrel, "minecraft:gunpowder", tntCraftNumber)
        turtle.select(9)
        takeItem(GunpowderBarrel, "minecraft:gunpowder", tntCraftNumber)
        turtle.select(11)
        takeItem(GunpowderBarrel, "minecraft:gunpowder", tntCraftNumber)
        turtle.select(2)
        takeItem(SandChest, "minecraft:sand", tntCraftNumber)
        turtle.select(5)
        takeItem(SandChest, "minecraft:sand", tntCraftNumber)
        turtle.select(7)
        takeItem(SandChest, "minecraft:sand", tntCraftNumber)
        turtle.select(10)
        takeItem(SandChest, "minecraft:sand", tntCraftNumber)
        turtle.select(tntCraftNumber)
        turtle.craft(tntCraftNumber)
        turtle.drop(tntCraftNumber)
    end

    -- Empty inventory
    local slots = {1, 2, 3, 5, 6, 7, 9, 10, 11}
    local checkSlot = DummyChest.getItemDetail(1)
    
    if checkSlot ~= nil then
        DummyChest.pushItems(peripheral.getName(Trash), 1, 64, 1)
    end

    for key, slot in pairs(slots)
    do
        turtle.select(slot)
        turtle.dropDown()
        DummyChest.pushItems(peripheral.getName(Trash), 1, 64, 1)
    end

    sleep(10)
end