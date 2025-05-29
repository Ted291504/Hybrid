local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local Notification_Screen = Instance.new("ScreenGui")
Notification_Screen.Name = "Hybrid_Notification"
Notification_Screen.Parent = cloneref(CoreGui)
Notification_Screen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local NotificationsFolder = Instance.new("Folder")
NotificationsFolder.Name = "NotificationsFolder"
NotificationsFolder.Parent = Notification_Screen

local NOTIFICATION_WIDTH = 250
local NOTIFICATION_HEIGHT = 70
local NOTIFICATION_MARGIN = 8
local MAX_NOTIFICATIONS = 4

local activeNotifications = {}

local function createNotification(titleText, descText)
    local frame = Instance.new("Frame")
    frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    frame.BorderSizePixel = 0
    frame.Size = UDim2.new(0, NOTIFICATION_WIDTH, 0, NOTIFICATION_HEIGHT)
    frame.AnchorPoint = Vector2.new(1, 1)
    frame.Position = UDim2.new(1, -10, 1, -10)
    frame.Parent = NotificationsFolder
    frame.ClipsDescendants = true
    frame.BackgroundTransparency = 1

    local uicorner = Instance.new("UICorner", frame)
    uicorner.CornerRadius = UDim.new(0, 8)

    local uistroke = Instance.new("UIStroke", frame)
    uistroke.Color = Color3.fromRGB(40, 40, 40)
    uistroke.Transparency = 1

    local title = Instance.new("TextLabel", frame)
    title.BackgroundTransparency = 1
    title.Position = UDim2.new(0, 12, 0, 8)
    title.Size = UDim2.new(1, -24, 0, 22)
    title.Font = Enum.Font.SourceSansSemibold
    title.Text = titleText or "Notification"
    title.TextColor3 = Color3.fromRGB(230, 230, 230)
    title.TextSize = 18
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.TextTruncate = Enum.TextTruncate.AtEnd

    local desc = Instance.new("TextLabel", frame)
    desc.BackgroundTransparency = 1
    desc.Position = UDim2.new(0, 12, 0, 30)
    desc.Size = UDim2.new(1, -24, 0, 30)
    desc.Font = Enum.Font.SourceSans
    desc.Text = descText or ""
    desc.TextColor3 = Color3.fromRGB(160, 160, 160)
    desc.TextSize = 14
    desc.TextXAlignment = Enum.TextXAlignment.Left
    desc.TextWrapped = true

    local progressBar = Instance.new("Frame", frame)
    progressBar.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    progressBar.BorderSizePixel = 0
    progressBar.Size = UDim2.new(1, -24, 0, 6)
    progressBar.Position = UDim2.new(0, 12, 1, -10)

    local progressCorner = Instance.new("UICorner", progressBar)
    progressCorner.CornerRadius = UDim.new(0, 3)

    local progressBarFill = Instance.new("Frame", progressBar)
    progressBarFill.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
    progressBarFill.BorderSizePixel = 0
    progressBarFill.Size = UDim2.new(1, 0, 1, 0)

    local progressFillCorner = Instance.new("UICorner", progressBarFill)
    progressFillCorner.CornerRadius = UDim.new(0, 3)

    local fadeInTween = TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0
    })
    local strokeInTween = TweenService:Create(uistroke, TweenInfo.new(0.4), {Transparency = 0})
    fadeInTween:Play()
    strokeInTween:Play()

    local dismissed = false
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dismissed = true
        end
    end)

    return frame, progressBarFill, function()
        dismissed = true
    end, function()
        return dismissed
    end
end

local function repositionNotifications()
    for i, notif in ipairs(activeNotifications) do
        local goalPos = UDim2.new(1, -10, 1, -10 - ((NOTIFICATION_HEIGHT + NOTIFICATION_MARGIN) * (i - 1)))
        TweenService:Create(notif, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = goalPos}):Play()
    end
end

local function showNotification(titleText, descText, customTime)
    local duration = tonumber(customTime) or 4
    if #activeNotifications >= MAX_NOTIFICATIONS then
        local oldest = activeNotifications[#activeNotifications]
        if oldest then
            oldest:Destroy()
            table.remove(activeNotifications, #activeNotifications)
        end
    end

    local frame, progressBarFill, dismissFunc, isDismissed = createNotification(titleText, descText)

    table.insert(activeNotifications, 1, frame)
    repositionNotifications()

    local progressTween = TweenService:Create(progressBarFill, TweenInfo.new(duration, Enum.EasingStyle.Linear), {Size = UDim2.new(0, 0, 1, 0)})
    progressTween:Play()

    local timer = 0
    while timer < duration do
        task.wait(0.1)
        timer += 0.1
        if isDismissed() then
            break
        end
    end

    local fadeOutTween = TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
        BackgroundTransparency = 1,
        Position = frame.Position + UDim2.new(0, 200, 0, 0)
    })
    local stroke = frame:FindFirstChildWhichIsA("UIStroke")
    if stroke then
        TweenService:Create(stroke, TweenInfo.new(0.4), {Transparency = 1}):Play()
    end

    progressTween:Cancel()
    fadeOutTween:Play()
    fadeOutTween.Completed:Wait()

    for i, v in ipairs(activeNotifications) do
        if v == frame then
            table.remove(activeNotifications, i)
            break
        end
    end

    frame:Destroy()
    repositionNotifications()
end

return {
    showNotification = showNotification
}
