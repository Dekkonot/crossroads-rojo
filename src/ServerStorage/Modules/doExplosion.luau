local Modules = game:GetService("ServerStorage"):FindFirstChild("Modules")
local tagHumanoid = require(Modules:FindFirstChild("tagHumanoid"))
local PartsThatHaveBeenHit = {}

local function onExplosionHit(tag, hit)
	local char = hit:FindFirstAncestorWhichIsA("Model")
	if char then
		local humanoid = char:FindFirstChild("Humanoid")
		if humanoid then
			tagHumanoid(tag, humanoid)
			humanoid:TakeDamage(999)
		else
			hit:BreakJoints()
		end
	end
end

return function(tag, position)
	local explosion = Instance.new("Explosion")
	explosion.BlastPressure = 1600000
	explosion.DestroyJointRadiusPercent = 100
	explosion.Position = position
	tag:Clone().Parent = explosion
	explosion.Hit:Connect(function(hit) onExplosionHit(tag, hit) end)
	explosion.Parent = workspace
end