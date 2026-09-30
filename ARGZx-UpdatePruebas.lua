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
local Lighting = game:GetService("Lighting")
local StarterGui = game:GetService("StarterGui")

local LP = Players.LocalPlayer
local PlayerGui = LP:WaitForChild("PlayerGui")

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
					if keyGui then keyGui:Destroy() end
					if gui then gui:Destroy() end
					if miniBtn then miniBtn:Destroy() end
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

repeat task.wait(0.3) until LP:FindFirstChild("muscleEvent") and LP:FindFirstChild("leaderstats")

local Strength = LP.leaderstats.Strength
local Rebirths = LP.leaderstats.Rebirths

-- ==================== VARIABLES ====================
local FastFarm = false
local AutoRebirth = false
local FastRebirth = false
local isOPMode = false
local FarmPower = 50
local AntiLagEnabled = false
local PerformanceEnabled = false
local AutoBuy = false
local SelectedCrystal = "Blue Crystal"

local startTime = tick()
local sessionRebirths = 0
local lastRebirths = Rebirths.Value

local CrystalList = {
	"Blue Crystal",
	"Green Crystal",
	"Frost Crystal",
	"Inferno Crystal",
	"Mythical Crystal",
	"Jungle Crystal",
	"Muscle Elite Crystal",
	"Industrial Crystal",
	"Overcharged Crystal"
}

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
	local gems = LP:FindFirstChild("Gems") or (LP:FindFirstChild("leaderstats") and LP.leaderstats:FindFirstChild("Gems"))
	return gems and tonumber(gems.Value) or 0
end

-- ==================== FAST FARM ====================
task.spawn(function()
	local cachedEvent = LP:FindFirstChild("muscleEvent")
	LP.ChildAdded:Connect(function(child)
		if child.Name == "muscleEvent" then
			cachedEvent = child
		end
	end)

	while true do
		if FastFarm then
			if not cachedEvent or not cachedEvent.Parent then
				cachedEvent = LP:FindFirstChild("muscleEvent")
			end
			if cachedEvent then
				local power = isOPMode and 400 or 50
				for i = 1, power do
					if not FastFarm then break end
					pcall(function()
						cachedEvent:FireServer("rep")
					end)
					if isOPMode then
						if i % 80 == 0 then task.wait() end
					else
						if i % 6 == 0 then task.wait() end
					end
				end
			end
			task.wait()
		else
			task.wait(0.12)
		end
	end
end)

-- ==================== AUTO REBIRTH ====================
local function doRebirth()
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

task.spawn(function()
	Strength:GetPropertyChangedSignal("Value"):Connect(function()
		if AutoRebirth or FastRebirth then
			doRebirth()
		end
	end)
	Rebirths:GetPropertyChangedSignal("Value"):Connect(function()
		if AutoRebirth or FastRebirth then
			task.wait(0.15)
			doRebirth()
		end
	end)
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

	for i = 1, math.min(#pets, 5) do
		pcall(function()
			humanoid:EquipTool(pets[i].tool)
		end)
		task.wait(0.04)
	end
end

task.spawn(function()
	local lastMode = "rep"
	while true do
		if FastRebirth then
			doRebirth()
			if Rebirths.Value > lastRebirths then
				equipBestPets("rep")
				lastMode = "rep"
				lastRebirths = Rebirths.Value
				sessionRebirths = sessionRebirths + 1
			else
				if lastMode ~= "rep" then
					equipBestPets("rep")
					lastMode = "rep"
				end
			end
			task.wait(0.35)
		else
			task.wait(0.5)
		end
	end
end)

task.spawn(function()
	while true do
		if Rebirths.Value > lastRebirths then
			sessionRebirths = sessionRebirths + (Rebirths.Value - lastRebirths)
			lastRebirths = Rebirths.Value
		elseif Rebirths.Value < lastRebirths then
			lastRebirths = Rebirths.Value
		end
		task.wait(0.5)
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

-- ==================== SHOP ====================
local function buyCrystal(crystalName)
	local rEvents = ReplicatedStorage:FindFirstChild("rEvents")
	if not rEvents then return false end

	local remote = rEvents:FindFirstChild("openCrystalRemote")
	if not remote then return false end

	local success = pcall(function()
		if remote:IsA("RemoteFunction") then
			remote:InvokeServer("openCrystal", crystalName)
		else
			remote:FireServer("openCrystal", crystalName)
		end
	end)
	return success
end

task.spawn(function()
	while true do
		if AutoBuy then
			local ok = buyCrystal(SelectedCrystal)
			task.wait(ok and 0.45 or 1.2)
		else
			task.wait(0.4)
		end
	end
end)

-- ==================== GUI ====================
local gui = Instance.new("ScreenGui")
gui.Name = "ARGZx_Modern"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = PlayerGui

local miniBtn = Instance.new("TextButton")
miniBtn.Name = "MiniARGZ"
miniBtn.Size = UDim2.new(0, 90, 0, 36)
miniBtn.Position = UDim2.new(0, 20, 0.5, -18)
miniBtn.BackgroundColor3 = Color3.fromRGB(18, 16, 28)
miniBtn.Text = "ARGZx"
miniBtn.TextColor3 = Color3.fromRGB(180, 140, 255)
miniBtn.Font = Enum.Font.GothamBold
miniBtn.TextSize = 15
miniBtn.Visible = false
miniBtn.Active = true
miniBtn.Draggable = true
miniBtn.Parent = gui
Instance.new("UICorner", miniBtn).CornerRadius = UDim.new(0, 10)

local miniStroke = Instance.new("UIStroke")
miniStroke.Color = Color3.fromRGB(120, 70, 255)
miniStroke.Thickness = 1.5
miniStroke.Parent = miniBtn

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.new(0, 500, 0, 440)
main.Position = UDim2.new(0.5, -250, 0.5, -220)
main.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = gui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 14)

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(50, 40, 80)
mainStroke.Thickness = 1
mainStroke.Parent = main

-- SIDEBAR
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 148, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
sidebar.BorderSizePixel = 0
sidebar.Parent = main
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 14)

local logoFrame = Instance.new("Frame")
logoFrame.Size = UDim2.new(1, 0, 0, 68)
logoFrame.BackgroundTransparency = 1
logoFrame.Parent = sidebar

local logoIcon = Instance.new("Frame")
logoIcon.Size = UDim2.new(0, 32, 0, 32)
logoIcon.Position = UDim2.new(0, 14, 0, 16)
logoIcon.BackgroundColor3 = Color3.fromRGB(110, 60, 240)
logoIcon.Parent = logoFrame
Instance.new("UICorner", logoIcon).CornerRadius = UDim.new(0, 8)

local logoLetter = Instance.new("TextLabel")
logoLetter.Size = UDim2.new(1, 0, 1, 0)
logoLetter.BackgroundTransparency = 1
logoLetter.Text = "A"
logoLetter.TextColor3 = Color3.fromRGB(255, 255, 255)
logoLetter.Font = Enum.Font.GothamBold
logoLetter.TextSize = 16
logoLetter.Parent = logoIcon

local logoTitle = Instance.new("TextLabel")
logo
