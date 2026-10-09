local ThemeManager = require(script.Parent:WaitForChild("ThemeManager"))

local Taskbar = {}

function Taskbar:Create(gui, controller)
	local bar = Instance.new("Frame")
	bar.Name = "Taskbar"
	bar.Size = UDim2.new(1, 0, 0, 44)
	bar.Position = UDim2.new(0, 0, 1, -44)
	bar.BackgroundColor3 = ThemeManager:GetColor("BackgroundSecondary")
	bar.BorderSizePixel = 0
	bar.Parent = gui

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 18)
	corner.Parent = bar

	local left = Instance.new("Frame")
	left.Size = UDim2.new(0.35, 0, 1, 0)
	left.Position = UDim2.new(0, 12, 0, 0)
	left.BackgroundTransparency = 1
	left.Parent = bar

	local appButtons = {
		{ "SongBrowser", "Songs" },
		{ "Profile", "Profile" },
		{ "Leaderboard", "Rank" },
		{ "SkinStudio", "Skins" },
		{ "StatsAnalyzer", "Stats" },
		{ "CommunityHub", "Community" },
		{ "Settings", "Settings" },
	}

	for i, item in ipairs(appButtons) do
		local appName, label = item[1], item[2]
		local button = Instance.new("TextButton")
		button.Size = UDim2.new(0, 112, 0, 30)
		button.Position = UDim2.new(0, 10 + (i - 1) * 118, 0.5, -15)
		button.BackgroundColor3 = ThemeManager:GetColor("Panel")
		button.BorderSizePixel = 0
		button.Text = label
		button.TextColor3 = ThemeManager:GetColor("Text")
		button.Font = Enum.Font.GothamSemibold
		button.TextSize = 12
		button.Parent = left
		local btnCorner = Instance.new("UICorner")
		btnCorner.CornerRadius = UDim.new(0, 12)
		btnCorner.Parent = button
		button.MouseButton1Click:Connect(function()
			if controller and controller.OpenApp then
				controller:OpenApp(appName)
			end
		end)
	end

	local clock = Instance.new("TextLabel")
	clock.Size = UDim2.new(0, 120, 1, 0)
	clock.Position = UDim2.new(1, -130, 0, 0)
	clock.BackgroundTransparency = 1
	clock.TextColor3 = ThemeManager:GetColor("TextMuted")
	clock.Font = Enum.Font.GothamMedium
	clock.TextSize = 13
	clock.TextXAlignment = Enum.TextXAlignment.Right
	clock.Parent = bar
	clock.Text = os.date("%I:%M %p")

	local updateClock = function()
		clock.Text = os.date("%I:%M %p")
	end

	local clockConnection = game:GetService("RunService").Heartbeat:Connect(function()
		if tick() % 60 < 0.1 then
			updateClock()
		end
	end)

	bar.Destroying:Connect(function()
		clockConnection:Disconnect()
	end)

	return bar
end

return Taskbar
