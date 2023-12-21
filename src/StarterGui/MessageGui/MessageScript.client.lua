-- @CloneTrooper1019, 2017
-- This restores a legacy functionality where you could put a message inside of a Player,
-- and that message would be drawn on their screen.

local player = game.Players.LocalPlayer
local gui = script.Parent
local msgLabel = gui:WaitForChild("MessageLabel")
local inMessage = false

local function onChildAdded(child)
	if child:IsA("Message") and not inMessage then
		inMessage = true
		msgLabel.Text = child.Text
		msgLabel:TweenPosition(UDim2.new(0.5,0,0.875,0),"Out","Back",0.5,true)
		while child.Parent == player do
			local prop = child.Changed:Wait()
			if prop == "Text" then
				msgLabel.Text = child.Text
			end
		end
		msgLabel:TweenPosition(UDim2.new(0.5,0,1.25,0),"Out","Back",0.5,true)
		inMessage = false
	end
end

player.ChildAdded:Connect(onChildAdded)