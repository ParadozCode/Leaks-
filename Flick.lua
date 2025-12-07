
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local HRP = character:WaitForChild("HumanoidRootPart")
local camera = workspace.CurrentCamera

local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")


local gui = Instance.new("ScreenGui")
gui.Name = "FlickGUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local btn = Instance.new("ImageButton")
btn.Name = "FlickButton"
btn.Size = UDim2.new(0, 40, 0, 40)
btn.Position = UDim2.new(0.5, -20, 0.06, 0)
btn.BackgroundTransparency = 1
btn.Image = "rbxassetid://0"
btn.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(1, 0)
corner.Parent = btn

local stroke = Instance.new("UIStroke")
stroke.Thickness = 2
stroke.Color = Color3.fromRGB(0, 35, 160)
stroke.Transparency = 0.15
stroke.Parent = btn

local lbl = Instance.new("TextLabel")
lbl.Size = UDim2.new(1, 0, 1, 0)
lbl.BackgroundTransparency = 1
lbl.Text = "Flick"  -- full word now
lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
lbl.Font = Enum.Font.GothamBold
lbl.TextScaled = true
lbl.Parent = btn


local snd = Instance.new("Sound")
snd.SoundId = "rbxassetid://1673280232"
snd.Volume = 1
snd.Parent = btn


local flicking = false
local flickAngle = math.rad(65)  -- MUCH STRONGER flick

btn.MouseButton1Click:Connect(function()
	if flicking then return end
	flicking = true

	snd:Play()

	
	local camStart = camera.CFrame
	local hrpStart = HRP.CFrame

	
	local camOut = TweenService:Create(camera, TweenInfo.new(0.18, Enum.EasingStyle.Quad), {
		CFrame = camStart * CFrame.Angles(0, flickAngle, 0)
	})

	local bodyOut = TweenService:Create(HRP, TweenInfo.new(0.18, Enum.EasingStyle.Quad), {
		CFrame = hrpStart * CFrame.Angles(0, flickAngle, 0)
	})

	
	local camBack = TweenService:Create(camera, TweenInfo.new(0.18, Enum.EasingStyle.Quad), {
		CFrame = camStart
	})

	local bodyBack = TweenService:Create(HRP, TweenInfo.new(0.18, Enum.EasingStyle.Quad), {
		CFrame = hrpStart
	})

	camOut:Play()
	bodyOut:Play()
	camOut.Completed:Wait()

	camBack:Play()
	bodyBack:Play()
	bodyBack.Completed:Wait()

	flicking = false
end)

local dragging = false
local dragStart
local startPos

btn.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = btn.Position
	end
end)

btn.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.Touch then
		local pos = input.Position
		local abs = btn.AbsolutePosition
		local size = btn.AbsoluteSize

		if pos.X >= abs.X and pos.X <= abs.X + size.X and pos.Y >= abs.Y and pos.Y <= abs.Y + size.Y then
			local delta = pos - dragStart
			btn.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end
end)
