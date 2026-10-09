local ThemeManager = require(script.Parent.Parent:WaitForChild("ThemeManager"))

local MainMenu = {}
MainMenu.title = "Home"
MainMenu.defaultWidth = 900
MainMenu.defaultHeight = 620

function MainMenu:Build(parent, params)
	local shell = Instance.new("Frame")
	shell.Name = "MainMenuShell"
	shell.BackgroundTransparency = 1
	shell.Size = UDim2.new(1, 0, 1, 0)
	shell.Parent = parent

	local header = Instance.new("Frame")
	header.Size = UDim2.new(1, -30, 0, 110)
	header.Position = UDim2.new(0, 15, 0, 14)
	header.BackgroundColor3 = ThemeManager:GetColor("PanelSoft")
	header.BorderSizePixel = 0
	header.Parent = shell
	local headerCorner = Instance.new("UICorner")
	headerCorner.CornerRadius = UDim.new(0, 20)
	headerCorner.Parent = header

	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(0.7, 0, 0, 36)
	title.Position = UDim2.new(0, 20, 0, 18)
	title.BackgroundTransparency = 1
	title.Text = "RhythmOS Dashboard"
	title.Font = Enum.Font.GothamBold
	title.TextSize = 28
	title.TextColor3 = ThemeManager:GetColor("Text")
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.Parent = header

	local subtitle = Instance.new("TextLabel")
	subtitle.Size = UDim2.new(0.7, 0, 0, 24)
	subtitle.Position = UDim2.new(0, 20, 0, 56)
	subtitle.BackgroundTransparency = 1
	subtitle.Text = "Your rhythm operating system"
	subtitle.Font = Enum.Font.Gotham
	subtitle.TextSize = 14
	subtitle.TextColor3 = ThemeManager:GetColor("TextMuted")
	subtitle.TextXAlignment = Enum.TextXAlignment.Left
	subtitle.Parent = header

	local search = Instance.new("TextBox")
	search.Size = UDim2.new(0, 240, 0, 32)
	search.Position = UDim2.new(1, -270, 0, 34)
	search.BackgroundColor3 = ThemeManager:GetColor("Panel")
	search.Text = "Search everything..."
	search.TextColor3 = ThemeManager:GetColor("TextMuted")
	search.BorderSizePixel = 0
	search.Font = Enum.Font.Gotham
	search.TextSize = 14
	search.Parent = header
	local searchCorner = Instance.new("UICorner")
	searchCorner.CornerRadius = UDim.new(0, 12)
	searchCorner.Parent = search

	local grid = Instance.new("Frame")
	grid.Size = UDim2.new(1, -30, 1, -150)
	grid.Position = UDim2.new(0, 15, 0, 135)
	grid.BackgroundTransparency = 1
	grid.Parent = shell

	local cards = {
		{ "Current Rank", "#12 Global", ThemeManager:GetColor("Accent") },
		{ "Friends Online", "27 online", ThemeManager:GetColor("Mint") },
		{ "Recent Scores", "6 top plays", ThemeManager:GetColor("Sky") },
		{ "Achievements", "18 unlocked", ThemeManager:GetColor("Pink") },
		{ "Trending Songs", "7 new picks", ThemeManager:GetColor("Orange") },
		{ "Season Progress", "82%", ThemeManager:GetColor("AccentSoft") },
	}

	for i, cardInfo in ipairs(cards) do
		local card = Instance.new("Frame")
		card.Size = UDim2.new(0, 240, 0, 150)
		card.Position = UDim2.new(0, 10 + ((i - 1) % 3) * 250, 0, 8 + math.floor((i - 1) / 3) * 165)
		card.BackgroundColor3 = ThemeManager:GetColor("PanelSoft")
		card.BorderSizePixel = 0
		card.Parent = grid
		local cardCorner = Instance.new("UICorner")
		cardCorner.CornerRadius = UDim.new(0, 18)
		cardCorner.Parent = card

		local icon = Instance.new("Frame")
		icon.Size = UDim2.new(0, 42, 0, 42)
		icon.Position = UDim2.new(0, 18, 0, 18)
		icon.BackgroundColor3 = cardInfo[3]
		icon.BorderSizePixel = 0
		icon.Parent = card
		local iconCorner = Instance.new("UICorner")
		iconCorner.CornerRadius = UDim.new(1, 0)
		iconCorner.Parent = icon

		local heading = Instance.new("TextLabel")
		heading.Size = UDim2.new(1, -28, 0, 20)
		heading.Position = UDim2.new(0, 18, 0, 76)
		heading.BackgroundTransparency = 1
		heading.Text = cardInfo[1]
		heading.Font = Enum.Font.Gotham
		heading.TextSize = 13
		heading.TextColor3 = ThemeManager:GetColor("TextMuted")
		heading.TextXAlignment = Enum.TextXAlignment.Left
		heading.Parent = card

		local value = Instance.new("TextLabel")
		value.Size = UDim2.new(1, -28, 0, 28)
		value.Position = UDim2.new(0, 18, 0, 100)
		value.BackgroundTransparency = 1
		value.Text = cardInfo[2]
		value.Font = Enum.Font.GothamBold
		value.TextSize = 18
		value.TextColor3 = ThemeManager:GetColor("Text")
		value.TextXAlignment = Enum.TextXAlignment.Left
		value.Parent = card
	end
end

return MainMenu
