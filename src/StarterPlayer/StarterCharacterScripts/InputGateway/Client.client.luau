-- @CloneTrooper1019, 2017

local UserInputService = game:GetService("UserInputService")
local Debris = game:GetService("Debris")
local Players = game:GetService("Players")

local gateway = script.Parent
local tool = gateway.Parent
local activation = gateway:WaitForChild("Activation")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

local isActive = false

local function activate(active,cf)
	isActive = active
	activation:FireServer(active,cf)
end

local function onInputBegan(input,gameProcessed)
	if not gameProcessed then
		local pass = false
		local name = input.UserInputType.Name
		if name == "MouseButton1" then
			-- Activate, no questions asked.
			pass = true
		elseif name == "Touch" then
			-- This only counts if the user releases their finger right away.
			wait(.1)
			if input.UserInputState == Enum.UserInputState.End then
				pass = true
			end
		elseif name == "Gamepad1" then
			-- Make sure we're pressing the right trigger.
			if input.KeyCode.Name == "ButtonR2" then
				pass = true
			end
		end
		if pass then
			activate(true,mouse.Hit)
		end
	end
end

local function onInputEnded(input,gameProcessed)
	if not gameProcessed and isActive then
		local name = input.UserInputType.Name
		if name == "MouseButton1" or name == "Touch" or name == "Gamepad1" then
			activate(false,mouse.Hit)
		end
	end
end

UserInputService.InputBegan:Connect(onInputBegan)
UserInputService.InputEnded:Connect(onInputEnded)