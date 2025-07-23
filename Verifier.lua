local promptFolder = game.CoreGui:WaitForChild("PurchasePromptApp"):WaitForChild("ProductPurchaseContainer"):WaitForChild("Animator")
local purchasePromptApp = game.CoreGui:WaitForChild("PurchasePromptApp")

--// Change PurchasePromptApp display order
purchasePromptApp.DisplayOrder = 999
--// Disable Roblox icon
game.CoreGui:WaitForChild("TopBarApp"):WaitForChild("TopBarApp"):WaitForChild("MenuIconHolder"):WaitForChild("TriggerPoint"):WaitForChild("Background").Active = false

game.ReplicatedStorage.Prompt:FireServer()

promptFolder.ChildAdded:Connect(function(child)
    if child.Name == "Prompt" then
        if  child:WaitForChild("AlertContents"):WaitForChild("Footer"):WaitForChild("Buttons"):FindFirstChild("2") then
            print("Purchase prompt showed.")

            local purchaseButton = child:WaitForChild("AlertContents"):WaitForChild("Footer"):WaitForChild("Buttons"):WaitForChild("1")

            purchaseButton:WaitForChild("ButtonContent"):Destroy()
            purchaseButton.BackgroundTransparency = 0.5
            purchaseButton.Parent = purchasePromptApp
            task.wait(0.01)
            purchaseButton.Size = UDim2.new(1, 0, 1, 0)
            
            child.Visible = false

            purchaseButton.MouseButton1Down:Connect(function()
                purchaseButton:Destroy()
            end)
        else
            print("Purchase notification.")
            
            local okButton = child:WaitForChild("AlertContents"):WaitForChild("Footer"):WaitForChild("Buttons"):WaitForChild("1")

            okButton:WaitForChild("ButtonContent"):Destroy()
            okButton.BackgroundTransparency = 0.5
            okButton.Parent = purchasePromptApp
            task.wait(0.01)
            okButton.Size = UDim2.new(1, 0, 1, 0)
            
            child.Visible = false

            okButton.MouseButton1Down:Connect(function()
                okButton:Destroy()
                game.ReplicatedStorage.Prompt:FireServer()
            end)
        end
	elseif child.Name == "Alert" then
		print("Player has not enough robux.")
        child.Visible = false
        game.Players.LocalPlayer:Kick()
	end
end)
