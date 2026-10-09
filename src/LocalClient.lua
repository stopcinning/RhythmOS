-- RhythmOS | Main Client Entry Point
-- This is the heart of the entire platform
-- Everything starts here

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- ===== CORE INITIALIZATION =====

local RhythmOS = {
	version = "1.0.0",
	isInitialized = false,
	currentApp = nil,
	apps = {},
	state = {},
}

-- Load all core modules
local Modules = script.Parent:WaitForChild("Modules")
local UIModules = Modules:WaitForChild("UI")

local ThemeManager = require(Modules:WaitForChild("ThemeManager"))
local SettingsManager = require(Modules:WaitForChild("SettingsManager"))
local InputManager = require(Modules:WaitForChild("InputManager"))
local AudioManager = require(Modules:WaitForChild("AudioManager"))
local WindowManager = require(Modules:WaitForChild("WindowManager"))
local AnimationHelper = require(Modules:WaitForChild("AnimationHelper"))

-- UI Apps
local MainMenu = require(UIModules:WaitForChild("MainMenu"))
local SongBrowser = require(UIModules:WaitForChild("SongBrowser"))
local GameScreen = require(UIModules:WaitForChild("GameScreen"))
local Profile = require(UIModules:WaitForChild("Profile"))
local Leaderboard = require(UIModules:WaitForChild("Leaderboard"))
local SkinStudio = require(UIModules:WaitForChild("SkinStudio"))
local StatsAnalyzer = require(UIModules:WaitForChild("StatsAnalyzer"))
local CommunityHub = require(UIModules:WaitForChild("CommunityHub"))
local Settings = require(UIModules:WaitForChild("Settings"))
local Taskbar = require(UIModules:WaitForChild("Taskbar"))
local Dock = require(UIModules:WaitForChild("Dock"))

-- ===== SETUP SCREEN GUI =====

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RhythmOSGui"
screenGui.ResetOnSpawn = false
screenGui.DisplayOrder = 1
screenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")

-- Apply theme
ThemeManager:Initialize()
ThemeManager:ApplyTheme(screenGui, "DefaultDark")

-- ===== INITIALIZE MANAGERS =====

function RhythmOS:Initialize()
	print("🎵 RhythmOS Initializing...")
	
	-- Load player settings
	SettingsManager:LoadSettings()
	
	-- Apply saved theme
	local savedTheme = SettingsManager:GetSetting("theme") or "DefaultDark"
	ThemeManager:ApplyTheme(screenGui, savedTheme)
	
	-- Setup input handling
	InputManager:Initialize()
	
	-- Setup audio system
	AudioManager:Initialize()
	
	-- Setup window manager
	WindowManager:Initialize(screenGui)
	
	-- Register all apps
	self.apps.MainMenu = MainMenu
	self.apps.SongBrowser = SongBrowser
	self.apps.GameScreen = GameScreen
	self.apps.Profile = Profile
	self.apps.Leaderboard = Leaderboard
	self.apps.SkinStudio = SkinStudio
	self.apps.StatsAnalyzer = StatsAnalyzer
	self.apps.CommunityHub = CommunityHub
	self.apps.Settings = Settings
	
	-- Create taskbar and dock
	self.taskbar = Taskbar:Create(screenGui, self)
	self.dock = Dock:Create(screenGui, self)
	
	-- Load main menu
	self:OpenApp("MainMenu")
	
	-- Setup keyboard shortcuts
	self:SetupHotkeys()
	
	self.isInitialized = true
	print("✅ RhythmOS Ready")
end

-- ===== APP MANAGEMENT =====

function RhythmOS:OpenApp(appName, params)
	if not self.apps[appName] then
		warn("App not found: " .. appName)
		return
	end
	
	-- Close previous app if needed
	if self.currentApp and self.currentApp.Close then
		self.currentApp:Close()
	end
	
	-- Create new app window
	local app = self.apps[appName]
	local window = WindowManager:CreateWindow({
		title = app.title or appName,
		width = app.defaultWidth or 800,
		height = app.defaultHeight or 600,
		app = app,
		params = params
	})
	
	-- Initialize app
	if app.Create then
		app:Create(window, params)
	end
	
	self.currentApp = app
	self.taskbar:UpdateActive(appName)
end

-- ===== HOTKEYS =====

function RhythmOS:SetupHotkeys()
	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then return end
		
		-- Global hotkeys
		if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
			if input.KeyCode == Enum.KeyCode.F then
				-- Open search overlay
				self:OpenApp("Search")
			elseif input.KeyCode == Enum.KeyCode.H then
				-- Open home/main menu
				self:OpenApp("MainMenu")
			elseif input.KeyCode == Enum.KeyCode.P then
				-- Open profile
				self:OpenApp("Profile")
			elseif input.KeyCode == Enum.KeyCode.S then
				-- Open song browser
				self:OpenApp("SongBrowser")
			elseif input.KeyCode == Enum.KeyCode.L then
				-- Open leaderboard
				self:OpenApp("Leaderboard")
			elseif input.KeyCode == Enum.KeyCode.K then
				-- Open skin studio
				self:OpenApp("SkinStudio")
			end
		end
	end)
end

-- ===== MAIN LOOP =====

RunService.RenderStepped:Connect(function(deltaTime)
	if not RhythmOS.isInitialized then return end
	
	-- Update input manager for frame
	InputManager:Update(deltaTime)
	
	-- Update audio visualization
	AudioManager:Update(deltaTime)
	
	-- Update animations
	AnimationHelper:Update(deltaTime)
end)

-- ===== START =====

RhythmOS:Initialize()

return RhythmOS
