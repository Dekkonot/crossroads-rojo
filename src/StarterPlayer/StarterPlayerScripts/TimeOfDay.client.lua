local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

local function stepTime()
	Lighting.ClockTime = (tick()/4) % 24
end

RunService:BindToRenderStep("StepTime",1000,stepTime)