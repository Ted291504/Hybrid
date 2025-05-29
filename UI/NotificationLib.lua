local Notification_Screen = Instance.new("ScreenGui")
Notification_Screen.Name = "Hybrid_Notification"
Notification_Screen.Parent = cloneref(game:GetService("CoreGui"))
Notification_Screen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local Notification = Instance.new("Frame")
Notification.Name = "Notification"
Notification.Parent = Notification_Screen
Notification.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
Notification.BorderSizePixel = 0
Notification.Position = UDim2.new(0.75, 0, 0.82, 0)
Notification.Size = UDim2.new(0, 155, 0, 55)
Notification.Visible = false

local UICorner = Instance.new("UICorner")
UICorner.Parent = Notification

local UIStroke = Instance.new("UIStroke")
UIStroke.Parent = Notification
UIStroke.Color = Color3.fromRGB(35, 35, 35)

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = Notification
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 8, 0, 2)
Title.Size = UDim2.new(1, -16, 0, 20)
Title.Font = Enum.Font.SourceSansSemibold
Title.Text = "Invalid Key!"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.TextWrapped = true
Title.TextXAlignment = Enum.TextXAlignment.Left

local Description = Instance.new("TextLabel")
Description.Name = "Description"
Description.Parent = Notification
Description.BackgroundTransparency = 1
Description.Position = UDim2.new(0, 8, 0, 25)
Description.Size = UDim2.new(1, -16, 0, 20)
Description.Font = Enum.Font.SourceSans
Description.Text = "Your key is invalid!"
Description.TextColor3 = Color3.fromRGB(200, 200, 200)
Description.TextSize = 14
Description.TextWrapped = true
Description.TextXAlignment = Enum.TextXAlignment.Left

local TweenService = game:GetService("TweenService")

function showNotification(titleText, descText)
	local frame = Notification
	local title = frame:FindFirstChild("Title")
	local desc = frame:FindFirstChild("Description")
	local stroke = frame:FindFirstChild("UIStroke")

	if title then title.Text = titleText or "Notification" end
	if desc then desc.Text = descText or "" end

	frame.AnchorPoint = Vector2.new(1, 1)
	frame.Position = UDim2.new(1, 200, 1, -20)
	frame.BackgroundTransparency = 1
	if stroke then stroke.Transparency = 1 end
	frame.Visible = true

	local fadeIn = TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
		Position = UDim2.new(1, -10, 1, -20),
		BackgroundTransparency = 0
	})
	local strokeIn = stroke and TweenService:Create(stroke, TweenInfo.new(0.4), {Transparency = 0})
	fadeIn:Play()
	if strokeIn then strokeIn:Play() end

	task.wait(2.5)

	local fadeOut = TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
		Position = UDim2.new(1, 200, 1, -20),
		BackgroundTransparency = 1
	})
	local strokeOut = stroke and TweenService:Create(stroke, TweenInfo.new(0.4), {Transparency = 1})
	fadeOut:Play()
	if strokeOut then strokeOut:Play() end

	task.wait(0.4)
	frame.Visible = false
end

return {
	showNotification = showNotification
}
