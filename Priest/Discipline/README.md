# Discipline Priest Rotation (256)
A comprehensive Discipline Priest rotation for healing and damage optimization with extensive configuration options.

## Overview
This rotation provides automated healing, damage dealing, and utility management for Discipline Priests. It focuses on maintaining Atonement buffs, efficient healing through damage, and proper cooldown usage.

## Key Features
- **Atonement Management**: Automatically spreads and maintains Atonement buffs
- **Smart Healing**: Priority-based healing with configurable thresholds
- **Mouseover Support**: Full mouseover functionality for targeted healing/damage
- **Movement Optimization**: Special handling for casting while moving
- **Cooldown Management**: Intelligent use of Pain Suppression and other cooldowns
- **Trinket Integration**: Automated Living Silk trinket usage

## Configuration Options
### Targeting & Combat
- **Auto-target**: Automatically target enemies when none selected
- **Pull with MO**: Allow pulling enemies with mouseover Shadow Word: Pain
- **Enable Mouseover**: Toggle mouseover functionality

### Pain Suppression
- **Threshold**: Health percentage to trigger Pain Suppression (10-60%)
- **Usage**: Who to use Pain Suppression on (Tank/Healer/Everyone/Disabled)
- **MO Pain Suppression**: Use Pain Suppression on mouseover targets

### Healing Thresholds
- **Ultimate Penitence**: Number of members below 50% to trigger (1-5)
- **Desperate Prayer**: Health percentage for self-heal (10-70%)
- **MO Penance**: Mouseover Penance threshold (default: 60%)
- **MO Flash Heal**: Mouseover Flash Heal threshold (default: 40%)
- **OOC Penance**: Out-of-combat Penance threshold (default: 95%)
- **OOC Flash Heal**: Out-of-combat Flash Heal threshold (default: 70%)

### Damage & Utility
- **SW: Death Threshold**: Prevent Shadow Word: Death usage when player below HP%(default: 50%)
- **Weal and Woe Stacks**: Minimum stacks for Power Word: Shield (Only applies to Oracle) (0-10)

### Movement & Utility
- **Angelic Feather**: When to use (None/Combat/Out of Combat/Always)
- **Movement Time**: Seconds of movement before using Angelic Feather (0-4s)

### Trinkets
- **Living Silk Usage**: On Cooldown/X Members below %/Disabled
- **Members Threshold**: Number of low-health members to trigger (1-5)
- **Percentage Threshold**: Health percentage options (30-90%)

## Rotation Priority
### High Priority
1. **Ultimate Penitence** - When configured number of members below 50%
2. **Desperate Prayer** - Emergency self-heal
3. **High-priority Penance** - For members below threshold
4. **Pain Suppression** - Emergency external cooldown if member below treshold

### Mouseover Actions
- **Pain Suppression** - Emergency external cooldown if MO target is below treshold
- **Penance** - Targeted healing
- **Flash Heal** - Quick targeted heal
- **Shadow Word: Pain** - DoT application on enemies
- **Purify** - Dispel harmful effects (Not yet working.)

### Atonement Management
1. **Evangelism** - Spread existing Atonements when multiple missing
2. **Power Word: Radiance** - AoE Atonement application
3. **Power Word: Shield** - Single-target Atonement with Weal and Woe consideration
4. **Flash Heal** - Single-target Atonement if Surge of Light up
5. **Plea** - Efficient single Atonement application

### Damage Rotation
1. **Shadow Word: Pain** - Maintain DoT on primary target
2. **Penance** - Priority damage spell (with charge management)
3. **Mind Blast** - Filler damage
4. **Shadow Word: Death** - Execute or with Void Blast talent
5. **Void Blast/Smite** - Basic filler spells

### Movement Handling
- **Penance** - Instant healing while moving
- **Power Word: Shield** - Instant Atonement application
- **Flash Heal** - With Surge of Light procs only

## Special Features
### Smart Cooldown Usage
- Pain Suppression automatically targets tanks, healers, or all members based on configuration
- Trinket usage tied to group health status or cooldown availability

### Proc Management
- **Surge of Light**: Prioritizes Flash Heal usage during movement
- **Power of the Dark Side**: Enhances Penance usage
- **Weal and Woe**: Optimizes Power Word: Shield timing

### Out-of-Combat Behavior
- Maintains group health with configurable thresholds
- Automatic Angelic Feather usage for movement speed

## Usage Tips
1. **Configure thresholds** based on content difficulty and group composition
2. **Enable mouseover** for manual override capabilities
3. **Adjust Pain Suppression** settings for tank vs. raid healing scenarios
4. **Set movement options** based on encounter mobility requirements
5. **Configure trinket usage** for optimal cooldown alignment

## Requirements
- Discipline Priest specialization
- Compatible rotation addon/framework
- Proper keybinds for all configured spells

## Version
Version 1 - Latest rotation with comprehensive configuration options and smart priority handling.