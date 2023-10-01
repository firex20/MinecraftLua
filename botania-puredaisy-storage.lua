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
    local rockChestString
    local woodChestString

    if rockChestCount == rockChestLimit then
        rockChestFull = true
        rockChestString = "true"
    else
        rockChestFull = false
        rockChestString = "false"
    end
    if woodChestCount == woodChestLimit then
        woodChestFull = true
        woodChestString = "true"
    else
        woodChestFull = false
        woodChestString = "false"
    end

    term.setCursorPos(50, 0)
    term.clear()
    print("LivingWoodFull: "..woodChestString)
    print("LivingRockFull: "..rockChestString)

    rednet.open("top")
    if rockChestFull and woodChestFull then
        allFull = true
    else
        allFull = false
    end
    rednet.broadcast(allFull, "firex_daisy")

    sleep(5)
end