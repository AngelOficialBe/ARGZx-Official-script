-- ==================== CONFIGURACIÓN DE KEY ====================
local ValidKey = "PRUEBA" -- <--- Aquí pones la key actual
-- El enlace Raw del script principal que tienes subido en tu GitHub
local ScriptURL = "https://raw.githubusercontent.com/AngelOficialBe/ARGZx-Official-script/refs/heads/main/ARGZx-Script.lua"
-- ==============================================================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local plr = Players.LocalPlayer
local PlayerGui = plr:WaitForChild("PlayerGui")

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
keyTitle.Text = "🔑 ARGZx Key System"
keyTitle.TextColor3 = Color3.fromRGB(255, 80, 80)
keyTitle.Font = Enum.Font.GothamBold
keyTitle.TextSize = 18
keyTitle.Parent = keyFrame

local keyInput = Instance.new("TextBox")
keyInput.Size = UDim2.new(0.85, 0, 0, 40)
keyInput.Position = UDim2.new(0.075, 0, 0, 60)
keyInput.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
keyInput.Text = ""
keyInput.PlaceholderText = "Ingresa la Key aquí..."
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
		verifyBtn.Text = "¡Key Correcta!"
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

-- ==================== KILL-SWITCH EN TIEMPO REAL ====================
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
				plr:Kick("⚠️ [ARGZx] La Key ha sido actualizada o tu acceso fue revocado.")
				break
			end
		end
	end
end)

-- Anti-Kick
plr.Idled:Connect(function()
	VirtualUser:CaptureController()
	VirtualUser:ClickButton2(Vector2.new())
end)

repeat task.wait(0.3) until plr:FindFirstChild("muscleEvent") and plr:FindFirstChild("leaderstats")

local Strength = plr.leaderstats.Strength
local Rebirths = plr.leaderstats.Rebirths

-- Variables de estado
local FastFarm = false
local AutoRebirth = false
local isOPMode = false          -- false = Main, true = Fast Farm (OP)
local FarmPower = 50

local startTime = tick()
local sessionRebirths = 0
local lastRebirths = Rebirths.Value

-- ==================== LÓGICA DE FARMEO ====================
task.spawn(function()
	local cachedEvent = plr:FindFirstChild("muscleEvent")
	plr.ChildAdded:Connect(function(child)
		if child.Name == "muscleEvent" then
			cachedEvent = child
		end
	end)

	while true do
		if FastFarm then
			if not cachedEvent or not cachedEvent.Parent then
				cachedEvent = plr:FindFirstChild("muscleEvent")
			end
			if cachedEvent then
				for i = 1, FarmPower do
					if not FastFarm then break end
					cachedEvent:FireServer("rep")
					if isOPMode then
						if i % 100 == 0 then task.wait() end
					else
						if i % 5 == 0 then task.wait() end
					end
				end
			end
			task.wait()
		else
			task.wait(0.1)
		end
	end
end)

-- Auto Rebirth
task.spawn(function()
	local function getRemote()
		local rEvents = ReplicatedStorage:FindFirstChild("rEvents")
		if not rEvents then return nil end
		return rEvents:FindFirstChild("rebirthRemote")
	end

	local function doRebirth()
		if not AutoRebirth then return end
		local rebirthRemote = getRemote()
		if not rebirthRemote then return end
		pcall(function()
			if rebirthRemote:IsA("RemoteFunction") then
				rebirthRemote:InvokeServer("rebirthRequest")
			elseif rebirthRemote:IsA("RemoteEvent") then
				rebirthRemote:FireServer("rebirthRequest")
			end
		end)
	end

	task.spawn(function()
		while true do
			if AutoRebirth then
				doRebirth()
				break
			end
			task.wait(0.1)
		end
	end)

	Strength:GetPropertyChangedSignal("Value"):Connect(function()
		if AutoRebirth then doRebirth() end
	end)

	Rebirths:GetPropertyChangedSignal("Value"):Connect(function()
		if AutoRebirth then doRebirth() end
	end)
end)

-- Contador de sesión
task.spawn(function()
	while true do
		if Rebirths.Value > lastRebirths then
			sessionRebirths = sessionRebirths + (Rebirths.Value - lastRebirths)
			lastRebirths = Rebirths.Value
		elseif Rebirths.Value < lastRebirths then
			lastRebirths = Rebirths.Value
		end
		task.wait(0.4)
	end
end)

-- ==================== GUI ESTILO AURAL ====================
local gui = Instance.new("ScreenGui")
gui.Name = "ARGZx_AuralGUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = PlayerGui

-- Main container
local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.new(0, 520, 0, 380)
main.Position = UDim2.new(0.5, -260, 0.5, -190)
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

-- ========== SIDEBAR ==========
local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Size = UDim2.new(0, 160, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
sidebar.BorderSizePixel = 0
sidebar.Parent = main
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 12)

-- Logo / Title
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

-- Nav buttons
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
		for _, page in pairs(pages) do
			page.Visible = false
		end
		if pages[name] then
			pages[name].Visible = true
		end
		currentPage = name

		for _, child in ipairs(navContainer:GetChildren()) do
			if child:IsA("TextButton") then
				child.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
				local ind = child:FindFirstChild("Indicator")
				if ind then ind.Visible = false end
				local t = child:FindFirstChildWhichIsA("TextLabel", true)
			end
		end
		btn.BackgroundColor3 = Color3.fromRGB(28, 24, 45)
		indicator.Visible = true
	end)

	return btn
end

createNavButton("Home", "⌂", 1)
local farmingNav = createNavButton("Farming", "⚡", 2)
createNavButton("Teleports", "⌖", 3)
createNavButton("Boss", "⚔", 4)
createNavButton("Pets", "🐾", 5)
createNavButton("Misc", "✦", 6)
createNavButton("Settings", "⚙", 7)

-- Activar Farming por defecto
farmingNav.BackgroundColor3 = Color3.fromRGB(28, 24, 45)
farmingNav:FindFirstChild("Indicator").Visible = true

-- ========== CONTENT AREA ==========
local content = Instance.new("Frame")
content.Name = "Content"
content.Size = UDim2.new(1, -160, 1, 0)
content.Position = UDim2.new(0, 160, 0, 0)
content.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
content.BorderSizePixel = 0
content.Parent = main

-- Close button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -36, 0, 10)
closeBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.Parent = content
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

closeBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

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

-- Helper: create toggle row
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

	-- Switch
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

	return row, function() return state end
end

-- Section header helper
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

-- ===== FAST FARM SECTION =====
createSection(farmingPage, 55, "FAST FARM")

-- Toggle Fast Farm
createToggle(farmingPage, 78, "Fast Farm", "Activa el farmeo automático de reps", false, function(state)
	FastFarm = state
end)

-- Mode selector (Main / OP)
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
modeDesc.Text = "Main = estable  |  Fast = OP (más poder)"
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
	FarmPower = op and 400 or 50
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

-- ===== REBIRTH SECTION =====
createSection(farmingPage, 205, "REBIRTH")

createToggle(farmingPage, 228, "Auto Rebirth", "Invokes rebirth when strength hits threshold", false, function(state)
	AutoRebirth = state
end)

-- ===== STATS SECTION =====
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
rebirthsLabel.Text = "Rebirths sesión: 0"
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

-- Actualizar stats
task.spawn(function()
	while true do
		local elapsed = tick() - startTime
		local hours = math.floor(elapsed / 3600)
		local minutes = math.floor((elapsed % 3600) / 60)
		local rate = elapsed > 15 and math.floor((sessionRebirths / elapsed) * 3600) or 0
		rebirthsLabel.Text = "Rebirths sesión: " .. sessionRebirths
		timeLabel.Text = string.format("Tiempo: %dh %dm", hours, minutes)
		rateLabel.Text = "Velocidad: " .. rate .. " /h"
		task.wait(1)
	end
end)

-- ========== PÁGINAS VACÍAS (placeholder) ==========
local function createPlaceholderPage(name, titleText, subText)
	local page = Instance.new("Frame")
	page.Name = name
	page.Size = UDim2.new(1, -20, 1, -50)
	page.Position = UDim2.new(0, 10, 0, 45)
	page.BackgroundTransparency = 1
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

	local s = Instance.new("TextLabel")
	s.Size = UDim2.new(1, 0, 0, 18)
	s.Position = UDim2.new(0, 0, 0, 28)
	s.BackgroundTransparency = 1
	s.Text = subText
	s.TextColor3 = Color3.fromRGB(140, 140, 160)
	s.Font = Enum.Font.Gotham
	s.TextSize = 12
	s.TextXAlignment = Enum.TextXAlignment.Left
	s.Parent = page

	local coming = Instance.new("TextLabel")
	coming.Size = UDim2.new(1, 0, 0, 30)
	coming.Position = UDim2.new(0, 0, 0.4, 0)
	coming.BackgroundTransparency = 1
	coming.Text = "Coming soon..."
	coming.TextColor3 = Color3.fromRGB(100, 100, 120)
	coming.Font = Enum.Font.GothamMedium
	coming.TextSize = 16
	coming.Parent = page
end

createPlaceholderPage("Home", "Home", "Overview & status")
createPlaceholderPage("Teleports", "Teleports", "Quick travel locations")
createPlaceholderPage("Boss", "Boss", "Boss farming tools")
createPlaceholderPage("Pets", "Pets", "Pet management")
createPlaceholderPage("Misc", "Misc", "Extra utilities")
createPlaceholderPage("Settings", "Settings", "Script configuration")

-- Minimizar con tecla (opcional)
UserInputService.InputBegan:Connect(function(input, gp)
	if gp then return end
	if input.KeyCode == Enum.KeyCode.RightControl then
		main.Visible = not main.Visible
	end
end)

print("ARGZx Aural GUI cargado | Farming listo")
