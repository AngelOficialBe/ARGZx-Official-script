```lua
--============================================================
-- ARGZx - GUI BASE CORREGIDO
--============================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Stats = game:GetService("Stats")

local LP = Players.LocalPlayer
local PlayerGui = LP:WaitForChild("PlayerGui")

--============================================================
-- CONFIG
--============================================================

local VALID_KEY = "ARGE"

local FastFarm = false
local AutoRebirth = false
local FastRebirth = false
local FastRebirthStage = "Idle"

local sessionStart = os.clock()
local sessionRebirths = 0
local totalStrengthGained = 0

local gui
local keyGui

--============================================================
-- UTILIDADES
--============================================================

local function safeDestroy(object)
    if object then
        pcall(function()
            object:Destroy()
        end)
    end
end

local function formatNumber(value)
    value = tonumber(value) or 0

    if value >= 1e12 then
        return string.format("%.2fT", value / 1e12)
    elseif value >= 1e9 then
        return string.format("%.2fB", value / 1e9)
    elseif value >= 1e6 then
        return string.format("%.2fM", value / 1e6)
    elseif value >= 1e3 then
        return string.format("%.1fK", value / 1e3)
    end

    return tostring(math.floor(value))
end

local function getPing()
    local success, result = pcall(function()
        local network = Stats:FindFirstChild("Network")
        local serverStats = network and network:FindFirstChild("ServerStatsItem")
        local pingObject = serverStats and serverStats:FindFirstChild("Data Ping")

        if not pingObject then
            return 0
        end

        local value = pingObject:GetValueString()
        return tonumber(string.match(value, "%d+")) or 0
    end)

    if success then
        return result
    end

    return 0
end

--============================================================
-- KEY SYSTEM
--============================================================

local verified = false

keyGui = Instance.new("ScreenGui")
keyGui.Name = "ARGZ_KeySystem"
keyGui.ResetOnSpawn = false
keyGui.IgnoreGuiInset = true
keyGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
keyGui.Parent = PlayerGui

local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.fromOffset(320, 190)
keyFrame.Position = UDim2.new(0.5, -160, 0.5, -95)
keyFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 17)
keyFrame.BorderSizePixel = 0
keyFrame.Parent = keyGui

Instance.new("UICorner", keyFrame).CornerRadius = UDim.new(0, 12)

local keyStroke = Instance.new("UIStroke")
keyStroke.Color = Color3.fromRGB(105, 75, 210)
keyStroke.Thickness = 1.5
keyStroke.Parent = keyFrame

local keyTitle = Instance.new("TextLabel")
keyTitle.Size = UDim2.new(1, -20, 0, 35)
keyTitle.Position = UDim2.fromOffset(10, 10)
keyTitle.BackgroundTransparency = 1
keyTitle.Text = "ARGZx Key System"
keyTitle.TextColor3 = Color3.fromRGB(235, 230, 255)
keyTitle.Font = Enum.Font.GothamBold
keyTitle.TextSize = 18
keyTitle.Parent = keyFrame

local keyInput = Instance.new("TextBox")
keyInput.Size = UDim2.new(1, -40, 0, 42)
keyInput.Position = UDim2.fromOffset(20, 58)
keyInput.BackgroundColor3 = Color3.fromRGB(23, 23, 30)
keyInput.BorderSizePixel = 0
keyInput.PlaceholderText = "Enter Key here..."
keyInput.Text = ""
keyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
keyInput.PlaceholderColor3 = Color3.fromRGB(120, 120, 135)
keyInput.Font = Enum.Font.Gotham
keyInput.TextSize = 14
keyInput.ClearTextOnFocus = false
keyInput.Parent = keyFrame

Instance.new("UICorner", keyInput).CornerRadius = UDim.new(0, 8)

local verifyButton = Instance.new("TextButton")
verifyButton.Size = UDim2.new(1, -40, 0, 42)
verifyButton.Position = UDim2.fromOffset(20, 113)
verifyButton.BackgroundColor3 = Color3.fromRGB(95, 65, 205)
verifyButton.BorderSizePixel = 0
verifyButton.Text = "Verify Key"
verifyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
verifyButton.Font = Enum.Font.GothamBold
verifyButton.TextSize = 14
verifyButton.Parent = keyFrame

Instance.new("UICorner", verifyButton).CornerRadius = UDim.new(0, 8)

local keyStatus = Instance.new("TextLabel")
keyStatus.Size = UDim2.new(1, -40, 0, 20)
keyStatus.Position = UDim2.fromOffset(20, 158)
keyStatus.BackgroundTransparency = 1
keyStatus.Text = ""
keyStatus.TextColor3 = Color3.fromRGB(180, 180, 200)
keyStatus.Font = Enum.Font.Gotham
keyStatus.TextSize = 11
keyStatus.Parent = keyFrame

local function verifyKey()
    if keyInput.Text == VALID_KEY then
        verified = true

        verifyButton.Text = "Key Accepted"
        verifyButton.BackgroundColor3 = Color3.fromRGB(45, 170, 90)
        keyStatus.Text = "Access granted"

        task.wait(0.5)

        safeDestroy(keyGui)
        keyGui = nil
    else
        keyStatus.Text = "Invalid key"
        keyStatus.TextColor3 = Color3.fromRGB(255, 100, 100)

        verifyButton.Text = "Invalid Key"

        task.delay(1, function()
            if verifyButton and verifyButton.Parent then
                verifyButton.Text = "Verify Key"
            end
        end)
    end
end

verifyButton.MouseButton1Click:Connect(verifyKey)

keyInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        verifyKey()
    end
end)

while not verified do
    task.wait(0.1)

    if not keyGui or not keyGui.Parent then
        return
    end
end

--============================================================
-- GUI
--============================================================

gui = Instance.new("ScreenGui")
gui.Name = "ARGZx_GUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = PlayerGui

--============================================================
-- MAIN
--============================================================

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.fromOffset(360, 280)
main.Position = UDim2.new(0.5, -180, 0.5, -140)
main.BackgroundColor3 = Color3.fromRGB(18, 18, 23)
main.BorderSizePixel = 0
main.Parent = gui

Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(42, 42, 54)
mainStroke.Thickness = 1
mainStroke.Parent = main

--============================================================
-- SIDEBAR
--============================================================

local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 100, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(12, 12, 17)
sidebar.BorderSizePixel = 0
sidebar.Parent = main

Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 12)

local logo = Instance.new("TextLabel")
logo.Size = UDim2.new(1, 0, 0, 50)
logo.BackgroundTransparency = 1
logo.Text = "ARGZx"
logo.TextColor3 = Color3.fromRGB(235, 230, 255)
logo.Font = Enum.Font.GothamBold
logo.TextSize = 15
logo.Parent = sidebar

local nav = Instance.new("Frame")
nav.Size = UDim2.new(1, -10, 1, -60)
nav.Position = UDim2.fromOffset(5, 55)
nav.BackgroundTransparency = 1
nav.Parent = sidebar

local navLayout = Instance.new("UIListLayout")
navLayout.Padding = UDim.new(0, 5)
navLayout.Parent = nav

--============================================================
-- CONTENT
--============================================================

local content = Instance.new("Frame")
content.Size = UDim2.new(1, -100, 1, 0)
content.Position = UDim2.fromOffset(100, 0)
content.BackgroundColor3 = Color3.fromRGB(18, 18, 23)
content.BorderSizePixel = 0
content.Parent = main

local topTitle = Instance.new("TextLabel")
topTitle.Size = UDim2.new(1, -90, 0, 38)
topTitle.Position = UDim2.fromOffset(15, 4)
topTitle.BackgroundTransparency = 1
topTitle.Text = "ARGZx"
topTitle.TextColor3 = Color3.fromRGB(235, 230, 255)
topTitle.Font = Enum.Font.GothamBold
topTitle.TextSize = 16
topTitle.TextXAlignment = Enum.TextXAlignment.Left
topTitle.Parent = content

--============================================================
-- MINIMIZE
--============================================================

local minimizeButton = Instance.new("TextButton")
minimizeButton.Size = UDim2.fromOffset(28, 28)
minimizeButton.Position = UDim2.new(1, -68, 0, 7)
minimizeButton.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
minimizeButton.BorderSizePixel = 0
minimizeButton.Text = "-"
minimizeButton.TextColor3 = Color3.fromRGB(220, 220, 230)
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.TextSize = 16
minimizeButton.Parent = content

Instance.new("UICorner", minimizeButton).CornerRadius = UDim.new(0, 6)

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.fromOffset(28, 28)
closeButton.Position = UDim2.new(1, -35, 0, 7)
closeButton.BackgroundColor3 = Color3.fromRGB(45, 28, 34)
closeButton.BorderSizePixel = 0
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 150, 160)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 12
closeButton.Parent = content

Instance.new("UICorner", closeButton).CornerRadius = UDim.new(0, 6)

local miniButton = Instance.new("TextButton")
miniButton.Size = UDim2.fromOffset(120, 42)
miniButton.Position = UDim2.new(1, -135, 0, 18)
miniButton.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
miniButton.BorderSizePixel = 0
miniButton.Text = "ARGZx"
miniButton.TextColor3 = Color3.fromRGB(235, 230, 255)
miniButton.Font = Enum.Font.GothamBold
miniButton.TextSize = 15
miniButton.Visible = false
miniButton.Parent = gui

Instance.new("UICorner", miniButton).CornerRadius = UDim.new(0, 10)

local miniStroke = Instance.new("UIStroke")
miniStroke.Color = Color3.fromRGB(100, 75, 210)
miniStroke.Parent = miniButton

local minimized = false

local function setMinimized(state)
    minimized = state

    main.Visible = not state
    miniButton.Visible = state
end

minimizeButton.MouseButton1Click:Connect(function()
    setMinimized(true)
end)

miniButton.MouseButton1Click:Connect(function()
    setMinimized(false)
end)

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then
        return
    end

    if input.KeyCode == Enum.KeyCode.RightControl then
        setMinimized(not minimized)
    end
end)

--============================================================
-- DRAG
--============================================================

local dragBar = Instance.new("Frame")
dragBar.Size = UDim2.new(1, -105, 0, 35)
dragBar.Position = UDim2.fromOffset(100, 0)
dragBar.BackgroundTransparency = 1
dragBar.Active = true
dragBar.Parent = main

local dragging = false
local dragStart
local startPosition

dragBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        dragging = true
        dragStart = input.Position
        startPosition = main.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if not dragging then
        return
    end

    if input.UserInputType ~= Enum.UserInputType.MouseMovement
        and input.UserInputType ~= Enum.UserInputType.Touch then
        return
    end

    local delta = input.Position - dragStart

    main.Position = UDim2.new(
        startPosition.X.Scale,
        startPosition.X.Offset + delta.X,
        startPosition.Y.Scale,
        startPosition.Y.Offset + delta.Y
    )
end)

--============================================================
-- PAGES
--============================================================

local pages = {}

local function createPage(name)
    local page = Instance.new("ScrollingFrame")
    page.Name = name
    page.Size = UDim2.new(1, -20, 1, -50)
    page.Position = UDim2.fromOffset(10, 45)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 4
    page.ScrollBarImageColor3 = Color3.fromRGB(95, 70, 190)
    page.CanvasSize = UDim2.new(0, 0, 0, 500)
    page.Active = true
    page.ScrollingEnabled = true
    page.Visible = false
    page.Parent = content

    pages[name] = page

    return page
end

local farmingPage = createPage("Farming")
local bossPage = createPage("Boss")
local infoPage = createPage("Info")
local settingsPage = createPage("Settings")

farmingPage.Visible = true

--============================================================
-- NAVIGATION
--============================================================

local navButtons = {}

local function createNavButton(name)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 32)
    button.BackgroundColor3 = Color3.fromRGB(12, 12, 17)
    button.BorderSizePixel = 0
    button.Text = name
    button.TextColor3 = Color3.fromRGB(180, 180, 195)
    button.Font = Enum.Font.GothamMedium
    button.TextSize = 11
    button.Parent = nav

    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 7)

    navButtons[name] = button

    button.MouseButton1Click:Connect(function()
        for pageName, page in pairs(pages) do
            page.Visible = pageName == name
        end

        for _, other in pairs(navButtons) do
            other.BackgroundColor3 = Color3.fromRGB(12, 12, 17)
        end

        button.BackgroundColor3 = Color3.fromRGB(38, 30, 62)
    end)

    return button
end

createNavButton("Farming")
createNavButton("Boss")
createNavButton("Info")
createNavButton("Settings")

navButtons.Farming.BackgroundColor3 = Color3.fromRGB(38, 30, 62)

--============================================================
-- GUI HELPERS
--============================================================

local function createSection(parent, y, text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 0, 20)
    label.Position = UDim2.fromOffset(0, y)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(135, 110, 220)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = parent

    return label
end

local function createToggle(parent, y, title, description, default, callback)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, -10, 0, 54)
    row.Position = UDim2.fromOffset(0, y)
    row.BackgroundColor3 = Color3.fromRGB(24, 24, 31)
    row.BorderSizePixel = 0
    row.Parent = parent

    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 8)

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -75, 0, 20)
    titleLabel.Position = UDim2.fromOffset(12, 7)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(235, 235, 245)
    titleLabel.Font = Enum.Font.GothamMedium
    titleLabel.TextSize = 12
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = row

    local descriptionLabel = Instance.new("TextLabel")
    descriptionLabel.Size = UDim2.new(1, -75, 0, 18)
    descriptionLabel.Position = UDim2.fromOffset(12, 28)
    descriptionLabel.BackgroundTransparency = 1
    descriptionLabel.Text = description
    descriptionLabel.TextColor3 = Color3.fromRGB(130, 130, 145)
    descriptionLabel.Font = Enum.Font.Gotham
    descriptionLabel.TextSize = 10
    descriptionLabel.TextXAlignment = Enum.TextXAlignment.Left
    descriptionLabel.Parent = row

    local switch = Instance.new("Frame")
    switch.Size = UDim2.fromOffset(42, 24)
    switch.Position = UDim2.new(1, -55, 0.5, -12)
    switch.BackgroundColor3 =
        default
        and Color3.fromRGB(100, 70, 210)
        or Color3.fromRGB(50, 50, 60)
    switch.BorderSizePixel = 0
    switch.Parent = row

    Instance.new("UICorner", switch).CornerRadius = UDim.new(1, 0)

    local knob = Instance.new("Frame")
    knob.Size = UDim2.fromOffset(18, 18)
    knob.Position =
        default
        and UDim2.new(1, -21, 0.5, -9)
        or UDim2.fromOffset(3, 3)
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    knob.BorderSizePixel = 0
    knob.Parent = switch

    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

    local state = default

    local button = Instance.new("TextButton")
    button.Size = UDim2.fromScale(1, 1)
    button.BackgroundTransparency = 1
    button.Text = ""
    button.Parent = row

    button.MouseButton1Click:Connect(function()
        state = not state

        TweenService:Create(
            switch,
            TweenInfo.new(0.15),
            {
                BackgroundColor3 =
                    state
                    and Color3.fromRGB(100, 70, 210)
                    or Color3.fromRGB(50, 50, 60)
            }
        ):Play()

        TweenService:Create(
            knob,
            TweenInfo.new(0.15),
            {
                Position =
                    state
                    and UDim2.new(1, -21, 0.5, -9)
                    or UDim2.fromOffset(3, 3)
            }
        ):Play()

        if callback then
            callback(state)
        end
    end)

    return row
end

--============================================================
-- FARMING
--============================================================

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
farmingSub.Position = UDim2.fromOffset(0, 27)
farmingSub.BackgroundTransparency = 1
farmingSub.Text = "ARGZx farming controls"
farmingSub.TextColor3 = Color3.fromRGB(140, 140, 160)
farmingSub.Font = Enum.Font.Gotham
farmingSub.TextSize = 11
farmingSub.TextXAlignment = Enum.TextXAlignment.Left
farmingSub.Parent = farmingPage

createSection(farmingPage, 55, "FARM")

createToggle(
    farmingPage,
    80,
    "OP Farm",
    "Farm control placeholder",
    false,
    function(state)
        FastFarm = state
    end
)

createSection(farmingPage, 145, "REBIRTH")

createToggle(
    farmingPage,
    170,
    "Auto Rebirth",
    "Rebirth control placeholder",
    false,
    function(state)
        AutoRebirth = state
    end
)

createSection(farmingPage, 235, "FAST REBIRTH")

createToggle(
    farmingPage,
    260,
    "Fast Rebirth",
    "Speed -> Farm -> Packs -> Rebirth -> Golems",
    false,
    function(state)
        FastRebirth = state

        if state then
            FastRebirthStage = "Running"
        else
            FastRebirthStage = "Idle"
        end
    end
)

local farmingStatus = Instance.new("TextLabel")
farmingStatus.Size = UDim2.new(1, -10, 0, 42)
farmingStatus.Position = UDim2.fromOffset(0, 330)
farmingStatus.BackgroundColor3 = Color3.fromRGB(24, 24, 31)
farmingStatus.BorderSizePixel = 0
farmingStatus.Text = "Fast Rebirth: Idle"
farmingStatus.TextColor3 = Color3.fromRGB(160, 160, 180)
farmingStatus.Font = Enum.Font.GothamMedium
farmingStatus.TextSize = 12
farmingStatus.TextXAlignment = Enum.TextXAlignment.Left
farmingStatus.Parent = farmingPage

Instance.new("UICorner", farmingStatus).CornerRadius = UDim.new(0, 8)

local farmingPadding = Instance.new("UIPadding")
farmingPadding.PaddingLeft = UDim.new(0, 12)
farmingPadding.Parent = farmingStatus

--============================================================
-- BOSS
--============================================================

local bossTitle = Instance.new("TextLabel")
bossTitle.Size = UDim2.new(1, 0, 0, 28)
bossTitle.BackgroundTransparency = 1
bossTitle.Text = "Boss"
bossTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
bossTitle.Font = Enum.Font.GothamBold
bossTitle.TextSize = 20
bossTitle.TextXAlignment = Enum.TextXAlignment.Left
bossTitle.Parent = bossPage

createSection(bossPage, 55, "AUTO BOSS")

createToggle(
    bossPage,
    80,
    "Attack Boss",
    "Boss control placeholder",
    false,
    function(state)
        -- Intentionally left as a safe placeholder.
    end
)

local bossStatus = Instance.new("TextLabel")
bossStatus.Size = UDim2.new(1, -10, 0, 90)
bossStatus.Position = UDim2.fromOffset(0, 150)
bossStatus.BackgroundColor3 = Color3.fromRGB(24, 24, 31)
bossStatus.BorderSizePixel = 0
bossStatus.Text =
    "Boss status\n\n"
    .. "Automation disabled in this GUI build."
bossStatus.TextColor3 = Color3.fromRGB(155, 155, 175)
bossStatus.Font = Enum.Font.Gotham
bossStatus.TextSize = 11
bossStatus.TextXAlignment = Enum.TextXAlignment.Left
bossStatus.TextYAlignment = Enum.TextYAlignment.Top
bossStatus.Parent = bossPage

Instance.new("UICorner", bossStatus).CornerRadius = UDim.new(0, 8)

local bossPadding = Instance.new("UIPadding")
bossPadding.PaddingLeft = UDim.new(0, 12)
bossPadding.PaddingTop = UDim.new(0, 10)
bossPadding.Parent = bossStatus

--============================================================
-- INFO
--============================================================

local infoTitle = Instance.new("TextLabel")
infoTitle.Size = UDim2.new(1, 0, 0, 28)
infoTitle.BackgroundTransparency = 1
infoTitle.Text = "Info"
infoTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
infoTitle.Font = Enum.Font.GothamBold
infoTitle.TextSize = 20
infoTitle.TextXAlignment = Enum.TextXAlignment.Left
infoTitle.Parent = infoPage

createSection(infoPage, 55, "SESSION")

local statsFrame = Instance.new("Frame")
statsFrame.Size = UDim2.new(1, -10, 0, 155)
statsFrame.Position = UDim2.fromOffset(0, 80)
statsFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 31)
statsFrame.BorderSizePixel = 0
statsFrame.Parent = infoPage

Instance.new("UICorner", statsFrame).CornerRadius = UDim.new(0, 8)

local strengthLabel = Instance.new("TextLabel")
strengthLabel.Size = UDim2.new(1, -25, 0, 30)
strengthLabel.Position = UDim2.fromOffset(12, 12)
strengthLabel.BackgroundTransparency = 1
strengthLabel.Text = "Strength/hour: 0"
strengthLabel.TextColor3 = Color3.fromRGB(150, 210, 255)
strengthLabel.Font = Enum.Font.GothamMedium
strengthLabel.TextSize = 13
strengthLabel.TextXAlignment = Enum.TextXAlignment.Left
strengthLabel.Parent = statsFrame

local rebirthLabel = Instance.new("TextLabel")
rebirthLabel.Size = UDim2.new(1, -25, 0, 30)
rebirthLabel.Position = UDim2.fromOffset(12, 48)
rebirthLabel.BackgroundTransparency = 1
rebirthLabel.Text = "Rebirths/hour: 0"
rebirthLabel.TextColor3 = Color3.fromRGB(160, 255, 160)
rebirthLabel.Font = Enum.Font.GothamMedium
rebirthLabel.TextSize = 13
rebirthLabel.TextXAlignment = Enum.TextXAlignment.Left
rebirthLabel.Parent = statsFrame

local timeLabel = Instance.new("TextLabel")
timeLabel.Size = UDim2.new(1, -25, 0, 30)
timeLabel.Position = UDim2.fromOffset(12, 84)
timeLabel.BackgroundTransparency = 1
timeLabel.Text = "Session: 0m"
timeLabel.TextColor3 = Color3.fromRGB(180, 180, 210)
timeLabel.Font = Enum.Font.Gotham
timeLabel.TextSize = 12
timeLabel.TextXAlignment = Enum.TextXAlignment.Left
timeLabel.Parent = statsFrame

local pingLabel = Instance.new("TextLabel")
pingLabel.Size = UDim2.new(1, -25, 0, 30)
pingLabel.Position = UDim2.fromOffset(12, 115)
pingLabel.BackgroundTransparency = 1
pingLabel.Text = "Ping: -- ms"
pingLabel.TextColor3 = Color3.fromRGB(180, 180, 210)
pingLabel.Font = Enum.Font.Gotham
pingLabel.TextSize = 12
pingLabel.TextXAlignment = Enum.TextXAlignment.Left
pingLabel.Parent = statsFrame

--============================================================
-- SETTINGS
--============================================================

local settingsTitle = Instance.new("TextLabel")
settingsTitle.Size = UDim2.new(1, 0, 0, 28)
settingsTitle.BackgroundTransparency = 1
settingsTitle.Text = "Settings"
settingsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
settingsTitle.Font = Enum.Font.GothamBold
settingsTitle.TextSize = 20
settingsTitle.TextXAlignment = Enum.TextXAlignment.Left
settingsTitle.Parent = settingsPage

createSection(settingsPage, 55, "PERFORMANCE")

local performanceEnabled = false

createToggle(
    settingsPage,
    80,
    "Performance Mode",
    "Reduce visual effects",
    false,
    function(state)
        performanceEnabled = state
    end
)

local pingControl = true

createToggle(
    settingsPage,
    145,
    "Ping Control",
    "Display connection information",
    true,
    function(state)
        pingControl = state
    end
)

local stableUI = true

createToggle(
    settingsPage,
    210,
    "Stable UI",
    "Reduce interface animation",
    true,
    function(state)
        stableUI = state
    end
)

local settingsInfo = Instance.new("TextLabel")
settingsInfo.Size = UDim2.new(1, -10, 0, 100)
settingsInfo.Position = UDim2.fromOffset(0, 280)
settingsInfo.BackgroundColor3 = Color3.fromRGB(24, 24, 31)
settingsInfo.BorderSizePixel = 0
settingsInfo.Text =
    "ARGZx Settings\n\n"
    .. "Performance Mode: " .. tostring(performanceEnabled) .. "\n"
    .. "Ping Control: " .. tostring(pingControl) .. "\n"
    .. "Stable UI: " .. tostring(stableUI)
settingsInfo.TextColor3 = Color3.fromRGB(155, 155, 175)
settingsInfo.Font = Enum.Font.Gotham
settingsInfo.TextSize = 11
settingsInfo.TextXAlignment = Enum.TextXAlignment.Left
settingsInfo.TextYAlignment = Enum.TextYAlignment.Top
settingsInfo.Parent = settingsPage

Instance.new("UICorner", settingsInfo).CornerRadius = UDim.new(0, 8)

local settingsPadding = Instance.new("UIPadding")
settingsPadding.PaddingLeft = UDim.new(0, 12)
settingsPadding.PaddingTop = UDim.new(0, 10)
settingsPadding.Parent = settingsInfo

--============================================================
-- SESSION UPDATE
--============================================================

task.spawn(function()
    while gui and gui.Parent do
        local elapsed = os.clock() - sessionStart

        local hours = math.floor(elapsed / 3600)
        local minutes = math.floor((elapsed % 3600) / 60)

        local strengthRate = 0
        local rebirthRate = 0

        if elapsed > 0 then
            strengthRate = math.floor(
                (totalStrengthGained / elapsed) * 3600
            )

            rebirthRate = math.floor(
                (sessionRebirths / elapsed) * 3600
            )
        end

        strengthLabel.Text =
            "Strength/hour: " .. formatNumber(strengthRate)

        rebirthLabel.Text =
            "Rebirths/hour: " .. tostring(rebirthRate)

        timeLabel.Text =
            string.format(
                "Session: %dh %dm",
                hours,
                minutes
            )

        if pingControl then
            pingLabel.Text =
                "Ping: " .. tostring(getPing()) .. " ms"
        else
            pingLabel.Text = "Ping: disabled"
        end

        farmingStatus.Text =
            "Fast Rebirth: " .. FastRebirthStage

        settingsInfo.Text =
            "ARGZx Settings\n\n"
            .. "Performance Mode: " .. tostring(performanceEnabled) .. "\n"
            .. "Ping Control: " .. tostring(pingControl) .. "\n"
            .. "Stable UI: " .. tostring(stableUI)

        task.wait(1)
    end
end)

--============================================================
-- CLOSE
--============================================================

closeButton.MouseButton1Click:Connect(function()
    FastFarm = false
    AutoRebirth = false
    FastRebirth = false
    FastRebirthStage = "Idle"

    safeDestroy(gui)
    gui = nil
end)

print("[ARGZx] GUI loaded successfully.")
```
