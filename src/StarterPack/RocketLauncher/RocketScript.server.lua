local doExplosion = require(game:GetService("ServerStorage"):FindFirstChild("Modules"):FindFirstChild("doExplosion"))

r = game:service("RunService")

shaft = script.Parent
position = Vector3.new(0,0,0)
debris = game:GetService("Debris")

function fly()
	local direction = shaft.CFrame.lookVector
	position = position + direction
	shaft.Velocity = position - shaft.Position
end

function blow(hit)
	local canExplode = true
	local char = hit:FindFirstAncestorWhichIsA("Model")
	if char then
		local humanoid = char:FindFirstChild("Humanoid")
		if humanoid then
			local tag = shaft:FindFirstChild("creator")
			local player = game.Players:GetPlayerFromCharacter(char)
			if tag and player and tag.Value == player then
				warn("Can't explode")
				canExplode = false
			end
		end
	end
	if canExplode then
		swoosh:Stop()
		local tag = shaft:FindFirstChild("creator")
		if tag then
			doExplosion(tag, shaft.Position)
			connection:disconnect()
			shaft.Explosion:Play()
			shaft.Anchored = true
			shaft.CanCollide = false
			shaft.Transparency = 1
			
			shaft.Explosion:Play()
			shaft.Explosion.Ended:Wait()
			shaft:Destroy()
		end
	end
end

t, s = r.Stepped:wait()

swoosh = script.Parent.Swoosh
swoosh:Play()

position = shaft.Position
d = t + 10.0 - s
connection = shaft.Touched:connect(blow)

while t < d do
	fly()
	t = r.Stepped:wait()
end

swoosh:Stop()
shaft:remove()
