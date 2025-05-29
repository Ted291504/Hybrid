local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")

local notificationUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Ted291504/Hybrid/main/UI/Notification.lua", true))()
local function showNotification(titleText, descText)
	local frame = notificationUI
	local title = frame:FindFirstChild("Title")
	local desc = frame:FindFirstChild("Description")
	local stroke = frame:FindFirstChild("UIStroke")

	if title then title.Text = titleText or "Notification" end
	if desc then desc.Text = descText or "" end

	frame.AnchorPoint = Vector2.new(1, 1)
	frame.Position = UDim2.new(1, 200, 1, -10)
	frame.BackgroundTransparency = 1
	if stroke then stroke.Transparency = 1 end
	frame.Visible = true

	local fadeIn = TweenService:Create(frame, TweenInfo.new(0.3), {BackgroundTransparency = 0})
	local slideIn = TweenService:Create(frame, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Position = UDim2.new(1, -10, 1, -10)
	})
	fadeIn:Play()
	if stroke then
		TweenService:Create(stroke, TweenInfo.new(0.3), {Transparency = 0}):Play()
	end
	slideIn:Play()
	slideIn.Completed:Wait()

	task.wait(2)

	local fadeOut = TweenService:Create(frame, TweenInfo.new(0.3), {BackgroundTransparency = 1})
	local slideOut = TweenService:Create(frame, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
		Position = UDim2.new(1, 200, 1, -10)
	})
	fadeOut:Play()
	if stroke then
		TweenService:Create(stroke, TweenInfo.new(0.3), {Transparency = 1}):Play()
	end
	slideOut:Play()
	slideOut.Completed:Wait()
	frame.Visible = false
end
