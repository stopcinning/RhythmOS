local Players = game:GetService("Players")

local LocalClient = {}

local Modules = script.Parent:WaitForChild("Modules")
local UI = Modules:WaitForChild("UI")

local ThemeManager = require(Modules:WaitForChild("ThemeManager"))
local SettingsManager = require(Modules:WaitForChild("SettingsManager"))
local InputManager = require(Modules:WaitForChild("InputManager"))
local WindowManager = require(Modules:WaitForChild("WindowManager"))

local MainMenu = require(UI:WaitForChild("MainMenu"))
local SongBrowser = require(UI:WaitForChild("SongBrowser"))
local Taskbar = require(UI:WaitForChild("Taskbar"))
local Dock = require(UI:WaitForChild("Dock"))

local player = Players.LocalPlayer
local screenGui = nil

LocalClient.version = "1.0.0"
LocalClient.apps = {
	MainMenu = MainMenu,
	SongBrowser = SongBrowser,
}
LocalClient.currentApp = nil

function LocalClient:Initialize()
	if screenGui then
		return
	end

	screenGui = Instance.new("ScreenGui")
	screenGui.Name = "RhythmOS"
	screenGui.ResetOnSpawn = false
	screenGui.Parent = player:WaitForChild("PlayerGui")

	ThemeManager:Initialize()
	ThemeManager:ApplyTheme(screenGui, "DefaultDark")
	SettingsManager:LoadSettings()
	InputManager:Initialize()
	WindowManager:Initialize(screenGui)

	local desktop = Instance.new("Frame")
	desktop.Name = "Desktop"
	desktop.Size = UDim2.new(1, 0, 1, 0)
	desktop.BackgroundColor3 = ThemeManager:GetColor("Background")
	desktop.BackgroundTransparency = 0
	desktop.BorderSizePixel = 0
	desktop.Parent = screenGui

	self.dock = Dock:Create(screenGui, self)
	self.taskbar = Taskbar:Create(screenGui, self)
	self:OpenApp("MainMenu")
end

function LocalClient:OpenApp(appName)
	if not self.apps[appName] then
		warn("Unknown app: " .. tostring(appName))
		return
	end

	if self.currentApp and self.currentApp.window then
		self.currentApp.window:Destroy()
	end

	local app = self.apps[appName]
	local config = {
		title = app.title or appName,
		width = app.defaultWidth or 760,
		height = app.defaultHeight or 520,
		app = app,
		params = {},
	}
	local window = WindowManager:CreateWindow(config)
	self.currentApp = {
		name = appName,
		window = window,
		module = app,
	}
end

LocalClient:Initialize()

return LocalClient
