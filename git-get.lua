local repo = "https://raw.githubusercontent.com/firex20/MinecraftLua/main/"
local fullfile = repo..arg[1]
shell.run("wget", fullfile, arg[1])