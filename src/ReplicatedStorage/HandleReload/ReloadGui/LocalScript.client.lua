local ScreenGui = script.Parent
local Progress = ScreenGui:FindFirstChild("Progress", true)
local Container = ScreenGui:FindFirstChild("Container", true)
local function ResizeProgress()
	Progress.Size = UDim2.new(0, Container.AbsoluteSize.X, 0, Container.AbsoluteSize.Y)
end

Container:GetPropertyChangedSignal("AbsoluteSize"):connect(ResizeProgress)
ResizeProgress()