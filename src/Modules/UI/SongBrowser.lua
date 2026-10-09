local ThemeManager = require(script.Parent.Parent:WaitForChild("ThemeManager"))

local SongBrowser = {}
SongBrowser.title = "Song Browser"
SongBrowser.defaultWidth = 930
SongBrowser.defaultHeight = 620

function SongBrowser:Build(parent, params)
	local shell = Instance.new("Frame")
	shell.BackgroundTransparency = 1
	shell.Size = UDim2.new(1, 0, 1, 0)
	shell.Parent = parent

	local left = Instance.new("Frame")
	left.Size = UDim2.new(0, 310, 1, -16)
	left.Position = UDim2.new(0, 12, 0, 8)
	left.BackgroundColor3 = ThemeManager:GetColor("PanelSoft")
	left.BorderSizePixel = 0
	left.Parent = shell
	local leftCorner = Instance.new("UICorner")
	leftCorner.CornerRadius = UDim.new(0, 20)
	leftCorner.Parent = left

	local search = Instance.new("TextBox")
	search.Size = UDim2.new(1, -24, 0, 36)
	search.Position = UDim2.new(0, 12, 0, 12)
	search.BackgroundColor3 = ThemeManager:GetColor("Panel")
	search.BorderSizePixel = 0
	search.Text = "Search songs..."
	search.TextColor3 = ThemeManager:GetColor("TextMuted")
	search.Font = Enum.Font.Gotham
	search.TextSize = 14
	search.Parent = left
	local sc = Instance.new("UICorner")
	sc.CornerRadius = UDim.new(0, 12)
	sc.Parent = search

	local list = Instance.new("ScrollingFrame")
	list.Size = UDim2.new(1, -18, 1, -60)
	list.Position = UDim2.new(0, 9, 0, 60)
	list.BackgroundTransparency = 1
	list.BorderSizePixel = 0
	list.ScrollBarThickness = 6
	list.Parent = left

	local songs = {
		"Lunar Bloom",
		"Daydream Circuit",
		"Neon Petals",
		"Cherry Sync",
		"Flowing Pulse",
		"Virtual Haze",
		"Misty Arcade",
	}

	for i, song in ipairs(songs) do
		local row = Instance.new("TextButton")
		row.Size = UDim2.new(1, -8, 0, 52)
		row.Position = UDim2.new(0, 4, 0, 6 + (i - 1) * 56)
		row.BackgroundColor3 = ThemeManager:GetColor("Panel")
		row.BorderSizePixel = 0
		row.Text = song
		row.TextColor3 = ThemeManager:GetColor("Text")
		row.Font = Enum.Font.GothamSemibold
		row.TextSize = 15
		row.TextXAlignment = Enum.TextXAlignment.Left
		row.Parent = list
		local rc = Instance.new("UICorner")
		rc.CornerRadius = UDim.new(0, 14)
		rc.Parent = row
	end

	local right = Instance.new("Frame")
	right.Size = UDim2.new(1, -338, 1, -16)
	right.Position = UDim2.new(0, 330, 0, 8)
	right.BackgroundColor3 = ThemeManager:GetColor("PanelSoft")
	right.BorderSizePixel = 0
	right.Parent = shell
	local rc = Instance.new("UICorner")
	rc.CornerRadius = UDim.new(0, 20)
	rc.Parent = right

	local artwork = Instance.new("Frame")
	artwork.Size = UDim2.new(1, -30, 0, 220)
	artwork.Position = UDim2.new(0, 15, 0, 16)
	artwork.BackgroundColor3 = ThemeManager:GetColor("Accent")
	artwork.BorderSizePixel = 0
	artwork.Parent = right
	local artCorner = Instance.new("UICorner")
	artCorner.CornerRadius = UDim.new(0, 20)
	artCorner.Parent = artwork

	local titleLabel = Instance.new("TextLabel")
	titleLabel.Size = UDim2.new(1, -30, 0, 30)
	titleLabel.Position = UDim2.new(0, 15, 0, 255)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = "Lunar Bloom"
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.TextSize = 24
	titleLabel.TextColor3 = ThemeManager:GetColor("Text")
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.Parent = right

	local meta = Instance.new("TextLabel")
	meta.Size = UDim2.new(1, -30, 0, 20)
	meta.Position = UDim2.new(0, 15, 0, 290)
	meta.BackgroundTransparency = 1
	meta.Text = "Artist • 180 BPM • 4K • 3 difficulties"
	meta.Font = Enum.Font.Gotham
	meta.TextSize = 13
	meta.TextColor3 = ThemeManager:GetColor("TextMuted")
	meta.TextXAlignment = Enum.TextXAlignment.Left
	meta.Parent = right

	local playButton = Instance.new("TextButton")
	playButton.Size = UDim2.new(0, 160, 0, 42)
	playButton.Position = UDim2.new(0, 15, 0, 330)
	playButton.BackgroundColor3 = ThemeManager:GetColor("Accent")
	playButton.BorderSizePixel = 0
	playButton.Text = "Play"
	playButton.TextColor3 = Color3.new(1, 1, 1)
	playButton.Font = Enum.Font.GothamBold
	playButton.TextSize = 16
	playButton.Parent = right
	local playCorner = Instance.new("UICorner")
	playCorner.CornerRadius = UDim.new(0, 14)
	playCorner.Parent = playButton
end

return SongBrowser
