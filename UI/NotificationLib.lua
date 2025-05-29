local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")

local key_info_link = "https://keysystem-s10c.onrender.com/keyinfo/"
local notificationUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Ted291504/Hybrid/main/UI/Notification.lua", true))()

_G.key_expiration = ""
_G.ip_address = ""
_G.Key = ""
_G.time_left = ""
_G.success = false

function get_info()
	local ipSuccess, ip = pcall(function()
		return game:HttpGet("https://api.ipify.org")
	end)

	if not ipSuccess or not ip or ip == "" then
		warn("Failed to get User Info. Please contact owner!")
		return false
	end

	local key_info = key_info_link .. HttpService:UrlEncode(ip)
	local success, response = pcall(function()
		return game:HttpGet(key_info)
	end)

	if success and response then
		local data = HttpService:JSONDecode(response)
		if data.success then
			_G.key_expiration = data.expiration
			_G.ip_address = data.ip_address
			_G.Key = data.key
			_G.time_left = data.time_left
			_G.success = data.success
			return true
		else
			warn("Invalid key data. Please contact owner!")
		end
	else
		warn("Failed to access key info. Please contact owner!")
	end

	return false
end

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
