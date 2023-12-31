local fs = require("@lune/fs")
local process = require("@lune/process")

process.spawn("git", { "rm", "-r", "--cached", "src" })
fs.removeDir("src")

fs.writeDir("src")
fs.writeDir("src/Lighting")
fs.writeDir("src/ReplicatedStorage")
fs.writeDir("src/ServerScriptService")
fs.writeDir("src/ServerStorage")
fs.writeDir("src/StarterGui")
fs.writeDir("src/StarterPack")
fs.writeDir("src/StarterPlayer")
fs.writeDir("src/StarterPlayer/StarterCharacterScripts")
fs.writeDir("src/StarterPlayer/StarterPlayerScripts")
fs.writeDir("src/Workspace")
