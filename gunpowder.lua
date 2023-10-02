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

local function ItemLimit(chest)
    local total = 0
    for i = 1, chest.size() do
        total = total + chest.getItemLimit(i)
    end
    return total
end

-- Take items from inventory
local function pushItem(chestFrom, chestTo, itemMatch, quantity, maxSlots)
    local slot = 1
    local match = false
    local checkSlot = chestTo.getItemDetail(1)

    while match == false do
        if slot > maxSlots then
            slot = 1
            sleep(5)
        end
        
        local item = chestFrom.getItemDetail(slot)
        
        if item ~= nil then
            if item.name == itemMatch and item.count >= quantity then
                chestFrom.pushItems(chestTo, slot, quantity)
                match = true
            else
                slot = slot + 1
            end
        else
            slot = slot + 1
        end
    end
end

while true do
    -- Crear polvora hasta que el barril este lleno
    local gunpowderChest = peripheral.wrap("left")
    local openCrate = peripheral.wrap("minecraft:barrel_4")
    local flintChest = peripheral.wrap("back")
    local gunpowderLimit = ItemLimit(gunpowderChest)
    local gunpowderCount = countItem(gunpowderChest, "minecraft:gunpowder")
    local gunpowderFull = false

    if gunpowderCount == gunpowderLimit then
        gunpowderFull = true
    else
        gunpowderFull = false
    end

    while gunpowderFull == false do
        local gunpowderWanted = gunpowderLimit - gunpowderCount

        if gunpowderWanted < 64 then
            pushItem(flintChest, openCrate, "minecraft:flint", gunpowderWanted, 9)
        else
            pushItem(flintChest, openCrate, "minecraft:flint", 64, 9)
        end
        sleep(4)

        gunpowderLimit = ItemLimit(gunpowderChest)
        gunpowderCount = countItem(gunpowderChest, "minecraft:gunpowder")
        if gunpowderCount == gunpowderLimit then
            gunpowderFull = true
        else
            gunpowderFull = false
        end
    end
end