-- @CloneTrooper1019, 2017

local self = script.Parent
local activation = self:WaitForChild("Activation")
local char = self.Parent

local INVALID_SENDING_PLAYER = "Cannot activate a tool that you don't have equipped."
local BAD_ARG_NUM1 = "Argument #1 should be a boolean describing the activation state of the tool."
local BAD_ARG_NUM2 = "Argument #2 should be a CFrame describing the user's target."

local function onChildAdded(child)
	if child:IsA("Tool") then
		child.ManualActivationOnly = true
	end
end

local function onActivationReceive(sendingPlayer,down,target)
	local humanoid = char:FindFirstChildWhichIsA("Humanoid")
	if humanoid then		
		local tool = char:FindFirstChildWhichIsA("Tool")
		if tool then
			local player = game.Players:GetPlayerFromCharacter(char)
			
			assert(sendingPlayer == player, INVALID_SENDING_PLAYER)
			assert(typeof(down) == "boolean", BAD_ARG_NUM1)
			assert(typeof(target) == "CFrame", BAD_ARG_NUM2)
			
			humanoid.TargetPoint = target.p
			
			if down then
				tool:Activate()
			else
				tool:Deactivate()
			end
		end
	end
end

activation.OnServerEvent:Connect(onActivationReceive)
char.ChildAdded:Connect(onChildAdded)