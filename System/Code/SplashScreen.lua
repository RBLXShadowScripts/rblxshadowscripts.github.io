local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

local SplashScreen = {}

function SplashScreen:Show(title, imageId, soundId, duration)
    duration = tonumber(duration) or 3

    -- Create GUI
    local gui = Instance.new("ScreenGui")
    gui.Name = "ShadowSplashScreen"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.Parent = game:GetService("CoreGui")

    -- Drop shadow
    local shadow = Instance.new("ImageLabel")
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://1316045217"
    shadow.ImageTransparency = 0.7
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(10,10,118,118)
    shadow.Size = UDim2.new(0, 440, 0, 240)
    shadow.Position = UDim2.new(0.5, -220, 0.5, -120)
    shadow.ZIndex = 0
    shadow.Parent = gui

    -- Main frame
    local frame = Instance.new("Frame")
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Position = UDim2.new(0.5, 0, 0.5, 0)
    frame.Size = UDim2.new(0, 400, 0, 200)
    frame.BackgroundColor3 = Color3.fromRGB(20, 22, 32)
    frame.BackgroundTransparency = 1
    frame.BorderSizePixel = 0
    frame.ZIndex = 1
    frame.Parent = gui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 18)
    corner.Parent = frame

    local borderStroke = Instance.new("UIStroke")
    borderStroke.Thickness = 3
    borderStroke.Color = Color3.fromRGB(80, 255, 180)
    borderStroke.Transparency = 0.2
    borderStroke.Parent = frame

    -- Background image (new feature)
    local bgImage
    if imageId and tostring(imageId) ~= "" then
        bgImage = Instance.new("ImageLabel")
        bgImage.BackgroundTransparency = 1
        bgImage.Image = "rbxassetid://" .. tostring(imageId)
        bgImage.ImageTransparency = 0.7
        bgImage.Size = UDim2.new(1, 0, 1, 0)
        bgImage.Position = UDim2.new(0, 0, 0, 0)
        bgImage.ZIndex = 1
        bgImage.ScaleType = Enum.ScaleType.Crop
        bgImage.Parent = frame
    end

    -- Title
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Text = "<b>" .. (title or "Splash") .. "</b>"
    titleLabel.Font = Enum.Font.GothamBlack
    titleLabel.TextSize = 34
    titleLabel.TextColor3 = Color3.fromRGB(80, 255, 180)
    titleLabel.TextStrokeTransparency = 0.7
    titleLabel.TextTransparency = 1
    titleLabel.RichText = true
    titleLabel.BackgroundTransparency = 1
    titleLabel.Size = UDim2.new(1, 0, 0, 54)
    titleLabel.Position = UDim2.new(0, 0, 0, 18)
    titleLabel.ZIndex = 3
    titleLabel.Parent = frame

    -- Cool underline
    local underline = Instance.new("Frame")
    underline.Size = UDim2.new(0.5, 0, 0, 3)
    underline.Position = UDim2.new(0.25, 0, 0, 62)
    underline.BackgroundColor3 = Color3.fromRGB(80, 255, 180)
    underline.BackgroundTransparency = 1
    underline.ZIndex = 3
    underline.Parent = frame

    local underlineCorner = Instance.new("UICorner")
    underlineCorner.CornerRadius = UDim.new(1, 0)
    underlineCorner.Parent = underline

    -- Optional image (main logo)
    local image
    if imageId and tostring(imageId) ~= "" then
        image = Instance.new("ImageLabel")
        image.Name = "ImageLabel"
        image.BackgroundTransparency = 1
        image.Size = UDim2.new(0, 100, 0, 100)
        image.Position = UDim2.new(0.5, -50, 0, 75)
        image.Image = "rbxassetid://" .. tostring(imageId)
        image.ImageTransparency = 1
        image.ZIndex = 4
        image.Parent = frame

        -- Neon glow
        local glow = Instance.new("ImageLabel")
        glow.BackgroundTransparency = 1
        glow.Image = "rbxassetid://1316045217"
        glow.ImageColor3 = Color3.fromRGB(80, 255, 180)
        glow.ImageTransparency = 0.7
        glow.Size = UDim2.new(1.5, 0, 1.5, 0)
        glow.Position = UDim2.new(-0.25, 0, -0.25, 0)
        glow.ZIndex = 3
        glow.Parent = image
    end

   

    -- Optional sound
    local sound
    if soundId and tostring(soundId) ~= "" then
        sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://" .. tostring(soundId)
        sound.Volume = 1
        sound.Parent = SoundService
        sound:Play()
    end

    -- Animate in
    TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {BackgroundTransparency = 0.08}):Play()
    TweenService:Create(titleLabel, TweenInfo.new(0.6, Enum.EasingStyle.Quad), {TextTransparency = 0}):Play()
    TweenService:Create(underline, TweenInfo.new(0.7, Enum.EasingStyle.Quad), {BackgroundTransparency = 0}):Play()
    TweenService:Create(borderStroke, TweenInfo.new(0.7), {Transparency = 0}):Play()
    if image then
        TweenService:Create(image, TweenInfo.new(0.7, Enum.EasingStyle.Quad), {ImageTransparency = 0}):Play()
    end
    if bgImage then
        TweenService:Create(bgImage, TweenInfo.new(0.7), {ImageTransparency = 0.7}):Play()
    end

    -- Wait, then fade out and cleanup
    task.spawn(function()
        task.wait(duration)
        running = false
        TweenService:Create(frame, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
        TweenService:Create(titleLabel, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
        TweenService:Create(underline, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
        TweenService:Create(borderStroke, TweenInfo.new(0.5), {Transparency = 1}):Play()
        if image then
            TweenService:Create(image, TweenInfo.new(0.5), {ImageTransparency = 1}):Play()
        end
        if bgImage then
            TweenService:Create(bgImage, TweenInfo.new(0.5), {ImageTransparency = 1}):Play()
        end
        TweenService:Create(shadow, TweenInfo.new(0.5), {ImageTransparency = 1}):Play()
        task.wait(0.5)
        if sound then
            sound:Destroy()
        end
        gui:Destroy()
    end)
end

return SplashScreen
