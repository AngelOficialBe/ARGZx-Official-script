local function _0xS(_0xT)
    local _0xO = {}
    for _0xI = 1, #_0xT do
        _0xO[_0xI] = string.char(_0xT[_0xI])
    end
    return table.concat(_0xO)
end


local ValidKey = _0xS({83,76,75})
local ScriptURL = _0xS({104,116,116,112,115,58,47,47,114,97,119,46,103,105,116,104,117,98,117,115,101,114,99,111,110,116,101,110,116,46,99,111,109,47,65,110,103,101,108,79,102,105,99,105,97,108,66,101,47,65,82,71,90,120,45,79,102,102,105,99,105,97,108,45,115,99,114,105,112,116,47,114,101,102,115,47,104,101,97,100,115,47,109,97,105,110,47,65,82,71,90,120,45,85,112,100,97,116,101,46,108,117,97})


local Players = game:GetService(_0xS({80,108,97,121,101,114,115}))
local ReplicatedStorage = game:GetService(_0xS({82,101,112,108,105,99,97,116,101,100,83,116,111,114,97,103,101}))
local VirtualUser = game:GetService(_0xS({86,105,114,116,117,97,108,85,115,101,114}))
local TweenService = game:GetService(_0xS({84,119,101,101,110,83,101,114,118,105,99,101}))
local UserInputService = game:GetService(_0xS({85,115,101,114,73,110,112,117,116,83,101,114,118,105,99,101}))
local RunService = game:GetService(_0xS({82,117,110,83,101,114,118,105,99,101}))
local CollectionService = game:GetService(_0xS({67,111,108,108,101,99,116,105,111,110,83,101,114,118,105,99,101}))

local LP = Players.LocalPlayer
local PlayerGui = LP:WaitForChild(_0xS({80,108,97,121,101,114,71,117,105}))


local keyGui = Instance.new(_0xS({83,99,114,101,101,110,71,117,105}))
keyGui.Name = _0xS({83,76,75,83,121,115,116,101,109})
keyGui.ResetOnSpawn = false
keyGui.IgnoreGuiInset = true
keyGui.Parent = PlayerGui

local keyFrame = Instance.new(_0xS({70,114,97,109,101}))
keyFrame.Size = UDim2.new(0, 300, 0, 180)
keyFrame.Position = UDim2.new(0.5, -150, 0.5, -90)
keyFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
keyFrame.BorderSizePixel = 0
keyFrame.Parent = keyGui
Instance.new(_0xS({85,73,67,111,114,110,101,114}), keyFrame).CornerRadius = UDim.new(0, 12)

local keyStroke = Instance.new(_0xS({85,73,83,116,114,111,107,101}))
keyStroke.Color = Color3.fromRGB(180, 0, 0)
keyStroke.Thickness = 2
keyStroke.Parent = keyFrame

local keyTitle = Instance.new(_0xS({84,101,120,116,76,97,98,101,108}))
keyTitle.Size = UDim2.new(1, 0, 0, 40)
keyTitle.BackgroundTransparency = 1
keyTitle.Text = _0xS({83,76,75,32,75,101,121,32,83,121,115,116,101,109})
keyTitle.TextColor3 = Color3.fromRGB(255, 80, 80)
keyTitle.Font = Enum.Font.GothamBold
keyTitle.TextSize = 18
keyTitle.Parent = keyFrame

local keyInput = Instance.new(_0xS({84,101,120,116,66,111,120}))
keyInput.Size = UDim2.new(0.85, 0, 0, 40)
keyInput.Position = UDim2.new(0.075, 0, 0, 60)
keyInput.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
keyInput.Text = _0xS({})
keyInput.PlaceholderText = _0xS({69,110,116,101,114,32,75,101,121,32,104,101,114,101,46,46,46})
keyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
keyInput.Font = Enum.Font.Gotham
keyInput.TextSize = 14
keyInput.Parent = keyFrame
Instance.new(_0xS({85,73,67,111,114,110,101,114}), keyInput).CornerRadius = UDim.new(0, 8)

local verifyBtn = Instance.new(_0xS({84,101,120,116,66,117,116,116,111,110}))
verifyBtn.Size = UDim2.new(0.85, 0, 0, 40)
verifyBtn.Position = UDim2.new(0.075, 0, 0, 115)
verifyBtn.BackgroundColor3 = Color3.fromRGB(180, 30, 30)
verifyBtn.Text = _0xS({86,101,114,105,102,121,32,75,101,121})
verifyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
verifyBtn.Font = Enum.Font.GothamBold
verifyBtn.TextSize = 14
verifyBtn.Parent = keyFrame
Instance.new(_0xS({85,73,67,111,114,110,101,114}), verifyBtn).CornerRadius = UDim.new(0, 8)

local isVerified = false
verifyBtn.MouseButton1Click:Connect(function()
	if keyInput.Text == ValidKey then
		verifyBtn.Text = _0xS({75,101,121,32,65,99,99,101,112,116,101,100,33})
		verifyBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
		task.wait(1)
		keyGui:Destroy()
		isVerified = true
	else
		verifyBtn.Text = _0xS({73,110,118,97,108,105,100,32,75,101,121})
		verifyBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
		task.wait(1)
		verifyBtn.Text = _0xS({86,101,114,105,102,121,32,75,101,121})
		verifyBtn.BackgroundColor3 = Color3.fromRGB(180, 30, 30)
	end
end)

repeat task.wait(0.2) until isVerified


task.spawn(function()
	while task.wait(10) do
		local success, onlineCode = pcall(function()
			return game:HttpGet(ScriptURL)
		end)

		if success and type(onlineCode) == _0xS({115,116,114,105,110,103}) then
			local onlineKey =
				string.match(onlineCode, _0xS({108,111,99,97,108,37,115,43,86,97,108,105,100,75,101,121,37,115,42,61,37,115,42,34,40,91,94,34,93,43,41,34}))
				or string.match(onlineCode, _0xS({108,111,99,97,108,37,115,43,86,97,108,105,100,75,101,121,37,115,42,61,37,115,42,39,40,91,94,39,93,43,41,39}))

			if onlineKey and onlineKey ~= ValidKey then
				pcall(function()
					if keyGui and keyGui.Parent then keyGui:Destroy() end
					if gui and gui.Parent then gui:Destroy() end
					FastFarm = false
					AutoRebirth = false
					FastRebirth = false
				end)

				pcall(function()
					LP:Kick(_0xS({91,83,76,75,93,32,76,97,32,75,101,121,32,104,97,32,115,105,100,111,32,97,99,116,117,97,108,105,122,97,100,97,32,111,32,116,117,32,97,99,99,101,115,111,32,102,117,101,32,114,101,118,111,99,97,100,111,46}))
				end)
				break
			end
		end
	end
end)


LP.Idled:Connect(function()
	VirtualUser:CaptureController()
	VirtualUser:ClickButton2(Vector2.new())
end)

repeat task.wait(0.3) until LP:FindFirstChild(_0xS({109,117,115,99,108,101,69,118,101,110,116})) and LP:FindFirstChild(_0xS({108,101,97,100,101,114,115,116,97,116,115}))

local Strength = LP.leaderstats.Strength
local Rebirths = LP.leaderstats.Rebirths


local FastFarm = false
local AutoRebirth = false
local FastRebirth = false
local FastRebirthStage = _0xS({73,100,108,101})
local FastRebirthGeneration = 0

local startTime = tick()
local sessionRebirths = 0
local lastRebirths = Rebirths.Value
local totalStrengthGained = 0
local lastStrengthValue = tonumber(Strength.Value) or 0

Strength:GetPropertyChangedSignal(_0xS({86,97,108,117,101})):Connect(function()
	local current = tonumber(Strength.Value) or 0
	if current >= lastStrengthValue then
		totalStrengthGained += current - lastStrengthValue
	else
		totalStrengthGained += lastStrengthValue
	end
	lastStrengthValue = current
end)


local function getCharacter()
	return LP.Character
end

local function getHumanoid()
	local char = getCharacter()
	return char and char:FindFirstChildOfClass(_0xS({72,117,109,97,110,111,105,100}))
end

local function getRoot()
	local char = getCharacter()
	return char and char:FindFirstChild(_0xS({72,117,109,97,110,111,105,100,82,111,111,116,80,97,114,116}))
end

local function formatExact(n)
	n = tonumber(n) or 0
	if n >= 1e12 then return string.format(_0xS({37,46,50,102,84}), n/1e12)
	elseif n >= 1e9 then return string.format(_0xS({37,46,50,102,66}), n/1e9)
	elseif n >= 1e6 then return string.format(_0xS({37,46,50,102,77}), n/1e6)
	elseif n >= 1e3 then return string.format(_0xS({37,46,49,102,75}), n/1e3)
	else return tostring(math.floor(n)) end
end


local PingProtection = true
local PING_PAUSE = 5000
local PING_RESUME = 350
local PING_CHECK = 0.5
local pingPaused = false
local fastFarmBeforePing = false

local Stats = game:GetService(_0xS({83,116,97,116,115}))

local function getPing()
    local success, ping = pcall(function()
        local network = Stats:FindFirstChild(_0xS({78,101,116,119,111,114,107}))
        local serverStats = network and network:FindFirstChild(_0xS({83,101,114,118,101,114,83,116,97,116,115,73,116,101,109}))
        local dataPing = serverStats and serverStats:FindFirstChild(_0xS({68,97,116,97,32,80,105,110,103}))
        if dataPing then
            return tonumber(string.match(dataPing:GetValueString(), _0xS({37,100,43})))
        end
        return nil
    end)
    return success and ping or nil
end

task.spawn(function()
    while true do
        task.wait(PING_CHECK)
        if PingProtection then
            local ping = getPing()
            if ping then
                if not pingPaused and ping >= PING_PAUSE then
                    pingPaused = true
                    fastFarmBeforePing = FastFarm
                    FastFarm = false
                elseif pingPaused and ping <= PING_RESUME then
                    pingPaused = false
                    if fastFarmBeforePing then
                        FastFarm = true
                    end
                    fastFarmBeforePing = false
                end
            end
        end
    end
end)


task.spawn(function()
    local cachedEvent = LP:FindFirstChild(_0xS({109,117,115,99,108,101,69,118,101,110,116}))
    LP.ChildAdded:Connect(function(child)
        if child.Name == _0xS({109,117,115,99,108,101,69,118,101,110,116}) then cachedEvent = child end
    end)

    local RATE = 1000
    local BURST = 100
    local INTERVAL = BURST / RATE

    while true do
        if FastFarm then
            if not cachedEvent or not cachedEvent.Parent then
                cachedEvent = LP:FindFirstChild(_0xS({109,117,115,99,108,101,69,118,101,110,116}))
            end
            if cachedEvent then
                local start = os.clock()
                for i = 1, BURST do
                    if not FastFarm then break end
                    pcall(function() cachedEvent:FireServer(_0xS({114,101,112})) end)
                end
                local remaining = INTERVAL - (os.clock() - start)
                if remaining > 0 then task.wait(remaining) else task.wait() end
            else
                task.wait(0.05)
            end
        else
            task.wait(0.1)
        end
    end
end)


task.spawn(function()
	local lastRequest = 0
	local minCooldown = 0.20

	local function getRemote()
		local rEvents = ReplicatedStorage:FindFirstChild(_0xS({114,69,118,101,110,116,115}))
		return rEvents and rEvents:FindFirstChild(_0xS({114,101,98,105,114,116,104,82,101,109,111,116,101}))
	end

	local function tryRebirth()
		if not AutoRebirth then return end
		local now = os.clock()
		if now - lastRequest < minCooldown then return end

		local remote = getRemote()
		if not remote then return end

		lastRequest = now
		pcall(function()
			if remote:IsA(_0xS({82,101,109,111,116,101,70,117,110,99,116,105,111,110})) then
				remote:InvokeServer(_0xS({114,101,98,105,114,116,104,82,101,113,117,101,115,116}))
			elseif remote:IsA(_0xS({82,101,109,111,116,101,69,118,101,110,116})) then
				remote:FireServer(_0xS({114,101,98,105,114,116,104,82,101,113,117,101,115,116}))
			end
		end)
	end


	Strength:GetPropertyChangedSignal(_0xS({86,97,108,117,101})):Connect(tryRebirth)
	Rebirths:GetPropertyChangedSignal(_0xS({86,97,108,117,101})):Connect(function()
		if AutoRebirth then
			task.defer(tryRebirth)
		end
	end)


	while task.wait(0.10) do
		tryRebirth()
	end
end)






local function getRebirthRemote()
	local rEvents = ReplicatedStorage:FindFirstChild(_0xS({114,69,118,101,110,116,115}))
	return rEvents and rEvents:FindFirstChild(_0xS({114,101,98,105,114,116,104,82,101,109,111,116,101}))
end

local function fastRebirthStep()
	if not FastRebirth then return end
	local generation = FastRebirthGeneration

	FastRebirthStage = _0xS({83,112,101,101,100})
	local speedRemote = ReplicatedStorage:FindFirstChild(_0xS({114,69,118,101,110,116,115}))
		and ReplicatedStorage.rEvents:FindFirstChild(_0xS({99,104,97,110,103,101,83,112,101,101,100,83,105,122,101,82,101,109,111,116,101}))
	if speedRemote and speedRemote.Parent and FastRebirth and generation == FastRebirthGeneration then

	end

	FastRebirthStage = _0xS({70,97,114,109})
	FastFarm = true


	local deadline = os.clock() + 8
	while FastRebirth and generation == FastRebirthGeneration and os.clock() < deadline do
		local remote = getRebirthRemote()
		if remote and Strength and Strength.Parent then
			break
		end
		task.wait(0.05)
	end

	FastRebirthStage = _0xS({80,97,99,107,115})


	task.wait(0.03)

	FastRebirthStage = _0xS({82,101,98,105,114,116,104})
	local rebirthRemote = getRebirthRemote()
	if rebirthRemote and FastRebirth and generation == FastRebirthGeneration then
		pcall(function()
			if rebirthRemote:IsA(_0xS({82,101,109,111,116,101,70,117,110,99,116,105,111,110})) then
				rebirthRemote:InvokeServer(_0xS({114,101,98,105,114,116,104,82,101,113,117,101,115,116}))
			elseif rebirthRemote:IsA(_0xS({82,101,109,111,116,101,69,118,101,110,116})) then
				rebirthRemote:FireServer(_0xS({114,101,98,105,114,116,104,82,101,113,117,101,115,116}))
			end
		end)
	end

	FastRebirthStage = _0xS({71,111,108,101,109,115})


	task.wait(0.03)

	if FastRebirth and generation == FastRebirthGeneration then
		FastRebirthStage = _0xS({70,97,114,109})
	end
end

task.spawn(function()
	while true do
		if FastRebirth then
			pcall(fastRebirthStep)
		else
			FastRebirthStage = _0xS({73,100,108,101})
			task.wait(0.15)
		end
	end
end)


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


local BossFarm = {
	active = false,
	generation = 0,
	status = _0xS({83,105,110,32,98,111,115,115,32,97,99,116,105,118,111}),
	originalCharacter = nil,
	originalPivot = nil,
	originalSize = nil,
	originalRootAnchored = nil,
	engagedBoss = nil,
	confirmedDamage = 0,
	attacks = 0,
	hitInterval = 0.31,
	antiLag = false,
	antiLagOriginals = setmetatable({}, { __mode = _0xS({107}) }),
	antiLagConnection = nil,
	cameraRenderName = _0xS({83,76,75,66,111,115,115,83,116,97,98,108,101,67,97,109,101,114,97}),
	cameraSaved = nil,
	cameraFocusPosition = nil,
	cameraStableCFrame = nil,
	lastPlayerHealth = nil,
	safetyTriggered = false,
	safeAttackPosition = nil,
}

local function findBoss()
	for _, boss in ipairs(CollectionService:GetTagged(_0xS({66,111,115,115,69,118,101,110,116,66,111,115,115}))) do
		if boss and boss.Parent then
			local part = boss:FindFirstChild(_0xS({66,111,115,115,68,97,109,97,103,101,72,105,116,98,111,120}), true)
				or boss.PrimaryPart
				or boss:FindFirstChild(_0xS({66,111,115,115}), true)
				or boss:FindFirstChild(_0xS({72,101,97,100}), true)
				or boss:FindFirstChildWhichIsA(_0xS({66,97,115,101,80,97,114,116}), true)
			if part and part:IsA(_0xS({66,97,115,101,80,97,114,116})) then
				local target = boss:FindFirstChild(_0xS({66,111,115,115}))
					or boss:FindFirstChild(_0xS({72,101,97,100}), true)
					or boss.PrimaryPart
					or part
				if not target:IsA(_0xS({66,97,115,101,80,97,114,116})) then target = part end
				return boss, part, target
			end
		end
	end
	return nil, nil, nil
end

local function bossHealth()
	return math.max(0, tonumber(workspace:GetAttribute(_0xS({66,111,115,115,72,101,97,108,116,104}))) or 0)
end

local function setCharacterSize(size)
	local events = ReplicatedStorage:FindFirstChild(_0xS({114,69,118,101,110,116,115}))
	local remote = events and events:FindFirstChild(_0xS({99,104,97,110,103,101,83,112,101,101,100,83,105,122,101,82,101,109,111,116,101}))
	size = math.clamp(math.floor((tonumber(size) or 2) + 0.5), 1, 100)
	if not remote then return false end
	if remote:IsA(_0xS({82,101,109,111,116,101,69,118,101,110,116})) then
		return pcall(remote.FireServer, remote, _0xS({99,104,97,110,103,101,83,105,122,101}), size)
	elseif remote:IsA(_0xS({82,101,109,111,116,101,70,117,110,99,116,105,111,110})) then
		return pcall(remote.InvokeServer, remote, _0xS({99,104,97,110,103,101,83,105,122,101}), size)
	end
	return false
end

local function readCharacterSize()
	local humanoid = getHumanoid()
	local height = humanoid and humanoid:FindFirstChild(_0xS({66,111,100,121,72,101,105,103,104,116,83,99,97,108,101}))
	return math.clamp(math.floor(((height and height.Value) or 2) + 0.5), 1, 100)
end

local function equipBossPunch()
	local character = getCharacter()
	local humanoid = getHumanoid()
	local backpack = LP:FindFirstChild(_0xS({66,97,99,107,112,97,99,107}))
	local punch = character and character:FindFirstChild(_0xS({80,117,110,99,104}))
		or (backpack and backpack:FindFirstChild(_0xS({80,117,110,99,104})))
	if punch and humanoid and punch.Parent ~= character then
		pcall(humanoid.EquipTool, humanoid, punch)
		RunService.Heartbeat:Wait()
	end
	local attackTime = punch and punch:FindFirstChild(_0xS({97,116,116,97,99,107,84,105,109,101}))
	if attackTime and attackTime:IsA(_0xS({86,97,108,117,101,66,97,115,101})) then attackTime.Value = 0 end
	return punch
end

function BossFarm:ApplyAntiLagObject(object)
	if not self.antiLag or not object then return end
	local property
	if object:IsA(_0xS({80,97,114,116,105,99,108,101,69,109,105,116,116,101,114})) or object:IsA(_0xS({84,114,97,105,108})) or object:IsA(_0xS({66,101,97,109}))
		or object:IsA(_0xS({70,105,114,101})) or object:IsA(_0xS({83,109,111,107,101})) or object:IsA(_0xS({83,112,97,114,107,108,101,115}))
		or object:IsA(_0xS({80,111,105,110,116,76,105,103,104,116})) or object:IsA(_0xS({83,112,111,116,76,105,103,104,116})) or object:IsA(_0xS({83,117,114,102,97,99,101,76,105,103,104,116}))
		or object:IsA(_0xS({72,105,103,104,108,105,103,104,116})) then
		property = _0xS({69,110,97,98,108,101,100})
	elseif object:IsA(_0xS({66,97,115,101,80,97,114,116})) then
		property = _0xS({67,97,115,116,83,104,97,100,111,119})
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
	local events = workspace:FindFirstChild(_0xS({69,118,101,110,116,115}))
	local arena = events and events:FindFirstChild(_0xS({66,111,115,115,65,114,101,110,97}))
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
		local root = character and character:FindFirstChild(_0xS({72,117,109,97,110,111,105,100,82,111,111,116,80,97,114,116}))
		local humanoid = character and character:FindFirstChildWhichIsA(_0xS({72,117,109,97,110,111,105,100}))
		local machine = LP:FindFirstChild(_0xS({109,97,99,104,105,110,101,73,110,85,115,101}))
		local rebirthing = character and (character:GetAttribute(_0xS({73,115,82,101,98,105,114,116,104,105,110,103})) == true
			or character:GetAttribute(_0xS({76,97,115,116,77,97,112,67,70,114,97,109,101})) ~= nil)
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
	if not character or not root or boss.Parent == nil or workspace:GetAttribute(_0xS({66,111,115,115,65,99,116,105,118,101})) ~= true then
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
	local root = character and character:FindFirstChild(_0xS({72,117,109,97,110,111,105,100,82,111,111,116,80,97,114,116}))
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

	local backpack = LP:FindFirstChild(_0xS({66,97,99,107,112,97,99,107}))
	local punch = character and character:FindFirstChild(_0xS({80,117,110,99,104}))
	if punch and backpack then punch.Parent = backpack end

	self.originalCharacter = nil
	self.originalPivot = nil
	self.originalSize = nil
	self.originalRootAnchored = nil
	self.engagedBoss = nil
	self.lastPlayerHealth = nil
	self.safeAttackPosition = nil


	if self._wasFarming then
		FastFarm = true
		self._wasFarming = nil
	end
end

function BossFarm:CollectChest(timeout)
	if type(fireproximityprompt) ~= _0xS({102,117,110,99,116,105,111,110}) then return false end
	local opened = false
	local openedConnection
	local remoteFolder = ReplicatedStorage:FindFirstChild(_0xS({114,69,118,101,110,116,115}))
	local openedEvent = remoteFolder and remoteFolder:FindFirstChild(_0xS({98,111,115,115,67,104,101,115,116,79,112,101,110,101,100,69,118,101,110,116}))
	if openedEvent and openedEvent:IsA(_0xS({82,101,109,111,116,101,69,118,101,110,116})) then
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
		for _, candidate in ipairs(CollectionService:GetTagged(_0xS({66,111,115,115,69,118,101,110,116,67,104,101,115,116}))) do
			prompt = candidate:FindFirstChild(_0xS({98,111,115,115,67,104,101,115,116,80,114,111,109,112,116}), true)
			if prompt then chestModel = candidate break end
		end
		if not prompt then
			local events = workspace:FindFirstChild(_0xS({69,118,101,110,116,115}))
			prompt = events and events:FindFirstChild(_0xS({98,111,115,115,67,104,101,115,116,80,114,111,109,112,116}), true)
			chestModel = prompt and prompt:FindFirstAncestorOfClass(_0xS({77,111,100,101,108}))
		end

		local eligible = LP:GetAttribute(_0xS({66,111,115,115,67,104,101,115,116,69,108,105,103,105,98,108,101})) == true
		local pending = LP:GetAttribute(_0xS({66,111,115,115,67,104,101,115,116,80,101,110,100,105,110,103})) == true
		if pending then pendingWasSeen = true
		elseif attempted and pendingWasSeen then return finish(true) end

		local emerging = chestModel and chestModel:GetAttribute(_0xS({66,111,115,115,67,104,101,115,116,69,109,101,114,103,105,110,103})) == true
		if prompt and prompt:IsA(_0xS({80,114,111,120,105,109,105,116,121,80,114,111,109,112,116})) and eligible and pending and not emerging then
			local character = getCharacter()
			local root = getRoot()
			local parent = prompt.Parent
			if character and root and parent and parent:IsA(_0xS({66,97,115,101,80,97,114,116})) then
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
	return finish(opened or (attempted and pendingWasSeen and LP:GetAttribute(_0xS({66,111,115,115,67,104,101,115,116,80,101,110,100,105,110,103})) ~= true))
end

function BossFarm:Fight(boss)
	if not self:BeginBattle(boss) then return end

	local lastHealth = bossHealth()
	local lastAttack = 0

	while self.active and boss.Parent and workspace:GetAttribute(_0xS({66,111,115,115,65,99,116,105,118,101})) == true do
		local currentBoss, part, target = findBoss()
		if currentBoss ~= boss or not part or not target then break end

		local character = getCharacter()
		local root = getRoot()
		local humanoid = getHumanoid()
		local punch = equipBossPunch()

		if not character or not root or not humanoid or humanoid.Health <= 0 or not punch then
			self.status = _0xS({69,115,112,101,114,97,110,100,111,32,112,101,114,115,111,110,97,106,101})
			self:UpdateUi()
			task.wait(0.25)
		else
			if self.lastPlayerHealth and humanoid.Health < self.lastPlayerHealth then
				self.safetyTriggered = true
				self.active = false
				self.status = _0xS({80,114,111,116,101,99,99,105,111,110,32,97,99,116,105,118,97,100,97,32,40,116,101,32,103,111,108,112,101,97,114,111,110,41})
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

			self.status = (workspace:GetAttribute(_0xS({66,111,115,115,68,105,115,112,108,97,121,78,97,109,101})) or _0xS({66,111,115,115}))
				.. _0xS({32,32,100,97,110,111,32}) .. formatExact(self.confirmedDamage)
			self:UpdateUi()
			task.wait(0.04)
		end
	end

	local defeated = workspace:GetAttribute(_0xS({66,111,115,115,65,99,116,105,118,101})) ~= true or bossHealth() <= 0
	if defeated and self.active then
		self.status = _0xS({66,111,115,115,32,100,101,114,114,111,116,97,100,111,32,32,114,101,99,108,97,109,97,110,100,111,32,114,101,99,111,109,112,101,110,115,97})
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
		self.status = _0xS({83,105,110,32,98,111,115,115,32,97,99,116,105,118,111})
		self:RestoreBattle()
		self:SetAntiLag(false)
		self:UpdateUi()
		return true
	end


	local config = ReplicatedStorage:FindFirstChild(_0xS({115,104,97,114,101,100}))
	config = config and config:FindFirstChild(_0xS({99,111,110,102,105,103}))
	config = config and config:FindFirstChild(_0xS({66,111,115,115,69,118,101,110,116,67,111,110,102,105,103}))
	local ok, values = pcall(function() return config and require(config) end)
	if not ok or type(values) ~= _0xS({116,97,98,108,101}) or values.ENABLED ~= true then
		self.active = false
		self.status = _0xS({69,108,32,101,118,101,110,116,111,32,100,101,108,32,98,111,115,115,32,110,111,32,101,115,116,97,32,100,105,115,112,111,110,105,98,108,101})
		self:SetAntiLag(false)
		self:UpdateUi()
		return false
	end

	self:SetAntiLag(true)
	self.hitInterval = math.max(0.31, (tonumber(values.MIN_HIT_INTERVAL) or 0.3) + 0.01)

	task.spawn(function()
		while self.active and self.generation == generation do
			local boss = findBoss()
			if boss and workspace:GetAttribute(_0xS({66,111,115,115,65,99,116,105,118,101})) == true then
				self:Fight(boss)
			else
				self.engagedBoss = nil
				self.status = _0xS({83,105,110,32,98,111,115,115,32,97,99,116,105,118,111})
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
		local maximum = math.max(health, tonumber(workspace:GetAttribute(_0xS({66,111,115,115,77,97,120,72,101,97,108,116,104}))) or 0)
		if maximum > 0 and workspace:GetAttribute(_0xS({66,111,115,115,65,99,116,105,118,101})) == true then
			self.HealthLabel.Text = formatExact(health) .. _0xS({32,47,32}) .. formatExact(maximum)
		else
			self.HealthLabel.Text = _0xS({45})
		end
	end
end


local gui = Instance.new(_0xS({83,99,114,101,101,110,71,117,105}))
gui.Name = _0xS({83,76,75,95,65,117,114,97,108,71,85,73,95,73,109,112,114,111,118,101,100})
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = PlayerGui

local main = Instance.new(_0xS({70,114,97,109,101}))
main.Name = _0xS({77,97,105,110})
main.Size = UDim2.new(0, 360, 0, 270)
main.Position = UDim2.new(0.5, -180, 0.5, -135)
main.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = false
main.Parent = gui
Instance.new(_0xS({85,73,67,111,114,110,101,114}), main).CornerRadius = UDim.new(0, 12)

local mainStroke = Instance.new(_0xS({85,73,83,116,114,111,107,101}))
mainStroke.Color = Color3.fromRGB(40, 40, 50)
mainStroke.Thickness = 1
mainStroke.Parent = main


local dragBar = Instance.new(_0xS({70,114,97,109,101}))
dragBar.Name = _0xS({68,114,97,103,66,97,114})
dragBar.Size = UDim2.new(1, -100, 0, 32)
dragBar.Position = UDim2.new(0, 100, 0, 0)
dragBar.BackgroundTransparency = 1
dragBar.Active = true
dragBar.Parent = main

local dragTitle = Instance.new(_0xS({84,101,120,116,76,97,98,101,108}))
dragTitle.Size = UDim2.new(1, -70, 1, 0)
dragTitle.Position = UDim2.new(0, 12, 0, 0)
dragTitle.BackgroundTransparency = 1
dragTitle.Text = _0xS({83,76,75})
dragTitle.TextColor3 = Color3.fromRGB(150, 150, 170)
dragTitle.Font = Enum.Font.GothamMedium
dragTitle.TextSize = 11
dragTitle.TextXAlignment = Enum.TextXAlignment.Left
dragTitle.Parent = dragBar

local dragging = false
local dragStart = nil
local startPos = nil

dragBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = main.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then dragging = false end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if not dragging then return end
	if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then return end
	local delta = input.Position - dragStart
	main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end)


local sidebar = Instance.new(_0xS({70,114,97,109,101}))
sidebar.Size = UDim2.new(0, 100, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
sidebar.BorderSizePixel = 0
sidebar.Parent = main
Instance.new(_0xS({85,73,67,111,114,110,101,114}), sidebar).CornerRadius = UDim.new(0, 12)

local logoFrame = Instance.new(_0xS({70,114,97,109,101}))
logoFrame.Size = UDim2.new(1, 0, 0, 56)
logoFrame.BackgroundTransparency = 1
logoFrame.Parent = sidebar

local logoIcon = Instance.new(_0xS({84,101,120,116,76,97,98,101,108}))
logoIcon.Size = UDim2.new(0, 20, 0, 20)
logoIcon.Position = UDim2.new(0, 7, 0, 10)
logoIcon.BackgroundColor3 = Color3.fromRGB(90, 60, 220)
logoIcon.Text = _0xS({65})
logoIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
logoIcon.Font = Enum.Font.GothamBold
logoIcon.TextSize = 12
logoIcon.Parent = logoFrame
Instance.new(_0xS({85,73,67,111,114,110,101,114}), logoIcon).CornerRadius = UDim.new(0, 6)

local logoTitle = Instance.new(_0xS({84,101,120,116,76,97,98,101,108}))
logoTitle.Size = UDim2.new(1, -32, 0, 16)
logoTitle.Position = UDim2.new(0, 31, 0, 8)
logoTitle.BackgroundTransparency = 1
logoTitle.Text = _0xS({83,76,75,32,80,97,105,100})
logoTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
logoTitle.Font = Enum.Font.GothamBold
logoTitle.TextSize = 10
logoTitle.TextXAlignment = Enum.TextXAlignment.Left
logoTitle.Parent = logoFrame

local logoSub = Instance.new(_0xS({84,101,120,116,76,97,98,101,108}))
logoSub.Size = UDim2.new(1, -32, 0, 12)
logoSub.Position = UDim2.new(0, 31, 0, 23)
logoSub.BackgroundTransparency = 1
logoSub.Text = _0xS({77,117,115,99,108,101,32,76,101,103,101,110,100,115})
logoSub.TextColor3 = Color3.fromRGB(140, 140, 160)
logoSub.Font = Enum.Font.Gotham
logoSub.TextSize = 8
logoSub.TextXAlignment = Enum.TextXAlignment.Left
logoSub.Parent = logoFrame

local navContainer = Instance.new(_0xS({70,114,97,109,101}))
navContainer.Size = UDim2.new(1, -10, 1, -58)
navContainer.Position = UDim2.new(0, 5, 0, 56)
navContainer.BackgroundTransparency = 1
navContainer.Parent = sidebar

local navLayout = Instance.new(_0xS({85,73,76,105,115,116,76,97,121,111,117,116}))
navLayout.Padding = UDim.new(0, 4)
navLayout.Parent = navContainer

local pages = {}
local currentPage = _0xS({70,97,114,109,105,110,103})

local function createNavButton(name, icon, order)
	local btn = Instance.new(_0xS({84,101,120,116,66,117,116,116,111,110}))
	btn.Name = name
	btn.Size = UDim2.new(1, 0, 0, 29)
	btn.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
	btn.BorderSizePixel = 0
	btn.Text = _0xS({})
	btn.AutoButtonColor = false
	btn.LayoutOrder = order
	btn.Parent = navContainer
	Instance.new(_0xS({85,73,67,111,114,110,101,114}), btn).CornerRadius = UDim.new(0, 8)

	local iconLabel = Instance.new(_0xS({84,101,120,116,76,97,98,101,108}))
	iconLabel.Size = UDim2.new(0, 20, 1, 0)
	iconLabel.Position = UDim2.new(0, 3, 0, 0)
	iconLabel.BackgroundTransparency = 1
	iconLabel.Text = icon
	iconLabel.TextColor3 = Color3.fromRGB(160, 160, 180)
	iconLabel.Font = Enum.Font.GothamBold
	iconLabel.TextSize = 10
	iconLabel.Parent = btn

	local textLabel = Instance.new(_0xS({84,101,120,116,76,97,98,101,108}))
	textLabel.Size = UDim2.new(1, -27, 1, 0)
	textLabel.Position = UDim2.new(0, 25, 0, 0)
	textLabel.BackgroundTransparency = 1
	textLabel.Text = name
	textLabel.TextColor3 = Color3.fromRGB(180, 180, 200)
	textLabel.Font = Enum.Font.GothamMedium
	textLabel.TextSize = 10
	textLabel.TextXAlignment = Enum.TextXAlignment.Left
	textLabel.Parent = btn

	local indicator = Instance.new(_0xS({70,114,97,109,101}))
	indicator.Name = _0xS({73,110,100,105,99,97,116,111,114})
	indicator.Size = UDim2.new(0, 3, 0, 20)
	indicator.Position = UDim2.new(0, 0, 0.5, -10)
	indicator.BackgroundColor3 = Color3.fromRGB(120, 80, 255)
	indicator.BorderSizePixel = 0
	indicator.Visible = false
	indicator.Parent = btn
	Instance.new(_0xS({85,73,67,111,114,110,101,114}), indicator).CornerRadius = UDim.new(0, 2)

	btn.MouseButton1Click:Connect(function()
		for _, page in pairs(pages) do page.Visible = false end
		if pages[name] then pages[name].Visible = true end
		currentPage = name

		for _, child in ipairs(navContainer:GetChildren()) do
			if child:IsA(_0xS({84,101,120,116,66,117,116,116,111,110})) then
				child.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
				local ind = child:FindFirstChild(_0xS({73,110,100,105,99,97,116,111,114}))
				if ind then ind.Visible = false end
			end
		end
		btn.BackgroundColor3 = Color3.fromRGB(28, 24, 45)
		indicator.Visible = true
	end)
	return btn
end

local farmingNav = createNavButton(_0xS({70,97,114,109,105,110,103}), _0xS({70}), 1)
local bossNav = createNavButton(_0xS({66,111,115,115}), _0xS({66}), 2)
local infoNav = createNavButton(_0xS({73,110,102,111}), _0xS({73}), 3)
local settingsNav = createNavButton(_0xS({83,101,116,116,105,110,103,115}), _0xS({83}), 4)

farmingNav.BackgroundColor3 = Color3.fromRGB(28, 24, 45)
farmingNav:FindFirstChild(_0xS({73,110,100,105,99,97,116,111,114})).Visible = true


local content = Instance.new(_0xS({70,114,97,109,101}))
content.Size = UDim2.new(1, -100, 1, 0)
content.Position = UDim2.new(0, 100, 0, 0)
content.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
content.BorderSizePixel = 0
content.Parent = main

local closeBtn = Instance.new(_0xS({84,101,120,116,66,117,116,116,111,110}))
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -36, 0, 10)
closeBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
closeBtn.Text = _0xS({88})
closeBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.Parent = content
Instance.new(_0xS({85,73,67,111,114,110,101,114}), closeBtn).CornerRadius = UDim.new(0, 6)
closeBtn.MouseButton1Click:Connect(function()
	BossFarm:Set(false)
	gui:Destroy()
end)


local miniButton = Instance.new(_0xS({84,101,120,116,66,117,116,116,111,110}))
miniButton.Name = _0xS({83,76,75,77,105,110,105})
miniButton.Size = UDim2.new(0, 118, 0, 42)
miniButton.Position = UDim2.new(1, -132, 0, 18)
miniButton.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
miniButton.BorderSizePixel = 0
miniButton.Text = _0xS({83,76,75})
miniButton.TextColor3 = Color3.fromRGB(235, 235, 255)
miniButton.Font = Enum.Font.GothamBold
miniButton.TextSize = 15
miniButton.Visible = false
miniButton.AutoButtonColor = false
miniButton.Parent = gui
Instance.new(_0xS({85,73,67,111,114,110,101,114}), miniButton).CornerRadius = UDim.new(0, 12)
local miniStroke = Instance.new(_0xS({85,73,83,116,114,111,107,101}))
miniStroke.Color = Color3.fromRGB(95, 70, 190)
miniStroke.Thickness = 1.5
miniStroke.Parent = miniButton

local minimizeBtn = Instance.new(_0xS({84,101,120,116,66,117,116,116,111,110}))
minimizeBtn.Name = _0xS({77,105,110,105,109,105,122,101})
minimizeBtn.Size = UDim2.new(0, 28, 0, 28)
minimizeBtn.Position = UDim2.new(1, -70, 0, 10)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
minimizeBtn.Text = _0xS({45})
minimizeBtn.TextColor3 = Color3.fromRGB(210, 210, 225)
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 16
minimizeBtn.Parent = content
Instance.new(_0xS({85,73,67,111,114,110,101,114}), minimizeBtn).CornerRadius = UDim.new(0, 6)

minimizeBtn.MouseButton1Click:Connect(function()
	main.Visible = false
	miniButton.Visible = true
end)

miniButton.MouseButton1Click:Connect(function()
	miniButton.Visible = false
	main.Visible = true
end)


local function createToggle(parent, yPos, titleText, descText, defaultState, callback)
	local row = Instance.new(_0xS({70,114,97,109,101}))
	row.Size = UDim2.new(1, -10, 0, 52)
	row.Position = UDim2.new(0, 0, 0, yPos)
	row.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
	row.BorderSizePixel = 0
	row.Parent = parent
	Instance.new(_0xS({85,73,67,111,114,110,101,114}), row).CornerRadius = UDim.new(0, 8)

	local title = Instance.new(_0xS({84,101,120,116,76,97,98,101,108}))
	title.Size = UDim2.new(1, -70, 0, 20)
	title.Position = UDim2.new(0, 14, 0, 8)
	title.BackgroundTransparency = 1
	title.Text = titleText
	title.TextColor3 = Color3.fromRGB(240, 240, 250)
	title.Font = Enum.Font.GothamMedium
	title.TextSize = 13
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.Parent = row

	local desc = Instance.new(_0xS({84,101,120,116,76,97,98,101,108}))
	desc.Size = UDim2.new(1, -70, 0, 16)
	desc.Position = UDim2.new(0, 14, 0, 28)
	desc.BackgroundTransparency = 1
	desc.Text = descText
	desc.TextColor3 = Color3.fromRGB(130, 130, 150)
	desc.Font = Enum.Font.Gotham
	desc.TextSize = 11
	desc.TextXAlignment = Enum.TextXAlignment.Left
	desc.Parent = row

	local switchBg = Instance.new(_0xS({70,114,97,109,101}))
	switchBg.Size = UDim2.new(0, 42, 0, 24)
	switchBg.Position = UDim2.new(1, -56, 0.5, -12)
	switchBg.BackgroundColor3 = defaultState and Color3.fromRGB(100, 70, 220) or Color3.fromRGB(50, 50, 60)
	switchBg.BorderSizePixel = 0
	switchBg.Parent = row
	Instance.new(_0xS({85,73,67,111,114,110,101,114}), switchBg).CornerRadius = UDim.new(1, 0)

	local knob = Instance.new(_0xS({70,114,97,109,101}))
	knob.Size = UDim2.new(0, 18, 0, 18)
	knob.Position = defaultState and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
	knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	knob.BorderSizePixel = 0
	knob.Parent = switchBg
	Instance.new(_0xS({85,73,67,111,114,110,101,114}), knob).CornerRadius = UDim.new(1, 0)

	local state = defaultState
	local btn = Instance.new(_0xS({84,101,120,116,66,117,116,116,111,110}))
	btn.Size = UDim2.new(1, 0, 1, 0)
	btn.BackgroundTransparency = 1
	btn.Text = _0xS({})
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
	local label = Instance.new(_0xS({84,101,120,116,76,97,98,101,108}))
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


local farmingPage = Instance.new(_0xS({83,99,114,111,108,108,105,110,103,70,114,97,109,101}))
farmingPage.Name = _0xS({70,97,114,109,105,110,103})
farmingPage.Size = UDim2.new(1, -20, 1, -50)
farmingPage.Position = UDim2.new(0, 10, 0, 45)
farmingPage.BackgroundTransparency = 1
farmingPage.BorderSizePixel = 0
farmingPage.ScrollBarThickness = 4
farmingPage.ScrollingEnabled = true
farmingPage.Active = true
farmingPage.ScrollBarImageColor3 = Color3.fromRGB(80, 60, 160)
farmingPage.CanvasSize = UDim2.new(0, 0, 0, 350)
farmingPage.Parent = content
pages[_0xS({70,97,114,109,105,110,103})] = farmingPage

local farmingTitle = Instance.new(_0xS({84,101,120,116,76,97,98,101,108}))
farmingTitle.Size = UDim2.new(1, 0, 0, 28)
farmingTitle.BackgroundTransparency = 1
farmingTitle.Text = _0xS({70,97,114,109,105,110,103})
farmingTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
farmingTitle.Font = Enum.Font.GothamBold
farmingTitle.TextSize = 20
farmingTitle.TextXAlignment = Enum.TextXAlignment.Left
farmingTitle.Parent = farmingPage

local farmingSub = Instance.new(_0xS({84,101,120,116,76,97,98,101,108}))
farmingSub.Size = UDim2.new(1, 0, 0, 18)
farmingSub.Position = UDim2.new(0, 0, 0, 26)
farmingSub.BackgroundTransparency = 1
farmingSub.Text = _0xS({83,116,114,101,110,103,116,104,44,32,114,101,98,105,114,116,104,44,32,98,111,111,115,116,115})
farmingSub.TextColor3 = Color3.fromRGB(140, 140, 160)
farmingSub.Font = Enum.Font.Gotham
farmingSub.TextSize = 12
farmingSub.TextXAlignment = Enum.TextXAlignment.Left
farmingSub.Parent = farmingPage


local opRow = Instance.new(_0xS({70,114,97,109,101}))
opRow.Size = UDim2.new(1, -10, 0, 64)
opRow.Position = UDim2.new(0, 0, 0, 55)
opRow.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
opRow.BorderSizePixel = 0
opRow.Parent = farmingPage
Instance.new(_0xS({85,73,67,111,114,110,101,114}), opRow).CornerRadius = UDim.new(0, 8)

local opTitle = Instance.new(_0xS({84,101,120,116,76,97,98,101,108}))
opTitle.Size = UDim2.new(1, -110, 0, 22)
opTitle.Position = UDim2.new(0, 14, 0, 8)
opTitle.BackgroundTransparency = 1
opTitle.Text = _0xS({79,80,32,70,97,114,109})
opTitle.TextColor3 = Color3.fromRGB(240, 240, 250)
opTitle.Font = Enum.Font.GothamBold
opTitle.TextSize = 14
opTitle.TextXAlignment = Enum.TextXAlignment.Left
opTitle.Parent = opRow

local opDesc = Instance.new(_0xS({84,101,120,116,76,97,98,101,108}))
opDesc.Size = UDim2.new(1, -110, 0, 18)
opDesc.Position = UDim2.new(0, 14, 0, 32)
opDesc.BackgroundTransparency = 1
opDesc.Text = _0xS({84,97,114,103,101,116,58,32,32,79,80,32,124,70,65,82,77})
opDesc.TextColor3 = Color3.fromRGB(135, 135, 155)
opDesc.Font = Enum.Font.Gotham
opDesc.TextSize = 11
opDesc.TextXAlignment = Enum.TextXAlignment.Left
opDesc.Parent = opRow

local opButton = Instance.new(_0xS({84,101,120,116,66,117,116,116,111,110}))
opButton.Size = UDim2.new(0, 78, 0, 32)
opButton.Position = UDim2.new(1, -90, 0.5, -16)
opButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
opButton.Text = _0xS({79,70,70})
opButton.TextColor3 = Color3.fromRGB(190, 190, 205)
opButton.Font = Enum.Font.GothamBold
opButton.TextSize = 12
opButton.Parent = opRow
Instance.new(_0xS({85,73,67,111,114,110,101,114}), opButton).CornerRadius = UDim.new(0, 8)

local function updateOpButton(state)
	if state then
		opButton.Text = _0xS({79,78})
		opButton.BackgroundColor3 = Color3.fromRGB(100, 70, 220)
		opButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	else
		opButton.Text = _0xS({79,70,70})
		opButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
		opButton.TextColor3 = Color3.fromRGB(190, 190, 205)
	end
end

opButton.MouseButton1Click:Connect(function()
	FastFarm = not FastFarm
	updateOpButton(FastFarm)
end)

createSection(farmingPage, 135, _0xS({82,69,66,73,82,84,72}))
createToggle(farmingPage, 158, _0xS({65,117,116,111,32,82,101,98,105,114,116,104}), _0xS({82,101,98,105,114,116,104,32,119,104,101,110,32,115,116,114,101,110,103,116,104,32,114,101,97,99,104,101,115,32,116,104,114,101,115,104,111,108,100}), false, function(state)
	AutoRebirth = state
end)


createSection(farmingPage, 205, _0xS({70,65,83,84,32,82,69,66,73,82,84,72}))
createToggle(farmingPage, 228, _0xS({70,97,115,116,32,82,101,98,105,114,116,104}), _0xS({83,112,101,101,100,32,45,62,32,70,97,114,109,32,45,62,32,80,97,99,107,115,32,45,62,32,82,101,98,105,114,116,104,32,45,62,32,71,111,108,101,109,115}), false, function(state)
	FastRebirth = state
	FastRebirthGeneration += 1
	if state then
		FastFarm = true
		updateOpButton(true)
	else
		FastRebirthStage = _0xS({73,100,108,101})
	end
end)

local fastRebirthStatus = Instance.new(_0xS({84,101,120,116,76,97,98,101,108}))
fastRebirthStatus.Size = UDim2.new(1, -10, 0, 34)
fastRebirthStatus.Position = UDim2.new(0, 0, 0, 291)
fastRebirthStatus.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
fastRebirthStatus.BorderSizePixel = 0
fastRebirthStatus.Text = _0xS({70,97,115,116,32,82,101,98,105,114,116,104,58,32,73,100,108,101})
fastRebirthStatus.TextColor3 = Color3.fromRGB(150, 150, 175)
fastRebirthStatus.Font = Enum.Font.GothamMedium
fastRebirthStatus.TextSize = 12
fastRebirthStatus.TextXAlignment = Enum.TextXAlignment.Left
fastRebirthStatus.Parent = farmingPage
Instance.new(_0xS({85,73,67,111,114,110,101,114}), fastRebirthStatus).CornerRadius = UDim.new(0, 8)
local frPad = Instance.new(_0xS({85,73,80,97,100,100,105,110,103}), fastRebirthStatus)
frPad.PaddingLeft = UDim.new(0, 12)


createSection(farmingPage, 340, _0xS({83,69,83,83,73,79,78,32,83,84,65,84,83}))
local statsFrame = Instance.new(_0xS({70,114,97,109,101}))
statsFrame.Size = UDim2.new(1, -10, 0, 90)
statsFrame.Position = UDim2.new(0, 0, 0, 363)
statsFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
statsFrame.BorderSizePixel = 0
statsFrame.Parent = farmingPage
Instance.new(_0xS({85,73,67,111,114,110,101,114}), statsFrame).CornerRadius = UDim.new(0, 8)

local rebirthsLabel = Instance.new(_0xS({84,101,120,116,76,97,98,101,108}))
rebirthsLabel.Size = UDim2.new(1, -20, 0, 22)
rebirthsLabel.Position = UDim2.new(0, 14, 0, 12)
rebirthsLabel.BackgroundTransparency = 1
rebirthsLabel.Text = _0xS({83,101,115,115,105,111,110,32,82,101,98,105,114,116,104,115,58,32,48})
rebirthsLabel.TextColor3 = Color3.fromRGB(160, 255, 160)
rebirthsLabel.Font = Enum.Font.GothamMedium
rebirthsLabel.TextSize = 13
rebirthsLabel.TextXAlignment = Enum.TextXAlignment.Left
rebirthsLabel.Parent = statsFrame

local timeLabel = Instance.new(_0xS({84,101,120,116,76,97,98,101,108}))
timeLabel.Size = UDim2.new(1, -20, 0, 20)
timeLabel.Position = UDim2.new(0, 14, 0, 36)
timeLabel.BackgroundTransparency = 1
timeLabel.Text = _0xS({84,105,109,101,58,32,48,104,32,48,109})
timeLabel.TextColor3 = Color3.fromRGB(180, 180, 210)
timeLabel.Font = Enum.Font.Gotham
timeLabel.TextSize = 12
timeLabel.TextXAlignment = Enum.TextXAlignment.Left
timeLabel.Parent = statsFrame

local rateLabel = Instance.new(_0xS({84,101,120,116,76,97,98,101,108}))
rateLabel.Size = UDim2.new(1, -20, 0, 20)
rateLabel.Position = UDim2.new(0, 14, 0, 58)
rateLabel.BackgroundTransparency = 1
rateLabel.Text = _0xS({82,97,116,101,58,32,48,32,47,104})
rateLabel.TextColor3 = Color3.fromRGB(140, 190, 255)
rateLabel.Font = Enum.Font.Gotham
rateLabel.TextSize = 12
rateLabel.TextXAlignment = Enum.TextXAlignment.Left
rateLabel.Parent = statsFrame



local bossPage = Instance.new(_0xS({83,99,114,111,108,108,105,110,103,70,114,97,109,101}))
bossPage.Name = _0xS({66,111,115,115})
bossPage.Size = UDim2.new(1, -20, 1, -50)
bossPage.Position = UDim2.new(0, 10, 0, 45)
bossPage.BackgroundTransparency = 1
bossPage.BorderSizePixel = 0
bossPage.ScrollBarThickness = 4
bossPage.ScrollingEnabled = true
bossPage.Active = true
bossPage.ScrollBarImageColor3 = Color3.fromRGB(80, 60, 160)
bossPage.CanvasSize = UDim2.new(0, 0, 0, 380)
bossPage.Visible = false
bossPage.Parent = content
pages[_0xS({66,111,115,115})] = bossPage

local bossTitle = Instance.new(_0xS({84,101,120,116,76,97,98,101,108}))
bossTitle.Size = UDim2.new(1, 0, 0, 28)
bossTitle.BackgroundTransparency = 1
bossTitle.Text = _0xS({66,111,115,115})
bossTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
bossTitle.Font = Enum.Font.GothamBold
bossTitle.TextSize = 20
bossTitle.TextXAlignment = Enum.TextXAlignment.Left
bossTitle.Parent = bossPage

local bossSub = Instance.new(_0xS({84,101,120,116,76,97,98,101,108}))
bossSub.Size = UDim2.new(1, 0, 0, 18)
bossSub.Position = UDim2.new(0, 0, 0, 26)
bossSub.BackgroundTransparency = 1
bossSub.Text = _0xS({65,117,116,111,32,66,111,115,115,32,69,118,101,110,116})
bossSub.TextColor3 = Color3.fromRGB(140, 140, 160)
bossSub.Font = Enum.Font.Gotham
bossSub.TextSize = 12
bossSub.TextXAlignment = Enum.TextXAlignment.Left
bossSub.Parent = bossPage

createSection(bossPage, 55, _0xS({65,85,84,79,32,66,79,83,83}))


local statusRow = Instance.new(_0xS({70,114,97,109,101}))
statusRow.Size = UDim2.new(1, -10, 0, 42)
statusRow.Position = UDim2.new(0, 0, 0, 78)
statusRow.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
statusRow.BorderSizePixel = 0
statusRow.Parent = bossPage
Instance.new(_0xS({85,73,67,111,114,110,101,114}), statusRow).CornerRadius = UDim.new(0, 8)

local statusTitle = Instance.new(_0xS({84,101,120,116,76,97,98,101,108}))
statusTitle.Size = UDim2.new(0, 70, 1, 0)
statusTitle.Position = UDim2.new(0, 14, 0, 0)
statusTitle.BackgroundTransparency = 1
statusTitle.Text = _0xS({83,116,97,116,117,115,58})
statusTitle.TextColor3 = Color3.fromRGB(160, 160, 180)
statusTitle.Font = Enum.Font.Gotham
statusTitle.TextSize = 12
statusTitle.TextXAlignment = Enum.TextXAlignment.Left
statusTitle.Parent = statusRow

BossFarm.StatusLabel = Instance.new(_0xS({84,101,120,116,76,97,98,101,108}))
BossFarm.StatusLabel.Size = UDim2.new(1, -90, 1, 0)
BossFarm.StatusLabel.Position = UDim2.new(0, 80, 0, 0)
BossFarm.StatusLabel.BackgroundTransparency = 1
BossFarm.StatusLabel.Text = _0xS({83,105,110,32,98,111,115,115,32,97,99,116,105,118,111})
BossFarm.StatusLabel.TextColor3 = Color3.fromRGB(160, 160, 180)
BossFarm.StatusLabel.Font = Enum.Font.GothamMedium
BossFarm.StatusLabel.TextSize = 13
BossFarm.StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
BossFarm.StatusLabel.Parent = statusRow


local healthRow = Instance.new(_0xS({70,114,97,109,101}))
healthRow.Size = UDim2.new(1, -10, 0, 42)
healthRow.Position = UDim2.new(0, 0, 0, 128)
healthRow.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
healthRow.BorderSizePixel = 0
healthRow.Parent = bossPage
Instance.new(_0xS({85,73,67,111,114,110,101,114}), healthRow).CornerRadius = UDim.new(0, 8)

local healthTitle = Instance.new(_0xS({84,101,120,116,76,97,98,101,108}))
healthTitle.Size = UDim2.new(0, 100, 1, 0)
healthTitle.Position = UDim2.new(0, 14, 0, 0)
healthTitle.BackgroundTransparency = 1
healthTitle.Text = _0xS({66,111,115,115,32,72,101,97,108,116,104,58})
healthTitle.TextColor3 = Color3.fromRGB(160, 160, 180)
healthTitle.Font = Enum.Font.Gotham
healthTitle.TextSize = 12
healthTitle.TextXAlignment = Enum.TextXAlignment.Left
healthTitle.Parent = healthRow

BossFarm.HealthLabel = Instance.new(_0xS({84,101,120,116,76,97,98,101,108}))
BossFarm.HealthLabel.Size = UDim2.new(1, -120, 1, 0)
BossFarm.HealthLabel.Position = UDim2.new(0, 110, 0, 0)
BossFarm.HealthLabel.BackgroundTransparency = 1
BossFarm.HealthLabel.Text = _0xS({45})
BossFarm.HealthLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
BossFarm.HealthLabel.Font = Enum.Font.GothamMedium
BossFarm.HealthLabel.TextSize = 13
BossFarm.HealthLabel.TextXAlignment = Enum.TextXAlignment.Left
BossFarm.HealthLabel.Parent = healthRow


createToggle(bossPage, 185, _0xS({65,116,116,97,99,107,32,66,111,115,115}), _0xS({65,117,116,111,32,102,97,114,109,32,102,111,114,32,66,111,115,115,32,101,118,101,110,116,32,40,112,97,117,115,101,115,32,79,80,32,70,97,114,109,41}), false, function(state)
	local accepted = BossFarm:Set(state)
	if accepted == false then

	end
end)

createSection(bossPage, 255, _0xS({73,78,70,79}))
local infoLabel = Instance.new(_0xS({84,101,120,116,76,97,98,101,108}))
infoLabel.Size = UDim2.new(1, -10, 0, 80)
infoLabel.Position = UDim2.new(0, 0, 0, 278)
infoLabel.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
infoLabel.BorderSizePixel = 0
infoLabel.Text = _0xS({32,68,101,116,101,99,116,97,32,97,117,116,111,109,97,116,105,99,97,108,108,121,32,99,117,97,110,100,111,32,97,112,97,114,101,99,101,32,101,108,32,66,111,115,115,10,32,67,97,109,98,105,97,32,116,97,109,97,110,111,32,97,32,53,44,32,97,116,97,99,97,32,100,101,115,100,101,32,97,114,114,105,98,97,10,32,65,110,116,105,45,108,97,103,32,43,32,115,116,97,98,108,101,32,99,97,109,101,114,97,10,32,82,101,99,108,97,109,97,32,101,108,32,99,111,102,114,101,32,97,108,32,100,101,114,114,111,116,97,114,108,111,10,32,83,101,32,97,112,97,103,97,32,115,105,32,116,101,32,104,97,99,101,110,32,100,97,110,111,32,40,112,114,111,116,101,99,99,105,111,110,41})
infoLabel.TextColor3 = Color3.fromRGB(150, 150, 170)
infoLabel.Font = Enum.Font.Gotham
infoLabel.TextSize = 12
infoLabel.TextXAlignment = Enum.TextXAlignment.Left
infoLabel.TextYAlignment = Enum.TextYAlignment.Top
infoLabel.Parent = bossPage
Instance.new(_0xS({85,73,67,111,114,110,101,114}), infoLabel).CornerRadius = UDim.new(0, 8)
Instance.new(_0xS({85,73,80,97,100,100,105,110,103}), infoLabel).PaddingTop = UDim.new(0, 10)
Instance.new(_0xS({85,73,80,97,100,100,105,110,103}), infoLabel).PaddingLeft = UDim.new(0, 12)


local infoPage = Instance.new(_0xS({83,99,114,111,108,108,105,110,103,70,114,97,109,101}))
infoPage.Name = _0xS({73,110,102,111})
infoPage.Size = UDim2.new(1, -20, 1, -50)
infoPage.Position = UDim2.new(0, 10, 0, 45)
infoPage.BackgroundTransparency = 1
infoPage.BorderSizePixel = 0
infoPage.ScrollBarThickness = 4
infoPage.ScrollingEnabled = true
infoPage.Active = true
infoPage.ScrollBarImageColor3 = Color3.fromRGB(80, 60, 160)
infoPage.CanvasSize = UDim2.new(0, 0, 0, 360)
infoPage.Visible = false
infoPage.Parent = content
pages[_0xS({73,110,102,111})] = infoPage

local infoTitle = Instance.new(_0xS({84,101,120,116,76,97,98,101,108}))
infoTitle.Size = UDim2.new(1, 0, 0, 28)
infoTitle.BackgroundTransparency = 1
infoTitle.Text = _0xS({73,110,102,111})
infoTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
infoTitle.Font = Enum.Font.GothamBold
infoTitle.TextSize = 20
infoTitle.TextXAlignment = Enum.TextXAlignment.Left
infoTitle.Parent = infoPage

local infoSub = Instance.new(_0xS({84,101,120,116,76,97,98,101,108}))
infoSub.Size = UDim2.new(1, 0, 0, 18)
infoSub.Position = UDim2.new(0, 0, 0, 28)
infoSub.BackgroundTransparency = 1
infoSub.Text = _0xS({83,101,115,115,105,111,110,32,112,101,114,102,111,114,109,97,110,99,101,32,97,110,100,32,102,97,114,109,105,110,103,32,114,97,116,101,115})
infoSub.TextColor3 = Color3.fromRGB(140, 140, 160)
infoSub.Font = Enum.Font.Gotham
infoSub.TextSize = 12
infoSub.TextXAlignment = Enum.TextXAlignment.Left
infoSub.Parent = infoPage

createSection(infoPage, 58, _0xS({82,65,84,69,83,32,80,69,82,32,72,79,85,82}))
local infoFrame = Instance.new(_0xS({70,114,97,109,101}))
infoFrame.Size = UDim2.new(1, -10, 0, 150)
infoFrame.Position = UDim2.new(0, 0, 0, 84)
infoFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
infoFrame.BorderSizePixel = 0
infoFrame.Parent = infoPage
Instance.new(_0xS({85,73,67,111,114,110,101,114}), infoFrame).CornerRadius = UDim.new(0, 8)

local strengthHourLabel = Instance.new(_0xS({84,101,120,116,76,97,98,101,108}))
strengthHourLabel.Size = UDim2.new(1, -28, 0, 32)
strengthHourLabel.Position = UDim2.new(0, 14, 0, 12)
strengthHourLabel.BackgroundTransparency = 1
strengthHourLabel.Text = _0xS({83,116,114,101,110,103,116,104,32,112,101,114,32,104,111,117,114,58,32,48})
strengthHourLabel.TextColor3 = Color3.fromRGB(150, 210, 255)
strengthHourLabel.Font = Enum.Font.GothamMedium
strengthHourLabel.TextSize = 14
strengthHourLabel.TextXAlignment = Enum.TextXAlignment.Left
strengthHourLabel.Parent = infoFrame

local rebirthHourLabel = Instance.new(_0xS({84,101,120,116,76,97,98,101,108}))
rebirthHourLabel.Size = UDim2.new(1, -28, 0, 32)
rebirthHourLabel.Position = UDim2.new(0, 14, 0, 52)
rebirthHourLabel.BackgroundTransparency = 1
rebirthHourLabel.Text = _0xS({82,101,98,105,114,116,104,115,32,112,101,114,32,104,111,117,114,58,32,48})
rebirthHourLabel.TextColor3 = Color3.fromRGB(160, 255, 160)
rebirthHourLabel.Font = Enum.Font.GothamMedium
rebirthHourLabel.TextSize = 14
rebirthHourLabel.TextXAlignment = Enum.TextXAlignment.Left
rebirthHourLabel.Parent = infoFrame

local sessionInfoLabel = Instance.new(_0xS({84,101,120,116,76,97,98,101,108}))
sessionInfoLabel.Size = UDim2.new(1, -28, 0, 32)
sessionInfoLabel.Position = UDim2.new(0, 14, 0, 92)
sessionInfoLabel.BackgroundTransparency = 1
sessionInfoLabel.Text = _0xS({83,101,115,115,105,111,110,32,116,105,109,101,58,32,48,109})
sessionInfoLabel.TextColor3 = Color3.fromRGB(180, 180, 210)
sessionInfoLabel.Font = Enum.Font.Gotham
sessionInfoLabel.TextSize = 12
sessionInfoLabel.TextXAlignment = Enum.TextXAlignment.Left
sessionInfoLabel.Parent = infoFrame



local function updateSessionInfo()
	local elapsed = math.max(0, tick() - startTime)
	local hours = math.floor(elapsed / 3600)
	local minutes = math.floor((elapsed % 3600) / 60)
	local strengthRate = elapsed > 0 and math.floor((totalStrengthGained / elapsed) * 3600) or 0
	local rebirthRate = elapsed > 0 and math.floor((sessionRebirths / elapsed) * 3600) or 0

	if strengthHourLabel then strengthHourLabel.Text = _0xS({83,116,114,101,110,103,116,104,32,112,101,114,32,104,111,117,114,58,32}) .. formatExact(strengthRate) end
	if rebirthHourLabel then rebirthHourLabel.Text = _0xS({82,101,98,105,114,116,104,115,32,112,101,114,32,104,111,117,114,58,32}) .. rebirthRate end
	if sessionInfoLabel then sessionInfoLabel.Text = string.format(_0xS({83,101,115,115,105,111,110,32,116,105,109,101,58,32,37,100,104,32,37,100,109}), hours, minutes) end
	if rebirthsLabel then rebirthsLabel.Text = _0xS({83,101,115,115,105,111,110,32,82,101,98,105,114,116,104,115,58,32}) .. sessionRebirths end
	if timeLabel then timeLabel.Text = string.format(_0xS({84,105,109,101,58,32,37,100,104,32,37,100,109}), hours, minutes) end
	if rateLabel then rateLabel.Text = _0xS({82,97,116,101,58,32}) .. rebirthRate .. _0xS({32,47,104}) end
	if fastRebirthStatus then fastRebirthStatus.Text = _0xS({70,97,115,116,32,82,101,98,105,114,116,104,58,32}) .. FastRebirthStage end
end

task.spawn(function()
	while gui and gui.Parent do
		updateSessionInfo()
		task.wait(1)
	end
end)

local infoNote = Instance.new(_0xS({84,101,120,116,76,97,98,101,108}))
infoNote.Size = UDim2.new(1, -10, 0, 70)
infoNote.Position = UDim2.new(0, 0, 0, 250)
infoNote.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
infoNote.BorderSizePixel = 0
infoNote.Text = _0xS({82,97,116,101,115,32,97,114,101,32,99,97,108,99,117,108,97,116,101,100,32,102,114,111,109,32,116,104,105,115,32,115,101,115,115,105,111,110,46,10,83,116,114,101,110,103,116,104,32,99,111,117,110,116,115,32,99,117,109,117,108,97,116,105,118,101,32,103,97,105,110,115,44,32,105,110,99,108,117,100,105,110,103,32,115,116,114,101,110,103,116,104,32,101,97,114,110,101,100,32,98,101,102,111,114,101,32,114,101,98,105,114,116,104,46,10,83,104,111,114,116,32,115,101,115,115,105,111,110,115,32,109,97,121,32,115,104,111,119,32,48,32,117,110,116,105,108,32,101,110,111,117,103,104,32,100,97,116,97,32,105,115,32,99,111,108,108,101,99,116,101,100,46})
infoNote.TextColor3 = Color3.fromRGB(150, 150, 170)
infoNote.Font = Enum.Font.Gotham
infoNote.TextSize = 11
infoNote.TextXAlignment = Enum.TextXAlignment.Left
infoNote.TextYAlignment = Enum.TextYAlignment.Center
infoNote.Parent = infoPage
Instance.new(_0xS({85,73,67,111,114,110,101,114}), infoNote).CornerRadius = UDim.new(0, 8)
local infoPad = Instance.new(_0xS({85,73,80,97,100,100,105,110,103}), infoNote)
infoPad.PaddingLeft = UDim.new(0, 12)


local settingsPage = Instance.new(_0xS({83,99,114,111,108,108,105,110,103,70,114,97,109,101}))
settingsPage.Name = _0xS({83,101,116,116,105,110,103,115})
settingsPage.Size = UDim2.new(1, -20, 1, -50)
settingsPage.Position = UDim2.new(0, 10, 0, 45)
settingsPage.BackgroundTransparency = 1
settingsPage.BorderSizePixel = 0
settingsPage.ScrollBarThickness = 4
settingsPage.ScrollingEnabled = true
settingsPage.Active = true
settingsPage.CanvasSize = UDim2.new(0, 0, 0, 390)
settingsPage.Visible = false
settingsPage.Parent = content
pages[_0xS({83,101,116,116,105,110,103,115})] = settingsPage

local settingsTitle = Instance.new(_0xS({84,101,120,116,76,97,98,101,108}))
settingsTitle.Size = UDim2.new(1, 0, 0, 28)
settingsTitle.BackgroundTransparency = 1
settingsTitle.Text = _0xS({83,101,116,116,105,110,103,115})
settingsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
settingsTitle.Font = Enum.Font.GothamBold
settingsTitle.TextSize = 20
settingsTitle.TextXAlignment = Enum.TextXAlignment.Left
settingsTitle.Parent = settingsPage

local settingsSub = Instance.new(_0xS({84,101,120,116,76,97,98,101,108}))
settingsSub.Size = UDim2.new(1, 0, 0, 18)
settingsSub.Position = UDim2.new(0, 0, 0, 28)
settingsSub.BackgroundTransparency = 1
settingsSub.Text = _0xS({80,101,114,102,111,114,109,97,110,99,101,44,32,85,73,32,97,110,100,32,115,116,97,98,105,108,105,116,121})
settingsSub.TextColor3 = Color3.fromRGB(140, 140, 160)
settingsSub.Font = Enum.Font.Gotham
settingsSub.TextSize = 12
settingsSub.TextXAlignment = Enum.TextXAlignment.Left
settingsSub.Parent = settingsPage

local savedVisuals = setmetatable({}, {__mode = _0xS({107})})
local performanceEnabled = false

local function setPerformance(enabled)
	performanceEnabled = enabled == true
	for _, obj in ipairs(workspace:GetDescendants()) do
		if obj:IsA(_0xS({80,97,114,116,105,99,108,101,69,109,105,116,116,101,114})) or obj:IsA(_0xS({84,114,97,105,108})) or obj:IsA(_0xS({66,101,97,109}))
			or obj:IsA(_0xS({70,105,114,101})) or obj:IsA(_0xS({83,109,111,107,101})) or obj:IsA(_0xS({83,112,97,114,107,108,101,115}))
			or obj:IsA(_0xS({80,111,105,110,116,76,105,103,104,116})) or obj:IsA(_0xS({83,112,111,116,76,105,103,104,116})) or obj:IsA(_0xS({83,117,114,102,97,99,101,76,105,103,104,116}))
			or obj:IsA(_0xS({72,105,103,104,108,105,103,104,116})) then
			if savedVisuals[obj] == nil then savedVisuals[obj] = obj.Enabled end
			pcall(function() obj.Enabled = not enabled end)
		elseif obj:IsA(_0xS({66,97,115,101,80,97,114,116})) then
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

createSection(settingsPage, 58, _0xS({80,69,82,70,79,82,77,65,78,67,69}))
createToggle(settingsPage, 82, _0xS({80,101,114,102,111,114,109,97,110,99,101,32,77,111,100,101}), _0xS({82,101,100,117,99,101,32,112,97,114,116,105,99,117,108,97,115,44,32,108,117,99,101,115,44,32,104,105,103,104,108,105,103,104,116,115,32,121,32,115,111,109,98,114,97,115}), false, setPerformance)

createToggle(settingsPage, 145, _0xS({83,116,97,98,108,101,32,85,73}), _0xS({82,101,100,117,99,101,32,97,110,105,109,97,99,105,111,110,101,115,32,118,105,115,117,97,108,101,115,32,112,97,114,97,32,98,97,106,97,114,32,116,114,97,98,97,106,111,32,100,101,108,32,99,108,105,101,110,116,101}), true, function(state)


	_G.ARGZxStableUI = state
end)

createSection(settingsPage, 210, _0xS({70,65,82,77,32,83,84,65,66,73,76,73,84,89}))
local rateInfo = Instance.new(_0xS({84,101,120,116,76,97,98,101,108}))
rateInfo.Size = UDim2.new(1, -10, 0, 70)
rateInfo.Position = UDim2.new(0, 0, 0, 234)
rateInfo.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
rateInfo.BorderSizePixel = 0
rateInfo.Text = _0xS({79,80,32,70,97,114,109,32,116,97,114,103,101,116,58,32,56,48,48,32,114,101,112,115,47,115,10,84,104,101,32,99,108,105,101,110,116,32,115,101,110,100,115,32,105,110,32,99,111,110,116,114,111,108,108,101,100,32,98,97,116,99,104,101,115,59,32,115,101,114,118,101,114,32,108,105,109,105,116,115,32,109,97,121,32,115,116,105,108,108,32,97,112,112,108,121,46,10,70,97,115,116,32,82,101,98,105,114,116,104,32,111,114,100,101,114,58,32,83,112,101,101,100,32,45,62,32,70,97,114,109,32,45,62,32,80,97,99,107,115,32,45,62,32,82,101,98,105,114,116,104,32,45,62,32,71,111,108,101,109,115})
rateInfo.TextColor3 = Color3.fromRGB(155, 155, 175)
rateInfo.Font = Enum.Font.Gotham
rateInfo.TextSize = 12
rateInfo.TextXAlignment = Enum.TextXAlignment.Left
rateInfo.TextYAlignment = Enum.TextYAlignment.Center
rateInfo.Parent = settingsPage
Instance.new(_0xS({85,73,67,111,114,110,101,114}), rateInfo).CornerRadius = UDim.new(0, 8)
local pad = Instance.new(_0xS({85,73,80,97,100,100,105,110,103}), rateInfo)
pad.PaddingLeft = UDim.new(0, 12)



local function bindAutoCanvas(scroller, extra)
	local layout = scroller:FindFirstChildOfClass(_0xS({85,73,76,105,115,116,76,97,121,111,117,116}))
	if layout then
		local function refresh()
			scroller.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + (extra or 16))
		end
		layout:GetPropertyChangedSignal(_0xS({65,98,115,111,108,117,116,101,67,111,110,116,101,110,116,83,105,122,101})):Connect(refresh)
		refresh()
	end
end

bindAutoCanvas(farmingPage, 24)
bindAutoCanvas(bossPage, 24)
bindAutoCanvas(infoPage, 24)
bindAutoCanvas(settingsPage, 24)


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
print(_0xS({65,82,71,90,120,32,71,85,73,32,43,32,65,117,116,111,32,66,111,115,115,32,108,111,97,100,101,100}))
