# RhythmOS

A Roblox UI-first rhythm gaming operating system.

## What is included

This repository contains a foundational Lua client scaffold for a RhythmOS desktop experience built in Roblox Studio.

Included:
- main client bootstrap
- theme system
- settings system
- input system
- window manager
- taskbar and dock
- dashboard/home screen
- song browser window

## Important note

This is a foundation for a UI-first rhythm operating system, not a single 3D Roblox game. The design is centered around a desktop-like environment with apps and windows.

## Suggested Roblox import layout

Place the contents of `src/` into a Roblox place under:
- StarterPlayer > StarterPlayerScripts
- and/or create a Script in StarterPlayerScripts that requires `LocalClient.lua`.

Then:
1. Open Roblox Studio
2. Insert a Script into `StarterPlayerScripts`
3. Use:
   ```lua
   local RhythmOS = require(script.Parent.LocalClient)
   ```

## Default theme

The default look is a soft dark, pastel cyber aesthetic with eye-friendly colors and premium desktop polish.

## Next steps

The next expansion could include:
- profile app
- leaderboard app
- skin studio app
- stats analyzer app
- community hub app
- gameplay panel inside the OS shell
