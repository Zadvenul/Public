_G.CAP_IsPlaying = true

local character = game:GetService("Players").LocalPlayer.Character
local root = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

local runAnimationTrack = humanoid:LoadAnimation(character:WaitForChild("Animate"):WaitForChild("run"):GetChildren()[1])
local jumpAnimationTrack = humanoid:LoadAnimation(character:WaitForChild("Animate"):WaitForChild("jump"):GetChildren()[1])
local fallAnimationTrack = humanoid:LoadAnimation(character:WaitForChild("Animate"):WaitForChild("fall"):GetChildren()[1])
local idleAnimationTrack = humanoid:LoadAnimation(character:WaitForChild("Animate"):WaitForChild("idle"):GetChildren()[1])
local climbAnimationTrack = humanoid:LoadAnimation(character:WaitForChild("Animate"):WaitForChild("climb"):GetChildren()[1])

local function stopAnimations()
	for _, animationTrack in pairs(humanoid:GetPlayingAnimationTracks()) do
		animationTrack:Stop()
	end
end

local function playAnimation(humanoidState)
	if humanoidState == "r" and runAnimationTrack.IsPlaying == false then
		stopAnimations()
		runAnimationTrack:Play()
	elseif humanoidState == "j" and jumpAnimationTrack.IsPlaying == false then
		stopAnimations()
		jumpAnimationTrack:Play()
	elseif humanoidState == "f" and jumpAnimationTrack.IsPlaying == false then
		stopAnimations()
		fallAnimationTrack:Play()
	elseif humanoidState == "i" and idleAnimationTrack.IsPlaying == false then
		stopAnimations()
		idleAnimationTrack:Play()
	elseif humanoidState == "c" and climbAnimationTrack.IsPlaying == false then
		stopAnimations()
		climbAnimationTrack:Play()
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

	playAnimation(data[offset+13])

    if frameIndex == #data/13 then
        print("Playback done.")
        heartbeat:Disconnect()
		runAnimationTrack:Destroy()
		jumpAnimationTrack:Destroy()
		fallAnimationTrack:Destroy()
		idleAnimationTrack:Destroy()
		climbAnimationTrack:Destroy()
        character.Animate.Enabled = true
		_G.CAP_IsPlaying = false
    else
        frameIndex += 1
    end
end)

