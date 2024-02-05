local Ball = script.Parent
local damage = 40

local r = game:service("RunService")
local debris = game:GetService("Debris")

local last_sound_time = tick()
local originTick = tick()

local function spawnSound(sound)
	local s = sound:Clone()
	s.Parent = sound.Parent
	s:Play()
	s.Ended:Connect(function ()
		s:Destroy()
	end)
end

function onTouched(hit)
	local hitChar = hit:FindFirstAncestorWhichIsA("Model")
	local humanoid = hitChar:FindFirstChildWhichIsA("Humanoid")	
	if humanoid ~=nil then
		local canDamage = true
		local tag = Ball:FindFirstChild("creator")
		if tag then
			local creator = tag.Value
			local player = game.Players:GetPlayerFromCharacter(hitChar)
			if creator and player then
				if creator.Team and player.Team and creator.Team == player.Team then
					canDamage = false
				end
				if creator == player then
					local myTick = tick()
					print(myTick - originTick)
					if myTick - originTick >= 1 then
						canDamage = true
					else
						canDamage = false
					end
				end
			end
		end
		
		if canDamage then
			if connection then 
				connection:disconnect() 
			end
			--Ball.Boing:play()
			spawnSound(Ball.Boing)
			tagHumanoid(humanoid)
			humanoid:TakeDamage(damage)
			if humanoid.RootPart then
				local apply = (Ball.Position - humanoid.RootPart.Position).unit * (Ball.Velocity/4)
				humanoid.RootPart.Velocity = humanoid.RootPart.Velocity + apply
				humanoid.RootPart.RotVelocity = humanoid.RootPart.RotVelocity + apply
			end
		end
	else
		local now = tick()
		if (now - last_sound_time > .1) then
			Ball.Boing:play()
			last_sound_time = now
			damage = damage / 2
			if damage < 2 then
				if connection then 
					connection:disconnect() 
				end
			end
		end
	end
end

function tagHumanoid(humanoid)	
	local tag = Ball:findFirstChild("creator")
	if tag ~= nil then
		local new_tag = tag:clone()
		new_tag.Parent = humanoid
		debris:AddItem(new_tag, 4)
	end
end


connection = Ball.Touched:connect(onTouched)

wait(5)

Ball:Destroy()