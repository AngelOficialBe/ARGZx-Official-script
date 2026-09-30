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
logoTitle.Size = UDim2.new(1, -54, 0, 18)
logoTitle.Position = UDim2.new(0, 52, 0, 16)
logoTitle.BackgroundTransparency = 1
logoTitle.Text = "ARGZx"
logoTitle.TextColor3 = Color3.fromRGB(240, 240, 255)
logoTitle.Font = Enum.Font.GothamBold
logoTitle.TextSize = 15
logoTitle.TextXAlignment = Enum.TextXAlignment.Left
logoTitle.Parent = logoFrame

local logoSub = Instance.new("TextLabel")
logoSub.Size = UDim2.new(1, -54, 0, 14)
logoSub.Position = UDim2.new(0, 52, 0, 36)
logoSub.BackgroundTransparency = 1
logoSub.Text = "Muscle Legends"
logoSub.TextColor3 = Color3.fromRGB(130, 130, 155)
logoSub.Font = Enum.Font.Gotham
logoSub.TextSize = 11
logoSub.TextXAlignment = Enum.TextXAlignment.Left
logoSub.Parent = logoFrame

local navContainer = Instance.new("Frame")
navContainer.Size = UDim2.new(1, -12, 1, -80)
navContainer.Position = UDim2.new(0, 6, 0, 72)
navContainer.BackgroundTransparency = 1
navContainer.Parent = sidebar

local navLayout = Instance.new("UIListLayout")
navLayout.Padding = UDim.new(0, 3)
navLayout.Parent = navContainer

local pages = {}
local currentPage = "Farming"

local function createNavButton(name, icon, order)
	local btn = Instance.new("TextButton")
	btn.Name = name
	btn.Size = UDim2.new(1, 0, 0, 34)
	btn.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
	btn.BorderSizePixel = 0
	btn.Text = ""
	btn.AutoButtonColor = false
	btn.LayoutOrder = order
	btn.Parent = navContainer
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

	local iconLabel = Instance.new("TextLabel")
	iconLabel.Size = UDim2.new(0, 26, 1, 0)
	iconLabel.Position = UDim2.new(0, 8, 0, 0)
	iconLabel.BackgroundTransparency = 1
	iconLabel.Text = icon
	iconLabel.TextColor3 = Color3.fromRGB(150, 150, 175)
	iconLabel.Font = Enum.Font.GothamBold
	iconLabel.TextSize = 13
	iconLabel.Parent = btn

	local textLabel = Instance.new("TextLabel")
	textLabel.Size = UDim2.new(1, -40, 1, 0)
	textLabel.Position = UDim2.new(0, 36, 0, 0)
	textLabel.BackgroundTransparency = 1
	textLabel.Text = name
	textLabel.TextColor3 = Color3.fromRGB(175, 175, 195)
	textLabel.Font = Enum.Font.GothamMedium
	textLabel.TextSize = 12
	textLabel.TextXAlignment = Enum.TextXAlignment.Left
	textLabel.Parent = btn

	local indicator = Instance.new("Frame")
	indicator.Name = "Indicator"
	indicator.Size = UDim2.new(0, 3, 0, 18)
	indicator.Position = UDim2.new(0, 0, 0.5, -9)
	indicator.BackgroundColor3 = Color3.fromRGB(130, 80, 255)
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
				child.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
				local ind = child:FindFirstChild("Indicator")
				if ind then ind.Visible = false end
			end
		end
		btn.BackgroundColor3 = Color3.fromRGB(28, 22, 48)
		indicator.Visible = true
	end)
	return btn
end

local farmingNav = createNavButton("Farming", "⚡", 1)
createNavButton("Shop", "💎", 2)
createNavButton("Performance", "◆", 3)
createNavButton("Settings", "⚙", 4)

farmingNav.BackgroundColor3 = Color3.fromRGB(28, 22, 48)
farmingNav:FindFirstChild("Indicator").Visible = true

-- CONTENT
local content = Instance.new("Frame")
content.Size = UDim2.new(1, -148, 1, 0)
content.Position = UDim2.new(0, 148, 0, 0)
content.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
content.BorderSizePixel = 0
content.Parent = main

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 42)
header.BackgroundTransparency = 1
header.Parent = content

local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0, 32, 0, 26)
minBtn.Position = UDim2.new(1, -78, 0, 8)
minBtn.BackgroundColor3 = Color3.fromRGB(30, 28, 42)
minBtn.Text = "—"
minBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 16
minBtn.Parent = header
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 6)

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 32, 0, 26)
closeBtn.Position = UDim2.new(1, -40, 0, 8)
closeBtn.BackgroundColor3 = Color3.fromRGB(40, 25, 35)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(220, 140, 160)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 13
closeBtn.Parent = header
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

local function minimize()
	main.Visible = false
	miniBtn.Visible = true
end

local function restore()
	miniBtn.Visible = false
	main.Visible = true
end

minBtn.MouseButton1Click:Connect(minimize)
miniBtn.MouseButton1Click:Connect(restore)
closeBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

-- HELPERS GUI
local function createToggle(parent, yPos, titleText, descText, defaultState, callback)
	local row = Instance.new("Frame")
	row.Size = UDim2.new(1, -16, 0, 54)
	row.Position = UDim2.new(0, 8, 0, yPos)
	row.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
	row.BorderSizePixel = 0
	row.Parent = parent
	Instance.new("UICorner", row).CornerRadius = UDim.new(0, 10)

	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1, -70, 0, 20)
	title.Position = UDim2.new(0, 14, 0, 9)
	title.BackgroundTransparency = 1
	title.Text = titleText
	title.TextColor3 = Color3.fromRGB(235, 235, 250)
	title.Font = Enum.Font.GothamMedium
	title.TextSize = 13
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.Parent = row

	local desc = Instance.new("TextLabel")
	desc.Size = UDim2.new(1, -70, 0, 16)
	desc.Position = UDim2.new(0, 14, 0, 29)
	desc.BackgroundTransparency = 1
	desc.Text = descText
	desc.TextColor3 = Color3.fromRGB(120, 120, 145)
	desc.Font = Enum.Font.Gotham
	desc.TextSize = 11
	desc.TextXAlignment = Enum.TextXAlignment.Left
	desc.Parent = row

	local switchBg = Instance.new("Frame")
	switchBg.Size = UDim2.new(0, 44, 0, 24)
	switchBg.Position = UDim2.new(1, -58, 0.5, -12)
	switchBg.BackgroundColor3 = defaultState and Color3.fromRGB(110, 60, 230) or Color3.fromRGB(45, 45, 58)
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
		local info = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		if state then
			TweenService:Create(switchBg, info, {BackgroundColor3 = Color3.fromRGB(110, 60, 230)}):Play()
			TweenService:Create(knob, info, {Position = UDim2.new(1, -21, 0.5, -9)}):Play()
		else
			TweenService:Create(switchBg, info, {BackgroundColor3 = Color3.fromRGB(45, 45, 58)}):Play()
			TweenService:Create(knob, info, {Position = UDim2.new(0, 3, 0.5, -9)}):Play()
		end
		if callback then callback(state) end
	end)
	return row
end

local function createSection(parent, yPos, text)
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -16, 0, 18)
	label.Position = UDim2.new(0, 10, 0, yPos)
	label.BackgroundTransparency = 1
	label.Text = string.upper(text)
	label.TextColor3 = Color3.fromRGB(130, 100, 220)
	label.Font = Enum.Font.GothamBold
	label.TextSize = 11
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = parent
	return label
end

-- ========== PAGE: FARMING ==========
local farmingPage = Instance.new("ScrollingFrame")
farmingPage.Name = "Farming"
farmingPage.Size = UDim2.new(1, -8, 1, -50)
farmingPage.Position = UDim2.new(0, 4, 0, 44)
farmingPage.BackgroundTransparency = 1
farmingPage.BorderSizePixel = 0
farmingPage.ScrollBarThickness = 3
farmingPage.ScrollBarImageColor3 = Color3.fromRGB(90, 60, 180)
farmingPage.CanvasSize = UDim2.new(0, 0, 0, 480)
farmingPage.Parent = content
pages["Farming"] = farmingPage

local fTitle = Instance.new("TextLabel")
fTitle.Size = UDim2.new(1, -20, 0, 26)
fTitle.Position = UDim2.new(0, 10, 0, 0)
fTitle.BackgroundTransparency = 1
fTitle.Text = "Farming"
fTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
fTitle.Font = Enum.Font.GothamBold
fTitle.TextSize = 20
fTitle.TextXAlignment = Enum.TextXAlignment.Left
fTitle.Parent = farmingPage

local fSub = Instance.new("TextLabel")
fSub.Size = UDim2.new(1, -20, 0, 16)
fSub.Position = UDim2.new(0, 10, 0, 26)
fSub.BackgroundTransparency = 1
fSub.Text = "Strength • Rebirth • Pets"
fSub.TextColor3 = Color3.fromRGB(130, 130, 155)
fSub.Font = Enum.Font.Gotham
fSub.TextSize = 12
fSub.TextXAlignment = Enum.TextXAlignment.Left
fSub.Parent = farmingPage

createSection(farmingPage, 52, "Fast Farm")
createToggle(farmingPage, 74, "Fast Farm", "Farmeo automático de repeticiones", false, function(s)
	FastFarm = s
end)

local modeRow = Instance.new("Frame")
modeRow.Size = UDim2.new(1, -16, 0, 54)
modeRow.Position = UDim2.new(0, 8, 0, 136)
modeRow.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
modeRow.BorderSizePixel = 0
modeRow.Parent = farmingPage
Instance.new("UICorner", modeRow).CornerRadius = UDim.new(0, 10)

local modeTitle = Instance.new("TextLabel")
modeTitle.Size = UDim2.new(1, -140, 0, 20)
modeTitle.Position = UDim2.new(0, 14, 0, 9)
modeTitle.BackgroundTransparency = 1
modeTitle.Text = "Farm Mode"
modeTitle.TextColor3 = Color3.fromRGB(235, 235, 250)
modeTitle.Font = Enum.Font.GothamMedium
modeTitle.TextSize = 13
modeTitle.TextXAlignment = Enum.TextXAlignment.Left
modeTitle.Parent = modeRow

local modeDesc = Instance.new("TextLabel")
modeDesc.Size = UDim2.new(1, -140, 0, 16)
modeDesc.Position = UDim2.new(0, 14, 0, 29)
modeDesc.BackgroundTransparency = 1
modeDesc.Text = "Main = estable   |   Fast = máximo poder"
modeDesc.TextColor3 = Color3.fromRGB(120, 120, 145)
modeDesc.Font = Enum.Font.Gotham
modeDesc.TextSize = 11
modeDesc.TextXAlignment = Enum.TextXAlignment.Left
modeDesc.Parent = modeRow

local mainModeBtn = Instance.new("TextButton")
mainModeBtn.Size = UDim2.new(0, 56, 0, 28)
mainModeBtn.Position = UDim2.new(1, -128, 0.5, -14)
mainModeBtn.BackgroundColor3 = Color3.fromRGB(110, 60, 230)
mainModeBtn.Text = "Main"
mainModeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
mainModeBtn.Font = Enum.Font.GothamBold
mainModeBtn.TextSize = 12
mainModeBtn.Parent = modeRow
Instance.new("UICorner", mainModeBtn).CornerRadius = UDim.new(0, 7)

local opModeBtn = Instance.new("TextButton")
opModeBtn.Size = UDim2.new(0, 56, 0, 28)
opModeBtn.Position = UDim2.new(1, -64, 0.5, -14)
opModeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
opModeBtn.Text = "Fast"
opModeBtn.TextColor3 = Color3.fromRGB(170, 170, 190)
opModeBtn.Font = Enum.Font.GothamBold
opModeBtn.TextSize = 12
opModeBtn.Parent = modeRow
Instance.new("UICorner", opModeBtn).CornerRadius = UDim.new(0, 7)

local function setMode(op)
	isOPMode = op
	FarmPower = op and 400 or 50
	if op then
		mainModeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
		mainModeBtn.TextColor3 = Color3.fromRGB(170, 170, 190)
		opModeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 70)
		opModeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	else
		mainModeBtn.BackgroundColor3 = Color3.fromRGB(110, 60, 230)
		mainModeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
		opModeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
		opModeBtn.TextColor3 = Color3.fromRGB(170, 170, 190)
	end
end
mainModeBtn.MouseButton1Click:Connect(function() setMode(false) end)
opModeBtn.MouseButton1Click:Connect(function() setMode(true) end)

createSection(farmingPage, 205, "Rebirth")
createToggle(farmingPage, 227, "Auto Rebirth", "Hace rebirth automáticamente", false, function(s)
	AutoRebirth = s
end)

createToggle(farmingPage, 289, "Fast Rebirth + Pets", "Equipa pets de Rep → loop infinito", false, function(s)
	FastRebirth = s
	if s then equipBestPets("rep") end
end)

createSection(farmingPage, 360, "Session Stats")
local statsFrame = Instance.new("Frame")
statsFrame.Size = UDim2.new(1, -16, 0, 78)
statsFrame.Position = UDim2.new(0, 8, 0, 382)
statsFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
statsFrame.BorderSizePixel = 0
statsFrame.Parent = farmingPage
Instance.new("UICorner", statsFrame).CornerRadius = UDim.new(0, 10)

local rebirthsLabel = Instance.new("TextLabel")
rebirthsLabel.Size = UDim2.new(1, -20, 0, 20)
rebirthsLabel.Position = UDim2.new(0, 14, 0, 10)
rebirthsLabel.BackgroundTransparency = 1
rebirthsLabel.Text = "Rebirths sesión: 0"
rebirthsLabel.TextColor3 = Color3.fromRGB(140, 255, 170)
rebirthsLabel.Font = Enum.Font.GothamMedium
rebirthsLabel.TextSize = 13
rebirthsLabel.TextXAlignment = Enum.TextXAlignment.Left
rebirthsLabel.Parent = statsFrame

local timeLabel = Instance.new("TextLabel")
timeLabel.Size = UDim2.new(1, -20, 0, 18)
timeLabel.Position = UDim2.new(0, 14, 0, 32)
timeLabel.BackgroundTransparency = 1
timeLabel.Text = "Tiempo: 0h 0m"
timeLabel.TextColor3 = Color3.fromRGB(170, 170, 200)
timeLabel.Font = Enum.Font.Gotham
timeLabel.TextSize = 12
timeLabel.TextXAlignment = Enum.TextXAlignment.Left
timeLabel.Parent = statsFrame

local rateLabel = Instance.new("TextLabel")
rateLabel.Size = UDim2.new(1, -20, 0, 18)
rateLabel.Position = UDim2.new(0, 14, 0, 52)
rateLabel.BackgroundTransparency = 1
rateLabel.Text = "Velocidad: 0 /h"
rateLabel.TextColor3 = Color3.fromRGB(130, 180, 255)
rateLabel.Font = Enum.Font.Gotham
rateLabel.TextSize = 12
rateLabel.TextXAlignment = Enum.TextXAlignment.Left
rateLabel.Parent = statsFrame

task.spawn(function()
	while true do
		local elapsed = tick() - startTime
		local hours = math.floor(elapsed / 3600)
		local minutes = math.floor((elapsed % 3600) / 60)
		local rate = elapsed > 20 and math.floor((sessionRebirths / elapsed) * 3600) or 0
		rebirthsLabel.Text = "Rebirths sesión: " .. sessionRebirths
		timeLabel.Text = string.format("Tiempo: %dh %dm", hours, minutes)
		rateLabel.Text = "Velocidad: " .. rate .. " /h"
		task.wait(1)
	end
end)

-- ========== PAGE: SHOP (LIMPIA Y FUNCIONAL) ==========
local shopPage = Instance.new("ScrollingFrame")
shopPage.Name = "Shop"
shopPage.Size = UDim2.new(1, -8, 1, -50)
shopPage.Position = UDim2.new(0, 4, 0, 44)
shopPage.BackgroundTransparency = 1
shopPage.BorderSizePixel = 0
shopPage.ScrollBarThickness = 4
shopPage.ScrollBarImageColor3 = Color3.fromRGB(110, 70, 220)
shopPage.CanvasSize = UDim2.new(0, 0, 0, 620)
shopPage.Visible = false
shopPage.Parent = content
pages["Shop"] = shopPage

local shopTitle = Instance.new("TextLabel")
shopTitle.Size = UDim2.new(1, -20, 0, 26)
shopTitle.Position = UDim2.new(0, 10, 0, 0)
shopTitle.BackgroundTransparency = 1
shopTitle.Text = "Shop"
shopTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
shopTitle.Font = Enum.Font.GothamBold
shopTitle.TextSize = 20
shopTitle.TextXAlignment = Enum.TextXAlignment.Left
shopTitle.Parent = shopPage

local shopSub = Instance.new("TextLabel")
shopSub.Size = UDim2.new(1, -20, 0, 16)
shopSub.Position = UDim2.new(0, 10, 0, 26)
shopSub.BackgroundTransparency = 1
shopSub.Text = "Comprar Pets con Gems (Crystals)"
shopSub.TextColor3 = Color3.fromRGB(130, 130, 155)
shopSub.Font = Enum.Font.Gotham
shopSub.TextSize = 12
shopSub.TextXAlignment = Enum.TextXAlignment.Left
shopSub.Parent = shopPage

local gemsFrame = Instance.new("Frame")
gemsFrame.Size = UDim2.new(1, -16, 0, 40)
gemsFrame.Position = UDim2.new(0, 8, 0, 52)
gemsFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
gemsFrame.BorderSizePixel = 0
gemsFrame.Parent = shopPage
Instance.new("UICorner", gemsFrame).CornerRadius = UDim.new(0, 10)

local gemsLabel = Instance.new("TextLabel")
gemsLabel.Size = UDim2.new(1, -20, 1, 0)
gemsLabel.Position = UDim2.new(0, 14, 0, 0)
gemsLabel.BackgroundTransparency = 1
gemsLabel.Text = "Gems: cargando..."
gemsLabel.TextColor3 = Color3.fromRGB(100, 220, 255)
gemsLabel.Font = Enum.Font.GothamMedium
gemsLabel.TextSize = 14
gemsLabel.TextXAlignment = Enum.TextXAlignment.Left
gemsLabel.Parent = gemsFrame

task.spawn(function()
	while task.wait(1) do
		gemsLabel.Text = "Gems: " .. tostring(getGems())
	end
end)

createSection(shopPage, 105, "Seleccionar Crystal")

local crystalContainer = Instance.new("ScrollingFrame")
crystalContainer.Size = UDim2.new(1, -16, 0, 220)
crystalContainer.Position = UDim2.new(0, 8, 0, 128)
crystalContainer.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
crystalContainer.BorderSizePixel = 0
crystalContainer.ScrollBarThickness = 4
crystalContainer.ScrollBarImageColor3 = Color3.fromRGB(110, 70, 220)
crystalContainer.CanvasSize = UDim2.new(0, 0, 0, #CrystalList * 36 + 16)
crystalContainer.Parent = shopPage
Instance.new("UICorner", crystalContainer).CornerRadius = UDim.new(0, 10)

local crystalLayout = Instance.new("UIListLayout")
crystalLayout.Padding = UDim.new(0, 6)
crystalLayout.SortOrder = Enum.SortOrder.LayoutOrder
crystalLayout.Parent = crystalContainer

local crystalPadding = Instance.new("UIPadding")
crystalPadding.PaddingTop = UDim.new(0, 8)
crystalPadding.PaddingBottom = UDim.new(0, 8)
crystalPadding.PaddingLeft = UDim.new(0, 8)
crystalPadding.PaddingRight = UDim.new(0, 8)
crystalPadding.Parent = crystalContainer

local selectedCrystalBtn = nil

for i, crystalName in ipairs(CrystalList) do
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, 30)
	btn.BackgroundColor3 = Color3.fromRGB(32, 30, 45)
	btn.Text = crystalName
	btn.TextColor3 = Color3.fromRGB(200, 200, 220)
	btn.Font = Enum.Font.GothamMedium
	btn.TextSize = 13
	btn.LayoutOrder = i
	btn.AutoButtonColor = false
	btn.Parent = crystalContainer
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 7)

	btn.MouseButton1Click:Connect(function()
		SelectedCrystal = crystalName
		if selectedCrystalBtn then
			selectedCrystalBtn.BackgroundColor3 = Color3.fromRGB(32, 30, 45)
			selectedCrystalBtn.TextColor3 = Color3.fromRGB(200, 200, 220)
		end
		btn.BackgroundColor3 = Color3.fromRGB(110, 60, 230)
		btn.TextColor3 = Color3.fromRGB(255, 255, 255)
		selectedCrystalBtn = btn
	end)

	if i == 1 then
		btn.BackgroundColor3 = Color3.fromRGB(110, 60, 230)
		btn.TextColor3 = Color3.fromRGB(255, 255, 255)
		selectedCrystalBtn = btn
		SelectedCrystal = crystalName
	end
end

createSection(shopPage, 365, "Comprar")

local buyOnceBtn = Instance.new("TextButton")
buyOnceBtn.Size = UDim2.new(1, -16, 0, 44)
buyOnceBtn.Position = UDim2.new(0, 8, 0, 390)
buyOnceBtn.BackgroundColor3 = Color3.fromRGB(40, 160, 90)
buyOnceBtn.Text = "Comprar 1 vez"
buyOnceBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
buyOnceBtn.Font = Enum.Font.GothamBold
buyOnceBtn.TextSize = 15
buyOnceBtn.Parent = shopPage
Instance.new("UICorner", buyOnceBtn).CornerRadius = UDim.new(0, 10)

buyOnceBtn.MouseButton1Click:Connect(function()
	buyOnceBtn.Text = "Comprando..."
	buyOnceBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
	
	local ok = buyCrystal(SelectedCrystal)
	
	if ok then
		buyOnceBtn.Text = "¡Comprado!"
		buyOnceBtn.BackgroundColor3 = Color3.fromRGB(30, 170, 80)
	else
		buyOnceBtn.Text = "Error / Sin gems"
		buyOnceBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
	end
	
	task.wait(1.3)
	buyOnceBtn.Text = "Comprar 1 vez"
	buyOnceBtn.BackgroundColor3 = Color3.fromRGB(40, 160, 90)
end)

createToggle(shopPage, 450, "Auto Buy", "Compra automáticamente el crystal seleccionado", false, function(s)
	AutoBuy = s
end)

local shopInfo = Instance.new("TextLabel")
shopInfo.Size = UDim2.new(1, -16, 0, 40)
shopInfo.Position = UDim2.new(0, 8, 0, 520)
shopInfo.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
shopInfo.BorderSizePixel = 0
shopInfo.Text = "  Selecciona un crystal → Comprar 1 vez o activa Auto Buy"
shopInfo.TextColor3 = Color3.fromRGB(140, 140, 165)
shopInfo.Font = Enum.Font.Gotham
shopInfo.TextSize = 12
shopInfo.TextXAlignment = Enum.TextXAlignment.Left
shopInfo.Parent = shopPage
Instance.new("UICorner", shopInfo).CornerRadius = UDim.new(0, 8)

-- ========== PAGE: PERFORMANCE ==========
local perfPage = Instance.new("ScrollingFrame")
perfPage.Name = "Performance"
perfPage.Size = UDim2.new(1, -8, 1, -50)
perfPage.Position = UDim2.new(0, 4, 0, 44)
perfPage.BackgroundTransparency = 1
perfPage.BorderSizePixel = 0
perfPage.ScrollBarThickness = 3
perfPage.Visible = false
perfPage.CanvasSize = UDim2.new(0, 0, 0, 280)
perfPage.Parent = content
pages["Performance"] = perfPage

local pTitle = Instance.new("TextLabel")
pTitle.Size = UDim2.new(1, -20, 0, 26)
pTitle.Position = UDim2.new(0, 10, 0, 0)
pTitle.BackgroundTransparency = 1
pTitle.Text = "Performance"
pTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
pTitle.Font = Enum.Font.GothamBold
pTitle.TextSize = 20
pTitle.TextXAlignment = Enum.TextXAlignment.Left
pTitle.Parent = perfPage

local pSub = Instance.new("TextLabel")
pSub.Size = UDim2.new(1, -20, 0, 16)
pSub.Position = UDim2.new(0, 10, 0, 26)
pSub.BackgroundTransparency = 1
pSub.Text = "Anti-Lag • Optimización"
pSub.TextColor3 = Color3.fromRGB(130, 130, 155)
pSub.Font = Enum.Font.Gotham
pSub.TextSize = 12
pSub.TextXAlignment = Enum.TextXAlignment.Left
pSub.Parent = perfPage

createSection(perfPage, 55, "Optimización")
createToggle(perfPage, 77, "Anti-Lag", "Desactiva partículas, trails y sombras", false, function(s)
	setAntiLag(s)
end)

createToggle(perfPage, 139, "Rendimiento Máximo", "Baja calidad gráfica + desactiva sombras", false, function(s)
	setPerformance(s)
end)

-- ========== PAGE: SETTINGS ==========
local settPage = Instance.new("Frame")
settPage.Name = "Settings"
settPage.Size = UDim2.new(1, -8, 1, -50)
settPage.Position = UDim2.new(0, 4, 0, 44)
settPage.BackgroundTransparency = 1
settPage.Visible = false
settPage.Parent = content
pages["Settings"] = settPage

local sTitle = Instance.new("TextLabel")
sTitle.Size = UDim2.new(1, -20, 0, 26)
sTitle.Position = UDim2.new(0, 10, 0, 0)
sTitle.BackgroundTransparency = 1
sTitle.Text = "Settings"
sTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
sTitle.Font = Enum.Font.GothamBold
sTitle.TextSize = 20
sTitle.TextXAlignment = Enum.TextXAlignment.Left
sTitle.Parent = settPage

local sSub = Instance.new("TextLabel")
sSub.Size = UDim2.new(1, -20, 0, 16)
sSub.Position = UDim2.new(0, 10, 0, 26)
sSub.BackgroundTransparency = 1
sSub.Text = "Atajos y configuración"
sSub.TextColor3 = Color3.fromRGB(130, 130, 155)
sSub.Font = Enum.Font.Gotham
sSub.TextSize = 12
sSub.TextXAlignment = Enum.TextXAlignment.Left
sSub.Parent = settPage

local infoBox = Instance.new("TextLabel")
infoBox.Size = UDim2.new(1, -20, 0, 140)
infoBox.Position = UDim2.new(0, 10, 0, 60)
infoBox.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
infoBox.BorderSizePixel = 0
infoBox.Text = "• RightCtrl → Minimizar / Restaurar GUI\n• El botón flotante \"ARGZx\" es arrastrable\n• Shop usa openCrystalRemote (preciso)\n• Auto Buy tiene delay seguro\n• Fast Rebirth + Pets automático\n• Anti-Lag + Rendimiento mejoran FPS"
infoBox.TextColor3 = Color3.fromRGB(160, 160, 185)
infoBox.Font = Enum.Font.Gotham
infoBox.TextSize = 13
infoBox.TextXAlignment = Enum.TextXAlignment.Left
infoBox.TextYAlignment = Enum.TextYAlignment.Top
infoBox.Parent = settPage
Instance.new("UICorner", infoBox).CornerRadius = UDim.new(0, 10)

local pad = Instance.new("UIPadding")
pad.PaddingTop = UDim.new(0, 14)
pad.PaddingLeft = UDim.new(0, 14)
pad.Parent = infoBox

-- Tecla RightCtrl
UserInputService.InputBegan:Connect(function(input, gp)
	if gp then return end
	if input.KeyCode == Enum.KeyCode.RightControl then
		if main.Visible then
			minimize()
		else
			restore()
		end
	end
end)

print("ARGZx Modern GUI + Shop cargado correctamente")
