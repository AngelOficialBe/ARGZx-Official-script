-- Halloween Boss Auto Kill (standalone)
-- Solo incluye un toggle para atacar al Grim Reaper/Halloween Boss.
-- El servidor del juego sigue controlando qué golpes y daño acepta.

local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("HalloweenAutoKillGui")
if old then old:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "HalloweenAutoKillGui"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(230, 105)
frame.Position = UDim2.new(0, 20, 0.45, 0)
frame.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
frame.BorderSizePixel = 0
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -16, 0, 32)
title.Position = UDim2.fromOffset(8, 5)
title.BackgroundTransparency = 1
title.Text = "HALLOWEEN BOSS"
title.TextColor3 = Color3.fromRGB(255, 170, 70)
title.Font = Enum.Font.GothamBold
title.TextSize = 15
title.Parent = frame

local toggle = Instance.new("TextButton")
toggle.Size = UDim2.new(1, -20, 0, 42)
toggle.Position = UDim2.fromOffset(10, 48)
toggle.BackgroundColor3 = Color3.fromRGB(115, 45, 45)
toggle.TextColor3 = Color3.new(1, 1, 1)
toggle.Font = Enum.Font.GothamBold
toggle.TextSize = 14
toggle.Text = "AUTO KILL: OFF"
toggle.Parent = frame
Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 8)

local enabled = false
local interval = 0.12 -- frecuencia de intentos; el servidor puede limitarla

local function normalize(value)
    return string.lower(tostring(value or "")):gsub("[%s_%-]", "")
end

local function isHalloweenBoss(model)
    if not model or not model.Parent then return false end

    local name = normalize(model.Name)
    local displayName = normalize(
        model:GetAttribute("BossDisplayName")
        or model:GetAttribute("DisplayName")
        or model:GetAttribute("BossName")
    )

    -- Evita atacar otros bosses que también tengan el tag genérico.
    local isGrim = name:find("grimreaper", 1, true)
        or displayName:find("grimreaper", 1, true)
    local isHalloween = name:find("halloween", 1, true)
        or displayName:find("halloween", 1, true)

    return isGrim ~= nil or isHalloween ~= nil
end

local function findHalloweenBoss()
    for _, model in ipairs(CollectionService:GetTagged("BossEventBoss")) do
        if model:IsA("Model") and isHalloweenBoss(model) then
            local hitbox = model:FindFirstChild("BossDamageHitbox", true)
                or model.PrimaryPart
                or model:FindFirstChild("Head", true)
                or model:FindFirstChildWhichIsA("BasePart", true)

            if hitbox and hitbox:IsA("BasePart") then
                return model, hitbox
            end
        end
    end
    return nil, nil
end

local function getCharacterParts()
    local character = player.Character
    if not character then return end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local root = character:FindFirstChild("HumanoidRootPart")
    if humanoid and root and humanoid.Health > 0 then
