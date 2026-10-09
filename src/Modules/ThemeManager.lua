local ThemeManager = {}

ThemeManager.Palettes = {
	DefaultDark = {
		Background = Color3.fromRGB(12, 14, 23),
		BackgroundSecondary = Color3.fromRGB(19, 22, 32),
		Panel = Color3.fromRGB(24, 28, 38),
		PanelSoft = Color3.fromRGB(31, 36, 48),
		PanelHard = Color3.fromRGB(17, 20, 29),
		Accent = Color3.fromRGB(155, 118, 255),
		AccentSoft = Color3.fromRGB(190, 167, 255),
		Mint = Color3.fromRGB(111, 215, 176),
		Pink = Color3.fromRGB(255, 166, 196),
		Sky = Color3.fromRGB(122, 196, 255),
		Orange = Color3.fromRGB(255, 184, 120),
		Text = Color3.fromRGB(245, 247, 255),
		TextMuted = Color3.fromRGB(160, 168, 190),
		Border = Color3.fromRGB(80, 89, 110),
		Glow = Color3.fromRGB(172, 132, 255),
		Shadow = Color3.fromRGB(0, 0, 0),
		Success = Color3.fromRGB(94, 219, 148),
		Warning = Color3.fromRGB(255, 187, 91),
		Danger = Color3.fromRGB(255, 112, 112),
	},
	LightMode = {
		Background = Color3.fromRGB(235, 240, 250),
		BackgroundSecondary = Color3.fromRGB(220, 225, 235),
		Panel = Color3.fromRGB(255, 255, 255),
		PanelSoft = Color3.fromRGB(244, 247, 252),
		PanelHard = Color3.fromRGB(233, 237, 244),
		Accent = Color3.fromRGB(116, 96, 255),
		AccentSoft = Color3.fromRGB(143, 125, 255),
		Mint = Color3.fromRGB(74, 198, 163),
		Pink = Color3.fromRGB(255, 138, 182),
		Sky = Color3.fromRGB(92, 178, 255),
		Orange = Color3.fromRGB(255, 165, 85),
		Text = Color3.fromRGB(28, 31, 38),
		TextMuted = Color3.fromRGB(95, 101, 116),
		Border = Color3.fromRGB(202, 210, 224),
		Glow = Color3.fromRGB(126, 104, 255),
		Shadow = Color3.fromRGB(185, 191, 204),
		Success = Color3.fromRGB(67, 176, 110),
		Warning = Color3.fromRGB(219, 147, 52),
		Danger = Color3.fromRGB(215, 76, 76),
	}
}

ThemeManager.Current = ThemeManager.Palettes.DefaultDark

function ThemeManager:Initialize()
	self.Current = self.Palettes.DefaultDark
end

function ThemeManager:ApplyTheme(gui, paletteName)
	local palette = self.Palettes[paletteName] or self.Palettes.DefaultDark
	self.Current = palette

	if gui then
		local function recursiveApply(obj)
			if obj:IsA("Frame") or obj:IsA("TextButton") or obj:IsA("TextLabel") or obj:IsA("ImageLabel") or obj:IsA("ScrollingFrame") or obj:IsA("ViewportFrame") then
				if obj:IsA("Frame") or obj:IsA("ScrollingFrame") or obj:IsA("ViewportFrame") then
					if obj.Name ~= "Taskbar" and obj.Name ~= "Dock" then
						local hasCorner = obj:FindFirstChild("UICorner")
						if not hasCorner then
							local corner = Instance.new("UICorner")
							corner.CornerRadius = UDim.new(0, 16)
							corner.Parent = obj
						end
					end
				end
			end

			for _, child in ipairs(obj:GetChildren()) do
				recursiveApply(child)
			end
		end

		recursiveApply(gui)
	end
end

function ThemeManager:GetColor(name)
	return self.Current[name] or self.Palettes.DefaultDark[name]
end

return ThemeManager
