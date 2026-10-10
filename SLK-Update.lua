--[[
███████╗██╗   ██╗██╗██╗         █████╗ ██╗  ██╗███████╗
██╔════╝██║   ██║██║██║        ██╔══██╗╚██╗██╔╝██╔════╝
█████╗  ██║   ██║██║██║        ███████║ ╚███╔╝ █████╗
██╔══╝  ╚██╗ ██╔╝██║██║        ██╔══██║ ██╔██╗ ██╔══╝
███████╗ ╚████╔╝ ██║███████╗   ██║  ██║██╔╝ ██╗███████╗
╚══════╝  ╚═══╝  ╚═╝╚══════╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝

        STUDIOS V2 OBFUSCATOR By MAX
        https://eaxe.net

        Sponsored by
        https://BloxDen.com
--]]

local x = "SLK";
local n = "https://raw.githubusercontent.com/AngelOficialBe/ARGZx-Official-script/refs/heads/main/ARGZx-Update.lua";
local z = game:GetService("Players");
local u = game:GetService("ReplicatedStorage");
local h = game:GetService("VirtualUser");
local j = game:GetService("TweenService");
local g = game:GetService("UserInputService");
local X = game:GetService("RunService");
local s = game:GetService("CollectionService");
local H = z.LocalPlayer;
local A = H:WaitForChild("PlayerGui");
local l = Instance.new("ScreenGui");
l.Name = "SLKSystem";
l.ResetOnSpawn = false;
l.IgnoreGuiInset = true;
l.Parent = A;
local t = Instance.new("Frame");
t.Size = UDim2.new(0, 300, 0, 180);
t.Position = UDim2.new(.5, -150, .5, -90);
t.BackgroundColor3 = Color3.fromRGB(10, 10, 15);
t.BorderSizePixel = 0;
t.Parent = l;
(Instance.new("UICorner", t)).CornerRadius = UDim.new(0, 12);
local S = Instance.new("UIStroke");
S.Color = Color3.fromRGB(180, 0, 0);
S.Thickness = 2;
S.Parent = t;
local q = Instance.new("TextLabel");
q.Size = UDim2.new(1, 0, 0, 40);
q.BackgroundTransparency = 1;
q.Text = "SLK Key System";
q.TextColor3 = Color3.fromRGB(255, 80, 80);
q.Font = Enum.Font.GothamBold;
q.TextSize = 18;
q.Parent = t;
local W = Instance.new("TextBox");
W.Size = UDim2.new(.85, 0, 0, 40);
W.Position = UDim2.new(.075, 0, 0, 60);
W.BackgroundColor3 = Color3.fromRGB(20, 20, 25);
W.Text = "";
W.PlaceholderText = "Enter Key here...";
W.TextColor3 = Color3.fromRGB(255, 255, 255);
W.Font = Enum.Font.Gotham;
W.TextSize = 14;
W.Parent = t;
(Instance.new("UICorner", W)).CornerRadius = UDim.new(0, 8);
local d = Instance.new("TextButton");
d.Size = UDim2.new(.85, 0, 0, 40);
d.Position = UDim2.new(.075, 0, 0, 115);
d.BackgroundColor3 = Color3.fromRGB(180, 30, 30);
d.Text = "Verify Key";
d.TextColor3 = Color3.fromRGB(255, 255, 255);
d.Font = Enum.Font.GothamBold;
d.TextSize = 14;
d.Parent = t;
(Instance.new("UICorner", d)).CornerRadius = UDim.new(0, 8);
local L = false;
d.MouseButton1Click:Connect(function()
	if W.Text == x then
		d.Text = "Key Accepted!";
		d.BackgroundColor3 = Color3.fromRGB(0, 180, 0);
		task.wait(1);
		l:Destroy();
		L = true;
	else
		d.Text = "Invalid Key";
		d.BackgroundColor3 = Color3.fromRGB(180, 0, 0);
		task.wait(1);
		d.Text = "Verify Key";
		d.BackgroundColor3 = Color3.fromRGB(180, 30, 30);
	end;
end);
repeat
	task.wait(.2);
until L;
task.spawn(function()
	while task.wait(10) do
		local z, u = pcall(function()
				return game:HttpGet(n);
			end);
		if z and type(u) == "string" then
			local n = string.match(u, "local%s+ValidKey%s*=%s*\"([^\"]+)\"") or string.match(u, "local%s+ValidKey%s*=%s*\'([^\']+)\'");
			if n and n ~= x then
				pcall(function()
					if l and l.Parent then
						l:Destroy();
					end;
					if gui and gui.Parent then
						gui:Destroy();
					end;
					FastFarm = false;
					AutoRebirth = false;
					FastRebirth = false;
				end);
				pcall(function()
					H:Kick("[SLK] La Key ha sido actualizada o tu acceso fue revocado.");
				end);
				break;
			end;
		end;
	end;
end);
H.Idled:Connect(function()
	h:CaptureController();
	h:ClickButton2(Vector2.new());
end);
repeat
	task.wait(.3);
until H:FindFirstChild("muscleEvent") and H:FindFirstChild("leaderstats");
local f = H.leaderstats.Strength;
local p = H.leaderstats.Rebirths;
local r = false;
local Q = false;
local y = false;
local w = "Idle";
local c = 0;
local b = tick();
local m = 0;
local k = p.Value;
local B = 0;
local J = tonumber(f.Value) or 0;
(f:GetPropertyChangedSignal("Value")):Connect(function()
	local x = tonumber(f.Value) or 0;
	if x >= J then
		B = B + ((x - J));
	else
		B = B + (J);
	end;
	J = x;
end);
local function R()
	return H.Character;
end;
local function D()
	local x = R();
	return x and x:FindFirstChildOfClass("Humanoid");
end;
local function P()
	local x = R();
	return x and x:FindFirstChild("HumanoidRootPart");
end;
local function Y(x)
	x = tonumber(x) or 0;
	if x >= 1000000000000 then
		return string.format("%.2fT", x / 1000000000000);
	elseif x >= 1000000000 then
		return string.format("%.2fB", x / 1000000000);
	elseif x >= 1000000 then
		return string.format("%.2fM", x / 1000000);
	elseif x >= 1000 then
		return string.format("%.1fK", x / 1000);
	else
		return tostring(math.floor(x));
	end;
end;
local N = true;
local M = 5000;
local O = 350;
local V = .5;
local i = false;
local C = false;
local a = game:GetService("Stats");
local function o()
	local x, n = pcall(function()
			local x = a:FindFirstChild("Network");
			local n = x and x:FindFirstChild("ServerStatsItem");
			local z = n and n:FindFirstChild("Data Ping");
			if z then
				return tonumber(string.match(z:GetValueString(), "%d+"));
			end;
			return nil;
		end);
	return x and n or nil;
end;
task.spawn(function()
	while true do
		task.wait(V);
		if N then
			local x = o();
			if x then
				if not i and x >= M then
					i = true;
					C = r;
					r = false;
				elseif i and x <= O then
					i = false;
					if C then
						r = true;
					end;
					C = false;
				end;
			end;
		end;
	end;
end);
task.spawn(function()
	local x = H:FindFirstChild("muscleEvent");
	H.ChildAdded:Connect(function(n)
		if n.Name == "muscleEvent" then
			x = n;
		end;
	end);
	local n = 1000;
	local z = 100;
	local u = z / n;
	while true do
		if r then
			if not x or not x.Parent then
				x = H:FindFirstChild("muscleEvent");
			end;
			if x then
				local n = os.clock();
				for n = 1, z, 1 do
					if not r then
						break;
					end;
					pcall(function()
						x:FireServer("rep");
					end);
				end;
				local h = u - ((os.clock() - n));
				if h > 0 then
					task.wait(h);
				else
					task.wait();
				end;
			else
				task.wait(.05);
			end;
		else
			task.wait(.1);
		end;
	end;
end);
task.spawn(function()
	local x = 0;
	local n = .2;
	local function z()
		local x = u:FindFirstChild("rEvents");
		return x and x:FindFirstChild("rebirthRemote");
	end;
	local function h()
		if not Q then
			return;
		end;
		local u = os.clock();
		if u - x < n then
			return;
		end;
		local h = z();
		if not h then
			return;
		end;
		x = u;
		pcall(function()
			if h:IsA("RemoteFunction") then
				h:InvokeServer("rebirthRequest");
			elseif h:IsA("RemoteEvent") then
				h:FireServer("rebirthRequest");
			end;
		end);
	end;
	(f:GetPropertyChangedSignal("Value")):Connect(h);
	(p:GetPropertyChangedSignal("Value")):Connect(function()
		if Q then
			task.defer(h);
		end;
	end);
	while task.wait(.1) do
		h();
	end;
end);
local function F()
	local x = u:FindFirstChild("rEvents");
	return x and x:FindFirstChild("rebirthRemote");
end;
local function e()
	if not y then
		return;
	end;
	local x = c;
	w = "Speed";
	local n = u:FindFirstChild("rEvents") and u.rEvents:FindFirstChild("changeSpeedSizeRemote");
	if n and (n.Parent and (y and x == c)) then
 
	end;
	w = "Farm";
	r = true;
	local z = os.clock() + 8;
	while y and (x == c and os.clock() < z) do
		local x = F();
		if x and (f and f.Parent) then
			break;
		end;
		task.wait(.05);
	end;
	w = "Packs";
	task.wait(.03);
	w = "Rebirth";
	local h = F();
	if h and (y and x == c) then
		pcall(function()
			if h:IsA("RemoteFunction") then
				h:InvokeServer("rebirthRequest");
			elseif h:IsA("RemoteEvent") then
				h:FireServer("rebirthRequest");
			end;
		end);
	end;
	w = "Golems";
	task.wait(.03);
	if y and x == c then
		w = "Farm";
	end;
end;
task.spawn(function()
	while true do
		if y then
			pcall(e);
		else
			w = "Idle";
			task.wait(.15);
		end;
	end;
end);
task.spawn(function()
	while true do
		if p.Value > k then
			m = m + ((p.Value - k));
			k = p.Value;
		elseif p.Value < k then
			k = p.Value;
		end;
		task.wait(.4);
	end;
end);
local K = {
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
		hitInterval = .31,
		antiLag = false,
		antiLagOriginals = setmetatable({}, { __mode = "k" }),
		antiLagConnection = nil,
		cameraRenderName = "SLKBossStableCamera",
		cameraSaved = nil,
		cameraFocusPosition = nil,
		cameraStableCFrame = nil,
		lastPlayerHealth = nil,
		safetyTriggered = false,
		safeAttackPosition = nil,
	};
local function I()
	for x, n in ipairs(s:GetTagged("BossEventBoss")) do
		if n and n.Parent then
			local x = n:FindFirstChild("BossDamageHitbox", true) or n.PrimaryPart or n:FindFirstChild("Boss", true) or n:FindFirstChild("Head", true) or n:FindFirstChildWhichIsA("BasePart", true);
			if x and x:IsA("BasePart") then
				local z = n:FindFirstChild("Boss") or n:FindFirstChild("Head", true) or n.PrimaryPart or x;
				if not z:IsA("BasePart") then
					z = x;
				end;
				return n, x, z;
			end;
		end;
	end;
	return nil, nil, nil;
end;
local function T()
	return math.max(0, tonumber(workspace:GetAttribute("BossHealth")) or 0);
end;
local function v(x)
	local n = u:FindFirstChild("rEvents");
	local z = n and n:FindFirstChild("changeSpeedSizeRemote");
	x = math.clamp(math.floor(((tonumber(x) or 2)) + .5), 1, 100);
	if not z then
		return false;
	end;
	if z:IsA("RemoteEvent") then
		return pcall(z.FireServer, z, "changeSize", x);
	elseif z:IsA("RemoteFunction") then
		return pcall(z.InvokeServer, z, "changeSize", x);
	end;
	return false;
end;
local function E()
	local x = D();
	local n = x and x:FindFirstChild("BodyHeightScale");
	return math.clamp(math.floor((((n and n.Value) or 2)) + .5), 1, 100);
end;
local function Z()
	local x = R();
	local n = D();
	local z = H:FindFirstChild("Backpack");
	local u = x and x:FindFirstChild("Punch") or (z and z:FindFirstChild("Punch"));
	if u and (n and u.Parent ~= x) then
		pcall(n.EquipTool, n, u);
		X.Heartbeat:Wait();
	end;
	local h = u and u:FindFirstChild("attackTime");
	if h and h:IsA("ValueBase") then
		h.Value = 0;
	end;
	return u;
end;
function K.ApplyAntiLagObject(n, x)
	if not n.antiLag or not x then
		return;
	end;
	local z;
	if x:IsA("ParticleEmitter") or x:IsA("Trail") or x:IsA("Beam") or x:IsA("Fire") or x:IsA("Smoke") or x:IsA("Sparkles") or x:IsA("PointLight") or x:IsA("SpotLight") or x:IsA("SurfaceLight") or x:IsA("Highlight") then
		z = "Enabled";
	elseif x:IsA("BasePart") then
		z = "CastShadow";
	end;
	if z and n.antiLagOriginals[x] == nil then
		n.antiLagOriginals[x] = { property = z, value = x[z] };
		pcall(function()
			x[z] = false;
		end);
	end;
end;
function K.SetAntiLag(n, x)
	x = x == true;
	n.antiLag = x;
	if n.antiLagConnection then
		n.antiLagConnection:Disconnect();
		n.antiLagConnection = nil;
	end;
	if not x then
		for x, z in pairs(n.antiLagOriginals) do
			if x and x.Parent then
				pcall(function()
					x[z.property] = z.value;
				end);
			end;
			n.antiLagOriginals[x] = nil;
		end;
		return true;
	end;
	local z = workspace:FindFirstChild("Events");
	local u = z and z:FindFirstChild("BossArena");
	if not u then
		n.antiLag = false;
		return false;
	end;
	for x, z in ipairs(u:GetDescendants()) do
		n:ApplyAntiLagObject(z);
	end;
	n.antiLagConnection = u.DescendantAdded:Connect(function(x)
			task.defer(function()
				n:ApplyAntiLagObject(x);
			end);
		end);
	return true;
end;
function K.StopStableCamera(x)
	pcall(X.UnbindFromRenderStep, X, x.cameraRenderName);
	local n = workspace.CurrentCamera;
	local z = x.cameraSaved;
	if n and z then
		pcall(function()
			n.CameraType = Enum.CameraType.Scriptable;
			n.CFrame = z.cframe;
			n.Focus = z.focus;
			if z.subject and z.subject.Parent then
				n.CameraSubject = z.subject;
			end;
			n.CameraType = z.cameraType;
		end);
	end;
	x.cameraSaved = nil;
	x.cameraFocusPosition = nil;
	x.cameraStableCFrame = nil;
end;
function K.StartStableCamera(x)
	x:StopStableCamera();
	local n = workspace.CurrentCamera;
	if not n then
		return;
	end;
	x.cameraSaved = {
			cameraType = n.CameraType,
			subject = n.CameraSubject,
			cframe = n.CFrame,
			focus = n.Focus,
		};
	n.CameraType = Enum.CameraType.Scriptable;
	X:BindToRenderStep(x.cameraRenderName, Enum.RenderPriority.Camera.Value + 50, function(n)
		local z = x.cameraFocusPosition;
		local u = workspace.CurrentCamera;
		if not x.engagedBoss or not z or not u then
			return;
		end;
		local h = CFrame.lookAt(z + Vector3.new(0, 34, 48), z + Vector3.new(0, -5, 0));
		x.cameraStableCFrame = x.cameraStableCFrame and x.cameraStableCFrame:Lerp(h, math.clamp(n * 4, .04, .22)) or h;
		u.CameraType = Enum.CameraType.Scriptable;
		u.CFrame = x.cameraStableCFrame;
		u.Focus = CFrame.new(z);
	end);
end;
function K.WaitForReadyCharacter(n, x)
	local z = os.clock() + ((tonumber(x) or 8));
	local u, h, j;
	while n.active and os.clock() < z do
		local x = R();
		local n = x and x:FindFirstChild("HumanoidRootPart");
		local z = x and x:FindFirstChildWhichIsA("Humanoid");
		local g = H:FindFirstChild("machineInUse");
		local X = x and ((x:GetAttribute("IsRebirthing") == true or x:GetAttribute("LastMapCFrame") ~= nil));
		local s = (g and g.Value ~= nil) or (z and z.SeatPart ~= nil);
		if x and (n and (z and (z.Health > 0 and (not X and not s)))) then
			if x ~= u or n ~= h then
				u, h, j = x, n, os.clock();
			elseif os.clock() - j >= .18 then
				return x, n, z;
			end;
		else
			u, h, j = nil, nil, nil;
		end;
		task.wait(.05);
	end;
	return nil, nil, nil;
end;
function K.BeginBattle(n, x)
	if n.engagedBoss == x then
		return true;
	end;
	local z = r;
	r = false;
	local u, h = n:WaitForReadyCharacter(8);
	if not u or not h or x.Parent == nil or workspace:GetAttribute("BossActive") ~= true then
		r = z;
		n:RestoreBattle();
		return false;
	end;
	n.originalCharacter = u;
	n.originalPivot = u:GetPivot();
	n.originalSize = E();
	n.originalRootAnchored = h.Anchored;
	n.engagedBoss = x;
	n.confirmedDamage = 0;
	n.attacks = 0;
	n.safetyTriggered = false;
	n.lastPlayerHealth = nil;
	n.safeAttackPosition = nil;
	n._wasFarming = z;
	n:StartStableCamera();
	v(5);
	task.wait(.55);
	local j = D();
	n.lastPlayerHealth = j and j.Health or nil;
	return true;
end;
function K.RestoreBattle(x)
	local n = H.Character;
	local z = n and n:FindFirstChild("HumanoidRootPart");
	if n and (n == x.originalCharacter and (z and x.originalPivot)) then
		n:PivotTo(x.originalPivot);
		z.AssemblyLinearVelocity = Vector3.zero;
		z.AssemblyAngularVelocity = Vector3.zero;
		if x.originalRootAnchored ~= nil then
			z.Anchored = x.originalRootAnchored;
		end;
	end;
	if x.originalSize then
		v(x.originalSize);
	end;
	x:StopStableCamera();
	local u = H:FindFirstChild("Backpack");
	local h = n and n:FindFirstChild("Punch");
	if h and u then
		h.Parent = u;
	end;
	x.originalCharacter = nil;
	x.originalPivot = nil;
	x.originalSize = nil;
	x.originalRootAnchored = nil;
	x.engagedBoss = nil;
	x.lastPlayerHealth = nil;
	x.safeAttackPosition = nil;
	if x._wasFarming then
		r = true;
		x._wasFarming = nil;
	end;
end;
function K.CollectChest(n, x)
	if type(fireproximityprompt) ~= "function" then
		return false;
	end;
	local z = false;
	local h;
	local j = u:FindFirstChild("rEvents");
	local g = j and j:FindFirstChild("bossChestOpenedEvent");
	if g and g:IsA("RemoteEvent") then
		h = g.OnClientEvent:Connect(function()
				z = true;
			end);
	end;
	local function X(x)
		if h then
			h:Disconnect();
		end;
		return x;
	end;
	local A = os.clock() + ((tonumber(x) or 15));
	local l, t, S = false, false, 0;
	while n.active and os.clock() < A do
		if z then
			return X(true);
		end;
		local x, n;
		for z, u in ipairs(s:GetTagged("BossEventChest")) do
			n = u:FindFirstChild("bossChestPrompt", true);
			if n then
				x = u;
				break;
			end;
		end;
		if not n then
			local z = workspace:FindFirstChild("Events");
			n = z and z:FindFirstChild("bossChestPrompt", true);
			x = n and n:FindFirstAncestorOfClass("Model");
		end;
		local u = H:GetAttribute("BossChestEligible") == true;
		local h = H:GetAttribute("BossChestPending") == true;
		if h then
			l = true;
		elseif t and l then
			return X(true);
		end;
		local j = x and x:GetAttribute("BossChestEmerging") == true;
		if n and (n:IsA("ProximityPrompt") and (u and (h and not j))) then
			local x = R();
			local z = P();
			local u = n.Parent;
			if x and (z and (u and u:IsA("BasePart"))) then
				x:PivotTo(u.CFrame * CFrame.new(0, math.max(4, u.Size.Y * .5 + 3), 0));
				z.AssemblyLinearVelocity = Vector3.zero;
				z.AssemblyAngularVelocity = Vector3.zero;
				task.wait(.12);
			end;
			if n.Enabled and os.clock() - S >= .45 then
				S = os.clock();
				t = pcall(fireproximityprompt, n) or t;
			end;
		end;
		task.wait(.1);
	end;
	return X(z or (t and (l and H:GetAttribute("BossChestPending") ~= true)));
end;
function K.Fight(n, x)
	if not n:BeginBattle(x) then
		return;
	end;
	local z = T();
	local u = 0;
	while n.active and (x.Parent and workspace:GetAttribute("BossActive") == true) do
		local h, j, g = I();
		if h ~= x or not j or not g then
			break;
		end;
		local X = R();
		local s = P();
		local H = D();
		local A = Z();
		if not X or not s or not H or H.Health <= 0 or not A then
			n.status = "Esperando personaje";
			n:UpdateUi();
			task.wait(.25);
		else
			if n.lastPlayerHealth and H.Health < n.lastPlayerHealth then
				n.safetyTriggered = true;
				n.active = false;
				n.status = "Proteccion activada (te golpearon)";
				n:SetAntiLag(false);
				n:UpdateUi();
				break;
			end;
			n.lastPlayerHealth = H.Health;
			local x = g.Position.Y + g.Size.Y * .5;
			local h = math.max(6, s.Size.Y * .5 + 4);
			local l = Vector3.new(j.Position.X, x + h, j.Position.Z);
			if not n.safeAttackPosition or ((l - n.safeAttackPosition)).Magnitude > 45 then
				n.safeAttackPosition = l;
			else
				n.safeAttackPosition = n.safeAttackPosition:Lerp(l, .16);
			end;
			local t = n.safeAttackPosition;
			local S = g.Position + Vector3.new(0, g.Size.Y * .32, 0);
			n.cameraFocusPosition = n.cameraFocusPosition and n.cameraFocusPosition:Lerp(S, .08) or S;
			X:PivotTo(CFrame.lookAt(t, S));
			s.AssemblyLinearVelocity = Vector3.zero;
			s.AssemblyAngularVelocity = Vector3.zero;
			local q = os.clock();
			if q - u >= n.hitInterval then
				u = q;
				pcall(A.Deactivate, A);
				pcall(A.Activate, A);
				n.attacks = n.attacks + (1);
			end;
			local W = T();
			if W < z then
				n.confirmedDamage = n.confirmedDamage + ((z - W));
			end;
			z = W;
			n.status = ((workspace:GetAttribute("BossDisplayName") or "Boss")) .. ("  dano " .. Y(n.confirmedDamage));
			n:UpdateUi();
			task.wait(.04);
		end;
	end;
	local h = workspace:GetAttribute("BossActive") ~= true or T() <= 0;
	if h and n.active then
		n.status = "Boss derrotado  reclamando recompensa";
		n:UpdateUi();
		n:CollectChest(12);
	end;
	n:RestoreBattle();
end;
function K.Set(n, x)
	x = x == true;
	n.generation = n.generation + (1);
	local z = n.generation;
	n.active = x;
	if not x then
		n.status = "Sin boss activo";
		n:RestoreBattle();
		n:SetAntiLag(false);
		n:UpdateUi();
		return true;
	end;
	local h = u:FindFirstChild("shared");
	h = h and h:FindFirstChild("config");
	h = h and h:FindFirstChild("BossEventConfig");
	local j, g = pcall(function()
			return h and require(h);
		end);
	if not j or type(g) ~= "table" or g.ENABLED ~= true then
		n.active = false;
		n.status = "El evento del boss no esta disponible";
		n:SetAntiLag(false);
		n:UpdateUi();
		return false;
	end;
	n:SetAntiLag(true);
	n.hitInterval = math.max(.31, ((tonumber(g.MIN_HIT_INTERVAL) or .3)) + .01);
	task.spawn(function()
		while n.active and n.generation == z do
			local x = I();
			if x and workspace:GetAttribute("BossActive") == true then
				n:Fight(x);
			else
				n.engagedBoss = nil;
				n.status = "Sin boss activo";
				n:UpdateUi();
				task.wait(.4);
			end;
		end;
		if n.generation == z then
			n:RestoreBattle();
		end;
	end);
	n:UpdateUi();
	return true;
end;
function K.UpdateUi(x)
	if x.StatusLabel then
		x.StatusLabel.Text = x.status;
		x.StatusLabel.TextColor3 = x.engagedBoss and Color3.fromRGB(100, 255, 140) or Color3.fromRGB(160, 160, 180);
	end;
	if x.HealthLabel then
		local n = T();
		local z = math.max(n, tonumber(workspace:GetAttribute("BossMaxHealth")) or 0);
		if z > 0 and workspace:GetAttribute("BossActive") == true then
			x.HealthLabel.Text = Y(n) .. (" / " .. Y(z));
		else
			x.HealthLabel.Text = "-";
		end;
	end;
end;
local G = Instance.new("ScreenGui");
G.Name = "SLK_AuralGUI_Improved";
G.ResetOnSpawn = false;
G.IgnoreGuiInset = true;
G.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
G.Parent = A;
local U = Instance.new("Frame");
U.Name = "Main";
U.Size = UDim2.new(0, 360, 0, 270);
U.Position = UDim2.new(.5, -180, .5, -135);
U.BackgroundColor3 = Color3.fromRGB(18, 18, 22);
U.BorderSizePixel = 0;
U.Active = true;
U.Draggable = false;
U.Parent = G;
(Instance.new("UICorner", U)).CornerRadius = UDim.new(0, 12);
local x1 = Instance.new("UIStroke");
x1.Color = Color3.fromRGB(40, 40, 50);
x1.Thickness = 1;
x1.Parent = U;
local n1 = Instance.new("Frame");
n1.Name = "DragBar";
n1.Size = UDim2.new(1, -100, 0, 32);
n1.Position = UDim2.new(0, 100, 0, 0);
n1.BackgroundTransparency = 1;
n1.Active = true;
n1.Parent = U;
local z1 = Instance.new("TextLabel");
z1.Size = UDim2.new(1, -70, 1, 0);
z1.Position = UDim2.new(0, 12, 0, 0);
z1.BackgroundTransparency = 1;
z1.Text = "SLK";
z1.TextColor3 = Color3.fromRGB(150, 150, 170);
z1.Font = Enum.Font.GothamMedium;
z1.TextSize = 11;
z1.TextXAlignment = Enum.TextXAlignment.Left;
z1.Parent = n1;
local u1 = false;
local h1 = nil;
local j1 = nil;
n1.InputBegan:Connect(function(x)
	if x.UserInputType == Enum.UserInputType.MouseButton1 or x.UserInputType == Enum.UserInputType.Touch then
		u1 = true;
		h1 = x.Position;
		j1 = U.Position;
		x.Changed:Connect(function()
			if x.UserInputState == Enum.UserInputState.End then
				u1 = false;
			end;
		end);
	end;
end);
g.InputChanged:Connect(function(x)
	if not u1 then
		return;
	end;
	if x.UserInputType ~= Enum.UserInputType.MouseMovement and x.UserInputType ~= Enum.UserInputType.Touch then
		return;
	end;
	local n = x.Position - h1;
	U.Position = UDim2.new(j1.X.Scale, j1.X.Offset + n.X, j1.Y.Scale, j1.Y.Offset + n.Y);
end);
local g1 = Instance.new("Frame");
g1.Size = UDim2.new(0, 100, 1, 0);
g1.BackgroundColor3 = Color3.fromRGB(12, 12, 16);
g1.BorderSizePixel = 0;
g1.Parent = U;
(Instance.new("UICorner", g1)).CornerRadius = UDim.new(0, 12);
local X1 = Instance.new("Frame");
X1.Size = UDim2.new(1, 0, 0, 56);
X1.BackgroundTransparency = 1;
X1.Parent = g1;
local s1 = Instance.new("TextLabel");
s1.Size = UDim2.new(0, 20, 0, 20);
s1.Position = UDim2.new(0, 7, 0, 10);
s1.BackgroundColor3 = Color3.fromRGB(90, 60, 220);
s1.Text = "A";
s1.TextColor3 = Color3.fromRGB(255, 255, 255);
s1.Font = Enum.Font.GothamBold;
s1.TextSize = 12;
s1.Parent = X1;
(Instance.new("UICorner", s1)).CornerRadius = UDim.new(0, 6);
local H1 = Instance.new("TextLabel");
H1.Size = UDim2.new(1, -32, 0, 16);
H1.Position = UDim2.new(0, 31, 0, 8);
H1.BackgroundTransparency = 1;
H1.Text = "SLK Paid";
H1.TextColor3 = Color3.fromRGB(255, 255, 255);
H1.Font = Enum.Font.GothamBold;
H1.TextSize = 10;
H1.TextXAlignment = Enum.TextXAlignment.Left;
H1.Parent = X1;
local A1 = Instance.new("TextLabel");
A1.Size = UDim2.new(1, -32, 0, 12);
A1.Position = UDim2.new(0, 31, 0, 23);
A1.BackgroundTransparency = 1;
A1.Text = "Muscle Legends";
A1.TextColor3 = Color3.fromRGB(140, 140, 160);
A1.Font = Enum.Font.Gotham;
A1.TextSize = 8;
A1.TextXAlignment = Enum.TextXAlignment.Left;
A1.Parent = X1;
local l1 = Instance.new("Frame");
l1.Size = UDim2.new(1, -10, 1, -58);
l1.Position = UDim2.new(0, 5, 0, 56);
l1.BackgroundTransparency = 1;
l1.Parent = g1;
local t1 = Instance.new("UIListLayout");
t1.Padding = UDim.new(0, 4);
t1.Parent = l1;
local S1 = {};
local q1 = "Farming";
local function W1(x, n, z)
	local u = Instance.new("TextButton");
	u.Name = x;
	u.Size = UDim2.new(1, 0, 0, 29);
	u.BackgroundColor3 = Color3.fromRGB(12, 12, 16);
	u.BorderSizePixel = 0;
	u.Text = "";
	u.AutoButtonColor = false;
	u.LayoutOrder = z;
	u.Parent = l1;
	(Instance.new("UICorner", u)).CornerRadius = UDim.new(0, 8);
	local h = Instance.new("TextLabel");
	h.Size = UDim2.new(0, 20, 1, 0);
	h.Position = UDim2.new(0, 3, 0, 0);
	h.BackgroundTransparency = 1;
	h.Text = n;
	h.TextColor3 = Color3.fromRGB(160, 160, 180);
	h.Font = Enum.Font.GothamBold;
	h.TextSize = 10;
	h.Parent = u;
	local j = Instance.new("TextLabel");
	j.Size = UDim2.new(1, -27, 1, 0);
	j.Position = UDim2.new(0, 25, 0, 0);
	j.BackgroundTransparency = 1;
	j.Text = x;
	j.TextColor3 = Color3.fromRGB(180, 180, 200);
	j.Font = Enum.Font.GothamMedium;
	j.TextSize = 10;
	j.TextXAlignment = Enum.TextXAlignment.Left;
	j.Parent = u;
	local g = Instance.new("Frame");
	g.Name = "Indicator";
	g.Size = UDim2.new(0, 3, 0, 20);
	g.Position = UDim2.new(0, 0, .5, -10);
	g.BackgroundColor3 = Color3.fromRGB(120, 80, 255);
	g.BorderSizePixel = 0;
	g.Visible = false;
	g.Parent = u;
	(Instance.new("UICorner", g)).CornerRadius = UDim.new(0, 2);
	u.MouseButton1Click:Connect(function()
		for x, n in pairs(S1) do
			n.Visible = false;
		end;
		if S1[x] then
			S1[x].Visible = true;
		end;
		q1 = x;
		for x, n in ipairs(l1:GetChildren()) do
			if n:IsA("TextButton") then
				n.BackgroundColor3 = Color3.fromRGB(12, 12, 16);
				local x = n:FindFirstChild("Indicator");
				if x then
					x.Visible = false;
				end;
			end;
		end;
		u.BackgroundColor3 = Color3.fromRGB(28, 24, 45);
		g.Visible = true;
	end);
	return u;
end;
local d1 = W1("Farming", "F", 1);
local L1 = W1("Boss", "B", 2);
local f1 = W1("Info", "I", 3);
local p1 = W1("Settings", "S", 4);
d1.BackgroundColor3 = Color3.fromRGB(28, 24, 45);
(d1:FindFirstChild("Indicator")).Visible = true;
local r1 = Instance.new("Frame");
r1.Size = UDim2.new(1, -100, 1, 0);
r1.Position = UDim2.new(0, 100, 0, 0);
r1.BackgroundColor3 = Color3.fromRGB(18, 18, 22);
r1.BorderSizePixel = 0;
r1.Parent = U;
local Q1 = Instance.new("TextButton");
Q1.Size = UDim2.new(0, 28, 0, 28);
Q1.Position = UDim2.new(1, -36, 0, 10);
Q1.BackgroundColor3 = Color3.fromRGB(30, 30, 38);
Q1.Text = "X";
Q1.TextColor3 = Color3.fromRGB(180, 180, 200);
Q1.Font = Enum.Font.GothamBold;
Q1.TextSize = 14;
Q1.Parent = r1;
(Instance.new("UICorner", Q1)).CornerRadius = UDim.new(0, 6);
Q1.MouseButton1Click:Connect(function()
	K:Set(false);
	G:Destroy();
end);
local y1 = Instance.new("TextButton");
y1.Name = "SLKMini";
y1.Size = UDim2.new(0, 118, 0, 42);
y1.Position = UDim2.new(1, -132, 0, 18);
y1.BackgroundColor3 = Color3.fromRGB(22, 22, 30);
y1.BorderSizePixel = 0;
y1.Text = "SLK";
y1.TextColor3 = Color3.fromRGB(235, 235, 255);
y1.Font = Enum.Font.GothamBold;
y1.TextSize = 15;
y1.Visible = false;
y1.AutoButtonColor = false;
y1.Parent = G;
(Instance.new("UICorner", y1)).CornerRadius = UDim.new(0, 12);
local w1 = Instance.new("UIStroke");
w1.Color = Color3.fromRGB(95, 70, 190);
w1.Thickness = 1.5;
w1.Parent = y1;
local c1 = Instance.new("TextButton");
c1.Name = "Minimize";
c1.Size = UDim2.new(0, 28, 0, 28);
c1.Position = UDim2.new(1, -70, 0, 10);
c1.BackgroundColor3 = Color3.fromRGB(30, 30, 38);
c1.Text = "-";
c1.TextColor3 = Color3.fromRGB(210, 210, 225);
c1.Font = Enum.Font.GothamBold;
c1.TextSize = 16;
c1.Parent = r1;
(Instance.new("UICorner", c1)).CornerRadius = UDim.new(0, 6);
c1.MouseButton1Click:Connect(function()
	U.Visible = false;
	y1.Visible = true;
end);
y1.MouseButton1Click:Connect(function()
	y1.Visible = false;
	U.Visible = true;
end);
local function b1(x, n, z, u, h, g)
	local X = Instance.new("Frame");
	X.Size = UDim2.new(1, -10, 0, 52);
	X.Position = UDim2.new(0, 0, 0, n);
	X.BackgroundColor3 = Color3.fromRGB(24, 24, 30);
	X.BorderSizePixel = 0;
	X.Parent = x;
	(Instance.new("UICorner", X)).CornerRadius = UDim.new(0, 8);
	local s = Instance.new("TextLabel");
	s.Size = UDim2.new(1, -70, 0, 20);
	s.Position = UDim2.new(0, 14, 0, 8);
	s.BackgroundTransparency = 1;
	s.Text = z;
	s.TextColor3 = Color3.fromRGB(240, 240, 250);
	s.Font = Enum.Font.GothamMedium;
	s.TextSize = 13;
	s.TextXAlignment = Enum.TextXAlignment.Left;
	s.Parent = X;
	local H = Instance.new("TextLabel");
	H.Size = UDim2.new(1, -70, 0, 16);
	H.Position = UDim2.new(0, 14, 0, 28);
	H.BackgroundTransparency = 1;
	H.Text = u;
	H.TextColor3 = Color3.fromRGB(130, 130, 150);
	H.Font = Enum.Font.Gotham;
	H.TextSize = 11;
	H.TextXAlignment = Enum.TextXAlignment.Left;
	H.Parent = X;
	local A = Instance.new("Frame");
	A.Size = UDim2.new(0, 42, 0, 24);
	A.Position = UDim2.new(1, -56, .5, -12);
	A.BackgroundColor3 = h and Color3.fromRGB(100, 70, 220) or Color3.fromRGB(50, 50, 60);
	A.BorderSizePixel = 0;
	A.Parent = X;
	(Instance.new("UICorner", A)).CornerRadius = UDim.new(1, 0);
	local l = Instance.new("Frame");
	l.Size = UDim2.new(0, 18, 0, 18);
	l.Position = h and UDim2.new(1, -21, .5, -9) or UDim2.new(0, 3, .5, -9);
	l.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	l.BorderSizePixel = 0;
	l.Parent = A;
	(Instance.new("UICorner", l)).CornerRadius = UDim.new(1, 0);
	local t = h;
	local S = Instance.new("TextButton");
	S.Size = UDim2.new(1, 0, 1, 0);
	S.BackgroundTransparency = 1;
	S.Text = "";
	S.Parent = X;
	S.MouseButton1Click:Connect(function()
		t = not t;
		local x = TweenInfo.new(.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
		if t then
			(j:Create(A, x, { BackgroundColor3 = Color3.fromRGB(100, 70, 220) })):Play();
			(j:Create(l, x, { Position = UDim2.new(1, -21, .5, -9) })):Play();
		else
			(j:Create(A, x, { BackgroundColor3 = Color3.fromRGB(50, 50, 60) })):Play();
			(j:Create(l, x, { Position = UDim2.new(0, 3, .5, -9) })):Play();
		end;
		if g then
			g(t);
		end;
	end);
	return X;
end;
local function m1(x, n, z)
	local u = Instance.new("TextLabel");
	u.Size = UDim2.new(1, 0, 0, 20);
	u.Position = UDim2.new(0, 0, 0, n);
	u.BackgroundTransparency = 1;
	u.Text = z;
	u.TextColor3 = Color3.fromRGB(120, 100, 200);
	u.Font = Enum.Font.GothamBold;
	u.TextSize = 11;
	u.TextXAlignment = Enum.TextXAlignment.Left;
	u.Parent = x;
	return u;
end;
local k1 = Instance.new("ScrollingFrame");
k1.Name = "Farming";
k1.Size = UDim2.new(1, -20, 1, -50);
k1.Position = UDim2.new(0, 10, 0, 45);
k1.BackgroundTransparency = 1;
k1.BorderSizePixel = 0;
k1.ScrollBarThickness = 4;
k1.ScrollingEnabled = true;
k1.Active = true;
k1.ScrollBarImageColor3 = Color3.fromRGB(80, 60, 160);
k1.CanvasSize = UDim2.new(0, 0, 0, 350);
k1.Parent = r1;
S1.Farming = k1;
local B1 = Instance.new("TextLabel");
B1.Size = UDim2.new(1, 0, 0, 28);
B1.BackgroundTransparency = 1;
B1.Text = "Farming";
B1.TextColor3 = Color3.fromRGB(255, 255, 255);
B1.Font = Enum.Font.GothamBold;
B1.TextSize = 20;
B1.TextXAlignment = Enum.TextXAlignment.Left;
B1.Parent = k1;
local J1 = Instance.new("TextLabel");
J1.Size = UDim2.new(1, 0, 0, 18);
J1.Position = UDim2.new(0, 0, 0, 26);
J1.BackgroundTransparency = 1;
J1.Text = "Strength, rebirth, boosts";
J1.TextColor3 = Color3.fromRGB(140, 140, 160);
J1.Font = Enum.Font.Gotham;
J1.TextSize = 12;
J1.TextXAlignment = Enum.TextXAlignment.Left;
J1.Parent = k1;
local R1 = Instance.new("Frame");
R1.Size = UDim2.new(1, -10, 0, 64);
R1.Position = UDim2.new(0, 0, 0, 55);
R1.BackgroundColor3 = Color3.fromRGB(24, 24, 30);
R1.BorderSizePixel = 0;
R1.Parent = k1;
(Instance.new("UICorner", R1)).CornerRadius = UDim.new(0, 8);
local D1 = Instance.new("TextLabel");
D1.Size = UDim2.new(1, -110, 0, 22);
D1.Position = UDim2.new(0, 14, 0, 8);
D1.BackgroundTransparency = 1;
D1.Text = "OP Farm";
D1.TextColor3 = Color3.fromRGB(240, 240, 250);
D1.Font = Enum.Font.GothamBold;
D1.TextSize = 14;
D1.TextXAlignment = Enum.TextXAlignment.Left;
D1.Parent = R1;
local P1 = Instance.new("TextLabel");
P1.Size = UDim2.new(1, -110, 0, 18);
P1.Position = UDim2.new(0, 14, 0, 32);
P1.BackgroundTransparency = 1;
P1.Text = "Target:  OP |FARM";
P1.TextColor3 = Color3.fromRGB(135, 135, 155);
P1.Font = Enum.Font.Gotham;
P1.TextSize = 11;
P1.TextXAlignment = Enum.TextXAlignment.Left;
P1.Parent = R1;
local Y1 = Instance.new("TextButton");
Y1.Size = UDim2.new(0, 78, 0, 32);
Y1.Position = UDim2.new(1, -90, .5, -16);
Y1.BackgroundColor3 = Color3.fromRGB(45, 45, 55);
Y1.Text = "OFF";
Y1.TextColor3 = Color3.fromRGB(190, 190, 205);
Y1.Font = Enum.Font.GothamBold;
Y1.TextSize = 12;
Y1.Parent = R1;
(Instance.new("UICorner", Y1)).CornerRadius = UDim.new(0, 8);
local function N1(x)
	if x then
		Y1.Text = "ON";
		Y1.BackgroundColor3 = Color3.fromRGB(100, 70, 220);
		Y1.TextColor3 = Color3.fromRGB(255, 255, 255);
	else
		Y1.Text = "OFF";
		Y1.BackgroundColor3 = Color3.fromRGB(45, 45, 55);
		Y1.TextColor3 = Color3.fromRGB(190, 190, 205);
	end;
end;
Y1.MouseButton1Click:Connect(function()
	r = not r;
	N1(r);
end);
m1(k1, 135, "REBIRTH");
b1(k1, 158, "Auto Rebirth", "Rebirth when strength reaches threshold", false, function(x)
	Q = x;
end);
m1(k1, 205, "FAST REBIRTH");
b1(k1, 228, "Fast Rebirth", "Speed -> Farm -> Packs -> Rebirth -> Golems", false, function(x)
	y = x;
	c = c + (1);
	if x then
		r = true;
		N1(true);
	else
		w = "Idle";
	end;
end);
local M1 = Instance.new("TextLabel");
M1.Size = UDim2.new(1, -10, 0, 34);
M1.Position = UDim2.new(0, 0, 0, 291);
M1.BackgroundColor3 = Color3.fromRGB(24, 24, 30);
M1.BorderSizePixel = 0;
M1.Text = "Fast Rebirth: Idle";
M1.TextColor3 = Color3.fromRGB(150, 150, 175);
M1.Font = Enum.Font.GothamMedium;
M1.TextSize = 12;
M1.TextXAlignment = Enum.TextXAlignment.Left;
M1.Parent = k1;
(Instance.new("UICorner", M1)).CornerRadius = UDim.new(0, 8);
local O1 = Instance.new("UIPadding", M1);
O1.PaddingLeft = UDim.new(0, 12);
m1(k1, 340, "SESSION STATS");
local V1 = Instance.new("Frame");
V1.Size = UDim2.new(1, -10, 0, 90);
V1.Position = UDim2.new(0, 0, 0, 363);
V1.BackgroundColor3 = Color3.fromRGB(24, 24, 30);
V1.BorderSizePixel = 0;
V1.Parent = k1;
(Instance.new("UICorner", V1)).CornerRadius = UDim.new(0, 8);
local i1 = Instance.new("TextLabel");
i1.Size = UDim2.new(1, -20, 0, 22);
i1.Position = UDim2.new(0, 14, 0, 12);
i1.BackgroundTransparency = 1;
i1.Text = "Session Rebirths: 0";
i1.TextColor3 = Color3.fromRGB(160, 255, 160);
i1.Font = Enum.Font.GothamMedium;
i1.TextSize = 13;
i1.TextXAlignment = Enum.TextXAlignment.Left;
i1.Parent = V1;
local C1 = Instance.new("TextLabel");
C1.Size = UDim2.new(1, -20, 0, 20);
C1.Position = UDim2.new(0, 14, 0, 36);
C1.BackgroundTransparency = 1;
C1.Text = "Time: 0h 0m";
C1.TextColor3 = Color3.fromRGB(180, 180, 210);
C1.Font = Enum.Font.Gotham;
C1.TextSize = 12;
C1.TextXAlignment = Enum.TextXAlignment.Left;
C1.Parent = V1;
local a1 = Instance.new("TextLabel");
a1.Size = UDim2.new(1, -20, 0, 20);
a1.Position = UDim2.new(0, 14, 0, 58);
a1.BackgroundTransparency = 1;
a1.Text = "Rate: 0 /h";
a1.TextColor3 = Color3.fromRGB(140, 190, 255);
a1.Font = Enum.Font.Gotham;
a1.TextSize = 12;
a1.TextXAlignment = Enum.TextXAlignment.Left;
a1.Parent = V1;
local o1 = Instance.new("ScrollingFrame");
o1.Name = "Boss";
o1.Size = UDim2.new(1, -20, 1, -50);
o1.Position = UDim2.new(0, 10, 0, 45);
o1.BackgroundTransparency = 1;
o1.BorderSizePixel = 0;
o1.ScrollBarThickness = 4;
o1.ScrollingEnabled = true;
o1.Active = true;
o1.ScrollBarImageColor3 = Color3.fromRGB(80, 60, 160);
o1.CanvasSize = UDim2.new(0, 0, 0, 380);
o1.Visible = false;
o1.Parent = r1;
S1.Boss = o1;
local F1 = Instance.new("TextLabel");
F1.Size = UDim2.new(1, 0, 0, 28);
F1.BackgroundTransparency = 1;
F1.Text = "Boss";
F1.TextColor3 = Color3.fromRGB(255, 255, 255);
F1.Font = Enum.Font.GothamBold;
F1.TextSize = 20;
F1.TextXAlignment = Enum.TextXAlignment.Left;
F1.Parent = o1;
local e1 = Instance.new("TextLabel");
e1.Size = UDim2.new(1, 0, 0, 18);
e1.Position = UDim2.new(0, 0, 0, 26);
e1.BackgroundTransparency = 1;
e1.Text = "Auto Boss Event";
e1.TextColor3 = Color3.fromRGB(140, 140, 160);
e1.Font = Enum.Font.Gotham;
e1.TextSize = 12;
e1.TextXAlignment = Enum.TextXAlignment.Left;
e1.Parent = o1;
m1(o1, 55, "AUTO BOSS");
local K1 = Instance.new("Frame");
K1.Size = UDim2.new(1, -10, 0, 42);
K1.Position = UDim2.new(0, 0, 0, 78);
K1.BackgroundColor3 = Color3.fromRGB(24, 24, 30);
K1.BorderSizePixel = 0;
K1.Parent = o1;
(Instance.new("UICorner", K1)).CornerRadius = UDim.new(0, 8);
local I1 = Instance.new("TextLabel");
I1.Size = UDim2.new(0, 70, 1, 0);
I1.Position = UDim2.new(0, 14, 0, 0);
I1.BackgroundTransparency = 1;
I1.Text = "Status:";
I1.TextColor3 = Color3.fromRGB(160, 160, 180);
I1.Font = Enum.Font.Gotham;
I1.TextSize = 12;
I1.TextXAlignment = Enum.TextXAlignment.Left;
I1.Parent = K1;
K.StatusLabel = Instance.new("TextLabel");
K.StatusLabel.Size = UDim2.new(1, -90, 1, 0);
K.StatusLabel.Position = UDim2.new(0, 80, 0, 0);
K.StatusLabel.BackgroundTransparency = 1;
K.StatusLabel.Text = "Sin boss activo";
K.StatusLabel.TextColor3 = Color3.fromRGB(160, 160, 180);
K.StatusLabel.Font = Enum.Font.GothamMedium;
K.StatusLabel.TextSize = 13;
K.StatusLabel.TextXAlignment = Enum.TextXAlignment.Left;
K.StatusLabel.Parent = K1;
local T1 = Instance.new("Frame");
T1.Size = UDim2.new(1, -10, 0, 42);
T1.Position = UDim2.new(0, 0, 0, 128);
T1.BackgroundColor3 = Color3.fromRGB(24, 24, 30);
T1.BorderSizePixel = 0;
T1.Parent = o1;
(Instance.new("UICorner", T1)).CornerRadius = UDim.new(0, 8);
local v1 = Instance.new("TextLabel");
v1.Size = UDim2.new(0, 100, 1, 0);
v1.Position = UDim2.new(0, 14, 0, 0);
v1.BackgroundTransparency = 1;
v1.Text = "Boss Health:";
v1.TextColor3 = Color3.fromRGB(160, 160, 180);
v1.Font = Enum.Font.Gotham;
v1.TextSize = 12;
v1.TextXAlignment = Enum.TextXAlignment.Left;
v1.Parent = T1;
K.HealthLabel = Instance.new("TextLabel");
K.HealthLabel.Size = UDim2.new(1, -120, 1, 0);
K.HealthLabel.Position = UDim2.new(0, 110, 0, 0);
K.HealthLabel.BackgroundTransparency = 1;
K.HealthLabel.Text = "-";
K.HealthLabel.TextColor3 = Color3.fromRGB(100, 200, 255);
K.HealthLabel.Font = Enum.Font.GothamMedium;
K.HealthLabel.TextSize = 13;
K.HealthLabel.TextXAlignment = Enum.TextXAlignment.Left;
K.HealthLabel.Parent = T1;
b1(o1, 185, "Attack Boss", "Auto farm for Boss event (pauses OP Farm)", false, function(x)
	local n = K:Set(x);
	if n == false then
 
	end;
end);
m1(o1, 255, "INFO");
local E1 = Instance.new("TextLabel");
E1.Size = UDim2.new(1, -10, 0, 80);
E1.Position = UDim2.new(0, 0, 0, 278);
E1.BackgroundColor3 = Color3.fromRGB(24, 24, 30);
E1.BorderSizePixel = 0;
E1.Text = " Detecta automatically cuando aparece el Boss\n Cambia tamano a 5, ataca desde arriba\n Anti-lag + stable camera\n Reclama el cofre al derrotarlo\n Se apaga si te hacen dano (proteccion)";
E1.TextColor3 = Color3.fromRGB(150, 150, 170);
E1.Font = Enum.Font.Gotham;
E1.TextSize = 12;
E1.TextXAlignment = Enum.TextXAlignment.Left;
E1.TextYAlignment = Enum.TextYAlignment.Top;
E1.Parent = o1;
(Instance.new("UICorner", E1)).CornerRadius = UDim.new(0, 8);
(Instance.new("UIPadding", E1)).PaddingTop = UDim.new(0, 10);
(Instance.new("UIPadding", E1)).PaddingLeft = UDim.new(0, 12);
local Z1 = Instance.new("ScrollingFrame");
Z1.Name = "Info";
Z1.Size = UDim2.new(1, -20, 1, -50);
Z1.Position = UDim2.new(0, 10, 0, 45);
Z1.BackgroundTransparency = 1;
Z1.BorderSizePixel = 0;
Z1.ScrollBarThickness = 4;
Z1.ScrollingEnabled = true;
Z1.Active = true;
Z1.ScrollBarImageColor3 = Color3.fromRGB(80, 60, 160);
Z1.CanvasSize = UDim2.new(0, 0, 0, 360);
Z1.Visible = false;
Z1.Parent = r1;
S1.Info = Z1;
local G1 = Instance.new("TextLabel");
G1.Size = UDim2.new(1, 0, 0, 28);
G1.BackgroundTransparency = 1;
G1.Text = "Info";
G1.TextColor3 = Color3.fromRGB(255, 255, 255);
G1.Font = Enum.Font.GothamBold;
G1.TextSize = 20;
G1.TextXAlignment = Enum.TextXAlignment.Left;
G1.Parent = Z1;
local U1 = Instance.new("TextLabel");
U1.Size = UDim2.new(1, 0, 0, 18);
U1.Position = UDim2.new(0, 0, 0, 28);
U1.BackgroundTransparency = 1;
U1.Text = "Session performance and farming rates";
U1.TextColor3 = Color3.fromRGB(140, 140, 160);
U1.Font = Enum.Font.Gotham;
U1.TextSize = 12;
U1.TextXAlignment = Enum.TextXAlignment.Left;
U1.Parent = Z1;
m1(Z1, 58, "RATES PER HOUR");
local x_ = Instance.new("Frame");
x_.Size = UDim2.new(1, -10, 0, 150);
x_.Position = UDim2.new(0, 0, 0, 84);
x_.BackgroundColor3 = Color3.fromRGB(24, 24, 30);
x_.BorderSizePixel = 0;
x_.Parent = Z1;
(Instance.new("UICorner", x_)).CornerRadius = UDim.new(0, 8);
local n_ = Instance.new("TextLabel");
n_.Size = UDim2.new(1, -28, 0, 32);
n_.Position = UDim2.new(0, 14, 0, 12);
n_.BackgroundTransparency = 1;
n_.Text = "Strength per hour: 0";
n_.TextColor3 = Color3.fromRGB(150, 210, 255);
n_.Font = Enum.Font.GothamMedium;
n_.TextSize = 14;
n_.TextXAlignment = Enum.TextXAlignment.Left;
n_.Parent = x_;
local z_ = Instance.new("TextLabel");
z_.Size = UDim2.new(1, -28, 0, 32);
z_.Position = UDim2.new(0, 14, 0, 52);
z_.BackgroundTransparency = 1;
z_.Text = "Rebirths per hour: 0";
z_.TextColor3 = Color3.fromRGB(160, 255, 160);
z_.Font = Enum.Font.GothamMedium;
z_.TextSize = 14;
z_.TextXAlignment = Enum.TextXAlignment.Left;
z_.Parent = x_;
local u_ = Instance.new("TextLabel");
u_.Size = UDim2.new(1, -28, 0, 32);
u_.Position = UDim2.new(0, 14, 0, 92);
u_.BackgroundTransparency = 1;
u_.Text = "Session time: 0m";
u_.TextColor3 = Color3.fromRGB(180, 180, 210);
u_.Font = Enum.Font.Gotham;
u_.TextSize = 12;
u_.TextXAlignment = Enum.TextXAlignment.Left;
u_.Parent = x_;
local function h_()
	local x = math.max(0, tick() - b);
	local n = math.floor(x / 3600);
	local z = math.floor(((x % 3600)) / 60);
	local u = x > 0 and math.floor(((B / x)) * 3600) or 0;
	local h = x > 0 and math.floor(((m / x)) * 3600) or 0;
	if n_ then
		n_.Text = "Strength per hour: " .. Y(u);
	end;
	if z_ then
		z_.Text = "Rebirths per hour: " .. h;
	end;
	if u_ then
		u_.Text = string.format("Session time: %dh %dm", n, z);
	end;
	if i1 then
		i1.Text = "Session Rebirths: " .. m;
	end;
	if C1 then
		C1.Text = string.format("Time: %dh %dm", n, z);
	end;
	if a1 then
		a1.Text = "Rate: " .. (h .. " /h");
	end;
	if M1 then
		M1.Text = "Fast Rebirth: " .. w;
	end;
end;
task.spawn(function()
	while G and G.Parent do
		h_();
		task.wait(1);
	end;
end);
local j_ = Instance.new("TextLabel");
j_.Size = UDim2.new(1, -10, 0, 70);
j_.Position = UDim2.new(0, 0, 0, 250);
j_.BackgroundColor3 = Color3.fromRGB(24, 24, 30);
j_.BorderSizePixel = 0;
j_.Text = "Rates are calculated from this session.\nStrength counts cumulative gains, including strength earned before rebirth.\nShort sessions may show 0 until enough data is collected.";
j_.TextColor3 = Color3.fromRGB(150, 150, 170);
j_.Font = Enum.Font.Gotham;
j_.TextSize = 11;
j_.TextXAlignment = Enum.TextXAlignment.Left;
j_.TextYAlignment = Enum.TextYAlignment.Center;
j_.Parent = Z1;
(Instance.new("UICorner", j_)).CornerRadius = UDim.new(0, 8);
local g_ = Instance.new("UIPadding", j_);
g_.PaddingLeft = UDim.new(0, 12);
local X_ = Instance.new("ScrollingFrame");
X_.Name = "Settings";
X_.Size = UDim2.new(1, -20, 1, -50);
X_.Position = UDim2.new(0, 10, 0, 45);
X_.BackgroundTransparency = 1;
X_.BorderSizePixel = 0;
X_.ScrollBarThickness = 4;
X_.ScrollingEnabled = true;
X_.Active = true;
X_.CanvasSize = UDim2.new(0, 0, 0, 390);
X_.Visible = false;
X_.Parent = r1;
S1.Settings = X_;
local s_ = Instance.new("TextLabel");
s_.Size = UDim2.new(1, 0, 0, 28);
s_.BackgroundTransparency = 1;
s_.Text = "Settings";
s_.TextColor3 = Color3.fromRGB(255, 255, 255);
s_.Font = Enum.Font.GothamBold;
s_.TextSize = 20;
s_.TextXAlignment = Enum.TextXAlignment.Left;
s_.Parent = X_;
local H_ = Instance.new("TextLabel");
H_.Size = UDim2.new(1, 0, 0, 18);
H_.Position = UDim2.new(0, 0, 0, 28);
H_.BackgroundTransparency = 1;
H_.Text = "Performance, UI and stability";
H_.TextColor3 = Color3.fromRGB(140, 140, 160);
H_.Font = Enum.Font.Gotham;
H_.TextSize = 12;
H_.TextXAlignment = Enum.TextXAlignment.Left;
H_.Parent = X_;
local A_ = setmetatable({}, { __mode = "k" });
local l_ = false;
local function t_(x)
	l_ = x == true;
	for n, z in ipairs(workspace:GetDescendants()) do
		if z:IsA("ParticleEmitter") or z:IsA("Trail") or z:IsA("Beam") or z:IsA("Fire") or z:IsA("Smoke") or z:IsA("Sparkles") or z:IsA("PointLight") or z:IsA("SpotLight") or z:IsA("SurfaceLight") or z:IsA("Highlight") then
			if A_[z] == nil then
				A_[z] = z.Enabled;
			end;
			pcall(function()
				z.Enabled = not x;
			end);
		elseif z:IsA("BasePart") then
			if A_[z] == nil then
				A_[z] = z.CastShadow;
			end;
			pcall(function()
				z.CastShadow = not x;
			end);
		end;
	end;
	if not x then
		for x, n in pairs(A_) do
			if x and x.Parent then
				pcall(function()
					x.Enabled = n;
				end);
				pcall(function()
					x.CastShadow = n;
				end);
			end;
			A_[x] = nil;
		end;
	end;
end;
m1(X_, 58, "PERFORMANCE");
b1(X_, 82, "Performance Mode", "Reduce particulas, luces, highlights y sombras", false, t_);
b1(X_, 145, "Stable UI", "Reduce animaciones visuales para bajar trabajo del cliente", true, function(x)
	_G.ARGZxStableUI = x;
end);
m1(X_, 210, "FARM STABILITY");
local S_ = Instance.new("TextLabel");
S_.Size = UDim2.new(1, -10, 0, 70);
S_.Position = UDim2.new(0, 0, 0, 234);
S_.BackgroundColor3 = Color3.fromRGB(24, 24, 30);
S_.BorderSizePixel = 0;
S_.Text = "OP Farm target: 800 reps/s\nThe client sends in controlled batches; server limits may still apply.\nFast Rebirth order: Speed -> Farm -> Packs -> Rebirth -> Golems";
S_.TextColor3 = Color3.fromRGB(155, 155, 175);
S_.Font = Enum.Font.Gotham;
S_.TextSize = 12;
S_.TextXAlignment = Enum.TextXAlignment.Left;
S_.TextYAlignment = Enum.TextYAlignment.Center;
S_.Parent = X_;
(Instance.new("UICorner", S_)).CornerRadius = UDim.new(0, 8);
local q_ = Instance.new("UIPadding", S_);
q_.PaddingLeft = UDim.new(0, 12);
local function W_(x, n)
	local z = x:FindFirstChildOfClass("UIListLayout");
	if z then
		local function u()
			x.CanvasSize = UDim2.new(0, 0, 0, z.AbsoluteContentSize.Y + ((n or 16)));
		end;
		(z:GetPropertyChangedSignal("AbsoluteContentSize")):Connect(u);
		u();
	end;
end;
W_(k1, 24);
W_(o1, 24);
W_(Z1, 24);
W_(X_, 24);
g.InputBegan:Connect(function(x, n)
	if n then
		return;
	end;
	if x.KeyCode == Enum.KeyCode.RightControl then
		if U.Visible then
			U.Visible = false;
			y1.Visible = true;
		else
			y1.Visible = false;
			U.Visible = true;
		end;
	end;
end);
K:UpdateUi();
print("ARGZx GUI + Auto Boss loaded");
