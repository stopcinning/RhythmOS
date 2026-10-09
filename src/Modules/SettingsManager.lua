local SettingsManager = {}

local DEFAULT_SETTINGS = {
	theme = "DefaultDark",
	brightness = 100,
	uiScale = 100,
	accentColor = "Lavender",
	windowAnimations = true,
	ambientParticles = true,
	soundEffects = true,
	showDock = true,
	showTaskbar = true,
	largeText = false,
	colorblindMode = "Off",
	musicVolume = 70,
	sfxVolume = 65,
}

SettingsManager.settings = {}

function SettingsManager:LoadSettings()
	local player = game.Players.LocalPlayer
	local key = "RhythmOS_Settings"
	local stored = player:GetAttribute(key)

	if typeof(stored) == "table" then
		self.settings = stored
	else
		self.settings = table.clone(DEFAULT_SETTINGS)
	end

	for keyName, defaultValue in pairs(DEFAULT_SETTINGS) do
		if self.settings[keyName] == nil then
			self.settings[keyName] = defaultValue
		end
	end

	self:SaveSettings()
end

function SettingsManager:SaveSettings()
	local player = game.Players.LocalPlayer
	player:SetAttribute("RhythmOS_Settings", self.settings)
end

function SettingsManager:GetSetting(name)
	if self.settings[name] == nil then
		self.settings[name] = DEFAULT_SETTINGS[name]
	end
	return self.settings[name]
end

function SettingsManager:SetSetting(name, value)
	self.settings[name] = value
	self:SaveSettings()
end

return SettingsManager
