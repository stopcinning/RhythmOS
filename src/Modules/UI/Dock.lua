local ThemeManager = require(script.Parent.Parent:WaitForChild("ThemeManager"))

local Dock = {}

function Dock:Create(gui, controller)
	local dock = Instance.new("Frame")
	dock.Name = "Dock"
	dock.Size = UDim2.new(0, 90, 0.75, 0)
	dock.Position = UDim2.new(0, 18, 0.13, 0)
	dock.BackgroundColor3 = ThemeManager:GetColor("Panel")
	dock.BorderSizePixel = 0
	dock.Parent = gui

	local dockCorner = Instance.new("UICorner")
	dockCorner.CornerRadius = UDim.new(0, 20)
	dockCorner.Parent = dock

	local icons = {
		{ "SongBrowser", "♫" },
		{ "Profile", "P" },
		{ "Leaderboard", "L" },
		{ "SkinStudio", "S" },
		{ "StatsAnalyzer", "A" },
		{ "CommunityHub", "C" },
		{ "Settings", "⚙" },
	}

	for i, info in ipairs(icons) do
		local appName, symbol = info[1], info[2]
		local button = Instance.new("TextButton")
		button.Size = UDim2.new(1, -20, 0, 52)
		button.Position = UDim2.new(0, 10, 0, 12 + (i - 1) * 58)
		button.BackgroundColor3 = ThemeManager:GetColor("PanelSoft")
		button.BorderSizePixel = 0
		button.Font = Enum.Font.GothamBold
		button.TextColor3 = ThemeManager:GetColor("Text")
		button.TextSize = 22
		button.Text = symbol
		button.Parent = dock
		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(0, 16)
		corner.Parent = button
		button.MouseButton1Click:Connect(function()
			if controller and controller.OpenApp then
				controller:OpenApp(appName)
			end
		end)
	end

	return dock
end

return Dock
