# RhythmOS - Architecture Document

## Overview
A pure **UI-based rhythm game** built entirely in Roblox ScreenGui. No 3D world, no characters—just beautiful, responsive, cutesy rhythm gameplay with an OS-style interface.

---

## Design Philosophy

### Visual Theme
- **Default: Cutesy Dark Mode** (eye-friendly, zero harsh whites)
- Soft pastels: lavender, mint, blush, sky blue, soft peachy tones
- Rounded but not childish—premium desktop feel
- All animations smooth and delightful
- Emphasis on character and personality

### UI Paradigm
- **Operating System Desktop** metaphor
- Animated taskbar at bottom
- Dock system for quick access
- Resizable windows (song browser, profile, leaderboard, etc.)
- Search everywhere
- Right-click context menus
- Keyboard navigation throughout

### Interaction Design
Every interaction has:
- Hover animations (scale, color shift, glow)
- Click feedback (ripple, bounce, sound)
- Smooth transitions (easing functions)
- Sound effects (satisfying but not jarring)
- Context awareness
- Natural discovery (complexity hidden)

---

## Folder Structure

```
ServerScriptService/
├── GameService.lua          # Main server loop, game state
├── MultiplayerService.lua   # Multiplayer synchronization
├── LeaderboardService.lua   # Ranked system, scoring
├── ReplayService.lua        # Record/playback replays
└── AdminService.lua         # Anti-cheat, moderation

ServerStorage/
├── SongDatabase.lua         # All available songs + metadata
├── RankingAlgorithm.lua     # PP calculation, skill rating
├── MatchmakingService.lua   # Multiplayer pairing
└── DataConfig.lua           # Server-side constants

StarterPlayer/
└── StarterCharacterScripts/
    └── (empty - no character needed)

StarterPlayer/
└── StarterPlayerScripts/
    ├── LocalClient.lua      # Main client entry point
    └── 📁 Modules/
        ├── ThemeManager.lua       # All UI colors, fonts, sizing
        ├── SettingsManager.lua    # User preferences
        ├── InputManager.lua       # Keyboard/mouse input handling
        ├── AudioManager.lua       # Music, SFX, volume control
        ├── GameplayEngine.lua     # Note spawning, hit detection
        ├── ScoreCalculator.lua    # Accuracy, PP, combo logic
        ├── SkinManager.lua        # Skin loading, applying
        ├── ReplayManager.lua      # Replay recording/playback
        ├── AnimationHelper.lua    # Tweens, easing functions
        └── 📁 UI/
            ├── MainMenu.lua           # Home screen
            ├── SongBrowser.lua        # Song selection with preview
            ├── GameScreen.lua         # Actual gameplay UI
            ├── ResultsScreen.lua      # Post-game stats
            ├── Profile.lua            # Player profile window
            ├── Leaderboard.lua        # Global, seasonal, friend rankings
            ├── SkinEditor.lua         # Skin creator
            ├── Settings.lua           # Deep settings menu
            ├── MultiplayerLobby.lua   # Party, tournament, spectate
            ├── WindowManager.lua      # Resizable window system
            ├── Taskbar.lua            # Bottom navigation
            ├── Dock.lua               # Quick access buttons
            └── SearchOverlay.lua      # Global search UI

ReplicatedStorage/
└── 📁 Assets/
    ├── 📁 Themes/
    │   ├── DefaultDark.lua      # Cutesy pastel dark theme
    │   ├── LightMode.lua        # Optional light theme
    │   ├── HighContrast.lua     # Accessibility mode
    │   └── CandyMode.lua        # Ultra-cutesy variant
    ├── 📁 SFX/
    │   ├── hit_perfect.wav
    │   ├── hit_great.wav
    │   ├── hit_good.wav
    │   ├── hit_bad.wav
    │   ├── miss.wav
    │   ├── ui_hover.wav
    │   └── ui_click.wav
    ├── 📁 Fonts/
    │   ├── MainFont (system font or imported)
    │   └── AccentFont
    └── 📁 SampleSongs/
        ├── song1_chart.lua
        ├── song2_chart.lua
        └── ...

StarterGui/
└── GameScreen/              # Main ScreenGui
    ├── Layers (UICorner, shadows, etc.)
    └── (populated by LocalClient.lua at runtime)
```

---

## Core Systems

### 1. ThemeManager
**Responsible for:** All visual styling

```lua
-- Single source of truth for colors, fonts, sizes
ThemeManager = {
  Colors = {
    Background = Color3.fromRGB(20, 20, 28),      -- Deep indigo
    Primary = Color3.fromRGB(200, 150, 255),      -- Soft lavender
    Secondary = Color3.fromRGB(150, 220, 200),    -- Mint
    Accent = Color3.fromRGB(255, 180, 200),       -- Blush
    Text = Color3.fromRGB(245, 245, 250),         -- Off-white
    Muted = Color3.fromRGB(150, 150, 160),        -- Gray
  },
  Fonts = { ... },
  Sizes = { ... },
  -- Apply theme dynamically to any GUI element
}
```

### 2. InputManager
**Responsible for:** Keyboard and mouse input during gameplay

```lua
-- Maps keybinds to lane positions
-- Supports: 4K, 5K, 6K, 7K, 8K, 9K, 10K
-- Handles: key press timing, hold notes, release timing
```

### 3. GameplayEngine
**Responsible for:** Core rhythm game logic

```lua
-- Note spawning from chart data
-- Hit window calculations (perfect ±15ms, great ±50ms, good ±100ms)
-- Combo tracking
-- Health bar (optional)
-- Visual feedback (hit indicators, note animations)
```

### 4. ScoreCalculator
**Responsible for:** Scoring system

```lua
-- Accuracy calculation (100%, 95%, 90%, etc.)
-- PP (Performance Points) calculation
-- Skill rating
-- Leaderboard rank estimation
-- Historical tracking
```

### 5. SkinManager
**Responsible for:** Visual customization

```lua
-- Load skin from ReplicatedStorage
-- Apply skin to:
--   - Note appearance
--   - Lane styling
--   - Receptors
--   - Hit effects
--   - Score UI
--   - Background
-- Live preview during skin editing
```

### 6. ReplayManager
**Responsible for:** Recording and playback

```lua
-- Record: timestamp, key pressed/released, note hit/missed
-- Playback: replay inputs frame-by-frame
-- Share replays with other players
-- Watch friend's best plays
```

### 7. WindowManager
**Responsible for:** OS-style resizable windows

```lua
-- Each "window" (song browser, profile, etc.) is draggable
-- Resizable with corner handles
-- Minimize/maximize buttons
-- Z-order (bring to front)
-- Snap to grid (optional)
-- Remember position/size
```

### 8. LeaderboardService
**Responsible for:** Ranking system

```lua
-- Global leaderboard
-- Seasonal leaderboard (resets monthly)
-- Country/region leaderboard
-- Friend leaderboard
-- Skill-based matchmaking
-- Historical ranking data
-- Anti-cheat score validation (server-side)
```

---

## Gameplay Flow

1. **Launch** → MainMenu loads
2. **Song Select** → SongBrowser with preview, difficulty info
3. **Gameplay** → GameScreen spawns notes, handles input
4. **Results** → ResultsScreen shows score, PP, rank
5. **Profile** → Player can view stats, achievements
6. **Leaderboard** → See how they rank globally
7. **Customization** → Skins, settings, themes

---

## Note Falling Mechanics

### Chart Format
```lua
{
  title = "Song Name",
  artist = "Artist",
  bpm = 180,
  offset = 0,
  notes = {
    -- { time (ms), lane (1-10), length (0 for tap, >0 for hold) }
    { 1000, 2, 0 },      -- Tap on lane 2 at 1000ms
    { 1500, 4, 500 },    -- Hold note: press at 1500ms, release at 2000ms
    { 2000, 1, 0 },
    ...
  }
}
```

### Hit Windows
- **Perfect:** ±15ms → 100 points
- **Great:** ±50ms → 95 points
- **Good:** ±100ms → 80 points
- **Bad:** ±150ms → 50 points
- **Miss:** >150ms → 0 points

### Accuracy Calculation
```
Accuracy = (Total Points / Max Points) * 100%
```

---

## UI Component Hierarchy

```
ScreenGui (GameScreen)
├── Background (gradient, animated)
├── Taskbar (bottom, quick access)
├── Dock (side, app shortcuts)
├── ActiveWindows
│   ├── MainMenu
│   │   ├── Logo
│   │   ├── StartButton
│   │   ├── SettingsButton
│   │   ├── ProfileButton
│   │   └── LeaderboardButton
│   ├── SongBrowser
│   │   ├── SearchBar
│   │   ├── FilterTabs
│   │   ├── SongList (scrollable)
│   │   ├── AlbumArt (preview)
│   │   ├── DifficultyInfo
│   │   └── PlayButton
│   ├── GameScreen
│   │   ├── Lanes (4-10)
│   │   ├── Receptors (top)
│   │   ├── FallingNotes
│   │   ├── ScoreDisplay
│   │   ├── ComboDisplay
│   │   ├── AccuracyIndicator
│   │   ├── HealthBar (optional)
│   │   ├── HitMeter (visual timing feedback)
│   │   └── PauseButton
│   ├── Results
│   │   ├── AccuracyBreakdown (perfect/great/good/bad/miss counts)
│   │   ├── FinalScore
│   │   ├── RankDisplay (S+, S, A, B, C, D, F)
│   │   ├── PPEarned
│   │   ├── NewPersonalBest (if applicable)
│   │   ├── ShareButton
│   │   ├── RetryButton
│   │   └── MenuButton
│   ├── Profile
│   │   ├── PlayerCard (avatar, username, level)
│   │   ├── StatsSummary
│   │   ├── RecentScores
│   │   ├── AchievementGrid
│   │   └── CustomTheme (optional player theming)
│   ├── Leaderboard
│   │   ├── FilterButtons (Global/Seasonal/Friends/Country)
│   │   ├── RankingTable
│   │   │   ├── Rank
│   │   │   ├── PlayerName
│   │   │   ├── PP
│   │   │   ├── PlayCount
│   │   │   └── Accuracy
│   │   ├── PlayerInspectPopup
│   │   └── ScoreComparison
│   ├── Settings
│   │   ├── DisplaySettings
│   │   │   ├── BrightnessSlider
│   │   │   ├── DimSlider
│   │   │   ├── UIScaleSlider
│   │   │   ├── BloomStrengthSlider
│   │   │   └── ThemeSelector
│   │   ├── GameplaySettings
│   │   │   ├── OffsetSlider
│   │   │   ├── ScrollSpeedSlider
│   │   │   ├── LaneWidthSlider
│   │   │   ├── ReceptorHeightSlider
│   │   │   └── KeybindCustomizer
│   │   ├── AudioSettings
│   │   │   ├── MasterVolume
│   │   │   ├── MusicVolume
│   │   │   ├── SFXVolume
│   │   │   ├── HitSoundSelector
│   │   │   └── PreviewVolumeSlider
│   │   └── AccessibilitySettings
│   │       ├── ColorblindMode
│   │       ├── LargeTextMode
│   │       ├── OneHandedMode
│   │       └── ScreenReaderMode
│   └── MultiplayerLobby
│       ├── LobbyCode
│       ├── PlayerList
│       ├── ReadyButton
│       ├── ModeSelector (party/tournament/race/etc)
│       └── ChatBox
└── SearchOverlay (Ctrl+F, always accessible)
```

---

## Multiplayer Architecture

### Modes
1. **Party Mode** - Play with friends, non-competitive
2. **Score Race** - See who gets highest score on same song
3. **Tournament** - Bracket system, multiple rounds
4. **Spectate** - Watch friend's live gameplay
5. **Ranked Matchmaking** - Skill-based pairing

### Server Communication
- **RemoteEvents** for: note hits, combo updates, score sync
- **RemoteFunction** for: song/chart requests, leaderboard queries
- **Debouncing** to prevent exploit spam
- **Server-side validation** of all scores before ranking

---

## Skin System

### Skin Package Structure
```lua
{
  name = "Pastel Dream",
  author = "username",
  version = "1.0",
  noteColor = { ... },
  laneColor = { ... },
  receptorImage = "rbxasset://path",
  hitEffect = { ... },
  scoreUIFont = "...",
  backgroundImage = "...",
  -- etc.
}
```

### Skin Editor Features
- **Visual drag-and-drop editor**
- **Color picker** for each element
- **Image uploader** for custom textures
- **Live preview** in gameplay
- **Save/export** to ReplicatedStorage
- **Share** with community
- **Rate/favorite** other skins

---

## Performance Optimization

### Object Pooling
```lua
-- Pre-create 1000 note UI elements
-- Reuse them instead of creating/destroying
-- Huge FPS boost for high-BPM charts
```

### Asset Streaming
```lua
-- Load songs on-demand
-- Cache album art
-- Lazy-load player profiles
```

### Rendering Optimization
```lua
-- Batch UI updates where possible
-- Use CanvasSize for scrolling lists
-- Minimize re-renders
```

### Memory Management
```lua
-- Clear unused data between songs
-- Unload leaderboard when closed
-- Cache only active window data
```

**Target:** 60 FPS minimum on low-end PCs (Intel i5-6400, GTX 960 equivalent)

---

## Data Schema

### Player Document (DataStore2)
```lua
{
  userId = 12345,
  username = "player",
  level = 42,
  totalScore = 999999,
  playCount = 5000,
  totalNotes = 1000000,
  totalPlaytime = 360000, -- seconds
  
  stats = {
    accuracy = 98.5,
    currentPP = 7500,
    allTimeHighestPP = 8200,
  },
  
  achievements = { ... },
  
  scores = {
    { songId, difficulty, score, pp, accuracy, combo, ... },
    ...
  },
  
  settings = { ... },
  skinFavorites = { ... },
  friends = { ... },
}
```

### Song Document
```lua
{
  id = "song_001",
  title = "...",
  artist = "...",
  bpm = 180,
  offset = 0,
  
  difficulties = {
    {
      level = "Easy",
      keymode = 4,
      noteCount = 500,
      maxBPM = 180,
      chart = { ... },
    },
    ...
  },
  
  albumArt = "rbxasset://...",
  previewUrl = "...",
  leaderboard = { ... },
}
```

---

## Roadmap & Expandability

### Phase 1 (MVP)
- Song browser
- Basic 4K gameplay
- Scoring system
- Settings menu
- Leaderboard (local, later synced)

### Phase 2
- 5K-10K support
- Replay system
- Skin manager
- Multiplayer (party mode)
- Profile system

### Phase 3
- Ranked matchmaking
- Tournament system
- Seasonal events
- Community hub
- Advanced PP algorithm

### Phase 4
- Trading system
- Marketplace for skins
- Clan system
- Streaming integrations
- Mobile companion app

---

## File Size & Performance Targets

| Metric | Target |
|--------|--------|
| Startup time | <2 seconds |
| FPS (minimum) | 60 on low-end PC |
| Leaderboard load | <1 second |
| Song select scroll | 60 FPS with 10,000 songs |
| Replay playback | Real-time, no stutter |
| Memory usage | <500MB during gameplay |

---

## Conclusion

RhythmOS is designed to feel like a premium, polished desktop rhythm game—not a typical Roblox game. Every interaction is intentional, every animation has purpose, and every pixel serves the gameplay and player experience.

The modular architecture makes it easy to add features, iterate on systems, and scale to millions of players while maintaining quality and performance.
