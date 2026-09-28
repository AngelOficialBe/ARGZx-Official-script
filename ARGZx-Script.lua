-- ==================== CONFIGURACIÓN DE KEY ====================
local ValidKey = "PRUEBA" -- <--- Aquí pones la key actual
local ScriptURL = "https://raw.githubusercontent.com/AngelOficialBe/ARGZx-Official-script/refs/heads/main/ARGZx-Script.lua"
-- ==============================================================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

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

-- ==================== KILL-SWITCH & ANTI-KICK ====================
task.spawn(function()
	while task.wait(10) do
		local success, onlineCode = pcall(function() return game:HttpGet(ScriptURL) end)
		if success then
			local onlineKey = string.match(onlineCode, 'local ValidKey%s*=%s*"(.-)"')
			if onlineKey and onlineKey ~= ValidKey then
				plr:Kick("⚠️ [ARGZx] La Key ha sido actualizada o tu acceso fue revocado.")
				break
			end
		end
	end
end)

plr.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

repeat task.wait(0.3) until plr:FindFirstChild("muscleEvent") and plr:FindFirstChild("leaderstats")

local Strength = plr.leaderstats.Strength
local Rebirths = plr.leaderstats.Rebirths

-- ==================== VARIABLES DE ESTADO ====================
local FastFarm = false
local AutoRebirth = false
local isOP = false
local FarmPower = 50

local startTime = tick()
local sessionRebirths = 0
local lastRebirths = Rebirths.Value

-- ==================== NUEVA GUI MODERNA (RAYFIELD) ====================
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "ARGZx Script",
   LoadingTitle = "Cargando ARGZx...",
   LoadingSubtitle = "by Angel",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false
})

-- Pestañas de la Barra Lateral
local TabHome = Window:CreateTab("🏠 Inicio", nil)
local TabFarm = Window:CreateTab("⚡ Farming", nil)

-- --- Contenido de la Pestaña Inicio ---
local LabelWelcome = TabHome:CreateLabel("¡Bienvenido al panel principal de ARGZx!")

local StatsParagraph = TabHome:CreateParagraph({
    Title = "📊 Estadísticas de la Sesión",
    Content = "Calculando...\nRebirths: 0\nTiempo: 0h 0m\nVelocidad: 0 /h"
})

-- --- Contenido de la Pestaña Farming ---
TabFarm:CreateSection("Modos de Farmeo (Elige Uno)")

-- Variables para evitar que se bugeen los botones si se presionan al mismo tiempo
local isUpdating = false
local ToggleMain, ToggleOP 

ToggleMain = TabFarm:CreateToggle({
   Name = "Main Farm (50 Ráfagas - Estable)",
   CurrentValue = false,
   Flag = "TglMain", 
   Callback = function(Value)
       if isUpdating then return end
       isUpdating = true
       
       if Value then
           ToggleOP:Set(false) -- Apaga el OP automáticamente si prendes el Main
           FastFarm = true
           isOP = false
           FarmPower = 50
       else
           FastFarm = false
       end
       
       isUpdating = false
   end,
})

ToggleOP = TabFarm:CreateToggle({
   Name = "OP Farm (400 Ráfagas - Extremo)",
   CurrentValue = false,
   Flag = "TglOP",
   Callback = function(Value)
       if isUpdating then return end
       isUpdating = true
       
       if Value then
           ToggleMain:Set(false) -- Apaga el Main automáticamente si prendes el OP
           FastFarm = true
           isOP = true
           FarmPower = 400
       else
           FastFarm = false
       end
       
       isUpdating = false
   end,
})

TabFarm:CreateSection("Opciones Adicionales")

local ToggleAutoRebirth = TabFarm:CreateToggle({
   Name = "Auto Rebirth",
   CurrentValue = false,
   Flag = "TglRebirth",
   Callback = function(Value)
       AutoRebirth = Value
   end,
})

-- ==================== LÓGICA DEL SCRIPT ====================
-- 1. FAST FARMING
task.spawn(function()
    local cachedEvent = plr:FindFirstChild("muscleEvent")

    plr.ChildAdded:Connect(function(child)
        if child.Name == "muscleEvent" then cachedEvent = child end
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

-- 2. AUTO REBIRTH
task.spawn(function()
    local rebirthRemote
    local function getRemote()
        local rEvents = ReplicatedStorage:FindFirstChild("rEvents")
        if rEvents then return rEvents:FindFirstChild("rebirthRemote") end
        return nil
    end

    local function doRebirth()
        if not AutoRebirth then return end
        rebirthRemote = getRemote()
        if not rebirthRemote then return end

        pcall(function()
            if rebirthRemote:IsA("RemoteFunction") then
                rebirthRemote:InvokeServer("rebirthRequest")
            elseif rebirthRemote:IsA("RemoteEvent") then
                rebirthRemote:FireServer("rebirthRequest")
            end
        end)
    end

    Strength:GetPropertyChangedSignal("Value"):Connect(function()
        if AutoRebirth then doRebirth() end
    end)

    Rebirths:GetPropertyChangedSignal("Value"):Connect(function()
        if AutoRebirth then doRebirth() end
    end)
    
    while true do
        if AutoRebirth then doRebirth() end
        task.wait(1)
    end
end)

-- 3. ACTUALIZAR ESTADÍSTICAS EN LA GUI
task.spawn(function()
    while true do
        if Rebirths.Value > lastRebirths then
            sessionRebirths = sessionRebirths + (Rebirths.Value - lastRebirths)
            lastRebirths = Rebirths.Value
        elseif Rebirths.Value < lastRebirths then
            lastRebirths = Rebirths.Value
        end

        local elapsed = tick() - startTime
        local hours = math.floor(elapsed / 3600)
        local minutes = math.floor((elapsed % 3600) / 60)
        local rate = elapsed > 15 and math.floor((sessionRebirths / elapsed) * 3600) or 0

        StatsParagraph:Set({
            Title = "📊 Estadísticas de la Sesión",
            Content = "Rebirths conseguidos: " .. sessionRebirths .. "\nTiempo activo: " .. hours .. "h " .. minutes .. "m\nVelocidad: " .. rate .. " /h"
        })

        task.wait(1)
    end
end)

-- Notificación de carga lista
Rayfield:Notify({
   Title = "ARGZx Cargado",
   Content = "Script inyectado correctamente. Ve a la pestaña Farming.",
   Duration = 5,
   Image = 4483362458,
})
