local doExplosion = require(game:GetService("ServerStorage"):FindFirstChild("Modules"):FindFirstChild("doExplosion"))

local updateInterval = .4

local currentColor = 1
local colors = {26, 21} 

local bomb = script.Parent
local debris = game:GetService("Debris")

local ticksound = Instance.new("Sound")
ticksound.SoundId = "rbxasset://sounds\\clickfast.wav"
ticksound.Parent = bomb

local function update()
	updateInterval = updateInterval * .9
	script.Parent.BrickColor = BrickColor.new(colors[currentColor])
	currentColor = currentColor + 1
	if (currentColor > 2) then currentColor = 1 end
end

local function spawnSound(sound)
	local s = sound:clone()
	s.Parent = sound.Parent
	s:Play()
	s.Ended:connect(function ()
		s:Destroy()
	end)
end

function tagHumanoid(humanoid)
	-- todo: make tag expire
	local tag = bomb:findFirstChild("creator")
	if tag ~= nil then
		-- kill all other tags
		while(humanoid:findFirstChild("creator") ~= nil) do
			humanoid:findFirstChild("creator").Parent = nil
		end

		local new_tag = tag:clone()
		new_tag.Parent = humanoid
		debris:AddItem(new_tag, 1)
	end
end

local function onExplosionHit(hit)
	local char = hit:FindFirstAncestorWhichIsA("Model")
	if char then
		local humanoid = char:FindFirstChild("Humanoid")
		if humanoid then
			tagHumanoid(humanoid)
			humanoid:TakeDamage(999)
		end
	end
end

while updateInterval > .1 do
	wait(updateInterval)
	update()	
	spawnSound(ticksound)
end

local sound = Instance.new("Sound")
sound.SoundId = "rbxasset://sounds\\Rocket shot.wav"
sound.Parent = script.Parent
sound.Volume = 1
sound:Play()

local creator = bomb:FindFirstChild("creator")
doExplosion(creator, bomb.Position)

bomb.Transparency = 1
bomb.Anchored = true
bomb.CanCollide = false
sound.Ended:wait()
bomb:Destroy()