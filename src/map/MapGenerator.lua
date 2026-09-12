-- MapGenerator.lua
-- Procedurally generates all map environments for Escape Buddy

local MapGenerator = {}
MapGenerator.__index = MapGenerator

local Config = require(script.Parent.Config)

function MapGenerator.new()
	local self = setmetatable({}, MapGenerator)
	self.workspace = workspace
	self.generatedParts = {}
	return self
end

-- Utility function to create a part
local function CreatePart(name, size, position, parent, color, material)
	local part = Instance.new("Part")
	part.Name = name
	part.Size = size
	part.Position = position
	part.Parent = parent
	part.BrickColor = BrickColor.new(color or "Medium stone grey")
	part.Material = Enum.Material[material or "Plastic"]
	part.CanCollide = true
	part.TopSurface = Enum.SurfaceType.Smooth
	part.BottomSurface = Enum.SurfaceType.Smooth
	return part
end

-- Create a folder to hold all map parts
function MapGenerator:CreateMapFolder()
	local mapFolder = Instance.new("Folder")
	mapFolder.Name = "GameMap"
	mapFolder.Parent = self.workspace
	return mapFolder
end

-- ===== TV STUDIO AREA =====
function MapGenerator:CreateTVStudio(mapFolder)
	local studioFolder = Instance.new("Folder")
	studioFolder.Name = "TVStudio"
	studioFolder.Parent = mapFolder

	-- Studio Floor
	CreatePart("Floor", Vector3.new(200, 1, 200), Vector3.new(0, 0, 0), studioFolder, "Dark stone grey", "Concrete")

	-- Studio Walls
	CreatePart("WallFront", Vector3.new(200, 20, 1), Vector3.new(0, 10, 100), studioFolder, "Dark stone grey")
	CreatePart("WallBack", Vector3.new(200, 20, 1), Vector3.new(0, 10, -100), studioFolder, "Dark stone grey")
	CreatePart("WallLeft", Vector3.new(1, 20, 200), Vector3.new(-100, 10, 0), studioFolder, "Dark stone grey")
	CreatePart("WallRight", Vector3.new(1, 20, 200), Vector3.new(100, 10, 0), studioFolder, "Dark stone grey")

	-- Studio Set Pieces (obstacles/hiding spots)
	CreatePart("SetPiece1", Vector3.new(30, 15, 5), Vector3.new(-40, 7.5, 20), studioFolder, "Bright red")
	CreatePart("SetPiece2", Vector3.new(30, 15, 5), Vector3.new(40, 7.5, 20), studioFolder, "Bright blue")
	CreatePart("SetPiece3", Vector3.new(5, 15, 30), Vector3.new(0, 7.5, -30), studioFolder, "Bright yellow")

	-- Dressing Room
	CreatePart("DressingRoomWall1", Vector3.new(40, 15, 1), Vector3.new(60, 7.5, 30), studioFolder, "Medium stone grey")
	CreatePart("DressingRoomWall2", Vector3.new(40, 15, 1), Vector3.new(60, 7.5, 50), studioFolder, "Medium stone grey")
	CreatePart("DressingRoomFloor", Vector3.new(40, 1, 20), Vector3.new(60, 0, 40), studioFolder, "Dark stone grey", "Concrete")

	-- Control Room Platform
	CreatePart("ControlRoomFloor", Vector3.new(50, 1, 30), Vector3.new(-60, 0, -50), studioFolder, "Dark stone grey", "Concrete")
	CreatePart("ControlRoomWall", Vector3.new(50, 15, 1), Vector3.new(-60, 7.5, -65), studioFolder, "Medium stone grey")

	-- Warehouse Area
	CreatePart("WarehouseFloor", Vector3.new(150, 1, 100), Vector3.new(0, 0, -150), studioFolder, "Dark stone grey", "Concrete")
	CreatePart("WarehouseRack1", Vector3.new(80, 20, 5), Vector3.new(-30, 10, -150), studioFolder, "Dark stone grey")
	CreatePart("WarehouseRack2", Vector3.new(80, 20, 5), Vector3.new(30, 10, -150), studioFolder, "Dark stone grey")

	-- Exit Door
	local exitDoor = CreatePart("ExitDoor", Vector3.new(10, 15, 1), Vector3.new(0, 7.5, 100), studioFolder, "Bright green")
	exitDoor.Name = "StudioExit"
	exitDoor.CanCollide = false
	exitDoor.Transparency = 0.3

	return studioFolder
end

-- ===== FLOWER FIELD AREA =====
function MapGenerator:CreateFlowerField(mapFolder)
	local fieldFolder = Instance.new("Folder")
	fieldFolder.Name = "FlowerField"
	fieldFolder.Parent = mapFolder

	-- Ground
	CreatePart("FieldFloor", Vector3.new(300, 1, 300), Vector3.new(300, 0, 0), fieldFolder, "Bright green", "Grass")

	-- Flower obstacles (tall structures)
	for i = 1, 15 do
		local randomX = math.random(-150, 150) + 300
		local randomZ = math.random(-150, 150)
		CreatePart("Flower" .. i, Vector3.new(8, 25, 8), Vector3.new(randomX, 12.5, randomZ), fieldFolder, "Bright red")
	end

	-- Petal platforms for platforming sections
	for i = 1, 10 do
		local platformX = 200 + (i * 10)
		CreatePart("PetalPlatform" .. i, Vector3.new(15, 1, 15), Vector3.new(platformX, 10, 0), fieldFolder, "Magenta")
	end

	-- Hiding spots in flowers
	for i = 1, 8 do
		local hideX = 300 + math.random(-120, 120)
		local hideZ = math.random(-120, 120)
		CreatePart("HideSpot" .. i, Vector3.new(12, 15, 12), Vector3.new(hideX, 7.5, hideZ), fieldFolder, "Bright red")
	end

	-- Field Exit
	local fieldExit = CreatePart("FieldExit", Vector3.new(15, 15, 1), Vector3.new(300, 7.5, 150), fieldFolder, "Bright green")
	fieldExit.CanCollide = false
	fieldExit.Transparency = 0.3

	return fieldFolder
end

-- ===== OBSTACLE COURSE AREA =====
function MapGenerator:CreateObstacleCourse(mapFolder)
	local courseFolder = Instance.new("Folder")
	courseFolder.Name = "ObstacleCourse"
	courseFolder.Parent = mapFolder

	-- Course floor
	CreatePart("CourseFloor", Vector3.new(400, 1, 100), Vector3.new(600, 0, 0), courseFolder, "Dark stone grey", "Concrete")

	-- Moving platforms (will be animated with scripts)
	for i = 1, 12 do
		local platformX = 500 + (i * 30)
		local platformZ = math.random(-40, 40)
		CreatePart("MovingPlatform" .. i, Vector3.new(25, 1, 25), Vector3.new(platformX, 15, platformZ), courseFolder, "Cyan")
	end

	-- Spike traps
	for i = 1, 8 do
		local trapX = 500 + (i * 45)
		CreatePart("SpikeTrap" .. i, Vector3.new(20, 1, 20), Vector3.new(trapX, 13.5, 0), courseFolder, "Really red")
	end

	-- Wall climb section
	CreatePart("ClimbWall", Vector3.new(50, 40, 5), Vector3.new(850, 20, 0), courseFolder, "Medium stone grey")

	-- Balance beams
	for i = 1, 5 do
		local beamX = 950 + (i * 25)
		CreatePart("BalanceBeam" .. i, Vector3.new(5, 1, 30), Vector3.new(beamX, 20, 0), courseFolder, "Dark stone grey")
	end

	-- Course Exit
	local courseExit = CreatePart("CourseExit", Vector3.new(15, 15, 1), Vector3.new(1150, 7.5, 0), courseFolder, "Bright green")
	courseExit.CanCollide = false
	courseExit.Transparency = 0.3

	return courseFolder
end

-- ===== FOREST AREA =====
function MapGenerator:CreateForest(mapFolder)
	local forestFolder = Instance.new("Folder")
	forestFolder.Name = "Forest"
	forestFolder.Parent = mapFolder

	-- Forest floor
	CreatePart("ForestFloor", Vector3.new(500, 1, 500), Vector3.new(-300, 0, 200), forestFolder, "Dark green", "Grass")

	-- Trees (obstacles)
	for i = 1, 30 do
		local treeX = math.random(-250, 250) - 300
		local treeZ = math.random(-250, 250) + 200
		CreatePart("Tree" .. i, Vector3.new(8, 40, 8), Vector3.new(treeX, 20, treeZ), forestFolder, "Dark stone grey")
	end

	-- Forest maze paths (narrow corridors between trees)
	CreatePart("MazePath1", Vector3.new(30, 1, 100), Vector3.new(-200, 0, 200), forestFolder, "Dark green", "Grass")
	CreatePart("MazePath2", Vector3.new(30, 1, 100), Vector3.new(0, 0, 200), forestFolder, "Dark green", "Grass")
	CreatePart("MazePath3", Vector3.new(30, 1, 100), Vector3.new(200, 0, 200), forestFolder, "Dark green", "Grass")

	-- Cliff section
	CreatePart("Cliff1", Vector3.new(50, 1, 50), Vector3.new(-300, 30, 350), forestFolder, "Dark stone grey", "Rock")
	CreatePart("Cliff2", Vector3.new(50, 1, 50), Vector3.new(-200, 25, 380), forestFolder, "Dark stone grey", "Rock")
	CreatePart("Cliff3", Vector3.new(50, 1, 50), Vector3.new(-100, 20, 410), forestFolder, "Dark stone grey", "Rock")
	CreatePart("Cliff4", Vector3.new(50, 1, 50), Vector3.new(0, 15, 440), forestFolder, "Dark stone grey", "Rock")

	-- River section (hazard)
	CreatePart("River", Vector3.new(80, 0.5, 200), Vector3.new(150, 5, 300), forestFolder, "Bright blue", "Water")

	-- Ancient temple entrance
	CreatePart("TempleFloor", Vector3.new(100, 1, 80), Vector3.new(-300, 0, 500), forestFolder, "Dark stone grey", "Concrete")
	CreatePart("TempleWall1", Vector3.new(100, 25, 5), Vector3.new(-300, 12.5, 540), forestFolder, "Medium stone grey")
	CreatePart("TempleWall2", Vector3.new(5, 25, 80), Vector3.new(-350, 12.5, 500), forestFolder, "Medium stone grey")
	CreatePart("TempleWall3", Vector3.new(5, 25, 80), Vector3.new(-250, 12.5, 500), forestFolder, "Medium stone grey")

	-- Forest clearing (final confrontation area)
	CreatePart("ClearingFloor", Vector3.new(150, 1, 150), Vector3.new(-300, 0, -100), forestFolder, "Dark green", "Grass")

	-- Forest exit
	local forestExit = CreatePart("ForestExit", Vector3.new(15, 15, 1), Vector3.new(-300, 7.5, -200), forestFolder, "Bright green")
	forestExit.CanCollide = false
	forestExit.Transparency = 0.3

	return forestFolder
end

-- ===== SPAWN AREAS =====
function MapGenerator:CreateSpawnAreas(mapFolder)
	local spawnFolder = Instance.new("Folder")
	spawnFolder.Name = "SpawnAreas"
	spawnFolder.Parent = mapFolder

	-- Player spawn points
	for i = 1, 4 do
		local spawnPart = CreatePart("PlayerSpawn" .. i, Vector3.new(6, 1, 6), Vector3.new(-50 + (i * 20), 5, 0), spawnFolder, "Bright green")
		spawnPart.CanCollide = true
		spawnPart.Name = "PlayerSpawn" .. i
	end

	-- Buddy spawn point
	local buddySpawn = CreatePart("BuddySpawn", Vector3.new(10, 1, 10), Vector3.new(0, 100, 0), spawnFolder, "Really red")
	buddySpawn.CanCollide = false
	buddySpawn.Name = "BuddySpawn"

	return spawnFolder
end

-- ===== LIGHTING SETUP =====
function MapGenerator:SetupLighting(mapFolder)
	local lighting = game:GetService("Lighting")
	
	-- Atmosphere
	local atmosphere = Instance.new("Atmosphere")
	atmosphere.Density = 0.2
	atmosphere.Offset = 0
	atmosphere.Glint = 0.2
	atmosphere.Parent = lighting

	-- Ambient light
	lighting.Ambient = Color3.fromRGB(100, 100, 100)
	lighting.OutdoorAmbient = Color3.fromRGB(100, 100, 100)
	lighting.Brightness = 1.5

	-- Sun light
	local sunLight = Instance.new("Part")
	sunLight.Name = "Sun"
	sunLight.CanCollide = false
	sunLight.Transparency = 1
	sunLight.Parent = mapFolder

	local pointLight = Instance.new("PointLight")
	pointLight.Brightness = 2
	pointLight.Range = 100
	pointLight.Color = Color3.fromRGB(255, 255, 200)
	pointLight.Parent = sunLight
	sunLight.Position = Vector3.new(0, 50, 0)
end

-- ===== MAIN GENERATION FUNCTION =====
function MapGenerator:GenerateCompleteMap()
	print("🎮 Generating Escape Buddy Map...")

	-- Create main map folder
	local mapFolder = self:CreateMapFolder()

	-- Generate all areas
	print("📺 Creating TV Studio...")
	self:CreateTVStudio(mapFolder)

	print("🌸 Creating Flower Field...")
	self:CreateFlowerField(mapFolder)

	print("🏃 Creating Obstacle Course...")
	self:CreateObstacleCourse(mapFolder)

	print("🌲 Creating Forest...")
	self:CreateForest(mapFolder)

	print("🎯 Creating Spawn Areas...")
	self:CreateSpawnAreas(mapFolder)

	print("💡 Setting up Lighting...")
	self:SetupLighting(mapFolder)

	print("✅ Map Generation Complete!")
	return mapFolder
end

return MapGenerator
