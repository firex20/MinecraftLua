-- Add the programs in /bin as aliases
local programs = fs.list("/bin")
for key, file in pairs(programs)
do
    for i in string.gmatch(file, "([^"..'.'.."]+)")
    do
        if i == "lua"
        then
        else
            shell.run("alias", i, "/bin/"..file)
        end
    end
end