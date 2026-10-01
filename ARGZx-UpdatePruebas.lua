-- ==================== CONFIGURACI脫N DE KEY ====================
local ValidKey = "PRUEBA" -- <--- Cambia tu key aqu铆
local ScriptURL = "https://raw.githubusercontent.com/AngelOficialBe/ARGZx-Official-script/refs/heads/main/ARGZx-Script.lua"
-- ==============================================================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")

local LP = Players.LocalPlayer
local PlayerGui = LP:WaitForChild("PlayerGui")

-- ==================== KEY SYSTEM ====================
local keyGui = Instance.new("ScreenGui")
keyGui.Name = "ARGZ_KeySystem"
keyGui.ResetOnSpawn = false
keyGui.IgnoreGuiInset = true
keyGui.Parent = PlayerGui

local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(0, 300, 0, 180)
keyFrame.Position = UDim2.new(0.5, -150, 0.5, -90)
keyFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
keyFrame.BorderSizePixel = 0
keyFrame.Parent = keyGui
Instance.new("UICorner", keyFrame).CornerRadius = UDim.new(0, 12)

local keyStroke = Instance.new("UIStroke")
keyStroke.Color = Color3.fromRGB(180, 0, 0)
keyStroke.Thickness = 2
keyStroke.Parent = keyFrame

local keyTitle = Instance.new("TextLabel")
keyTitle.Size = UDim2.new(1, 0, 0, 40)
keyTitle.BackgroundTransparency = 1
keyTitle.Text = "馃攽 ARGZx Key System"
keyTitle.TextColor3 = Color3.fromRGB(255, 80, 80)
keyTitle.Font = Enum.Font.GothamBold
keyTitle.TextSize = 18
keyTitle.Parent = keyFrame

local keyInput = Instance.new("TextBox")
keyInput.Size = UDim2.new(0.85, 0, 0, 40)
keyInput.Position = UDim2.new(0.075, 0, 0, 60)
keyInput.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
keyInput.Text = ""
keyInput.PlaceholderText = "Ingresa la Key aqu铆..."
keyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
keyInput.Font = Enum.Font.Gotham
keyInput.TextSize = 14
keyInput.Parent = keyFrame
Instance.new("UICorner", keyInput).CornerRadius = UDim.new(0, 8)

local verifyBtn = Instance.new("TextButton")
verifyBtn.Size = UDim2.new(0.85, 0, 0, 40)
verifyBtn.Position = UDim2.new(0.075, 0, 0, 115)
verifyBtn.BackgroundColor3 = Color3.fromRGB(180, 30, 30)
verifyBtn.Text = "Verificar Key"
verifyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
verifyBtn.Font = Enum.Font.GothamBold
verifyBtn.TextSize = 14
verifyBtn.Parent = keyFrame
Instance.new("UICorner", verifyBtn).CornerRadius = UDim.new(0, 8)

local isVerified = false
verifyBtn.MouseButton1Click:Connect(function()
	if keyInput.Text == ValidKey then
		verifyBtn.Text = "隆Key Correcta!"
		verifyBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
		task.wait(1)
		keyGui:Destroy()
		isVerified = true
	else
		verifyBtn.Text = "Key Incorrecta"
		verifyBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
		task.wait(1)
		verifyBtn.Text = "Verificar Key"
		verifyBtn.BackgroundColor3 = Color3.fromRGB(180, 30, 30)
	end
end)

repeat task.wait(0.2) until isVerified

-- Kill-switch
task.spawn(function()
	while task.wait(10) do
		local success, onlineCode = pcall(function()
			return game:HttpGet(ScriptURL)
		end)
		if success then
			local onlineKey = string.match(onlineCode, 'local ValidKey%s*=%s*"(.-)"')
			if onlineKey and onlineKey ~= ValidKey then
				pcall(function()
					if keyGui then keyGui:Destroy() end
					if gui then gui:Destroy() end
				end)
				LP:Kick("鈿狅笍 [ARGZx] La Key ha sido actualizada o tu acceso fue revocado.")
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

repeat task.wait(0.3) until LP:FindFirstChild("muscleEvent") and LP:FindFirstChild("leaderstats")

local Strength = LP.leaderstats.Strength
local Rebirths = LP.leaderstats.Rebirths

-- ==================== VARIABLES GLOBALES ====================
local FastFarm = false
local AutoRebirth = false
local isOPMode = false
local FarmPower = 50

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

local function formatExact(n)
	n = tonumber(n) or 0
	if n >= 1e12 then return string.format("%.2fT", n/1e12)
	elseif n >= 1e9 then return string.format("%.2fB", n/1e9)
	elseif n >= 1e6 then return string.format("%.2fM", n/1e6)
	elseif n >= 1e3 then return string.format("%.1fK", n/1e3)
	else return tostring(math.floor(n)) end
end

-- ==================== FAST FARM ESTABLE ====================
-- Usa un ritmo temporal uniforme en vez de r谩fagas enormes.
-- El servidor puede limitar la cantidad de reps aceptadas; este sistema no
-- puede garantizar una tasa concreta de reps aceptadas por segundo.
local FarmConfig = {
	MainRate = 50,
	FastRate = 600,       -- objetivo local; no garantiza 600 reps aceptadas
	MaxBurst = 12,        -- evita acumulaciones que producen picos
	Tick = 0.02,
}

local function getMuscleEvent()
	local event = LP:FindFirstChild("muscleEvent")
	return event and event:IsA("RemoteEvent") and event or nil
end

task.spawn(function()
	local accumulator = 0
	local last = os.clock()

	while task.wait(FarmConfig.Tick) do
		local now = os.clock()
		local dt = math.clamp(now - last, 0, 0.10)
		last = now

		if not FastFarm then
			accumulator = 0
			continue
		end

		local event = getMuscleEvent()
		if not event then
			accumulator = 0
			continue
		end

		local rate = isOPMode and FarmConfig.FastRate or FarmConfig.MainRate
		accumulator = math.min(accumulator + rate * dt, FarmConfig.MaxBurst)

		local sends = math.min(math.floor(accumulator), FarmConfig.MaxBurst)
		if sends > 0 then
			accumulator -= sends
			for _ = 1, sends do
				if not FastFarm then break end
				pcall(event.FireServer, event, "rep")
			end
		end
	end
end)

-- ==================== AUTO REBIRTH ESTABLE ====================
task.spawn(function()
	local lastRequest = 0
	local minCooldown = 0.20

	local function getRemote()
		local rEvents = ReplicatedStorage:FindFirstChild("rEvents")
		return rEvents and rEvents:FindFirstChild("rebirthRemote")
	end

	local function tryRebirth()
		if not AutoRebirth then return end
		local now = os.clock()
		if now - lastRequest < minCooldown then return end

		local remote = getRemote()
		if not remote then return end

		lastRequest = now
		pcall(function()
			if remote:IsA("RemoteFunction") then
				remote:InvokeServer("rebirthRequest")
			elseif remote:IsA("RemoteEvent") then
				remote:FireServer("rebirthRequest")
			end
		end)
	end

	-- Eventos para reaccionar r谩pido.
	Strength:GetPropertyChangedSignal("Value"):Connect(tryRebirth)
	Rebirths:GetPropertyChangedSignal("Value"):Connect(function()
		if AutoRebirth then
			task.defer(tryRebirth)
		end
	end)

	-- Fallback peri贸dico: evita quedarse bloqueado si un cambio se pierde.
	while task.wait(0.10) do
		tryRebirth()
	end
end)

-- Contador sesi贸n
task.spawn(function()
	while true do
		if Rebirths.Value > lastRebirths then
			sessionRebirths += (Rebirths.Value - lastRebirths)
			lastRebirths = Rebirths.Value
		elseif Rebirths.Value < lastRebirths then
			lastRebirths = Rebirths.Value
		end
		task.wait(0.4)
	end
end)

-- ==================== BOSS FARM (adaptado) ====================
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
		self.cameraStableCFrame = self.cameraStableCFrame
			and self.cameraStableCFrame:Lerp(desired, math.clamp(delta * 4, 0.04, 0.22)) or desired
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
		local rebirthing = character and (character:GetAttribute("IsRebirthing") == true
			or character:GetAttribute("LastMapCFrame") ~= nil)
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

	-- Pausar Fast Farm temporalmente
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
	if self.originalSize then setCharacterSize(self.originalSize) end
	self:StopStableCamera()

	local backpack = LP:FindFirstChild("Backpack")
	local punch = character and character:FindFirstChild("Punch")
	if punch and backpack then punch.Parent = backpack end

	self.originalCharacter = nil
	self.originalPivot = nil
	self.originalSize = nil
	self.originalRootAnchored = nil
	self.engagedBoss = nil
	self.lastPlayerHealth = nil
	self.safeAttackPosition = nil

	-- Restaurar Fast Farm si estaba activo
	if self._wasFarming then
		FastFarm = true
		self._wasFarming = nil
	end
end

function BossFarm:CollectChest(timeout)
	if type(fireproximityprompt) ~= "function" then return false end
	local opened = false
	local openedConnection
	local remoteFolder = ReplicatedStorage:FindFirstChild("rEvents")
	local openedEvent = remoteFolder and remoteFolder:FindFirstChild("bossChestOpenedEvent")
	if openedEvent and openedEvent:IsA("RemoteEvent") then
		openedConnection = openedEvent.OnClientEvent:Connect(function() opened = true end)
	end

	local function finish(success)
		if openedConnection then openedConnection:Disconnect() end
		return success
	end

	local deadline = os.clock() + (tonumber(timeout) or 15)
	local pendingWasSeen, attempted, lastAttempt = false, false, 0

	while self.active and os.clock() < deadline do
		if opened then return finish(true) end

		local chestModel, prompt
		for _, candidate in ipairs(CollectionService:GetTagged("BossEventChest")) do
			prompt = candidate:FindFirstChild("bossChestPrompt", true)
			if prompt then chestModel = candidate break end
		end
		if not prompt then
			local events = workspace:FindFirstChild("Events")
			prompt = events and events:FindFirstChild("bossChestPrompt", true)
			chestModel = prompt and prompt:FindFirstAncestorOfClass("Model")
		end

		local eligible = LP:GetAttribute("BossChestEligible") == true
		local pending = LP:GetAttribute("BossChestPending") == true
		if pending then pendingWasSeen = true
		elseif attempted and pendingWasSeen then return finish(true) end

		local emerging = chestModel and chestModel:GetAttribute("BossChestEmerging") == true
		if prompt and prompt:IsA("ProximityPrompt") and eligible and pending and not emerging then
			local character = getCharacter()
			local root = getRoot()
			local parent = prompt.Parent
			if character and root and parent and parent:IsA("BasePart") then
				character:PivotTo(parent.CFrame * CFrame.new(0, math.max(4, parent.Size.Y * 0.5 + 3), 0))
				root.AssemblyLinearVelocity = Vector3.zero
				root.AssemblyAngularVelocity = Vector3.zero
				task.wait(0.12)
			end
			if prompt.Enabled and os.clock() - lastAttempt >= 0.45 then
				lastAttempt = os.clock()
				attempted = pcall(fireproximityprompt, prompt) or attempted
			end
		end
		task.wait(0.1)
	end
	return finish(opened or (attempted and pendingWasSeen and LP:GetAttribute("BossChestPending") ~= true))
end

function BossFarm:Fight(boss)
	if not self:BeginBattle(boss) then return end

	local lastHealth = bossHealth()
	local lastAttack = 0

	while self.active and boss.Parent and workspace:GetAttribute("BossActive") == true do
		local currentBoss, part, target = findBoss()
		if currentBoss ~= boss or not part or not target then break end

		local character = getCharacter()
		local root = getRoot()
		local humanoid = getHumanoid()
		local punch = equipBossPunch()

		if not character or not root or not humanoid or humanoid.Health <= 0 or not punch then
			self.status = "Esperando personaje"
			self:UpdateUi()
			task.wait(0.25)
		else
			if self.lastPlayerHealth and humanoid.Health < self.lastPlayerHealth then
				self.safetyTriggered = true
				self.active = false
				self.status = "Protecci贸n activada (te golpearon)"
				self:SetAntiLag(false)
				self:UpdateUi()
				break
			end
			self.lastPlayerHealth = humanoid.Health

			local bossTop = target.Position.Y + target.Size.Y * 0.5
			local clearance = math.max(6, root.Size.Y * 0.5 + 4)
			local desiredPosition = Vector3.new(part.Position.X, bossTop + clearance, part.Position.Z)

			if not self.safeAttackPosition or (desiredPosition - self.safeAttackPosition).Magnitude > 45 then
				self.safeAttackPosition = desiredPosition
			else
				self.safeAttackPosition = self.safeAttackPosition:Lerp(desiredPosition, 0.16)
			end

			local attackPosition = self.safeAttackPosition
			local aimPosition = target.Position + Vector3.new(0, target.Size.Y * 0.32, 0)
			self.cameraFocusPosition = self.cameraFocusPosition
				and self.cameraFocusPosition:Lerp(aimPosition, 0.08) or aimPosition

			character:PivotTo(CFrame.lookAt(attackPosition, aimPosition))
			root.AssemblyLinearVelocity = Vector3.zero
			root.AssemblyAngularVelocity = Vector3.zero

			local now = os.clock()
			if now - lastAttack >= self.hitInterval then
				lastAttack = now
				pcall(punch.Deactivate, punch)
				pcall(punch.Activate, punch)
				self.attacks += 1
			end

			local health = bossHealth()
			if health < lastHealth then
				self.confirmedDamage += (lastHealth - health)
			end
			lastHealth = health

			self.status = (workspace:GetAttribute("BossDisplayName") or "Boss")
				.. " 路 da帽o " .. formatExact(self.confirmedDamage)
			self:UpdateUi()
			task.wait(0.04)
		end
	end

	local defeated = workspace:GetAttribute("BossActive") ~= true or bossHealth() <= 0
	if defeated and self.active then
		self.status = "Boss derrotado 路 reclamando recompensa"
		self:UpdateUi()
		self:CollectChest(12)
	end
	self:RestoreBattle()
end

function BossFarm:Set(enabled)
	enabled = enabled == true
	self.generation += 1
	local generation = self.generation
	self.active = enabled

	if not enabled then
		self.status = "Sin boss activo"
		self:RestoreBattle()
		self:SetAntiLag(false)
		self:UpdateUi()
		return true
	end

	-- Verificar si el evento est谩 disponible
	local config = ReplicatedStorage:FindFirstChild("shared")
	config = config and config:FindFirstChild("config")
	config = config and config:FindFirstChild("BossEventConfig")
	local ok, values = pcall(function() return config and require(config) end)
	if not ok or type(values) ~= "table" or values.ENABLED ~= true then
		self.active = false
		self.status = "El evento del boss no est谩 disponible"
		self:SetAntiLag(false)
		self:UpdateUi()
		return false
	end

	self:SetAntiLag(true)
	self.hitInterval = math.max(0.31, (tonumber(values.MIN_HIT_INTERVAL) or 0.3) + 0.01)

	task.spawn(function()
		while self.active and self.generation == generation do
			local boss = findBoss()
			if boss and workspace:GetAttribute("BossActive") == true then
				self:Fight(boss)
			else
				self.engagedBoss = nil
				self.status = "Sin boss activo"
				self:UpdateUi()
				task.wait(0.4)
			end
		end
		if self.generation == generation then
			self:RestoreBattle()
		end
	end)

	self:UpdateUi()
	return true
end

function BossFarm:UpdateUi()
	if self.StatusLabel then
		self.StatusLabel.Text = self.status
		self.StatusLabel.TextColor3 = self.engagedBoss and Color3.fromRGB(100, 255, 140) or Color3.fromRGB(160, 160, 180)
	end
	if self.HealthLabel then
		local health = bossHealth()
		local maximum = math.max(health, tonumber(workspace:GetAttribute("BossMaxHealth")) or 0)
		if maximum > 0 and workspace:GetAttribute("BossActive") == true then
			self.HealthLabel.Text = formatExact(health) .. " / " .. formatExact(maximum)
		else
			self.HealthLabel.Text = "鈥�"
		end
	end
end

-- ==================== GUI ESTILO AURAL ====================
local gui = Instance.new("ScreenGui")
gui.Name = "ARGZx_AuralGUI_Improved"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = PlayerGui

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.new(0, 560, 0, 430)
main.Position = UDim2.new(0.5, -280, 0.5, -215)
main.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = gui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(40, 40, 50)
mainStroke.Thickness = 1
mainStroke.Parent = main

-- SIDEBAR
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 160, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
sidebar.BorderSizePixel = 0
sidebar.Parent = main
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 12)

local logoFrame = Instance.new("Frame")
logoFrame.Size = UDim2.new(1, 0, 0, 70)
logoFrame.BackgroundTransparency = 1
logoFrame.Parent = sidebar

local logoIcon = Instance.new("TextLabel")
logoIcon.Size = UDim2.new(0, 28, 0, 28)
logoIcon.Position = UDim2.new(0, 14, 0, 16)
logoIcon.BackgroundColor3 = Color3.fromRGB(90, 60, 220)
logoIcon.Text = "A"
logoIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
logoIcon.Font = Enum.Font.GothamBold
logoIcon.TextSize = 16
logoIcon.Parent = logoFrame
Instance.new("UICorner", logoIcon).CornerRadius = UDim.new(0, 6)

local logoTitle = Instance.new("TextLabel")
logoTitle.Size = UDim2.new(1, -50, 0, 20)
logoTitle.Position = UDim2.new(0, 50, 0, 14)
logoTitle.BackgroundTransparency = 1
logoTitle.Text = "ARGZx Paid"
logoTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
logoTitle.Font = Enum.Font.GothamBold
logoTitle.TextSize = 14
logoTitle.TextXAlignment = Enum.TextXAlignment.Left
logoTitle.Parent = logoFrame

local logoSub = Instance.new("TextLabel")
logoSub.Size = UDim2.new(1, -50, 0, 16)
logoSub.Position = UDim2.new(0, 50, 0, 34)
logoSub.BackgroundTransparency = 1
logoSub.Text = "Muscle Legends"
logoSub.TextColor3 = Color3.fromRGB(140, 140, 160)
logoSub.Font = Enum.Font.Gotham
logoSub.TextSize = 11
logoSub.TextXAlignment = Enum.TextXAlignment.Left
logoSub.Parent = logoFrame

local navContainer = Instance.new("Frame")
navContainer.Size = UDim2.new(1, -16, 1, -90)
navContainer.Position = UDim2.new(0, 8, 0, 75)
navContainer.BackgroundTransparency = 1
navContainer.Parent = sidebar

local navLayout = Instance.new("UIListLayout")
navLayout.Padding = UDim.new(0, 4)
navLayout.Parent = navContainer

local pages = {}
local currentPage = "Farming"

local function createNavButton(name, icon, order)
	local btn = Instance.new("TextButton")
	btn.Name = name
	btn.Size = UDim2.new(1, 0, 0, 36)
	btn.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
	btn.BorderSizePixel = 0
	btn.Text = ""
	btn.AutoButtonColor = false
	btn.LayoutOrder = order
	btn.Parent = navContainer
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

	local iconLabel = Instance.new("TextLabel")
	iconLabel.Size = UDim2.new(0, 28, 1, 0)
	iconLabel.Position = UDim2.new(0, 8, 0, 0)
	iconLabel.BackgroundTransparency = 1
	iconLabel.Text = icon
	iconLabel.TextColor3 = Color3.fromRGB(160, 160, 180)
	iconLabel.Font = Enum.Font.GothamBold
	iconLabel.TextSize = 14
	iconLabel.Parent = btn

	local textLabel = Instance.new("TextLabel")
	textLabel.Size = UDim2.new(1, -44, 1, 0)
	textLabel.Position = UDim2.new(0, 38, 0, 0)
	textLabel.BackgroundTransparency = 1
	textLabel.Text = name
	textLabel.TextColor3 = Color3.fromRGB(180, 180, 200)
	textLabel.Font = Enum.Font.GothamMedium
	textLabel.TextSize = 13
	textLabel.TextXAlignment = Enum.TextXAlignment.Left
	textLabel.Parent = btn

	local indicator = Instance.new("Frame")
	indicator.Name = "Indicator"
	indicator.Size = UDim2.new(0, 3, 0, 20)
	indicator.Position = UDim2.new(0, 0, 0.5, -10)
	indicator.BackgroundColor3 = Color3.fromRGB(120, 80, 255)
	indicator.BorderSizePixel = 0
	indicator.Visible = false
	indicator.Parent = btn
	Instance.new("UICorner", indicator).CornerRadius = UDim.new(0, 2)

	btn.MouseButton1Click:Connect(function()
		for _, page in pairs(pages) do page.Visible = false end
		if pages[name] then pages[name].Visible = true end
		currentPage = name

		for _, child in ipairs(navContainer:GetChildren()) do
			if child:IsA("TextButton") then
				child.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
				local ind = child:FindFirstChild("Indicator")
				if ind then ind.Visible = false end
			end
		end
		btn.BackgroundColor3 = Color3.fromRGB(28, 24, 45)
		indicator.Visible = true
	end)
	return btn
end

createNavButton("Home", "鈱�", 1)
local farmingNav = createNavButton("Farming", "鈿�", 2)
createNavButton("Teleports", "鈱�", 3)
local bossNav = createNavButton("Boss", "鈿�", 4)
createNavButton("Pets", "馃惥", 5)
createNavButton("Misc", "鉁�", 6)
createNavButton("Settings", "鈿�", 7)

farmingNav.BackgroundColor3 = Color3.fromRGB(28, 24, 45)
farmingNav:FindFirstChild("Indicator").Visible = true

-- CONTENT
local content = Instance.new("Frame")
content.Size = UDim2.new(1, -160, 1, 0)
content.Position = UDim2.new(0, 160, 0, 0)
content.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
content.BorderSizePixel = 0
content.Parent = main

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -36, 0, 10)
closeBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
closeBtn.Text = "鉁�"
closeBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.Parent = content
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)
closeBtn.MouseButton1Click:Connect(function()
	BossFarm:Set(false)
	gui:Destroy()
end)

-- ==================== MINIMIZAR ARGZx ====================
local miniButton = Instance.new("TextButton")
miniButton.Name = "ARGZxMini"
miniButton.Size = UDim2.new(0, 118, 0, 42)
miniButton.Position = UDim2.new(1, -132, 0, 18)
miniButton.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
miniButton.BorderSizePixel = 0
miniButton.Text = "ARGZx"
miniButton.TextColor3 = Color3.fromRGB(235, 235, 255)
miniButton.Font = Enum.Font.GothamBold
miniButton.TextSize = 15
miniButton.Visible = false
miniButton.AutoButtonColor = false
miniButton.Parent = gui
Instance.new("UICorner", miniButton).CornerRadius = UDim.new(0, 12)
local miniStroke = Instance.new("UIStroke")
miniStroke.Color = Color3.fromRGB(95, 70, 190)
miniStroke.Thickness = 1.5
miniStroke.Parent = miniButton

local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Name = "Minimize"
minimizeBtn.Size = UDim2.new(0, 28, 0, 28)
minimizeBtn.Position = UDim2.new(1, -70, 0, 10)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
minimizeBtn.Text = "鈥�"
minimizeBtn.TextColor3 = Color3.fromRGB(210, 210, 225)
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 16
minimizeBtn.Parent = content
Instance.new("UICorner", minimizeBtn).CornerRadius = UDim.new(0, 6)

minimizeBtn.MouseButton1Click:Connect(function()
	main.Visible = false
	miniButton.Visible = true
end)

miniButton.MouseButton1Click:Connect(function()
	miniButton.Visible = false
	main.Visible = true
end)

-- ========== HELPERS GUI ==========
local function createToggle(parent, yPos, titleText, descText, defaultState, callback)
	local row = Instance.new("Frame")
	row.Size = UDim2.new(1, -10, 0, 52)
	row.Position = UDim2.new(0, 0, 0, yPos)
	row.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
	row.BorderSizePixel = 0
	row.Parent = parent
	Instance.new("UICorner", row).CornerRadius = UDim.new(0, 8)

	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1, -70, 0, 20)
	title.Position = UDim2.new(0, 14, 0, 8)
	title.BackgroundTransparency = 1
	title.Text = titleText
	title.TextColor3 = Color3.fromRGB(240, 240, 250)
	title.Font = Enum.Font.GothamMedium
	title.TextSize = 13
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.Parent = row

	local desc = Instance.new("TextLabel")
	desc.Size = UDim2.new(1, -70, 0, 16)
	desc.Position = UDim2.new(0, 14, 0, 28)
	desc.BackgroundTransparency = 1
	desc.Text = descText
	desc.TextColor3 = Color3.fromRGB(130, 130, 150)
	desc.Font = Enum.Font.Gotham
	desc.TextSize = 11
	desc.TextXAlignment = Enum.TextXAlignment.Left
	desc.Parent = row

	local switchBg = Instance.new("Frame")
	switchBg.Size = UDim2.new(0, 42, 0, 24)
	switchBg.Position = UDim2.new(1, -56, 0.5, -12)
	switchBg.BackgroundColor3 = defaultState and Color3.fromRGB(100, 70, 220) or Color3.fromRGB(50, 50, 60)
	switchBg.BorderSizePixel = 0
	switchBg.Parent = row
	Instance.new("UICorner", switchBg).CornerRadius = UDim.new(1, 0)

	local knob = Instance.new("Frame")
	knob.Size = UDim2.new(0, 18, 0, 18)
	knob.Position = defaultState and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
	knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	knob.BorderSizePixel = 0
	knob.Parent = switchBg
	Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

	local state = defaultState
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 1, 0)
	btn.BackgroundTransparency = 1
	btn.Text = ""
	btn.Parent = row

	btn.MouseButton1Click:Connect(function()
		state = not state
		local tweenInfo = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		if state then
			TweenService:Create(switchBg, tweenInfo, {BackgroundColor3 = Color3.fromRGB(100, 70, 220)}):Play()
			TweenService:Create(knob, tweenInfo, {Position = UDim2.new(1, -21, 0.5, -9)}):Play()
		else
			TweenService:Create(switchBg, tweenInfo, {BackgroundColor3 = Color3.fromRGB(50, 50, 60)}):Play()
			TweenService:Create(knob, tweenInfo, {Position = UDim2.new(0, 3, 0.5, -9)}):Play()
		end
		if callback then callback(state) end
	end)
	return row
end

local function createSection(parent, yPos, text)
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 0, 20)
	label.Position = UDim2.new(0, 0, 0, yPos)
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = Color3.fromRGB(120, 100, 200)
	label.Font = Enum.Font.GothamBold
	label.TextSize = 11
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = parent
	return label
end

-- ========== PAGE: FARMING ==========
local farmingPage = Instance.new("ScrollingFrame")
farmingPage.Name = "Farming"
farmingPage.Size = UDim2.new(1, -20, 1, -50)
farmingPage.Position = UDim2.new(0, 10, 0, 45)
farmingPage.BackgroundTransparency = 1
farmingPage.BorderSizePixel = 0
farmingPage.ScrollBarThickness = 4
farmingPage.ScrollBarImageColor3 = Color3.fromRGB(80, 60, 160)
farmingPage.CanvasSize = UDim2.new(0, 0, 0, 420)
farmingPage.Parent = content
pages["Farming"] = farmingPage

local farmingTitle = Instance.new("TextLabel")
farmingTitle.Size = UDim2.new(1, 0, 0, 28)
farmingTitle.BackgroundTransparency = 1
farmingTitle.Text = "Farming"
farmingTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
farmingTitle.Font = Enum.Font.GothamBold
farmingTitle.TextSize = 20
farmingTitle.TextXAlignment = Enum.TextXAlignment.Left
farmingTitle.Parent = farmingPage

local farmingSub = Instance.new("TextLabel")
farmingSub.Size = UDim2.new(1, 0, 0, 18)
farmingSub.Position = UDim2.new(0, 0, 0, 26)
farmingSub.BackgroundTransparency = 1
farmingSub.Text = "Strength, rebirth, boosts"
farmingSub.TextColor3 = Color3.fromRGB(140, 140, 160)
farmingSub.Font = Enum.Font.Gotham
farmingSub.TextSize = 12
farmingSub.TextXAlignment = Enum.TextXAlignment.Left
farmingSub.Parent = farmingPage

createSection(farmingPage, 55, "FAST FARM")
createToggle(farmingPage, 78, "Fast Farm", "Activa el farmeo autom谩tico de reps", false, function(state)
	FastFarm = state
end)

-- Mode selector
local modeRow = Instance.new("Frame")
modeRow.Size = UDim2.new(1, -10, 0, 52)
modeRow.Position = UDim2.new(0, 0, 0, 138)
modeRow.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
modeRow.BorderSizePixel = 0
modeRow.Parent = farmingPage
Instance.new("UICorner", modeRow).CornerRadius = UDim.new(0, 8)

local modeTitle = Instance.new("TextLabel")
modeTitle.Size = UDim2.new(1, -140, 0, 20)
modeTitle.Position = UDim2.new(0, 14, 0, 8)
modeTitle.BackgroundTransparency = 1
modeTitle.Text = "Farm Mode"
modeTitle.TextColor3 = Color3.fromRGB(240, 240, 250)
modeTitle.Font = Enum.Font.GothamMedium
modeTitle.TextSize = 13
modeTitle.TextXAlignment = Enum.TextXAlignment.Left
modeTitle.Parent = modeRow

local modeDesc = Instance.new("TextLabel")
modeDesc.Size = UDim2.new(1, -140, 0, 16)
modeDesc.Position = UDim2.new(0, 14, 0, 28)
modeDesc.BackgroundTransparency = 1
modeDesc.Text = "Main = estable  |  Fast = OP (m谩s poder)"
modeDesc.TextColor3 = Color3.fromRGB(130, 130, 150)
modeDesc.Font = Enum.Font.Gotham
modeDesc.TextSize = 11
modeDesc.TextXAlignment = Enum.TextXAlignment.Left
modeDesc.Parent = modeRow

local mainModeBtn = Instance.new("TextButton")
mainModeBtn.Size = UDim2.new(0, 55, 0, 28)
mainModeBtn.Position = UDim2.new(1, -125, 0.5, -14)
mainModeBtn.BackgroundColor3 = Color3.fromRGB(100, 70, 220)
mainModeBtn.Text = "Main"
mainModeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
mainModeBtn.Font = Enum.Font.GothamBold
mainModeBtn.TextSize = 12
mainModeBtn.Parent = modeRow
Instance.new("UICorner", mainModeBtn).CornerRadius = UDim.new(0, 6)

local opModeBtn = Instance.new("TextButton")
opModeBtn.Size = UDim2.new(0, 55, 0, 28)
opModeBtn.Position = UDim2.new(1, -62, 0.5, -14)
opModeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
opModeBtn.Text = "Fast"
opModeBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
opModeBtn.Font = Enum.Font.GothamBold
opModeBtn.TextSize = 12
opModeBtn.Parent = modeRow
Instance.new("UICorner", opModeBtn).CornerRadius = UDim.new(0, 6)

local function setMode(op)
	isOPMode = op
	FarmPower = op and FarmConfig.FastRate or FarmConfig.MainRate
	if op then
		mainModeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
		mainModeBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
		opModeBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
		opModeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	else
		mainModeBtn.BackgroundColor3 = Color3.fromRGB(100, 70, 220)
		mainModeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
		opModeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
		opModeBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
	end
end
mainModeBtn.MouseButton1Click:Connect(function() setMode(false) end)
opModeBtn.MouseButton1Click:Connect(function() setMode(true) end)

createSection(farmingPage, 205, "REBIRTH")
createToggle(farmingPage, 228, "Auto Rebirth", "Invokes rebirth when strength hits threshold", false, function(state)
	AutoRebirth = state
end)

createSection(farmingPage, 295, "SESSION STATS")
local statsFrame = Instance.new("Frame")
statsFrame.Size = UDim2.new(1, -10, 0, 90)
statsFrame.Position = UDim2.new(0, 0, 0, 318)
statsFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
statsFrame.BorderSizePixel = 0
statsFrame.Parent = farmingPage
Instance.new("UICorner", statsFrame).CornerRadius = UDim.new(0, 8)

local rebirthsLabel = Instance.new("TextLabel")
rebirthsLabel.Size = UDim2.new(1, -20, 0, 22)
rebirthsLabel.Position = UDim2.new(0, 14, 0, 12)
rebirthsLabel.BackgroundTransparency = 1
rebirthsLabel.Text = "Rebirths sesi贸n: 0"
rebirthsLabel.TextColor3 = Color3.fromRGB(160, 255, 160)
rebirthsLabel.Font = Enum.Font.GothamMedium
rebirthsLabel.TextSize = 13
rebirthsLabel.TextXAlignment = Enum.TextXAlignment.Left
rebirthsLabel.Parent = statsFrame

local timeLabel = Instance.new("TextLabel")
timeLabel.Size = UDim2.new(1, -20, 0, 20)
timeLabel.Position = UDim2.new(0, 14, 0, 36)
timeLabel.BackgroundTransparency = 1
timeLabel.Text = "Tiempo: 0h 0m"
timeLabel.TextColor3 = Color3.fromRGB(180, 180, 210)
timeLabel.Font = Enum.Font.Gotham
timeLabel.TextSize = 12
timeLabel.TextXAlignment = Enum.TextXAlignment.Left
timeLabel.Parent = statsFrame

local rateLabel = Instance.new("TextLabel")
rateLabel.Size = UDim2.new(1, -20, 0, 20)
rateLabel.Position = UDim2.new(0, 14, 0, 58)
rateLabel.BackgroundTransparency = 1
rateLabel.Text = "Velocidad: 0 /h"
rateLabel.TextColor3 = Color3.fromRGB(140, 190, 255)
rateLabel.Font = Enum.Font.Gotham
rateLabel.TextSize = 12
rateLabel.TextXAlignment = Enum.TextXAlignment.Left
rateLabel.Parent = statsFrame

task.spawn(function()
	while true do
		local elapsed = tick() - startTime
		local hours = math.floor(elapsed / 3600)
		local minutes = math.floor((elapsed % 3600) / 60)
		local rate = elapsed > 15 and math.floor((sessionRebirths / elapsed) * 3600) or 0
		rebirthsLabel.Text = "Rebirths sesi贸n: " .. sessionRebirths
		timeLabel.Text = string.format("Tiempo: %dh %dm", hours, minutes)
		rateLabel.Text = "Velocidad: " .. rate .. " /h"
		task.wait(1)
	end
end)

-- ========== PAGE: BOSS ==========
local bossPage = Instance.new("ScrollingFrame")
bossPage.Name = "Boss"
bossPage.Size = UDim2.new(1, -20, 1, -50)
bossPage.Position = UDim2.new(0, 10, 0, 45)
bossPage.BackgroundTransparency = 1
bossPage.BorderSizePixel = 0
bossPage.ScrollBarThickness = 4
bossPage.ScrollBarImageColor3 = Color3.fromRGB(80, 60, 160)
bossPage.CanvasSize = UDim2.new(0, 0, 0, 380)
bossPage.Visible = false
bossPage.Parent = content
pages["Boss"] = bossPage

local bossTitle = Instance.new("TextLabel")
bossTitle.Size = UDim2.new(1, 0, 0, 28)
bossTitle.BackgroundTransparency = 1
bossTitle.Text = "Boss"
bossTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
bossTitle.Font = Enum.Font.GothamBold
bossTitle.TextSize = 20
bossTitle.TextXAlignment = Enum.TextXAlignment.Left
bossTitle.Parent = bossPage

local bossSub = Instance.new("TextLabel")
bossSub.Size = UDim2.new(1, 0, 0, 18)
bossSub.Position = UDim2.new(0, 0, 0, 26)
bossSub.BackgroundTransparency = 1
bossSub.Text = "Auto Boss Event"
bossSub.TextColor3 = Color3.fromRGB(140, 140, 160)
bossSub.Font = Enum.Font.Gotham
bossSub.TextSize = 12
bossSub.TextXAlignment = Enum.TextXAlignment.Left
bossSub.Parent = bossPage

createSection(bossPage, 55, "AUTO BOSS")

-- Status
local statusRow = Instance.new("Frame")
statusRow.Size = UDim2.new(1, -10, 0, 42)
statusRow.Position = UDim2.new(0, 0, 0, 78)
statusRow.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
statusRow.BorderSizePixel = 0
statusRow.Parent = bossPage
Instance.new("UICorner", statusRow).CornerRadius = UDim.new(0, 8)

local statusTitle = Instance.new("TextLabel")
statusTitle.Size = UDim2.new(0, 70, 1, 0)
statusTitle.Position = UDim2.new(0, 14, 0, 0)
statusTitle.BackgroundTransparency = 1
statusTitle.Text = "Estado:"
statusTitle.TextColor3 = Color3.fromRGB(160, 160, 180)
statusTitle.Font = Enum.Font.Gotham
statusTitle.TextSize = 12
statusTitle.TextXAlignment = Enum.TextXAlignment.Left
statusTitle.Parent = statusRow

BossFarm.StatusLabel = Instance.new("TextLabel")
BossFarm.StatusLabel.Size = UDim2.new(1, -90, 1, 0)
BossFarm.StatusLabel.Position = UDim2.new(0, 80, 0, 0)
BossFarm.StatusLabel.BackgroundTransparency = 1
BossFarm.StatusLabel.Text = "Sin boss activo"
BossFarm.StatusLabel.TextColor3 = Color3.fromRGB(160, 160, 180)
BossFarm.StatusLabel.Font = Enum.Font.GothamMedium
BossFarm.StatusLabel.TextSize = 13
BossFarm.StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
BossFarm.StatusLabel.Parent = statusRow

-- Health
local healthRow = Instance.new("Frame")
healthRow.Size = UDim2.new(1, -10, 0, 42)
healthRow.Position = UDim2.new(0, 0, 0, 128)
healthRow.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
healthRow.BorderSizePixel = 0
healthRow.Parent = bossPage
Instance.new("UICorner", healthRow).CornerRadius = UDim.new(0, 8)

local healthTitle = Instance.new("TextLabel")
healthTitle.Size = UDim2.new(0, 100, 1, 0)
healthTitle.Position = UDim2.new(0, 14, 0, 0)
healthTitle.BackgroundTransparency = 1
healthTitle.Text = "Vida del boss:"
healthTitle.TextColor3 = Color3.fromRGB(160, 160, 180)
healthTitle.Font = Enum.Font.Gotham
healthTitle.TextSize = 12
healthTitle.TextXAlignment = Enum.TextXAlignment.Left
healthTitle.Parent = healthRow

BossFarm.HealthLabel = Instance.new("TextLabel")
BossFarm.HealthLabel.Size = UDim2.new(1, -120, 1, 0)
BossFarm.HealthLabel.Position = UDim2.new(0, 110, 0, 0)
BossFarm.HealthLabel.BackgroundTransparency = 1
BossFarm.HealthLabel.Text = "鈥�"
BossFarm.HealthLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
BossFarm.HealthLabel.Font = Enum.Font.GothamMedium
BossFarm.HealthLabel.TextSize = 13
BossFarm.HealthLabel.TextXAlignment = Enum.TextXAlignment.Left
BossFarm.HealthLabel.Parent = healthRow

-- Toggle Auto Boss
createToggle(bossPage, 185, "Atacar al boss", "Auto farm del evento Boss (pausa Fast Farm autom谩ticamente)", false, function(state)
	local accepted = BossFarm:Set(state)
	if accepted == false then
		-- Si fall贸, forzar el toggle visual a off (el createToggle no tiene Set, pero el estado se maneja)
	end
end)

createSection(bossPage, 255, "INFO")
local infoLabel = Instance.new("TextLabel")
infoLabel.Size = UDim2.new(1, -10, 0, 80)
infoLabel.Position = UDim2.new(0, 0, 0, 278)
infoLabel.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
infoLabel.BorderSizePixel = 0
infoLabel.Text = "鈥� Detecta autom谩ticamente cuando aparece el Boss\n鈥� Cambia tama帽o a 5, ataca desde arriba\n鈥� Anti-lag + c谩mara estable\n鈥� Reclama el cofre al derrotarlo\n鈥� Se apaga si te hacen da帽o (protecci贸n)"
infoLabel.TextColor3 = Color3.fromRGB(150, 150, 170)
infoLabel.Font = Enum.Font.Gotham
infoLabel.TextSize = 12
infoLabel.TextXAlignment = Enum.TextXAlignment.Left
infoLabel.TextYAlignment = Enum.TextYAlignment.Top
infoLabel.Parent = bossPage
Instance.new("UICorner", infoLabel).CornerRadius = UDim.new(0, 8)
Instance.new("UIPadding", infoLabel).PaddingTop = UDim.new(0, 10)
Instance.new("UIPadding", infoLabel).PaddingLeft = UDim.new(0, 12)

-- ========== P脕GINAS AUXILIARES ==========
local function createPlaceholderPage(name, titleText, subText)
	local page = Instance.new("ScrollingFrame")
	page.Name = name
	page.Size = UDim2.new(1, -20, 1, -50)
	page.Position = UDim2.new(0, 10, 0, 45)
	page.BackgroundTransparency = 1
	page.BorderSizePixel = 0
	page.ScrollBarThickness = 4
	page.CanvasSize = UDim2.new(0, 0, 0, 260)
	page.Visible = false
	page.Parent = content
	pages[name] = page

	local t = Instance.new("TextLabel")
	t.Size = UDim2.new(1, 0, 0, 28)
	t.BackgroundTransparency = 1
	t.Text = titleText
	t.TextColor3 = Color3.fromRGB(255, 255, 255)
	t.Font = Enum.Font.GothamBold
	t.TextSize = 20
	t.TextXAlignment = Enum.TextXAlignment.Left
	t.Parent = page

	local sub = Instance.new("TextLabel")
	sub.Size = UDim2.new(1, 0, 0, 18)
	sub.Position = UDim2.new(0, 0, 0, 28)
	sub.BackgroundTransparency = 1
	sub.Text = subText
	sub.TextColor3 = Color3.fromRGB(140, 140, 160)
	sub.Font = Enum.Font.Gotham
	sub.TextSize = 12
	sub.TextXAlignment = Enum.TextXAlignment.Left
	sub.Parent = page

	local coming = Instance.new("TextLabel")
	coming.Size = UDim2.new(1, 0, 0, 30)
	coming.Position = UDim2.new(0, 0, 0, 90)
	coming.BackgroundTransparency = 1
	coming.Text = "M贸dulo disponible pr贸ximamente"
	coming.TextColor3 = Color3.fromRGB(100, 100, 120)
	coming.Font = Enum.Font.GothamMedium
	coming.TextSize = 15
	coming.Parent = page
end

createPlaceholderPage("Home", "Home", "Overview & status")
createPlaceholderPage("Teleports", "Teleports", "Quick travel locations")
createPlaceholderPage("Pets", "Pets", "Pet management")
createPlaceholderPage("Misc", "Misc", "Extra utilities")

-- Settings real: rendimiento y optimizaci贸n.
local settingsPage = Instance.new("ScrollingFrame")
settingsPage.Name = "Settings"
settingsPage.Size = UDim2.new(1, -20, 1, -50)
settingsPage.Position = UDim2.new(0, 10, 0, 45)
settingsPage.BackgroundTransparency = 1
settingsPage.BorderSizePixel = 0
settingsPage.ScrollBarThickness = 4
settingsPage.CanvasSize = UDim2.new(0, 0, 0, 390)
settingsPage.Visible = false
settingsPage.Parent = content
pages["Settings"] = settingsPage

local settingsTitle = Instance.new("TextLabel")
settingsTitle.Size = UDim2.new(1, 0, 0, 28)
settingsTitle.BackgroundTransparency = 1
settingsTitle.Text = "Settings"
settingsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
settingsTitle.Font = Enum.Font.GothamBold
settingsTitle.TextSize = 20
settingsTitle.TextXAlignment = Enum.TextXAlignment.Left
settingsTitle.Parent = settingsPage

local settingsSub = Instance.new("TextLabel")
settingsSub.Size = UDim2.new(1, 0, 0, 18)
settingsSub.Position = UDim2.new(0, 0, 0, 28)
settingsSub.BackgroundTransparency = 1
settingsSub.Text = "Performance, UI y estabilidad"
settingsSub.TextColor3 = Color3.fromRGB(140, 140, 160)
settingsSub.Font = Enum.Font.Gotham
settingsSub.TextSize = 12
settingsSub.TextXAlignment = Enum.TextXAlignment.Left
settingsSub.Parent = settingsPage

local savedVisuals = setmetatable({}, {__mode = "k"})
local performanceEnabled = false

local function setPerformance(enabled)
	performanceEnabled = enabled == true
	for _, obj in ipairs(workspace:GetDescendants()) do
		if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam")
			or obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles")
			or obj:IsA("PointLight") or obj:IsA("SpotLight") or obj:IsA("SurfaceLight")
			or obj:IsA("Highlight") then
			if savedVisuals[obj] == nil then savedVisuals[obj] = obj.Enabled end
			pcall(function() obj.Enabled = not enabled end)
		elseif obj:IsA("BasePart") then
			if savedVisuals[obj] == nil then savedVisuals[obj] = obj.CastShadow end
			pcall(function() obj.CastShadow = not enabled end)
		end
	end
	if not enabled then
		for obj, old in pairs(savedVisuals) do
			if obj and obj.Parent then pcall(function() obj.Enabled = old end); pcall(function() obj.CastShadow = old end) end
			savedVisuals[obj] = nil
		end
	end
end

createSection(settingsPage, 58, "PERFORMANCE")
createToggle(settingsPage, 82, "Performance Mode", "Reduce part铆culas, luces, highlights y sombras", false, setPerformance)

createToggle(settingsPage, 145, "Stable UI", "Reduce animaciones visuales para bajar trabajo del cliente", true, function(state)
	-- Las funciones de farmeo no dependen de esta opci贸n.
	-- Se conserva como preferencia visual para futuras animaciones.
	_G.ARGZxStableUI = state
end)

createSection(settingsPage, 210, "FARM STABILITY")
local rateInfo = Instance.new("TextLabel")
rateInfo.Size = UDim2.new(1, -10, 0, 70)
rateInfo.Position = UDim2.new(0, 0, 0, 234)
rateInfo.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
rateInfo.BorderSizePixel = 0
rateInfo.Text = "Main: 50 reps/s objetivo local\nFast Farm OP: 600 reps/s objetivo local\nEl servidor puede aplicar sus propios l铆mites."
rateInfo.TextColor3 = Color3.fromRGB(155, 155, 175)
rateInfo.Font = Enum.Font.Gotham
rateInfo.TextSize = 12
rateInfo.TextXAlignment = Enum.TextXAlignment.Left
rateInfo.TextYAlignment = Enum.TextYAlignment.Center
rateInfo.Parent = settingsPage
Instance.new("UICorner", rateInfo).CornerRadius = UDim.new(0, 8)
local pad = Instance.new("UIPadding", rateInfo)
pad.PaddingLeft = UDim.new(0, 12)

-- Tecla para ocultar/mostrar
UserInputService.InputBegan:Connect(function(input, gp)
	if gp then return end
	if input.KeyCode == Enum.KeyCode.RightControl then
		if main.Visible then
			main.Visible = false
			miniButton.Visible = true
		else
			miniButton.Visible = false
			main.Visible = true
		end
	end
end)

BossFarm:UpdateUi()
print("ARGZx Aural GUI + Auto Boss cargado")
