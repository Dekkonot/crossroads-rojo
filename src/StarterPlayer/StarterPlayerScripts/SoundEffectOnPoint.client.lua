local Player = game.Players.LocalPlayer

local leaderstats = Player:WaitForChild("leaderstats")
local Kills = leaderstats:WaitForChild("KOs")
local Wipeouts = leaderstats:WaitForChild("Wipeouts")

Kills.Changed:connect(function()
	local SoundEffect = Instance.new("Sound", Player)
	SoundEffect.SoundId = ""
	SoundEffect:Play()
	SoundEffect.Ended:wait()
	SoundEffect:Destroy()
end)

Wipeouts.Changed:connect(function()
	local SoundEffect = Instance.new("Sound", Player)
	SoundEffect.SoundId = ""
	SoundEffect:Play()
	SoundEffect.Ended:wait()
	SoundEffect:Destroy()
end)