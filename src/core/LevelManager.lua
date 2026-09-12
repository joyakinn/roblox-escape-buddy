-- LevelManager.lua
-- Manages 50 levels with different types, difficulties, and mechanics

local Config = require(script.Parent.Config)

local LevelManager = {}
LevelManager.__index = LevelManager

-- Level Template Structure
local LevelTemplate = {
	id = 0,
	name = "",
	description = "",
	type = "", -- Puzzle, Chase, Stealth, Obstacle, Survival, Hallucination, Trap, Boss, Mixed
	difficulty = "Easy", -- Easy, Normal, Hard, Nightmare
	timeLimit = 300,
	buddyCount = 1, -- Number of enemies
	enemies = {}, -- Boss, Puppet, Trickster, Hallucination
	objectives = {},
	rewards = 0,
	nextLevel = 0,
	hasCheckpoint = false,
	specialMechanics = {},
}

-- Define all 50 levels
function LevelManager:CreateAllLevels()
	local levels = {}

	-- ===== LEVELS 1-15: EASY (TV Studio Arc) =====
	
	levels[1] = {
		id = 1,
		name = "Welcome to the Studio",
		description = "Learn to move and hide from Buddy",
		type = Config.LevelTypes.TUTORIAL,
		difficulty = "Easy",
		timeLimit = 300,
		buddyCount = 1,
		enemies = {"Buddy"},
		objectives = {
			"Reach the exit",
			"Avoid Buddy for 2 minutes",
		},
		rewards = 100,
		nextLevel = 2,
		hasCheckpoint = true,
		specialMechanics = {
			noKill = true, -- Buddy won't kill on this level
			hints = true,
		},
	}

	levels[2] = {
		id = 2,
		name = "Puppet Theater",
		description = "Solve the puppet puzzle to unlock the door",
		type = Config.LevelTypes.PUZZLE,
		difficulty = "Easy",
		timeLimit = 240,
		buddyCount = 1,
		enemies = {"Buddy"},
		objectives = {
			"Solve the puppet riddle",
			"Reach the next area",
		},
		rewards = 150,
		nextLevel = 3,
		hasCheckpoint = true,
		specialMechanics = {
			puzzleType = "RiddlePattern",
			patrolMode = true, -- Buddy patrols instead of chases
		},
	}

	levels[3] = {
		id = 3,
		name = "Dressing Room Chase",
		description = "Find hiding spots while Buddy searches",
		type = Config.LevelTypes.STEALTH,
		difficulty = "Easy",
		timeLimit = 180,
		buddyCount = 1,
		enemies = {"Buddy"},
		objectives = {
			"Hide for 3 minutes",
			"Find the key to the exit",
		},
		rewards = 125,
		nextLevel = 4,
		hasCheckpoint = false,
		specialMechanics = {
			hideSpotCount = 8,
			keyHidden = true,
		},
	}

	levels[4] = {
		id = 4,
		name = "Sound Stage Escape",
		description = "Navigate silently to avoid detection",
		type = Config.LevelTypes.STEALTH,
		difficulty = "Easy",
		timeLimit = 240,
		buddyCount = 1,
		enemies = {"Buddy"},
		objectives = {
			"Reach the control room",
			"Don't make noise",
		},
		rewards = 140,
		nextLevel = 5,
		hasCheckpoint = true,
		specialMechanics = {
			soundDetection = true,
			lowLighting = true,
		},
	}

	levels[5] = {
		id = 5,
		name = "Props Maze",
		description = "Navigate through a maze of props",
		type = Config.LevelTypes.OBSTACLE,
		difficulty = "Easy",
		timeLimit = 200,
		buddyCount = 1,
		enemies = {"Buddy"},
		objectives = {
			"Find the exit through the maze",
			"Collect 3 keys",
		},
		rewards = 160,
		nextLevel = 6,
		hasCheckpoint = true,
		specialMechanics = {
			mazeLayout = true,
			collectibles = 3,
		},
	}

	levels[6] = {
		id = 6,
		name = "Lighting Puzzle",
		description = "Turn on lights in the correct sequence",
		type = Config.LevelTypes.PUZZLE,
		difficulty = "Easy",
		timeLimit = 220,
		buddyCount = 1,
		enemies = {"Buddy"},
		objectives = {
			"Solve the light sequence",
			"Escape before darkness",
		},
		rewards = 135,
		nextLevel = 7,
		hasCheckpoint = false,
		specialMechanics = {
			lightPuzzle = true,
			timedMechanic = true,
		},
	}

	levels[7] = {
		id = 7,
		name = "Backstage Hide",
		description = "Find the best hiding spots",
		type = Config.LevelTypes.STEALTH,
		difficulty = "Easy",
		timeLimit = 300,
		buddyCount = 1,
		enemies = {"Buddy"},
		objectives = {
			"Survive for 5 minutes",
		},
		rewards = 150,
		nextLevel = 8,
		hasCheckpoint = true,
		specialMechanics = {
			hideSpotCount = 7,
			patrolMode = true,
		},
	}

	levels[8] = {
		id = 8,
		name = "Electrical Room",
		description = "Solve the circuit puzzle",
		type = Config.LevelTypes.PUZZLE,
		difficulty = "Easy",
		timeLimit = 210,
		buddyCount = 1,
		enemies = {"Buddy"},
		objectives = {
			"Complete the circuit",
			"Power up the exit door",
		},
		rewards = 145,
		nextLevel = 9,
		hasCheckpoint = false,
		specialMechanics = {
			circuitPuzzle = true,
		},
	}

	levels[9] = {
		id = 9,
		name = "Corridor Chase",
		description = "Run and hide in a long corridor",
		type = Config.LevelTypes.CHASE,
		difficulty = "Easy",
		timeLimit = 240,
		buddyCount = 1,
		enemies = {"Buddy"},
		objectives = {
			"Reach the end of the corridor",
		},
		rewards = 155,
		nextLevel = 10,
		hasCheckpoint = false,
		specialMechanics = {
			corridorLength = 200,
			periodicChases = true,
		},
	}

	levels[10] = {
		id = 10,
		name = "Green Room Mystery",
		description = "Find clues to unlock the next area",
		type = Config.LevelTypes.PUZZLE,
		difficulty = "Easy",
		timeLimit = 250,
		buddyCount = 1,
		enemies = {"Buddy"},
		objectives = {
			"Find 3 clues",
			"Unlock the mystery door",
		},
		rewards = 160,
		nextLevel = 11,
		hasCheckpoint = true,
		specialMechanics = {
			clueCollecting = 3,
			clueSequence = true,
		},
	}

	levels[11] = {
		id = 11,
		name = "Studio Survival",
		description = "Mix of puzzles, stealth, and evasion",
		type = Config.LevelTypes.MIXED,
		difficulty = "Easy",
		timeLimit = 300,
		buddyCount = 1,
		enemies = {"Buddy"},
		objectives = {
			"Solve 2 puzzles",
			"Reach safe zone",
		},
		rewards = 175,
		nextLevel = 12,
		hasCheckpoint = true,
		specialMechanics = {
			mixedMechanics = true,
		},
	}

	levels[12] = {
		id = 12,
		name = "Set Pieces Platforming",
		description = "Jump across set pieces",
		type = Config.LevelTypes.OBSTACLE,
		difficulty = "Easy",
		timeLimit = 220,
		buddyCount = 1,
		enemies = {"Buddy"},
		objectives = {
			"Reach the other side",
		},
		rewards = 140,
		nextLevel = 13,
		hasCheckpoint = false,
		specialMechanics = {
			platformCount = 10,
			movingPlatforms = false,
		},
	}

	levels[13] = {
		id = 13,
		name = "Camera Room",
		description = "Avoid the cameras while solving puzzles",
		type = Config.LevelTypes.MIXED,
		difficulty = "Easy",
		timeLimit = 240,
		buddyCount = 1,
		enemies = {"Buddy"},
		objectives = {
			"Disable cameras",
			"Reach the exit",
		},
		rewards = 150,
		nextLevel = 14,
		hasCheckpoint = false,
		specialMechanics = {
			cameraDetection = true,
			securityPuzzle = true,
		},
	}

	levels[14] = {
		id = 14,
		name = "Warehouse Chase",
		description = "Navigate through a warehouse",
		type = Config.LevelTypes.CHASE,
		difficulty = "Easy",
		timeLimit = 280,
		buddyCount = 1,
		enemies = {"Buddy"},
		objectives = {
			"Escape the warehouse",
		},
		rewards = 160,
		nextLevel = 15,
		hasCheckpoint = true,
		specialMechanics = {
			warehouseLayout = true,
			chaseIntensity = 0.5,
		},
	}

	levels[15] = {
		id = 15,
		name = "Exit Corridor Boss",
		description = "Final challenge of the Studio Arc",
		type = Config.LevelTypes.BOSS,
		difficulty = "Easy",
		timeLimit = 300,
		buddyCount = 1,
		enemies = {"Buddy"},
		objectives = {
			"Reach the studio exit",
			"Buddy blocks the way",
		},
		rewards = 250,
		nextLevel = 16,
		hasCheckpoint = true,
		specialMechanics = {
			buddySpeedUp = true,
			bossFight = true,
			checkpoint = true,
		},
	}

	-- ===== LEVELS 16-30: NORMAL (Flower Field & Hallucination Arc) =====

	levels[16] = {
		id = 16,
		name = "The Flower Field",
		description = "Enter the dangerous flower field",
		type = Config.LevelTypes.HALLUCINATION,
		difficulty = "Normal",
		timeLimit = 240,
		buddyCount = 1,
		enemies = {"Buddy"},
		objectives = {
			"Survive the flower field",
		},
		rewards = 200,
		nextLevel = 17,
		hasCheckpoint = true,
		specialMechanics = {
			flowerHallucination = true,
			distortedVisuals = true,
			slowMotion = true,
			soundWarping = true,
		},
	}

	levels[17] = {
		id = 17,
		name = "Petal Storm",
		description = "Survive a magical petal storm",
		type = Config.LevelTypes.SURVIVAL,
		difficulty = "Normal",
		timeLimit = 220,
		buddyCount = 1,
		enemies = {"Buddy"},
		objectives = {
			"Find shelter from petals",
		},
		rewards = 180,
		nextLevel = 18,
		hasCheckpoint = false,
		specialMechanics = {
			petalStorm = true,
			damageOverTime = true,
			visionImpaired = true,
		},
	}

	levels[18] = {
		id = 18,
		name = "Hallucination Maze",
		description = "Navigate a maze that shifts and changes",
		type = Config.LevelTypes.HALLUCINATION,
		difficulty = "Normal",
		timeLimit = 300,
		buddyCount = 1,
		enemies = {"Buddy"},
		objectives = {
			"Find the exit before it closes",
		},
		rewards = 210,
		nextLevel = 19,
		hasCheckpoint = false,
		specialMechanics = {
			shiftingMaze = true,
			timeStress = true,
			hallucinationIntensity = 0.7,
		},
	}

	levels[19] = {
		id = 19,
		name = "Buddy's Whispers",
		description = "Buddy's voice fills your head",
		type = Config.LevelTypes.STEALTH,
		difficulty = "Normal",
		timeLimit = 250,
		buddyCount = 1,
		enemies = {"Buddy"},
		objectives = {
			"Silence Buddy's whispers",
		},
		rewards = 190,
		nextLevel = 20,
		hasCheckpoint = true,
		specialMechanics = {
			audioHallucinations = true,
			confusionEffect = true,
			soundtracking = true,
		},
	}

	levels[20] = {
		id = 20,
		name = "Blackout Zone",
		description = "Navigate complete darkness",
		type = Config.LevelTypes.STEALTH,
		difficulty = "Normal",
		timeLimit = 280,
		buddyCount = 1,
		enemies = {"Buddy"},
		objectives = {
			"Find lights or escape",
		},
		rewards = 205,
		nextLevel = 21,
		hasCheckpoint = false,
		specialMechanics = {
			totalDarkness = true,
			soundNavigation = true,
			lowHealthRegen = true,
		},
	}

	levels[21] = {
		id = 21,
		name = "Petal Platforming",
		description = "Jump on flower petals as platforms",
		type = Config.LevelTypes.OBSTACLE,
		difficulty = "Normal",
		timeLimit = 240,
		buddyCount = 1,
		enemies = {"Buddy"},
		objectives = {
			"Cross the petal bridge",
		},
		rewards = 195,
		nextLevel = 22,
		hasCheckpoint = true,
		specialMechanics = {
			petalPlatforms = true,
			movingPlatforms = true,
			balanceMechanics = true,
		},
	}

	levels[22] = {
		id = 22,
		name = "Memory Puzzle",
		description = "Solve puzzles from distorted memories",
		type = Config.LevelTypes.PUZZLE,
		difficulty = "Normal",
		timeLimit = 200,
		buddyCount = 1,
		enemies = {"Buddy"},
		objectives = {
			"Piece together the memory",
		},
		rewards = 215,
		nextLevel = 23,
		hasCheckpoint = false,
		specialMechanics = {
			memoryPuzzle = true,
			hiddenClues = true,
		},
	}

	levels[23] = {
		id = 23,
		name = "Flower Dream Escape",
		description = "Escape from a lucid nightmare",
		type = Config.LevelTypes.MIXED,
		difficulty = "Normal",
		timeLimit = 300,
		buddyCount = 2,
		enemies = {"Buddy", "Puppet"},
		objectives = {
			"Wake up from the dream",
		},
		rewards = 230,
		nextLevel = 24,
		hasCheckpoint = true,
		specialMechanics = {
			multipleBuddies = true,
			dreamLogic = true,
			jumpScares = true,
		},
	}

	levels[24] = {
		id = 24,
		name = "Petal Vortex",
		description = "Survive the center of the petal storm",
		type = Config.LevelTypes.SURVIVAL,
		difficulty = "Normal",
		timeLimit = 220,
		buddyCount = 2,
		enemies = {"Buddy", "Puppet"},
		objectives = {
			"Reach the center and escape",
		},
		rewards = 220,
		nextLevel = 25,
		hasCheckpoint = false,
		specialMechanics = {
			vortexMechanic = true,
			increasingDamage = true,
			chaosMode = true,
		},
	}

	levels[25] = {
		id = 25,
		name = "Hallucinatory Chase",
		description = "Being chased through distorted space",
		type = Config.LevelTypes.CHASE,
		difficulty = "Normal",
		timeLimit = 240,
		buddyCount = 2,
		enemies = {"Buddy", "Puppet"},
		objectives = {
			"Outrun the chasers",
		},
		rewards = 225,
		nextLevel = 26,
		hasCheckpoint = true,
		specialMechanics = {
			disorientation = true,
			speedVariation = true,
			visualGlitches = true,
		},
	}

	levels[26] = {
		id = 26,
		name = "Flower Field Survival",
		description = "Complex survival scenario",
		type = Config.LevelTypes.SURVIVAL,
		difficulty = "Normal",
		timeLimit = 290,
		buddyCount = 2,
		enemies = {"Buddy", "Puppet"},
		objectives = {
			"Survive 5 minutes",
		},
		rewards = 240,
		nextLevel = 27,
		hasCheckpoint = true,
		specialMechanics = {
			resourceManagement = true,
			multiObjective = true,
		},
	}

	levels[27] = {
		id = 27,
		name = "Exit the Dream",
		description = "Solve reality-bending puzzles",
		type = Config.LevelTypes.PUZZLE,
		difficulty = "Normal",
		timeLimit = 260,
		buddyCount = 2,
		enemies = {"Buddy", "Puppet"},
		objectives = {
			"Find the real exit",
		},
		rewards = 235,
		nextLevel = 28,
		hasCheckpoint = false,
		specialMechanics = {
			multipleExits = true,
			correctPathPuzzle = true,
		},
	}

	levels[28] = {
		id = 28,
		name = "Petal Tornado Climb",
		description = "Climb while a tornado surrounds you",
		type = Config.LevelTypes.OBSTACLE,
		difficulty = "Normal",
		timeLimit = 250,
		buddyCount = 2,
		enemies = {"Buddy", "Puppet"},
		objectives = {
			"Reach the top",
		},
		rewards = 245,
		nextLevel = 29,
		hasCheckpoint = true,
		specialMechanics = {
			climbMechanic = true,
			windForce = true,
			platformUnstable = true,
		},
	}

	levels[29] = {
		id = 29,
		name = "Buddy's Lair",
		description = "Deep in Buddy's territory",
		type = Config.LevelTypes.MIXED,
		difficulty = "Normal",
		timeLimit = 300,
		buddyCount = 2,
		enemies = {"Buddy", "Puppet"},
		objectives = {
			"Escape Buddy's lair",
		},
		rewards = 250,
		nextLevel = 30,
		hasCheckpoint = true,
		specialMechanics = {
			buddyTerritoryBonus = true,
			ambushes = true,
		},
	}

	levels[30] = {
		id = 30,
		name = "Flower Field Boss",
		description = "Final battle in the flower field",
		type = Config.LevelTypes.BOSS,
		difficulty = "Normal",
		timeLimit = 320,
		buddyCount = 2,
		enemies = {"Buddy", "Puppet"},
		objectives = {
			"Defeat and escape",
		},
		rewards = 300,
		nextLevel = 31,
		hasCheckpoint = true,
		specialMechanics = {
			bossFight = true,
			twoPhases = true,
			checkpoint = true,
		},
	}

	-- ===== LEVELS 31-40: HARD (Puppet & Trickster Chase Arc) =====

	levels[31] = {
		id = 31,
		name = "The Trickster Arrives",
		description = "Meet the man who tricked everyone",
		type = Config.LevelTypes.CHASE,
		difficulty = "Hard",
		timeLimit = 210,
		buddyCount = 2,
		enemies = {"Trickster", "Puppet"},
		objectives = {
			"Escape the Trickster",
		},
		rewards = 280,
		nextLevel = 32,
		hasCheckpoint = true,
		specialMechanics = {
			tricksterIntroduction = true,
			aggressiveChase = true,
		},
	}

	levels[32] = {
		id = 32,
		name = "Obstacle Course - Platform Jump",
		description = "Jump on moving platforms while being chased",
		type = Config.LevelTypes.OBSTACLE,
		difficulty = "Hard",
		timeLimit = 200,
		buddyCount = 2,
		enemies = {"Trickster", "Puppet"},
		objectives = {
			"Cross all platforms",
		},
		rewards = 270,
		nextLevel = 33,
		hasCheckpoint = false,
		specialMechanics = {
			movingPlatforms = true,
			platformSpeed = 1.5,
			chasingMechanics = true,
		},
	}

	levels[33] = {
		id = 33,
		name = "Collapsing Floor Run",
		description = "Run on a floor that collapses behind you",
		type = Config.LevelTypes.OBSTACLE,
		difficulty = "Hard",
		timeLimit = 180,
		buddyCount = 2,
		enemies = {"Trickster", "Puppet"},
		objectives = {
			"Reach the end",
		},
		rewards = 275,
		nextLevel = 34,
		hasCheckpoint = false,
		specialMechanics = {
			collapsingFloor = true,
			speedRequired = true,
			noPause = true,
		},
	}

	levels[34] = {
		id = 34,
		name = "Spinning Corridor",
		description = "Navigate a constantly spinning corridor",
		type = Config.LevelTypes.OBSTACLE,
		difficulty = "Hard",
		timeLimit = 220,
		buddyCount = 2,
		enemies = {"Trickster", "Puppet"},
		objectives = {
			"Get to the other side",
		},
		rewards = 285,
		nextLevel = 35,
		hasCheckpoint = true,
		specialMechanics = {
			rotatingEnvironment = true,
			disorientation = true,
			speedChallenge = true,
		},
	}

	levels[35] = {
		id = 35,
		name = "Wall Climb Chase",
		description = "Climb walls while being chased",
		type = Config.LevelTypes.OBSTACLE,
		difficulty = "Hard",
		timeLimit = 240,
		buddyCount = 2,
		enemies = {"Trickster", "Puppet"},
		objectives = {
			"Reach the top",
		},
		rewards = 290,
		nextLevel = 36,
		hasCheckpoint = true,
		specialMechanics = {
			wallClimbing = true,
			chasingClose = true,
			staminaDrain = true,
		},
	}

	levels[36] = {
		id = 36,
		name = "Beam Balance",
		description = "Balance on narrow beams",
		type = Config.LevelTypes.OBSTACLE,
		difficulty = "Hard",
		timeLimit = 210,
		buddyCount = 2,
		enemies = {"Trickster", "Puppet"},
		objectives = {
			"Cross all beams",
		},
		rewards = 280,
		nextLevel = 37,
		hasCheckpoint = false,
		specialMechanics = {
			beamBalance = true,
			narrowPasses = true,
			swayingBeams = true,
		},
	}

	levels[37] = {
		id = 37,
		name = "Spike Gauntlet",
		description = "Navigate through spikes while being chased",
		type = Config.LevelTypes.SURVIVAL,
		difficulty = "Hard",
		timeLimit = 200,
		buddyCount = 2,
		enemies = {"Trickster", "Puppet"},
		objectives = {
			"Survive the gauntlet",
		},
		rewards = 295,
		nextLevel = 38,
		hasCheckpoint = true,
		specialMechanics = {
			hazards = true,
			precision = true,
			timingCritical = true,
		},
	}

	levels[38] = {
		id = 38,
		name = "Trickster's Gauntlet",
		description = "Ultimate obstacle course challenge",
		type = Config.LevelTypes.MIXED,
		difficulty = "Hard",
		timeLimit = 280,
		buddyCount = 2,
		enemies = {"Trickster", "Puppet"},
		objectives = {
			"Survive the complete gauntlet",
		},
		rewards = 305,
		nextLevel = 39,
		hasCheckpoint = true,
		specialMechanics = {
			multipleHazards = true,
			noCheckpoints = false,
			endgameChallenge = true,
		},
	}

	levels[39] = {
		id = 39,
		name = "Mirror Maze Chase",
		description = "Chase through a maze of mirrors",
		type = Config.LevelTypes.MIXED,
		difficulty = "Hard",
		timeLimit = 250,
		buddyCount = 2,
		enemies = {"Trickster", "Puppet"},
		objectives = {
			"Find the real exit",
		},
		rewards = 300,
		nextLevel = 40,
		hasCheckpoint = false,
		specialMechanics = {
			mirrorMaze = true,
			disorientingLayout = true,
			falseExits = true,
		},
	}

	levels[40] = {
		id = 40,
		name = "Trickster Showdown",
		description = "Final boss fight with the Trickster",
		type = Config.LevelTypes.BOSS,
		difficulty = "Hard",
		timeLimit = 300,
		buddyCount = 3,
		enemies = {"Trickster", "Puppet", "Buddy"},
		objectives = {
			"Survive and escape",
		},
		rewards = 350,
		nextLevel = 41,
		hasCheckpoint = true,
		specialMechanics = {
			threeBosses = true,
			multiPhase = true,
			ultimateChallenge = true,
		},
	}

	-- ===== LEVELS 41-50: NIGHTMARE (Forest Escape & Final Arc) =====

	levels[41] = {
		id = 41,
		name = "Forest Entrance",
		description = "Escape into the dark forest",
		type = Config.LevelTypes.CHASE,
		difficulty = "Nightmare",
		timeLimit = 180,
		buddyCount = 3,
		enemies = {"Buddy", "Puppet", "Trickster"},
		objectives = {
			"Get deep into the forest",
		},
		rewards = 330,
		nextLevel = 42,
		hasCheckpoint = true,
		specialMechanics = {
			forestSetting = true,
			threeEnemies = true,
			aggressiveAI = true,
		},
	}

	levels[42] = {
		id = 42,
		name = "Deep Woods Survival",
		description = "Survive in the dark woods",
		type = Config.LevelTypes.SURVIVAL,
		difficulty = "Nightmare",
		timeLimit = 240,
		buddyCount = 3,
		enemies = {"Buddy", "Puppet", "Trickster"},
		objectives = {
			"Survive 5 minutes",
		},
		rewards = 340,
		nextLevel = 43,
		hasCheckpoint = false,
		specialMechanics = {
			lowLight = true,
			threeHunters = true,
			limitedResources = true,
		},
	}

	levels[43] = {
		id = 43,
		name = "Forest Maze of Doom",
		description = "Escape a dangerous forest maze",
		type = Config.LevelTypes.MIXED,
		difficulty = "Nightmare",
		timeLimit = 270,
		buddyCount = 3,
		enemies = {"Buddy", "Puppet", "Trickster"},
		objectives = {
			"Find the exit",
		},
		rewards = 345,
		nextLevel = 44,
		hasCheckpoint = false,
		specialMechanics = {
			complexMaze = true,
			threeHunters = true,
			ambushPoints = true,
		},
	}

	levels[44] = {
		id = 44,
		name = "Cliff Jump Challenge",
		description = "Jump across cliffs while escaping",
		type = Config.LevelTypes.OBSTACLE,
		difficulty = "Nightmare",
		timeLimit = 200,
		buddyCount = 3,
		enemies = {"Buddy", "Puppet", "Trickster"},
		objectives = {
			"Cross all cliffs",
		},
		rewards = 355,
		nextLevel = 45,
		hasCheckpoint = true,
		specialMechanics = {
			cliffJumping = true,
			lethalFalls = true,
			speedRequired = true,
		},
	}

	levels[45] = {
		id = 45,
		name = "River Rapids Run",
		description = "Navigate dangerous river rapids",
		type = Config.LevelTypes.SURVIVAL,
		difficulty = "Nightmare",
		timeLimit = 220,
		buddyCount = 3,
		enemies = {"Buddy", "Puppet", "Trickster"},
		objectives = {
			"Reach the river end",
		},
		rewards = 350,
		nextLevel = 46,
		hasCheckpoint = false,
		specialMechanics = {
			waterHazard = true,
			fastCurrents = true,
			obstacles = true,
		},
	}

	levels[46] = {
		id = 46,
		name = "Dark Forest Temple",
		description = "Navigate an ancient temple in the forest",
		type = Config.LevelTypes.PUZZLE,
		difficulty = "Nightmare",
		timeLimit = 260,
		buddyCount = 3,
		enemies = {"Buddy", "Puppet", "Trickster"},
		objectives = {
			"Solve the temple",
		},
		rewards = 360,
		nextLevel = 47,
		hasCheckpoint = true,
		specialMechanics = {
			complexPuzzles = true,
			trapDoors = true,
			timedElements = true,
		},
	}

	levels[47] = {
		id = 47,
		name = "The Final Chase",
		description = "Ultimate chase through the forest",
		type = Config.LevelTypes.CHASE,
		difficulty = "Nightmare",
		timeLimit = 240,
		buddyCount = 3,
		enemies = {"Buddy", "Puppet", "Trickster"},
		objectives = {
			"Outrun them all",
		},
		rewards = 365,
		nextLevel = 48,
		hasCheckpoint = false,
		specialMechanics = {
			allThreeChasing = true,
			maxSpeed = true,
			noCover = true,
		},
	}

	levels[48] = {
		id = 48,
		name = "Forest Clearing Standoff",
		description = "Final confrontation in a clearing",
		type = Config.LevelTypes.SURVIVAL,
		difficulty = "Nightmare",
		timeLimit = 300,
		buddyCount = 3,
		enemies = {"Buddy", "Puppet", "Trickster"},
		objectives = {
			"Survive 5 minutes",
			"Find escape route",
		},
		rewards = 370,
		nextLevel = 49,
		hasCheckpoint = true,
		specialMechanics = {
			openCombat = true,
			multipleBosses = true,
			despeartChallenge = true,
		},
	}

	levels[49] = {
		id = 49,
		name = "Escape the Forest",
		description = "Last push to escape the forest",
		type = Config.LevelTypes.MIXED,
		difficulty = "Nightmare",
		timeLimit = 280,
		buddyCount = 3,
		enemies = {"Buddy", "Puppet", "Trickster"},
		objectives = {
			"Reach the forest edge",
		},
		rewards = 375,
		nextLevel = 50,
		hasCheckpoint = true,
		specialMechanics = {
			finalPush = true,
			allTactics = true,
		},
	}

	levels[50] = {
		id = 50,
		name = "Escape Buddy - FINALE",
		description = "The ultimate final level - escape and victory",
		type = Config.LevelTypes.BOSS,
		difficulty = "Nightmare",
		timeLimit = 320,
		buddyCount = 3,
		enemies = {"Buddy", "Puppet", "Trickster"},
		objectives = {
			"Escape the forest",
			"Multiple ending choices",
		},
		rewards = 500,
		nextLevel = 0, -- Game ends
		hasCheckpoint = true,
		specialMechanics = {
			finalBossFight = true,
			multipleEndings = true,
			cinematicFinale = true,
			allPathways = true, -- All escape routes available
		},
	}

	return levels
end

return LevelManager
