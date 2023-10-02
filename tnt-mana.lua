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
    local dispensers = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15}
    local tntChest = peripheral.wrap("minecraft:barrel_5")

    sleep(13)
    for key, number in pairs(dispensers)
    do
        local dispenser = peripheral.wrap("minecraft:dispenser_"..number)

        pushItem(tntChest, dispenser, "minecraft:tnt", 1, 27)
    end

    redstone.setOutput("right", true)
    sleep(0.5)
    redstone.setOutput("right", false)
end