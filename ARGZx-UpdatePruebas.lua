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

local LP = Players.LocalPlayer or Players.PlayerAdded:Wait()

-- Función robusta para cargar UI
local function getUIParent()
	if gethui then return gethui() end
	local success, core = pcall(function() return game:GetService("CoreGui") end)
	if success and core then return core end
	return LP:WaitForChild("PlayerGui", 10) or LP:WaitForChild("PlayerGui")
end

local UIParent = getUIParent()

-- ==================== KEY SYSTEM ====================
local keyGui = Instance.new("ScreenGui")
keyGui.Name = "ARGZ_KeySystem"
keyGui.ResetOnSpawn = false
keyGui.IgnoreGuiInset = true
keyGui.Parent = UIParent

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

-- Esperar a que el usuario ponga la key correcta para continuar
repeat task.wait(0.2) until isVerified

-- ==================== VARIABLES PRINCIPALES ====================
local FastFarm = false
local AutoRebirth = false
local FastRebirth = false
local isOPMode = false
local BossFarm = { active = false }

repeat task.wait(0.3) until LP:FindFirstChild("muscleEvent") and LP:FindFirstChild("leaderstats")
local leaderstats = LP:WaitForChild("leaderstats")
local Strength = leaderstats:WaitForChild("Strength")
local Rebirths = leaderstats:WaitForChild("Rebirths")

local lastRebirths = Rebirths.Value

-- ==================== FUNCIONES TRASERAS ====================

-- Anti-AFK
LP.Idled:Connect(function()
	VirtualUser:CaptureController()
	VirtualUser:ClickButton2(Vector2.new())
end)

-- Helpers
local function getCharacter() return LP.Character end
local function getHumanoid() local char = getCharacter(); return char and char:FindFirstChildOfClass("Humanoid") end

-- Fast Farm (Optimizado 400-800 reps)
task.spawn(function()
	local cachedEvent = LP:FindFirstChild("muscleEvent")
	LP.ChildAdded:Connect(function(child)
		if child.Name == "muscleEvent" then cachedEvent = child end
	end)

	RunService.Heartbeat:Connect(function()
		if FastFarm and cachedEvent then
			local limit = isOPMode and 13 or 8 
			for i = 1, limit do
				pcall(function() cachedEvent:FireServer("rep") end)
			end
		end
	end)
end)

-- Auto Rebirth
local lastRebirthAttempt = 0
local function doRebirth()
	if tick() - lastRebirthAttempt < 0.2 then return end
	lastRebirthAttempt = tick()
	local rEvents = ReplicatedStorage:FindFirstChild("rEvents")
	local remote = rEvents and rEvents:FindFirstChild("rebirthRemote")
	if remote then
		pcall(function()
			if remote:IsA("RemoteFunction") then remote:InvokeServer("rebirthRequest") else remote:FireServer("rebirthRequest") end
		end)
	end
end

Strength:GetPropertyChangedSignal("Value"):Connect(function()
	if AutoRebirth or FastRebirth then doRebirth() end
end)

task.spawn(function()
	while task.wait(0.35) do
		if FastRebirth then doRebirth() end
		if Rebirths.Value > lastRebirths then
			lastRebirths = Rebirths.Value
		elseif Rebirths.Value < lastRebirths then
			lastRebirths = Rebirths.Value
		end
	end
end)

-- Anti Lag
local originalSettings = {}
local function setAntiLag(enabled)
	if enabled then
		for _, obj in ipairs(workspace:GetDescendants()) do
			if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") or obj:IsA("Fire") or obj:IsA("Smoke") then
				if originalSettings[obj] == nil then originalSettings[obj] = obj.Enabled end
				pcall(function() obj.Enabled = false end)
			elseif obj:IsA("BasePart") and obj.CastShadow then
				if originalSettings[obj] == nil then originalSettings[obj] = true end
				pcall(function() obj.CastShadow = false end)
			end
		end
	else
		for obj, value in pairs(originalSettings) do
			if obj and obj.Parent then pcall(function() if obj:IsA("BasePart") then obj.CastShadow = value else obj.Enabled = value end end) end
		end
		table.clear(originalSettings)
	end
end

local function setPerformance(enabled)
	pcall(function()
		if enabled then
			settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
			Lighting.GlobalShadows = false
			Lighting.FogEnd = 9e9
		else
			settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
			Lighting.GlobalShadows = true
		end
	end)
end

-- ==================== INTERFAZ GRÁFICA (ORION LIB) ====================
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexsoftware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "ARGZx Hub | Muscle Legends", HidePremium = true, SaveConfig = true, ConfigFolder = "ARGZxConfig"})

-- PESTAÑA: FARMING
local FarmTab = Window:MakeTab({ Name = "Auto Farm", Icon = "rbxassetid://4483345998", PremiumOnly = false })

FarmTab:AddToggle({
	Name = "Normal Fast Farm (Balanceado)",
	Default = false,
	Callback = function(Value)
		FastFarm = Value
		isOPMode = false
	end
})

FarmTab:AddToggle({
	Name = "OP Fast Farm (800 Reps/s)",
	Default = false,
	Callback = function(Value)
		FastFarm = Value
		isOPMode = true
	end
})

FarmTab:AddToggle({
	Name = "Auto Rebirth Clásico",
	Default = false,
	Callback = function(Value)
		AutoRebirth = Value
	end
})

FarmTab:AddToggle({
	Name = "Fast Rebirth (Spam)",
	Default = false,
	Callback = function(Value)
		FastRebirth = Value
	end
})

-- PESTAÑA: BOSS
local BossTab = Window:MakeTab({ Name = "Bosses", Icon = "rbxassetid://4483345998", PremiumOnly = false })

BossTab:AddToggle({
	Name = "Auto Boss Farm (BETA)",
	Default = false,
	Callback = function(Value)
		BossFarm.active = Value
		if Value then
			OrionLib:MakeNotification({Name = "Auto Boss", Content = "Buscando Boss Activo...", Image = "rbxassetid://4483345998", Time = 3})
		end
	end
})

-- PESTAÑA: OPTIMIZACIÓN
local MiscTab = Window:MakeTab({ Name = "Optimización", Icon = "rbxassetid://4483345998", PremiumOnly = false })

MiscTab:AddToggle({
	Name = "Anti-Lag (Quitar texturas y sombras)",
	Default = false,
	Callback = function(Value)
		setAntiLag(Value)
	end
})

MiscTab:AddToggle({
	Name = "Performance Mode (Gráficos al Mínimo)",
	Default = false,
	Callback = function(Value)
		setPerformance(Value)
	end
})

MiscTab:AddButton({
	Name = "Destruir Interfaz",
	Callback = function()
		OrionLib:Destroy()
	end
})

OrionLib:Init()
