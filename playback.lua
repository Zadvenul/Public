local character = game:GetService("Players").LocalPlayer.Character
local root = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

local runAnimation = humanoid:LoadAnimation(character:WaitForChild("Animate"):WaitForChild("run"):GetChildren()[1])
local jumpAnimation = humanoid:LoadAnimation(character:WaitForChild("Animate"):WaitForChild("jump"):GetChildren()[1])
local fallAnimation = humanoid:LoadAnimation(character:WaitForChild("Animate"):WaitForChild("fall"):GetChildren()[1])
local idleAnimation = humanoid:LoadAnimation(character:WaitForChild("Animate"):WaitForChild("idle"):GetChildren()[1])
local climbAnimation = humanoid:LoadAnimation(character:WaitForChild("Animate"):WaitForChild("climb"):GetChildren()[1])

local function stopAnimations()
	for _, animationTrack in pairs(humanoid:GetPlayingAnimationTracks()) do
		animationTrack:Stop()
	end
end

local function playAnimation(humanoidState)
	if humanoidState == "r" and runAnimation.IsPlaying == false then
		stopAnimations()
		runAnimation:Play()
	elseif humanoidState == "j" and jumpAnimation.IsPlaying == false then
		stopAnimations()
		jumpAnimation:Play()
	elseif humanoidState == "f" and fallAnimation.IsPlaying == false then
		stopAnimations()
		fallAnimation:Play()
	elseif humanoidState == "i" and idleAnimation.IsPlaying == false then
		stopAnimations()
		idleAnimation:Play()
	elseif humanoidState == "c" and climbAnimation.IsPlaying == false then
		stopAnimations()
		climbAnimation:Play()
	end
end

data = readfile("./RAP/data.txt"):sub(1, -2):gsub("p ", ""):split(" ")

character.Animate.Enabled = false

local frameIndex = 1
heartbeat = game:GetService("RunService").Heartbeat:Connect(function()
    local offset = (frameIndex - 1)*13

    local position = Vector3.new(data[offset+1], data[offset+2], data[offset+3])
	local XVector = Vector3.new(data[offset+4], data[offset+7], data[offset+10])
	local YVector = Vector3.new(data[offset+5], data[offset+8], data[offset+11])
	local ZVector = Vector3.new(data[offset+6], data[offset+9], data[offset+12])

    root.CFrame = CFrame.fromMatrix(position, XVector, YVector, ZVector)

    coroutine.wrap(function()
		playAnimation(data[offset+13])
	end)()

    if frameIndex == #data/13 then
        print("Playback done.")
        heartbeat:Disconnect()
        character.Animate.Enabled = true
    else
        frameIndex += 1
    end
end)