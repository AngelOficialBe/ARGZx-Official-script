-- ==================== CONFIGURACIÓN DE KEY ====================
local ValidKey = "PRUEBA" -- <--- Cambia tu key aquí
local ScriptURL = "https://raw.githubusercontent.com/AngelOficialBe/ARGZx-Official-script/refs/heads/main/ARGZx-Script.lua"
-- ==============================================================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local Lighting = game:GetService("Lighting")
local StarterGui = game:GetService("StarterGui")

local LP = Players.LocalPlayer
local PlayerGui = LP:WaitForChild("PlayerGui")

-- Variables globales de interfaz para evitar nil en Kill-Switch
local gui = nil
local miniBtn = nil

-- ==================== KEY SYSTEM ====================
local keyGui = Instance.new("ScreenGui")
keyGui.Name = "ARGZ_KeySystem"
keyGui.ResetOnSpawn = false
keyGui.IgnoreGuiInset = true
keyGui.Parent = PlayerGui

local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(0, 320, 0, 190)
keyFrame.Position = UDim2.new(0.5, -160, 0.5, -95)
keyFrame.BackgroundColor3 = Color3.fromRGB(14, 14, 20)
keyFrame.BorderSizePixel = 0
keyFrame.Parent = keyGui
Instance.new("UICorner", keyFrame).CornerRadius = UDim.new(0, 14)

local keyStroke = Instance.new("UIStroke")
keyStroke.Color = Color3.fromRGB(140, 60, 255)
keyStroke.Thickness = 1.5
keyStroke.Parent = keyFrame

local keyTitle = Instance.new("TextLabel")
keyTitle.Size = UDim2.new(1, 0, 0, 45)
keyTitle.BackgroundTransparency = 1
keyTitle.Text = "ARGZx  •  Key System"
keyTitle.TextColor3 = Color3.fromRGB(200, 160, 255)
keyTitle.Font = Enum.Font.GothamBold
keyTitle.TextSize = 18
keyTitle.Parent = keyFrame

local keyInput = Instance.new("TextBox")
keyInput.Size = UDim2.new(0.85, 0, 0, 40)
keyInput.Position = UDim2.new(0.075, 0, 0, 55)
keyInput.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
keyInput.Text = ""
keyInput.PlaceholderText = "Ingresa tu key..."
keyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
keyInput.PlaceholderColor3 = Color3.fromRGB(120, 120, 140)
keyInput.Font = Enum.Font.Gotham
keyInput.TextSize = 14
keyInput.Parent = keyFrame
Instance.new("UICorner", keyInput).CornerRadius = UDim.new(0, 8)

local verifyBtn = Instance.new("TextButton")
verifyBtn.Size = UDim2.new(0.85, 0, 0, 40)
verifyBtn.Position = UDim2.new(0.075, 0, 0, 110)
verifyBtn.BackgroundColor3 = Color3.fromRGB(110, 50, 220)
verifyBtn.Text = "Verificar Key"
verifyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
verifyBtn.Font = Enum.Font.GothamBold
verifyBtn.TextSize = 15
verifyBtn.Parent = keyFrame
Instance.new("UICorner", verifyBtn).CornerRadius = UDim.new(0, 8)

local isVerified = false
verifyBtn.MouseButton1Click:Connect(function()
	if keyInput.Text == ValidKey then
		verifyBtn.Text = "¡Key Correcta!"
		verifyBtn.BackgroundColor3 = Color3.fromRGB(40, 180, 90)
		task.wait(0.8)
		keyGui:Destroy()
		isVerified = true
	else
		verifyBtn.Text = "Key Incorrecta"
		verifyBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
		task.wait(1)
		verifyBtn.Text = "Verificar Key"
		verifyBtn.BackgroundColor3 = Color3.fromRGB(110, 50, 220)
	end
end)

repeat task.wait(0.2) until isVerified

-- Kill-switch
task.spawn(function()
	while task.wait(12) do
		local success, onlineCode = pcall(function()
			return game:HttpGet(ScriptURL)
		end)
		if success then
			local onlineKey = string.match(onlineCode, 'local ValidKey%s*=%s*"(.-)"')
			if onlineKey and onlineKey ~= ValidKey then
				pcall(function()
					if keyGui and keyGui.Parent then keyGui:Destroy() end
					if gui and gui.Parent then gui:Destroy() end
					if miniBtn and miniBtn.Parent then miniBtn:Destroy() end
				end)
				LP:Kick("⚠️ [ARGZx] Key actualizada o acceso revocado.")
				break
			end
		end
	end
end)

-- Anti-AFK
LP.Idled:Connect(function()
	VirtualUser:CaptureController()
	VirtualUser:ClickButton2(Vector2.new())
end)

-- Espera segura por leaderstats y muscleEvent
repeat task.wait(0.3) until LP:FindFirstChild("muscleEvent") and LP:FindFirstChild("leaderstats")

local leaderstats = LP:WaitForChild("leaderstats")
local Strength = leaderstats:WaitForChild("Strength")
local Rebirths = leaderstats:WaitForChild("Rebirths")

-- ==================== VARIABLES ====================
local FastFarm = false
local AutoRebirth = false
local FastRebirth = false
local isOPMode = false
local AntiLagEnabled = false
local PerformanceEnabled = false

local startTime = tick()
local sessionRebirths = 0
local lastRebirths = Rebirths.Value

-- ==================== HELPERS ====================
local function getCharacter()
	return LP.Character
end

local function getHumanoid()
	local char = getCharacter()
	return char and char:FindFirstChildOfClass("Humanoid")
end

local function getRoot()
	local char = getCharacter()
	return char and char:FindFirstChild("HumanoidRootPart")
end

local function getGems()
	local gems = LP:FindFirstChild("Gems") or (leaderstats and leaderstats:FindFirstChild("Gems"))
	return gems and tonumber(gems.Value) or 0
end

local function formatExact(n)
	n = tonumber(n) or 0
	if n >= 1e12 then return string.format("%.2fT", n/1e12)
	elseif n >= 1e9 then return string.format("%.2fB", n/1e9)
	elseif n >= 1e6 then return string.format("%.2fM", n/1e6)
	elseif n >= 1e3 then return string.format("%.1fK", n/1e3)
	else return tostring(math.floor(n)) end
end

-- ==================== FAST FARM OPTIMIZADO (400 - 800 REPS/SEC) ====================
task.spawn(function()
	local cachedEvent = LP:FindFirstChild("muscleEvent")
	LP.ChildAdded:Connect(function(child)
		if child.Name == "muscleEvent" then
			cachedEvent = child
		end
	end)

	-- Heartbeat se ejecuta aprox 60 veces por segundo. 
	-- Multiplicado por el límite interno, nos da las reps exactas sin saturar la red.
	RunService.Heartbeat:Connect(function()
		if FastFarm then
			if not cachedEvent or not cachedEvent.Parent then
				cachedEvent = LP:FindFirstChild("muscleEvent")
			end
			
			if cachedEvent then
				-- OP Mode: ~13 peticiones por frame * 60 FPS = ~780 reps por segundo.
				-- Modo Normal: ~8 peticiones por frame * 60 FPS = ~480 reps por segundo.
				local limit = isOPMode and 13 or 8 
				
				for i = 1, limit do
					pcall(function()
						cachedEvent:FireServer("rep")
					end)
				end
			end
		end
	end)
end)

-- ==================== AUTO REBIRTH ====================
local lastRebirthAttempt = 0
local function doRebirth()
	if tick() - lastRebirthAttempt < 0.2 then return end
	lastRebirthAttempt = tick()
	
	local rEvents = ReplicatedStorage:FindFirstChild("rEvents")
	local remote = rEvents and rEvents:FindFirstChild("rebirthRemote")
	if not remote then return end
	pcall(function()
		if remote:IsA("RemoteFunction") then
			remote:InvokeServer("rebirthRequest")
		else
			remote:FireServer("rebirthRequest")
		end
	end)
end

Strength:GetPropertyChangedSignal("Value"):Connect(function()
	if AutoRebirth or FastRebirth then
		doRebirth()
	end
end)

-- ==================== FAST REBIRTH + PETS ====================
local function getPetMultiplier(pet, keyword)
	if not pet then return 0 end
	for _, child in ipairs(pet:GetDescendants()) do
		if child:IsA("NumberValue") or child:IsA("IntValue") or child:IsA("StringValue") then
			local name = string.lower(child.Name)
			if string.find(name, keyword) then
				return tonumber(child.Value) or 0
			end
		end
	end
	local n = string.lower(pet.Name)
	if string.find(n, keyword) then return 2 end
	return 0
end

local function equipBestPets(mode)
	local backpack = LP:FindFirstChild("Backpack")
	local character = getCharacter()
	if not backpack or not character then return end
	local humanoid = getHumanoid()
	if not humanoid then return end

	for _, tool in ipairs(character:GetChildren()) do
		if tool:IsA("Tool") then
			pcall(function() tool.Parent = backpack end)
		end
	end
	task.wait(0.08)

	local pets = {}
	for _, item in ipairs(backpack:GetChildren()) do
		if item:IsA("Tool") then
			local score = 0
			if mode == "rep" then
				score = getPetMultiplier(item, "rep") + getPetMultiplier(item, "strength") + getPetMultiplier(item, "train")
			else
				score = getPetMultiplier(item, "rebirth") + getPetMultiplier(item, "reb")
			end
			if score > 0 or string.find(string.lower(item.Name), mode == "rep" and "rep" or "reb") then
				table.insert(pets, {tool = item, score = score})
			end
		end
	end

	table.sort(pets, function(a, b) return a.score > b.score end)

	if #pets > 0 then
		pcall(function()
			humanoid:EquipTool(pets[1].tool)
		end)
	end
end

-- Bucle principal de Rebirths e inspección de sesión
task.spawn(function()
	while true do
		if FastRebirth then
			doRebirth()
		end
		
		if Rebirths.Value > lastRebirths then
			sessionRebirths = sessionRebirths + (Rebirths.Value - lastRebirths)
			lastRebirths = Rebirths.Value
			if FastRebirth then
				equipBestPets("rep")
			end
		elseif Rebirths.Value < lastRebirths then
			lastRebirths = Rebirths.Value
		end
		
		task.wait(0.35)
	end
end)

-- ==================== ANTI-LAG & RENDIMIENTO ====================
local originalSettings = {}

local function setAntiLag(enabled)
	AntiLagEnabled = enabled
	if enabled then
		for _, obj in ipairs(workspace:GetDescendants()) do
			if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") or
			   obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles") then
				if originalSettings[obj] == nil then
					originalSettings[obj] = obj.Enabled
				end
				pcall(function() obj.Enabled = false end)
			elseif obj:IsA("BasePart") and obj.CastShadow then
				if originalSettings[obj] == nil then
					originalSettings[obj] = true
				end
				pcall(function() obj.CastShadow = false end)
			end
		end
	else
		for obj, value in pairs(originalSettings) do
			if obj and obj.Parent then
				pcall(function()
					if typeof(value) == "boolean" then
						if obj:IsA("BasePart") then
							obj.CastShadow = value
						else
							obj.Enabled = value
						end
					end
				end)
			end
		end
		table.clear(originalSettings)
	end
end

local function setPerformance(enabled)
	PerformanceEnabled = enabled
	pcall(function()
		if enabled then
			settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
			Lighting.GlobalShadows = false
			Lighting.FogEnd = 9e9
			StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
		else
			settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
			Lighting.GlobalShadows = true
			StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)
		end
	end)
end

-- ==================== BOSS FARM ====================
local BossFarm = {
	active = false,
	generation = 0,
	status = "Sin boss activo",
	originalCharacter = nil,
	originalPivot = nil,
	originalSize = nil,
	originalRootAnchored = nil,
	engagedBoss = nil,
	confirmedDamage = 0,
	attacks = 0,
	hitInterval = 0.31,
	antiLag = false,
	antiLagOriginals = setmetatable({}, { __mode = "k" }),
	antiLagConnection = nil,
	cameraRenderName = "ARGZBossStableCamera",
	cameraSaved = nil,
	cameraFocusPosition = nil,
	cameraStableCFrame = nil,
	lastPlayerHealth = nil,
	safetyTriggered = false,
	safeAttackPosition = nil,
}

local function findBoss()
	for _, boss in ipairs(CollectionService:GetTagged("BossEventBoss")) do
		if boss and boss.Parent then
			local part = boss:FindFirstChild("BossDamageHitbox", true)
				or boss.PrimaryPart
				or boss:FindFirstChild("Boss", true)
				or boss:FindFirstChild("Head", true)
				or boss:FindFirstChildWhichIsA("BasePart", true)
			if part and part:IsA("BasePart") then
				local target = boss:FindFirstChild("Boss")
					or boss:FindFirstChild("Head", true)
					or boss.PrimaryPart
					or part
				if not target:IsA("BasePart") then target = part end
				return boss, part, target
			end
		end
	end
	return nil, nil, nil
end

local function bossHealth()
	return math.max(0, tonumber(workspace:GetAttribute("BossHealth")) or 0)
end

local function setCharacterSize(size)
	local events = ReplicatedStorage:FindFirstChild("rEvents")
	local remote = events and events:FindFirstChild("changeSpeedSizeRemote")
	size = math.clamp(math.floor((tonumber(size) or 2) + 0.5), 1, 100)
	if not remote then return false end
	if remote:IsA("RemoteEvent") then
		return pcall(remote.FireServer, remote, "changeSize", size)
	elseif remote:IsA("RemoteFunction") then
		return pcall(remote.InvokeServer, remote, "changeSize", size)
	end
	return false
end

local function readCharacterSize()
	local humanoid = getHumanoid()
	local height = humanoid and humanoid:FindFirstChild("BodyHeightScale")
	return math.clamp(math.floor(((height and height.Value) or 2) + 0.5), 1, 100)
end

local function equipBossPunch()
	local character = getCharacter()
	local humanoid = getHumanoid()
	local backpack = LP:FindFirstChild("Backpack")
	local punch = character and character:FindFirstChild("Punch")
		or (backpack and backpack:FindFirstChild("Punch"))
	if punch and humanoid and punch.Parent ~= character then
		pcall(humanoid.EquipTool, humanoid, punch)
		RunService.Heartbeat:Wait()
	end
	local attackTime = punch and punch:FindFirstChild("attackTime")
	if attackTime and attackTime:IsA("ValueBase") then attackTime.Value = 0 end
	return punch
end

function BossFarm:ApplyAntiLagObject(object)
	if not self.antiLag or not object then return end
	local property
	if object:IsA("ParticleEmitter") or object:IsA("Trail") or object:IsA("Beam")
		or object:IsA("Fire") or object:IsA("Smoke") or object:IsA("Sparkles")
		or object:IsA("PointLight") or object:IsA("SpotLight") or object:IsA("SurfaceLight")
		or object:IsA("Highlight") then
		property = "Enabled"
	elseif object:IsA("BasePart") then
		property = "CastShadow"
	end
	if property and self.antiLagOriginals[object] == nil then
		self.antiLagOriginals[object] = { property = property, value = object[property] }
		pcall(function() object[property] = false end)
	end
end

function BossFarm:SetAntiLag(enabled)
	enabled = enabled == true
	self.antiLag = enabled
	if self.antiLagConnection then
		self.antiLagConnection:Disconnect()
		self.antiLagConnection = nil
	end
	if not enabled then
		for object, saved in pairs(self.antiLagOriginals) do
			if object and object.Parent then
				pcall(function() object[saved.property] = saved.value end)
			end
			self.antiLagOriginals[object] = nil
		end
		return true
	end
	local events = workspace:FindFirstChild("Events")
	local arena = events and events:FindFirstChild("BossArena")
	if not arena then self.antiLag = false; return false end
	for _, object in ipairs(arena:GetDescendants()) do
		self:ApplyAntiLagObject(object)
	end
	self.antiLagConnection = arena.DescendantAdded:Connect(function(object)
		task.defer(function() self:ApplyAntiLagObject(object) end)
	end)
	return true
end

function BossFarm:StopStableCamera()
	pcall(RunService.UnbindFromRenderStep, RunService, self.cameraRenderName)
	local camera = workspace.CurrentCamera
	local saved = self.cameraSaved
	if camera and saved then
		pcall(function()
			camera.CameraType = Enum.CameraType.Scriptable
			camera.CFrame = saved.cframe
			camera.Focus = saved.focus
			if saved.subject and saved.subject.Parent then
				camera.CameraSubject = saved.subject
			end
			camera.CameraType = saved.cameraType
		end)
	end
	self.cameraSaved = nil
	self.cameraFocusPosition = nil
	self.cameraStableCFrame = nil
end

function BossFarm:StartStableCamera()
	self:StopStableCamera()
	local camera = workspace.CurrentCamera
	if not camera then return end
	self.cameraSaved = {
		cameraType = camera.CameraType,
		subject = camera.CameraSubject,
		cframe = camera.CFrame,
		focus = camera.Focus,
	}
	camera.CameraType = Enum.CameraType.Scriptable
	RunService:BindToRenderStep(self.cameraRenderName, Enum.RenderPriority.Camera.Value + 50, function(delta)
		local focus = self.cameraFocusPosition
		local currentCamera = workspace.CurrentCamera
		if not self.engagedBoss or not focus or not currentCamera then return end
		local desired = CFrame.lookAt(focus + Vector3.new(0, 34, 48), focus + Vector3.new(0, -5, 0))
		self.cameraStableCFrame = self.cameraStableCFrame and self.cameraStableCFrame:Lerp(desired, math.clamp(delta * 4, 0.04, 0.22)) or desired
		currentCamera.CameraType = Enum.CameraType.Scriptable
		currentCamera.CFrame = self.cameraStableCFrame
		currentCamera.Focus = CFrame.new(focus)
	end)
end

function BossFarm:WaitForReadyCharacter(timeout)
	local deadline = os.clock() + (tonumber(timeout) or 8)
	local stableCharacter, stableRoot, stableAt
	while self.active and os.clock() < deadline do
		local character = getCharacter()
		local root = character and character:FindFirstChild("HumanoidRootPart")
		local humanoid = character and character:FindFirstChildWhichIsA("Humanoid")
		local machine = LP:FindFirstChild("machineInUse")
		local rebirthing = character and (character:GetAttribute("IsRebirthing") == true or character:GetAttribute("LastMapCFrame") ~= nil)
		local mounted = (machine and machine.Value ~= nil) or (humanoid and humanoid.SeatPart ~= nil)
		if character and root and humanoid and humanoid.Health > 0 and not rebirthing and not mounted then
			if character ~= stableCharacter or root ~= stableRoot then
				stableCharacter, stableRoot, stableAt = character, root, os.clock()
			elseif os.clock() - stableAt >= 0.18 then
				return character, root, humanoid
			end
		else
			stableCharacter, stableRoot, stableAt = nil, nil, nil
		end
		task.wait(0.05)
	end
	return nil, nil, nil
end

function BossFarm:BeginBattle(boss)
	if self.engagedBoss == boss then return true end
	local wasFarming = FastFarm
	FastFarm = false
	local character, root = self:WaitForReadyCharacter(8)
	if not character or not root or boss.Parent == nil or workspace:GetAttribute("BossActive") ~= true then
		FastFarm = wasFarming
		self:RestoreBattle()
		return false
	end
	self.originalCharacter = character
	self.originalPivot = character:GetPivot()
	self.originalSize = readCharacterSize()
	self.originalRootAnchored = root.Anchored
	self.engagedBoss = boss
	self.confirmedDamage = 0
	self.attacks = 0
	self.safetyTriggered = false
	self.lastPlayerHealth = nil
	self.safeAttackPosition = nil
	self._wasFarming = wasFarming
	self:StartStableCamera()
	setCharacterSize(5)
	task.wait(0.55)
	local humanoid = getHumanoid()
	self.lastPlayerHealth = humanoid and humanoid.Health or nil
	return true
end

function BossFarm:RestoreBattle()
	local character = LP.Character
	local root = character and character:FindFirstChild("HumanoidRootPart")
	if character and character == self.originalCharacter and root and self.originalPivot then
		character:PivotTo(self.originalPivot)
		root.AssemblyLinearVelocity = Vector3.zero
		root.AssemblyAngularVelocity = Vector3.zero
		if self.originalRootAnchored ~= nil then
			root.Anchored = self.originalRootAnchored
		end
	end
	if self.originalSize then 
		setCharacterSize(self.originalSize) 
	end
	self:StopStableCamera()
	FastFarm = self._wasFarming or false
	self.engagedBoss = nil
end
