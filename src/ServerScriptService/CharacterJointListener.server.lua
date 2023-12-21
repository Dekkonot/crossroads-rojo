local Players = game:GetService("Players")


local function onNewPlayer(newPlayer)
	local Character = newPlayer.Character and newPlayer.CharacterAdded:wait()
	newPlayer.CharacterAdded:connect(function(newCharacter)
		local Humanoid = newCharacter:WaitForChild("Humanoid")
		local RootJoint = newCharacter:WaitForChild("LowerTorso"):WaitForChild("Root")
		RootJoint.AncestryChanged:Connect(function(_, newParent)
			if newParent == nil then
				--kill for our players
				Humanoid.Health = 0
			end
		end)
	end)
end
Players.PlayerAdded:connect(onNewPlayer)

for _, player in pairs(Players:GetPlayers()) do
	onNewPlayer(player)
end