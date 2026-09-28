-- ==================== CONFIGURACIÓN DE KEY ====================
local ValidKey = "PRUEBA" -- <--- Aquí pones la key actual
-- El enlace Raw del script principal que tienes subido en tu GitHub
local ScriptURL = "https://raw.githubusercontent.com/AngelOficialBe/ARGZx-Official-script/main/ARGZx-Script.lua"
-- ==============================================================

local Players = game:GetService("Players")
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

-- Pausar todo el script hasta que se verifique la Key
repeat task.wait(0.2) until isVerified

-- ==================== KILL-SWITCH EN TIEMPO REAL ====================
-- Esto revisa tu propio script en GitHub cada 10 segundos
task.spawn(function()
	while task.wait(10) do
		local success, onlineCode = pcall(function()
			return game:HttpGet(ScriptURL)
		end)
		
		if success then
			-- Extrae automáticamente lo que tengas escrito en la variable ValidKey de tu GitHub
			local onlineKey = string.match(onlineCode, 'local ValidKey%s*=%s*"(.-)"')
			
			if onlineKey and onlineKey ~= ValidKey then
				pcall(function()
					if keyGui then keyGui:Destroy() end
					if gui then gui:Destroy() end
					if selectGui then selectGui:Destroy() end
				end)
				plr:Kick("⚠️ [ARGZx] La Key ha sido actualizada o tu acceso fue revocado.")
				break
			end
		end
	end
end)
-- ====================================================

-- Anti-Kick
plr.Idled:Connect(function()
	VirtualUser:CaptureController()
	VirtualUser:ClickButton2(Vector2.new())
end)

repeat task.wait(0.3) until plr:FindFirstChild("muscleEvent") and plr:FindFirstChild("leaderstats")

local Strength = plr.leaderstats.Strength
local Rebirths = plr.leaderstats.Rebirths

local FastFarm = false
local AutoRebirth = false
local FarmPower = 80

-- Contador
local startTime = tick()
local sessionRebirths = 0
local lastRebirths = Rebirths.Value

-- ==================== SELECTOR ====================
local selectGui = Instance.new("ScreenGui")
selectGui.Name = "ARGZ_Selector"
selectGui.ResetOnSpawn = false
selectGui.IgnoreGuiInset = true
selectGui.Parent = PlayerGui

local selectFrame = Instance.new("Frame")
selectFrame.Size = UDim2.new(0, 320, 0, 220)
selectFrame.Position = UDim2.new(0.5, -160, 0.5, -110)
selectFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
selectFrame.BorderSizePixel = 0
selectFrame.Parent = selectGui
Instance.new("UICorner", selectFrame).CornerRadius = UDim.new(0, 16)

local selectStroke = Instance.new("UIStroke")
selectStroke.Color = Color3.fromRGB(180, 0, 0)
selectStroke.Thickness = 2
selectStroke.Parent = selectFrame

local selectTitle = Instance.new("TextLabel")
selectTitle.Size = UDim2.new(1, 0, 0, 50)
selectTitle.BackgroundTransparency = 1
selectTitle.Text = "ARGZx Script"
selectTitle.TextColor3 = Color3.fromRGB(255, 80, 80)
selectTitle.Font = Enum.Font.GothamBold
selectTitle.TextSize = 20
selectTitle.Parent = selectFrame

local mainBtn = Instance.new("TextButton")
mainBtn.Size = UDim2.new(0.85, 0, 0, 48)
mainBtn.Position = UDim2.new(0.075, 0, 0, 70)
mainBtn.BackgroundColor3 = Color3.fromRGB(180, 30, 30)
mainBtn.Text = "Execute Main Script"
mainBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
mainBtn.Font = Enum.Font.GothamBold
mainBtn.TextSize = 16
mainBtn.Parent = selectFrame
Instance.new("UICorner", mainBtn).CornerRadius = UDim.new(0, 10)

local opBtn = Instance.new("TextButton")
opBtn.Size = UDim2.new(0.85, 0, 0, 48)
opBtn.Position = UDim2.new(0.075, 0, 0, 135)
opBtn.BackgroundColor3 = Color3.fromRGB(180, 30, 30)
opBtn.Text = "Execute Fast Farming"
opBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
opBtn.Font = Enum.Font.GothamBold
opBtn.TextSize = 16
opBtn.Parent = selectFrame
Instance.new("UICorner", opBtn).CornerRadius = UDim.new(0, 10)

-- ==================== FUNCIÓN PRINCIPAL ====================
local function startScript(isOP)
	selectGui:Destroy()

	if isOP then
		FarmPower = 400
	else
		FarmPower = 50
	end

	-- ==================== FAST FARM ====================
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
						-- Si apagas el botón, esto rompe el ciclo instantáneamente
						if not FastFarm then break end

						cachedEvent:FireServer("rep")

						if isOP then
							-- MODO OP: Ráfagas masivas de 100 (Extremo)
							if i % 100 == 0 then
								task.wait()
							end
						else
							-- MODO MAIN: Ráfagas pequeñas de 5. 
							-- Mantiene el farmeo súper rápido y constante, y evita que el servidor 
							-- se atasque para que se apague DE INMEDIATO al darle OFF.
							if i % 5 == 0 then
								task.wait()
							end
						end
					end
				end
				task.wait()
			else
				task.wait(0.1)
			end
		end
	end)

	-- ==================== AUTO REBIRTH ====================
	task.spawn(function()
		while true do
			if AutoRebirth then
				pcall(function()
					local rStorage = ReplicatedStorage:FindFirstChild("repStorage") or ReplicatedStorage
					local rEvents = rStorage:FindFirstChild("rEvents")

					if rEvents then
						local rebirthRemote = rEvents:FindFirstChild("rebirthRemote")

						if rebirthRemote then
							-- Se ejecuta en task.spawn para que NO congelen ni retrasen el bucle esperándolo
							if rebirthRemote:IsA("RemoteFunction") then
								task.spawn(function()
									rebirthRemote:InvokeServer("rebirthRequest")
								end)
							elseif rebirthRemote:IsA("RemoteEvent") then
								rebirthRemote:FireServer("rebirthRequest")
							end
						end
					end
				end)

				-- Bucle ultra rápido (0.05s) para renacer inmediatamente al llegar a la fuerza
				task.wait(0.05)
			else
				task.wait(0.2)
			end
		end
	end)

	-- ==================== CONTADOR ====================
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

	-- ==================== GUI ====================
	local gui = Instance.new("ScreenGui")
	gui.Name = "ClanARGZ"
	gui.ResetOnSpawn = false
	gui.IgnoreGuiInset = true
	gui.Parent = PlayerGui

	local main = Instance.new("Frame")
	main.Size = UDim2.new(0, 270, 0, 245)
	main.Position = UDim2.new(0.02, 0, 0.22, 0)
	main.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
	main.BorderSizePixel = 0
	main.Active = true
	main.Draggable = true
	main.Parent = gui
	Instance.new("UICorner", main).CornerRadius = UDim.new(0, 14)

	local stroke = Instance.new("UIStroke")
	stroke.Color = isOP and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(80, 0, 255)
	stroke.Thickness = 1.5
	stroke.Transparency = 0.3
	stroke.Parent = main

	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1, -42, 0, 38)
	title.Position = UDim2.new(0, 0, 0, 0)
	title.BackgroundColor3 = Color3.fromRGB(18, 10, 35)
	title.Text = isOP and "Clan ARGZ • OP Farm" or "Clan ARGZ • Main"
	title.TextColor3 = isOP and Color3.fromRGB(255, 120, 120) or Color3.fromRGB(200, 160, 255)
	title.Font = Enum.Font.GothamBold
	title.TextSize = 15
	title.Parent = main
	Instance.new("UICorner", title).CornerRadius = UDim.new(0, 14)

	local minBtn = Instance.new("TextButton")
	minBtn.Size = UDim2.new(0, 30, 0, 30)
	minBtn.Position = UDim2.new(1, -36, 0, 4)
	minBtn.BackgroundColor3 = Color3.fromRGB(30, 20, 50)
	minBtn.Text = "−"
	minBtn.TextColor3 = Color3.fromRGB(200, 160, 255)
	minBtn.Font = Enum.Font.GothamBold
	minBtn.TextSize = 20
	minBtn.Parent = main
	Instance.new("UICorner", minBtn).CornerRadius = UDim.new(1, 0)

	local argIcon = Instance.new("TextButton")
	argIcon.Size = UDim2.new(0, 58, 0, 58)
	argIcon.Position = UDim2.new(0.02, 0, 0.22, 0)
	argIcon.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
	argIcon.Text = "ARGZx"
	argIcon.TextColor3 = Color3.fromRGB(180, 140, 255)
	argIcon.Font = Enum.Font.GothamBold
	argIcon.TextSize = 14
	argIcon.Visible = false
	argIcon.Active = true
	argIcon.Draggable = true
	argIcon.Parent = gui
	Instance.new("UICorner", argIcon).CornerRadius = UDim.new(0, 12)

	local farmBtn = Instance.new("TextButton")
	farmBtn.Size = UDim2.new(0.88, 0, 0, 40)
	farmBtn.Position = UDim2.new(0.06, 0, 0, 48)
	farmBtn.BackgroundColor3 = Color3.fromRGB(25, 20, 40)
	farmBtn.Text = "Fast Farm  •  OFF"
	farmBtn.TextColor3 = Color3.fromRGB(220, 200, 255)
	farmBtn.Font = Enum.Font.GothamBold
	farmBtn.TextSize = 15
	farmBtn.Parent = main
	Instance.new("UICorner", farmBtn).CornerRadius = UDim.new(0, 9)

	local rebirthBtn = Instance.new("TextButton")
	rebirthBtn.Size = UDim2.new(0.88, 0, 0, 40)
	rebirthBtn.Position = UDim2.new(0.06, 0, 0, 96)
	rebirthBtn.BackgroundColor3 = Color3.fromRGB(25, 20, 40)
	rebirthBtn.Text = "Auto Rebirth  •  OFF"
	rebirthBtn.TextColor3 = Color3.fromRGB(220, 200, 255)
	rebirthBtn.Font = Enum.Font.GothamBold
	rebirthBtn.TextSize = 15
	rebirthBtn.Parent = main
	Instance.new("UICorner", rebirthBtn).CornerRadius = UDim.new(0, 9)

	local statsFrame = Instance.new("Frame")
	statsFrame.Size = UDim2.new(0.88, 0, 0, 78)
	statsFrame.Position = UDim2.new(0.06, 0, 0, 148)
	statsFrame.BackgroundColor3 = Color3.fromRGB(18, 14, 30)
	statsFrame.BorderSizePixel = 0
	statsFrame.Parent = main
	Instance.new("UICorner", statsFrame).CornerRadius = UDim.new(0, 9)

	local rebirthsLabel = Instance.new("TextLabel")
	rebirthsLabel.Size = UDim2.new(1, -12, 0, 22)
	rebirthsLabel.Position = UDim2.new(0, 8, 0, 8)
	rebirthsLabel.BackgroundTransparency = 1
	rebirthsLabel.Text = "Rebirths sesión: 0"
	rebirthsLabel.TextColor3 = Color3.fromRGB(180, 255, 180)
	rebirthsLabel.Font = Enum.Font.GothamBold
	rebirthsLabel.TextSize = 13
	rebirthsLabel.TextXAlignment = Enum.TextXAlignment.Left
	rebirthsLabel.Parent = statsFrame

	local timeLabel = Instance.new("TextLabel")
	timeLabel.Size = UDim2.new(1, -12, 0, 20)
	timeLabel.Position = UDim2.new(0, 8, 0, 30)
	timeLabel.BackgroundTransparency = 1
	timeLabel.Text = "Tiempo: 0h 0m"
	timeLabel.TextColor3 = Color3.fromRGB(180, 170, 220)
	timeLabel.Font = Enum.Font.Gotham
	timeLabel.TextSize = 12
	timeLabel.TextXAlignment = Enum.TextXAlignment.Left
	timeLabel.Parent = statsFrame

	local rateLabel = Instance.new("TextLabel")
	rateLabel.Size = UDim2.new(1, -12, 0, 20)
	rateLabel.Position = UDim2.new(0, 8, 0, 50)
	rateLabel.BackgroundTransparency = 1
	rateLabel.Text = "Velocidad: 0 /h"
	rateLabel.TextColor3 = Color3.fromRGB(160, 200, 255)
	rateLabel.Font = Enum.Font.Gotham
	rateLabel.TextSize = 12
	rateLabel.TextXAlignment = Enum.TextXAlignment.Left
	rateLabel.Parent = statsFrame

	-- ==================== ACTUALIZAR STATS ====================
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

	-- ==================== MINIMIZAR ====================
	minBtn.MouseButton1Click:Connect(function()
		main.Visible = false
		argIcon.Visible = true
	end)

	argIcon.MouseButton1Click:Connect(function()
		argIcon.Visible = false
		main.Visible = true
	end)

	-- ==================== FAST FARM BUTTON ====================
	farmBtn.MouseButton1Click:Connect(function()
		FastFarm = not FastFarm

		if FastFarm then
			farmBtn.Text = "Fast Farm  •  ON"
			farmBtn.BackgroundColor3 = Color3.fromRGB(40, 0, 90)
			farmBtn.TextColor3 = Color3.fromRGB(180, 255, 180)
		else
			farmBtn.Text = "Fast Farm  •  OFF"
			farmBtn.BackgroundColor3 = Color3.fromRGB(25, 20, 40)
			farmBtn.TextColor3 = Color3.fromRGB(220, 200, 255)
		end
	end)

	-- ==================== AUTO REBIRTH BUTTON ====================
	rebirthBtn.MouseButton1Click:Connect(function()
		AutoRebirth = not AutoRebirth

		if AutoRebirth then
			rebirthBtn.Text = "Auto Rebirth  •  ON"
			rebirthBtn.BackgroundColor3 = Color3.fromRGB(40, 0, 90)
			rebirthBtn.TextColor3 = Color3.fromRGB(180, 255, 180)
		else
			rebirthBtn.Text = "Auto Rebirth  •  OFF"
			rebirthBtn.BackgroundColor3 = Color3.fromRGB(25, 20, 40)
			rebirthBtn.TextColor3 = Color3.fromRGB(220, 200, 255)
		end
	end)

	print("Clan ARGZ cargado | Modo: " .. (isOP and "OP Farm" or "Main"))
end

mainBtn.MouseButton1Click:Connect(function()
	startScript(false)
end)

opBtn.MouseButton1Click:Connect(function()
	startScript(true)
end)
