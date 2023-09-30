-- Activate or deactivate the turtle working on daisys fi the inventory is full

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

while true do
    local allFull
    local rockChest = peripheral.wrap("back")
    local woodChest = peripheral.wrap("minecraft:barrel_0")
    local rockChestLimit = ItemLimit(rockChest)
    local woodChestLimit = ItemLimit(woodChest)
    local rockChestCount = countItem(rockChest, "botania:livingrock")
    local woodChestCount = countItem(woodChest, "botania:livingwood_log")
    local rockChestFull
    local woodChestFull

    if rockChestCount == rockChestLimit then
        rockChestFull = true
    else
        rockChestFull = false 
    end
    if woodChestCount == woodChestLimit then
        woodChestFull = true
    else
        woodChestFull = false
    end

    term.setCursorPos(0, 0)
    term.clear()
    term.write("LivingWoodFull: "..woodChestFull)
    term.write("LivingRockFull: "..rockChestFull)

    rednet.open("top")
    if rockChestFull and woodChestFull then
        allFull = true
    else
        allFull = false
    end
    rednet.send(69, allFull, "firex_daisy")

    sleep(5)
end