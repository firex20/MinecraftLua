-- Este programa se descarga los programas de este repositorio
-- Usage: git-get <nombre-programa>.lua
local repo = "https://raw.githubusercontent.com/firex20/MinecraftLua/main/"
local fullfile = repo..arg[1]
local curdir = shell.dir()
if fs.exists(curdir.."/"..arg[1])
then
    print ("El archivo ya existe ¿Sobrescribir? Y/N [Y]:")
    local confir = io.read()
    if confir == "" or confir == "Y"
    then
        shell.run("rm", "/"..curdir.."/"..arg[1])
        shell.run("wget", fullfile, arg[1])
    else
        print("Descarga abortada!")
    end
else
    shell.run("wget", fullfile, arg[1])
end