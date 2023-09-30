local repo = "https://raw.githubusercontent.com/firex20/MinecraftLua/main/"
local fullfile = repo..arg[1]
if fs.exists(./arg[1])
then
    print ("El archivo ya existe ¿Sobrescribir? Y/N [Y]:")
    local confir = io.read()
    if confir == nil or confir == "Y"
    then
        shell.run("rm", "./"..arg[1])
        shell.run("wget", fullfile, arg[1])
    end
else
    shell.run("wget", fullfile, arg[1])
end