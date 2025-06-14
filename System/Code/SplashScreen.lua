local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

local SplashScreen = {}

function SplashScreen:Show(title, imageId, soundId, duration)
    duration = tonumber(duration) or 3

    local gui = Instance.new("ScreenGui")
    gui.Name = "ShadowSplashScreen"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.Parent = game:GetService("CoreGui")

    local frame = Instance.new("Frame")
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Position = UDim2.new(0.5, 0, 0.5, 0)
    frame.Size = UDim2.new(0, 400, 0, 200)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    frame.BackgroundTransparency = 0.1
    frame.BorderSizePixel = 0
    frame.Parent = gui

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Text = title or "Splash"
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 32
    titleLabel.TextColor3 = Color3.fromRGB(255,255,255)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Size = UDim2.new(1, 0, 0, 50)
    titleLabel.Position = UDim2.new(0, 0, 0, 20)
    titleLabel.Parent = frame

    if imageId and tostring(imageId) ~= "" then
        local image = Instance.new("ImageLabel")
        image.BackgroundTransparency = 1
        image.Size = UDim2.new(0, 100, 0, 100)
        image.Position = UDim2.new(0.5, -50, 0, 70)
        image.Image = "rbxassetid://" .. tostring(imageId)
        image.Parent = frame
    end

    local sound
    if soundId and tostring(soundId) ~= "" then
        sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://" .. tostring(soundId)
        sound.Volume = 1
        sound.Parent = SoundService
        sound:Play()
    end

    frame.BackgroundTransparency = 1
    titleLabel.TextTransparency = 1
    if frame:FindFirstChildOfClass("ImageLabel") then
        frame.ImageLabel.ImageTransparency = 1
    end

    TweenService:Create(frame, TweenInfo.new(0.5), {BackgroundTransparency = 0.1}):Play()
    TweenService:Create(titleLabel, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
    if frame:FindFirstChildOfClass("ImageLabel") then
        TweenService:Create(frame.ImageLabel, TweenInfo.new(0.5), {ImageTransparency = 0}):Play()
    end

    task.spawn(function()
        task.wait(duration)
        TweenService:Create(frame, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
        TweenService:Create(titleLabel, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
        if frame:FindFirstChildOfClass("ImageLabel") then
            TweenService:Create(frame.ImageLabel, TweenInfo.new(0.5), {ImageTransparency = 1}):Play()
        end
        task.wait(0.5)
        if sound then
            sound:Destroy()
        end
        gui:Destroy()
    end)
end

return SplashScreen
