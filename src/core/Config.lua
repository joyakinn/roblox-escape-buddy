-- GameConfig.lua
-- Central configuration for Escape Buddy game

local Config = {}

-- Game Settings
Config.MaxPlayers = 4
Config.MaxLevels = 50
Config.StartingLevel = 1
Config.EnableNightmareMode = true

-- Difficulty Settings
Config.DifficultyLevels = {
	Easy = {
		BuddySpeed = 25,
		DetectionRange = 50,
		PuzzleTime = 120,
		HideSpotCount = 8,
		PlayerHealth = 100,
	},
	Normal = {
		BuddySpeed = 35,
		DetectionRange = 65,
		PuzzleTime = 90,
		HideSpotCount = 5,
		PlayerHealth = 75,
	},
	Hard = {
		BuddySpeed = 45,
		DetectionRange = 80,
		PuzzleTime = 60,
		HideSpotCount = 3,
		PlayerHealth = 50,
	},
	Nightmare = {
		BuddySpeed = 60,
		DetectionRange = 100,
		PuzzleTime = 30,
		HideSpotCount = 1,
		PlayerHealth = 25,
	},
}

-- Level Progression
Config.LevelDifficulty = {
	-- Levels 1-15: Easy (TV Studio Arc)
	[1] = "Easy",
	[2] = "Easy",
	[3] = "Easy",
	[4] = "Easy",
	[5] = "Easy",
	[6] = "Easy",
	[7] = "Easy",
	[8] = "Easy",
	[9] = "Easy",
	[10] = "Easy",
	[11] = "Easy",
	[12] = "Easy",
	[13] = "Easy",
	[14] = "Easy",
	[15] = "Easy",
	
	-- Levels 16-30: Normal (Flower Field & Hallucination Arc)
	[16] = "Normal",
	[17] = "Normal",
	[18] = "Normal",
	[19] = "Normal",
	[20] = "Normal",
	[21] = "Normal",
	[22] = "Normal",
	[23] = "Normal",
	[24] = "Normal",
	[25] = "Normal",
	[26] = "Normal",
	[27] = "Normal",
	[28] = "Normal",
	[29] = "Normal",
	[30] = "Normal",
	
	-- Levels 31-40: Hard (Puppet & Trickster Chase Arc)
	[31] = "Hard",
	[32] = "Hard",
	[33] = "Hard",
	[34] = "Hard",
	[35] = "Hard",
	[36] = "Hard",
	[37] = "Hard",
	[38] = "Hard",
	[39] = "Hard",
	[40] = "Hard",
	
	-- Levels 41-50: Nightmare (Forest Escape & Final Arc)
	[41] = "Nightmare",
	[42] = "Nightmare",
	[43] = "Nightmare",
	[44] = "Nightmare",
	[45] = "Nightmare",
	[46] = "Nightmare",
	[47] = "Nightmare",
	[48] = "Nightmare",
	[49] = "Nightmare",
	[50] = "Nightmare",
}

-- Level Types
Config.LevelTypes = {
	PUZZLE = "Puzzle",
	CHASE = "Chase",
	STEALTH = "Stealth",
	OBSTACLE = "Obstacle",
	SURVIVAL = "Survival",
	HALLUCINATION = "Hallucination",
	TRAP = "Trap",
	BOSS = "Boss",
	MIXED = "Mixed",
}

-- Buddy AI Settings
Config.Buddy = {
	SpawnDistance = 50,
	ChaseDuration = 30,
	PatrolSpeed = 20,
	ChaseSpeed = 45,
	HearingRange = 100,
	SightRange = 80,
	JumpScareChance = 0.3,
	AttackDamage = 25,
}

-- Stealth Detection
Config.Detection = {
	BaseDetectionRange = 60,
	MovingDetectionMultiplier = 1.5,
	SprintingDetectionMultiplier = 2.0,
	StealthingDetectionMultiplier = 0.3,
	SoundDetectionRange = 100,
	LightDetectionBonus = 1.2,
}

-- Player Settings
Config.Player = {
	BaseHealth = 75,
	MaxStamina = 100,
	SprintCost = 1.5,
	StaminaRegenRate = 0.5,
	RespawnTime = 10,
	HideSpotExitTime = 2,
}

-- Puzzle Settings
Config.Puzzles = {
	DefaultTimeLimit = 90,
	HintCost = 10, -- stamina cost
	WrongAnswerPenalty = 5, -- seconds added
	MaxHints = 3,
}

-- Game States
Config.GameStates = {
	LOBBY = "Lobby",
	LOADING = "Loading",
	PLAYING = "Playing",
	LEVEL_COMPLETE = "LevelComplete",
	GAME_OVER = "GameOver",
	ESCAPED = "Escaped",
}

-- Endings
Config.Endings = {
	MAIN_EXIT = 1,
	SERVICE_TUNNEL = 2,
	BUDDY_TRAP = 3,
	BAD_ENDING = 4,
	FOREST_ESCAPE = 5,
}

return Config
