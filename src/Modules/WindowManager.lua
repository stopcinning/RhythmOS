local ThemeManager = require(script.Parent:WaitForChild("ThemeManager"))

local WindowManager = {
	windows = {},
	root = nil,
	nextZIndex = 100,
}

function WindowManager:Initialize(gui)
	self.root = gui
end

function WindowManager:BringToFront(window)
	self.nextZIndex += 1
	window.ZIndex = self.nextZIndex
	for _, otherWindow in ipairs(self.windows) do
		if otherWindow ~= window then
			otherWindow.ZIndex = math.max(otherWindow.ZIndex or 1, 1)
		end
	end
end

function WindowManager:CreateWindow(config)
	if not self.root then
		warn("WindowManager:Initialize() must be called before CreateWindow")
		return nil
	end

	local window = Instance.new("Frame")
	window.Name = config.title or "Window"
	window.Size = UDim2.new(0, config.width or 760, 0, config.height or 500)
	window.Position = UDim2.new(0.5, -(config.width or 760) / 2, 0.5, -(config.height or 500) / 2)
	window.BackgroundColor3 = ThemeManager:GetColor("Panel")
	window.BorderSizePixel = 0
	window.Parent = self.root
	window.ZIndex = self.nextZIndex + 1
	self.nextZIndex += 1

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 20)
	corner.Parent = window

	local shadow = Instance.new("ImageLabel")
	shadow.Name = "Shadow"
	shadow.BackgroundTransparency = 1
	shadow.Image = "rbxassetid://131604521"
	shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
	shadow.ImageTransparency = 0.45
	shadow.ScaleType = Enum.ScaleType.Slice
	shadow.SliceCenter = Rect.new(10, 10, 118, 118)
	shadow.Size = UDim2.new(1, 26, 1, 26)
	shadow.Position = UDim2.new(0, -13, 0, -13)
	shadow.ZIndex = window.ZIndex - 1
	shadow.Parent = window

	local titleBar = Instance.new("Frame")
	titleBar.Name = "TitleBar"
	titleBar.Size = UDim2.new(1, 0, 0, 42)
	titleBar.BackgroundColor3 = ThemeManager:GetColor("PanelSoft")
	titleBar.BorderSizePixel = 0
	titleBar.Parent = window

	local titleCorner = Instance.new("UICorner")
	titleCorner.CornerRadius = UDim.new(0, 20)
	titleCorner.Parent = titleBar

	local titleText = Instance.new("TextLabel")
	titleText.Name = "Title"
	titleText.Text = config.title or "Window"
	titleText.TextColor3 = ThemeManager:GetColor("Text")
	titleText.Font = Enum.Font.GothamSemibold
	titleText.TextSize = 15
	titleText.BackgroundTransparency = 1
	titleText.Position = UDim2.new(0, 16, 0, 0)
	titleText.Size = UDim2.new(1, -110, 1, 0)
	titleText.TextXAlignment = Enum.TextXAlignment.Left
	titleText.Parent = titleBar

	local closeButton = Instance.new("TextButton")
	closeButton.Name = "CloseButton"
	closeButton.Size = UDim2.new(0, 24, 0, 24)
	closeButton.Position = UDim2.new(1, -34, 0.5, -12)
	closeButton.BackgroundColor3 = ThemeManager:GetColor("Danger")
	closeButton.Text = "X"
	closeButton.TextColor3 = Color3.new(1, 1, 1)
	closeButton.Font = Enum.Font.GothamBold
	closeButton.TextSize = 14
	closeButton.BorderSizePixel = 0
	closeButton.Parent = titleBar
	local closeCorner = Instance.new("UICorner")
	closeCorner.CornerRadius = UDim.new(1, 0)
	closeCorner.Parent = closeButton
	closeButton.MouseButton1Click:Connect(function()
		window:Destroy()
		for i = #self.windows, 1, -1 do
			if self.windows[i] == window then
				table.remove(self.windows, i)
				break
			end
		end
	end)

	local content = Instance.new("Frame")
	content.Name = "Content"
	content.Position = UDim2.new(0, 0, 0, 42)
	content.Size = UDim2.new(1, 0, 1, -42)
	content.BackgroundTransparency = 1
	content.Parent = window

	local dragToggle = false
	local dragStart, startPos

	titleBar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragToggle = true
			dragStart = input.Position
			startPos = window.Position
		end
	end)

	titleBar.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragToggle = false
		end
	end)

	game:GetService("UserInputService").InputChanged:Connect(function(input)
		if dragToggle and input.UserInputType == Enum.UserInputType.MouseMovement then
			local delta = input.Position - dragStart
			window.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)

	window.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			self:BringToFront(window)
		end
	end)

	table.insert(self.windows, window)

	if config.app and config.app.Build then
		config.app:Build(content, config.params)
	end

	return window
end

return WindowManager
