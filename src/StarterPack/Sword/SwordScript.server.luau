-------- OMG HAX

r = game:service("RunService")


local damage = 5


local slash_damage = 10
local lunge_damage = 30

local function getDamageFrom(hit)
	--damage as a function of hit size (y axis)
	return hit and (math.min(hit.Size.Y, 4) / 5) * damage
end

local Debris = game:GetService("Debris")

Tool = script.Parent
sword = Tool.Handle

local SlashSound = Instance.new("Sound")
SlashSound.SoundId = "rbxasset://sounds\\swordslash.wav"
SlashSound.Parent = sword
SlashSound.Volume = .7

local LungeSound = Instance.new("Sound")
LungeSound.SoundId = "rbxasset://sounds\\swordlunge.wav"
LungeSound.Parent = sword
LungeSound.Volume = .6

local UnsheathSound = Instance.new("Sound")
UnsheathSound.SoundId = "rbxasset://sounds\\unsheath.wav"
UnsheathSound.Parent = sword
UnsheathSound.Volume = 1

local function spawnSound(sound)
	local s = sound:Clone()
	s.Parent = sound.Parent
	s:Play()
	s.Ended:Connect(function ()
		s:Destroy()
	end)
end

function tagHumanoid(humanoid, player)
	local creator_tag = Instance.new("ObjectValue")
	creator_tag.Value = player
	creator_tag.Name = "creator"
	creator_tag.Parent = humanoid
	Debris:AddItem(creator_tag,1)
end

function blow(hit)
	if (hit.Parent == nil) then return end -- happens when bullet hits sword

	local humanoid = hit.Parent:findFirstChild("Humanoid")
	local vCharacter = Tool.Parent
	local vPlayer = game.Players:playerFromCharacter(vCharacter)
	local hum = vCharacter:findFirstChild("Humanoid") -- non-nil if tool held by a character
	if humanoid~=nil and humanoid ~= hum and hum ~= nil then
		-- final check, make sure sword is in-hand

		local right_arm = vCharacter:FindFirstChild("Right Arm") or vCharacter:FindFirstChild("RightHand")
		if (right_arm ~= nil) then
			local joint = right_arm:FindFirstChild("RightGrip")
			if (joint ~= nil and (joint.Part0 == sword or joint.Part1 == sword)) then
				local canDamage = true
				local victim = game.Players:GetPlayerFromCharacter(humanoid.Parent)
				if victim then
					if vPlayer.Team and victim.Team and vPlayer.Team == victim.Team then
						canDamage = false
					end
				end
				if canDamage then
					tagHumanoid(humanoid, vPlayer)
					humanoid:TakeDamage(getDamageFrom(hit))
				end
			end
		end


	end
end

function attack()
	damage = slash_damage
	SlashSound:play()
	local anim = Instance.new("StringValue")
	anim.Name = "toolanim"
	anim.Value = "Slash"
	anim.Parent = Tool
end

function lunge()
	damage = lunge_damage

	LungeSound:play()

	local anim = Instance.new("StringValue")
	anim.Name = "toolanim"
	anim.Value = "Lunge"
	anim.Parent = Tool
	
	
	local force = Instance.new("BodyVelocity")
	force.Velocity = Vector3.new(0,3,0) --Tool.Parent.Torso.CFrame.lookVector * 80
	force.MaxForce = Vector3.new(0,40000,0)
	force.Parent = Tool.Parent:FindFirstChild("HumanoidRootPart")
	wait(.25)
	swordOut()
	wait(.25)
	force.Parent = nil
	wait(.5)
	swordUp()

	damage = slash_damage
end

function swordUp()
	Tool.GripForward = Vector3.new(-1,0,0)
	Tool.GripRight = Vector3.new(0,1,0)
	Tool.GripUp = Vector3.new(0,0,1)
end

function swordOut()
	Tool.GripForward = Vector3.new(0,0,1)
	Tool.GripRight = Vector3.new(0,-1,0)
	Tool.GripUp = Vector3.new(-1,0,0)
end

function swordAcross()
	-- parry
end


Tool.Enabled = true
local last_attack = 0
function onActivated()

	if not Tool.Enabled then
		return
	end

	Tool.Enabled = false

	local character = Tool.Parent;
	local humanoid = character.Humanoid
	if humanoid == nil then
		print("Humanoid not found")
		return 
	end

	t = r.Stepped:wait()

	if (t - last_attack < .2) then
		lunge()
	else
		attack()
	end

	last_attack = t

	--wait(.5)

	Tool.Enabled = true
end


function onEquipped()
	UnsheathSound:play()
end


script.Parent.Activated:connect(onActivated)
script.Parent.Equipped:connect(onEquipped)


connection = sword.Touched:connect(blow)

