local Notification_Screen = Instance.new("ScreenGui")
Notification_Screen.Name = "Hybrid_Notification"
Notification_Screen.Parent = cloneref(game:GetService("CoreGui"))
Notification_Screen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local Notification = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local UIStroke = Instance.new("UIStroke")
local Title = Instance.new("TextLabel")
local Description = Instance.new("TextLabel")

Notification.Name = "Notification"
Notification.Parent = Notification_Screen
Notification.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
Notification.BorderSizePixel = 0
Notification.Position = UDim2.new(0.75, 0, 0.82, 0)
Notification.Size = UDim2.new(0, 155, 0, 55)

UICorner.Parent = Notification

UIStroke.Parent = Notification
UIStroke.Color = Color3.fromRGB(35, 35, 35)

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
