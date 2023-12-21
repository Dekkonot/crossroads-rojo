local HandleReload = {}

local TweenService = game:GetService("TweenService")
local Gui = script:WaitForChild("ReloadGui")

local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

function HandleReload.new(Tool, ReloadTime)
	local Character = Player.Character
	local myScreenGui = Gui:Clone()
	local AncestryConnection = Tool.AncestryChanged:Connect(function(old, new)
		myScreenGui.Enabled = new == Character
	end)
	myScreenGui.Parent = PlayerGui
	local myTweenInfo = TweenInfo.new(ReloadTime, Enum.EasingStyle.Linear)
	local myTween = TweenService:Create(myScreenGui:FindFirstChild("ProgressFrame", true), myTweenInfo, {Size = UDim2.new(1, 0, 1, 0)})
	myTween:Play()
	myTween.Completed:connect(function()
		--could be flashier
		myScreenGui:Destroy()
		AncestryConnection:Disconnect()
	end)
end







return HandleReload