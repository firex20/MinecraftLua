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
    local rockChest = peripheral.wrap("techreborn:storage_unit_0")
    local woodChest = peripheral.wrap("bottom")
    local rockChestLimit = ItemLimit(rockChest)
    local woodChestLimit = ItemLimit(woodChest)
    local rockChestCount = countItem(rockChest)
    local woodChestCount = countItem(woodChest)

    term.clear()
    print("LivingWood: "..woodChestCount.."/"..woodChestLimit)
    print("LivingRock: "..rockChestCount.."/"..rockChestLimit)

    rednet.open("left")
    if rockChestCount == rockChestLimit and woodChestCount == woodChestLimit then
        allFull = true
    else
        allFull = false
    end
    rednet.send(69, allFull, "firex_daisy")

    sleep(5)
end