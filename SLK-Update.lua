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

local s = "SLK";
local h = "https://raw.githubusercontent.com/AngelOficialBe/ARGZx-Official-script/refs/heads/main/ARGZx-Update.lua";
local P = game:GetService("Players");
local I = game:GetService("ReplicatedStorage");
local T = game:GetService("VirtualUser");
local V = game:GetService("TweenService");
local k = game:GetService("UserInputService");
local v = game:GetService("RunService");
local O = game:GetService("CollectionService");
local p = P.LocalPlayer;
local D = p:WaitForChild("PlayerGui");
local G = Instance.new("ScreenGui");
G.Name = "SLKSystem";
G.ResetOnSpawn = false;
G.IgnoreGuiInset = true;
G.Parent = D;
local F = Instance.new("Frame");
F.Size = UDim2.new(0, 300, 0, 180);
F.Position = UDim2.new(.5, -150, .5, -90);
F.BackgroundColor3 = Color3.fromRGB(10, 10, 15);
F.BorderSizePixel = 0;
F.Parent = G;
(Instance.new("UICorner", F)).CornerRadius = UDim.new(0, 12);
local A = Instance.new("UIStroke");
A.Color = Color3.fromRGB(180, 0, 0);
A.Thickness = 2;
A.Parent = F;
local q = Instance.new("TextLabel");
q.Size = UDim2.new(1, 0, 0, 40);
q.BackgroundTransparency = 1;
q.Text = "SLK Key System";
q.TextColor3 = Color3.fromRGB(255, 80, 80);
q.Font = Enum.Font.GothamBold;
q.TextSize = 18;
q.Parent = F;
local E = Instance.new("TextBox");
E.Size = UDim2.new(.85, 0, 0, 40);
E.Position = UDim2.new(.075, 0, 0, 60);
E.BackgroundColor3 = Color3.fromRGB(20, 20, 25);
E.Text = "";
E.PlaceholderText = "Enter Key here...";
E.TextColor3 = Color3.fromRGB(255, 255, 255);
E.Font = Enum.Font.Gotham;
E.TextSize = 14;
E.Parent = F;
(Instance.new("UICorner", E)).CornerRadius = UDim.new(0, 8);
local U = Instance.new("TextButton");
U.Size = UDim2.new(.85, 0, 0, 40);
U.Position = UDim2.new(.075, 0, 0, 115);
U.BackgroundColor3 = Color3.fromRGB(180, 30, 30);
U.Text = "Verify Key";
U.TextColor3 = Color3.fromRGB(255, 255, 255);
U.Font = Enum.Font.GothamBold;
U.TextSize = 14;
U.Parent = F;
(Instance.new("UICorner", U)).CornerRadius = UDim.new(0, 8);
local B = false;
U.MouseButton1Click:Connect(function()
	if E.Text == s then
		U.Text = "Key Accepted!";
		U.BackgroundColor3 = Color3.fromRGB(0, 180, 0);
		task.wait(1);
		G:Destroy();
		B = true;
	else
		U.Text = "Invalid Key";
		U.BackgroundColor3 = Color3.fromRGB(180, 0, 0);
		task.wait(1);
		U.Text = "Verify Key";
		U.BackgroundColor3 = Color3.fromRGB(180, 30, 30);
	end;
end);
repeat
	task.wait(.2);
until B;
task.spawn(function()
	while task.wait(10) do
		local P, I = pcall(function()
				return game:HttpGet(h);
			end);
		if P and type(I) == "string" then
			local h = string.match(I, "local%s+ValidKey%s*=%s*\"([^\"]+)\"") or string.match(I, "local%s+ValidKey%s*=%s*\'([^\']+)\'");
			if h and h ~= s then
				pcall(function()
					if G and G.Parent then
						G:Destroy();
					end;
					if gui and gui.Parent then
						gui:Destroy();
					end;
					FastFarm = false;
					AutoRebirth = false;
					FastRebirth = false;
				end);
				pcall(function()
					p:Kick("[SLK] La Key ha sido actualizada o tu acceso fue revocado.");
				end);
				break;
			end;
		end;
	end;
end);
p.Idled:Connect(function()
	T:CaptureController();
	T:ClickButton2(Vector2.new());
end);
repeat
	task.wait(.3);
until p:FindFirstChild("muscleEvent") and p:FindFirstChild("leaderstats");
local J = p.leaderstats.Strength;
local g = p.leaderstats.Rebirths;
local R = false;
local W = false;
local N = false;
local C = "Idle";
local t = 0;
local H = tick();
local m = 0;
local j = g.Value;
local S = 0;
local Q = tonumber(J.Value) or 0;
(J:GetPropertyChangedSignal("Value")):Connect(function()
	local s = tonumber(J.Value) or 0;
	if s >= Q then
		S = S + ((s - Q));
	else
		S = S + (Q);
	end;
	Q = s;
end);
local function c()
	return p.Character;
end;
local function e()
	local s = c();
	return s and s:FindFirstChildOfClass("Humanoid");
end;
local function Y()
	local s = c();
	return s and s:FindFirstChild("HumanoidRootPart");
end;
local function b(s)
	s = tonumber(s) or 0;
	if s >= 1000000000000 then
		return string.format("%.2fT", s / 1000000000000);
	elseif s >= 1000000000 then
		return string.format("%.2fB", s / 1000000000);
	elseif s >= 1000000 then
		return string.format("%.2fM", s / 1000000);
	elseif s >= 1000 then
		return string.format("%.1fK", s / 1000);
	else
		return tostring(math.floor(s));
	end;
end;
local z = true;
local n = 5000;
local x = 350;
local l = .5;
local o = false;
local M = false;
local L = game:GetService("Stats");
local function r()
	local s, h = pcall(function()
			local s = L:FindFirstChild("Network");
			local h = s and s:FindFirstChild("ServerStatsItem");
			local P = h and h:FindFirstChild("Data Ping");
			if P then
				return tonumber(string.match(P:GetValueString(), "%d+"));
			end;
			return nil;
		end);
	return s and h or nil;
end;
task.spawn(function()
	while true do
		task.wait(l);
		if z then
			local s = r();
			if s then
				if not o and s >= n then
					o = true;
					M = R;
					R = false;
				elseif o and s <= x then
					o = false;
					if M then
						R = true;
					end;
					M = false;
				end;
			end;
		end;
	end;
end);
task.spawn(function()
	local s = p:FindFirstChild("muscleEvent");
	p.ChildAdded:Connect(function(h)
		if h.Name == "muscleEvent" then
			s = h;
		end;
	end);
	local h = 1000;
	local P = 100;
	local I = P / h;
	while true do
		if R then
			if not s or not s.Parent then
				s = p:FindFirstChild("muscleEvent");
			end;
			if s then
				local h = os.clock();
				for h = 1, P, 1 do
					if not R then
						break;
					end;
					pcall(function()
						s:FireServer("rep");
					end);
				end;
				local T = I - ((os.clock() - h));
				if T > 0 then
					task.wait(T);
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
	local s = 0;
	local h = .2;
	local function P()
		local s = I:FindFirstChild("rEvents");
		return s and s:FindFirstChild("rebirthRemote");
	end;
	local function T()
		if not W then
			return;
		end;
		local I = os.clock();
		if I - s < h then
			return;
		end;
		local T = P();
		if not T then
			return;
		end;
		s = I;
		pcall(function()
			if T:IsA("RemoteFunction") then
				T:InvokeServer("rebirthRequest");
			elseif T:IsA("RemoteEvent") then
				T:FireServer("rebirthRequest");
			end;
		end);
	end;
	(J:GetPropertyChangedSignal("Value")):Connect(T);
	(g:GetPropertyChangedSignal("Value")):Connect(function()
		if W then
			task.defer(T);
		end;
	end);
	while task.wait(.1) do
		T();
	end;
end);
local function d()
	local s = I:FindFirstChild("rEvents");
	return s and s:FindFirstChild("rebirthRemote");
end;
local function i()
	if not N then
		return;
	end;
	local s = t;
	C = "Speed";
	local h = I:FindFirstChild("rEvents") and I.rEvents:FindFirstChild("changeSpeedSizeRemote");
	if h and (h.Parent and (N and s == t)) then
 
	end;
	C = "Farm";
	R = true;
	local P = os.clock() + 8;
	while N and (s == t and os.clock() < P) do
		local s = d();
		if s and (J and J.Parent) then
			break;
		end;
		task.wait(.05);
	end;
	C = "Packs";
	task.wait(.03);
	C = "Rebirth";
	local T = d();
	if T and (N and s == t) then
		pcall(function()
			if T:IsA("RemoteFunction") then
				T:InvokeServer("rebirthRequest");
			elseif T:IsA("RemoteEvent") then
				T:FireServer("rebirthRequest");
			end;
		end);
	end;
	C = "Golems";
	task.wait(.03);
	if N and s == t then
		C = "Farm";
	end;
end;
task.spawn(function()
	while true do
		if N then
			pcall(i);
		else
			C = "Idle";
			task.wait(.15);
		end;
	end;
end);
task.spawn(function()
	while true do
		if g.Value > j then
			m = m + ((g.Value - j));
			j = g.Value;
		elseif g.Value < j then
			j = g.Value;
		end;
		task.wait(.4);
	end;
end);
local a = {
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
local function Z()
	for s, h in ipairs(O:GetTagged("BossEventBoss")) do
		if h and h.Parent then
			local s = h:FindFirstChild("BossDamageHitbox", true) or h.PrimaryPart or h:FindFirstChild("Boss", true) or h:FindFirstChild("Head", true) or h:FindFirstChildWhichIsA("BasePart", true);
			if s and s:IsA("BasePart") then
				local P = h:FindFirstChild("Boss") or h:FindFirstChild("Head", true) or h.PrimaryPart or s;
				if not P:IsA("BasePart") then
					P = s;
				end;
				return h, s, P;
			end;
		end;
	end;
	return nil, nil, nil;
end;
local function X()
	return math.max(0, tonumber(workspace:GetAttribute("BossHealth")) or 0);
end;
local function y(s)
	local h = I:FindFirstChild("rEvents");
	local P = h and h:FindFirstChild("changeSpeedSizeRemote");
	s = math.clamp(math.floor(((tonumber(s) or 2)) + .5), 1, 100);
	if not P then
		return false;
	end;
	if P:IsA("RemoteEvent") then
		return pcall(P.FireServer, P, "changeSize", s);
	elseif P:IsA("RemoteFunction") then
		return pcall(P.InvokeServer, P, "changeSize", s);
	end;
	return false;
end;
local function f()
	local s = e();
	local h = s and s:FindFirstChild("BodyHeightScale");
	return math.clamp(math.floor((((h and h.Value) or 2)) + .5), 1, 100);
end;
local function w()
	local s = c();
	local h = e();
	local P = p:FindFirstChild("Backpack");
	local I = s and s:FindFirstChild("Punch") or (P and P:FindFirstChild("Punch"));
	if I and (h and I.Parent ~= s) then
		pcall(h.EquipTool, h, I);
		v.Heartbeat:Wait();
	end;
	local T = I and I:FindFirstChild("attackTime");
	if T and T:IsA("ValueBase") then
		T.Value = 0;
	end;
	return I;
end;
function a.ApplyAntiLagObject(h, s)
	if not h.antiLag or not s then
		return;
	end;
	local P;
	if s:IsA("ParticleEmitter") or s:IsA("Trail") or s:IsA("Beam") or s:IsA("Fire") or s:IsA("Smoke") or s:IsA("Sparkles") or s:IsA("PointLight") or s:IsA("SpotLight") or s:IsA("SurfaceLight") or s:IsA("Highlight") then
		P = "Enabled";
	elseif s:IsA("BasePart") then
		P = "CastShadow";
	end;
	if P and h.antiLagOriginals[s] == nil then
		h.antiLagOriginals[s] = { property = P, value = s[P] };
		pcall(function()
			s[P] = false;
		end);
	end;
end;
function a.SetAntiLag(h, s)
	s = s == true;
	h.antiLag = s;
	if h.antiLagConnection then
		h.antiLagConnection:Disconnect();
		h.antiLagConnection = nil;
	end;
	if not s then
		for s, P in pairs(h.antiLagOriginals) do
			if s and s.Parent then
				pcall(function()
					s[P.property] = P.value;
				end);
			end;
			h.antiLagOriginals[s] = nil;
		end;
		return true;
	end;
	local P = workspace:FindFirstChild("Events");
	local I = P and P:FindFirstChild("BossArena");
	if not I then
		h.antiLag = false;
		return false;
	end;
	for s, P in ipairs(I:GetDescendants()) do
		h:ApplyAntiLagObject(P);
	end;
	h.antiLagConnection = I.DescendantAdded:Connect(function(s)
			task.defer(function()
				h:ApplyAntiLagObject(s);
			end);
		end);
	return true;
end;
function a.StopStableCamera(s)
	pcall(v.UnbindFromRenderStep, v, s.cameraRenderName);
	local h = workspace.CurrentCamera;
	local P = s.cameraSaved;
	if h and P then
		pcall(function()
			h.CameraType = Enum.CameraType.Scriptable;
			h.CFrame = P.cframe;
			h.Focus = P.focus;
			if P.subject and P.subject.Parent then
				h.CameraSubject = P.subject;
			end;
			h.CameraType = P.cameraType;
		end);
	end;
	s.cameraSaved = nil;
	s.cameraFocusPosition = nil;
	s.cameraStableCFrame = nil;
end;
function a.StartStableCamera(s)
	s:StopStableCamera();
	local h = workspace.CurrentCamera;
	if not h then
		return;
	end;
	s.cameraSaved = {
			cameraType = h.CameraType,
			subject = h.CameraSubject,
			cframe = h.CFrame,
			focus = h.Focus,
		};
	h.CameraType = Enum.CameraType.Scriptable;
	v:BindToRenderStep(s.cameraRenderName, Enum.RenderPriority.Camera.Value + 50, function(h)
		local P = s.cameraFocusPosition;
		local I = workspace.CurrentCamera;
		if not s.engagedBoss or not P or not I then
			return;
		end;
		local T = CFrame.lookAt(P + Vector3.new(0, 34, 48), P + Vector3.new(0, -5, 0));
		s.cameraStableCFrame = s.cameraStableCFrame and s.cameraStableCFrame:Lerp(T, math.clamp(h * 4, .04, .22)) or T;
		I.CameraType = Enum.CameraType.Scriptable;
		I.CFrame = s.cameraStableCFrame;
		I.Focus = CFrame.new(P);
	end);
end;
function a.WaitForReadyCharacter(h, s)
	local P = os.clock() + ((tonumber(s) or 8));
	local I, T, V;
	while h.active and os.clock() < P do
		local s = c();
		local h = s and s:FindFirstChild("HumanoidRootPart");
		local P = s and s:FindFirstChildWhichIsA("Humanoid");
		local k = p:FindFirstChild("machineInUse");
		local v = s and ((s:GetAttribute("IsRebirthing") == true or s:GetAttribute("LastMapCFrame") ~= nil));
		local O = (k and k.Value ~= nil) or (P and P.SeatPart ~= nil);
		if s and (h and (P and (P.Health > 0 and (not v and not O)))) then
			if s ~= I or h ~= T then
				I, T, V = s, h, os.clock();
			elseif os.clock() - V >= .18 then
				return s, h, P;
			end;
		else
			I, T, V = nil, nil, nil;
		end;
		task.wait(.05);
	end;
	return nil, nil, nil;
end;
function a.BeginBattle(h, s)
	if h.engagedBoss == s then
		return true;
	end;
	local P = R;
	R = false;
	local I, T = h:WaitForReadyCharacter(8);
	if not I or not T or s.Parent == nil or workspace:GetAttribute("BossActive") ~= true then
		R = P;
		h:RestoreBattle();
		return false;
	end;
	h.originalCharacter = I;
	h.originalPivot = I:GetPivot();
	h.originalSize = f();
	h.originalRootAnchored = T.Anchored;
	h.engagedBoss = s;
	h.confirmedDamage = 0;
	h.attacks = 0;
	h.safetyTriggered = false;
	h.lastPlayerHealth = nil;
	h.safeAttackPosition = nil;
	h._wasFarming = P;
	h:StartStableCamera();
	y(5);
	task.wait(.55);
	local V = e();
	h.lastPlayerHealth = V and V.Health or nil;
	return true;
end;
function a.RestoreBattle(s)
	local h = p.Character;
	local P = h and h:FindFirstChild("HumanoidRootPart");
	if h and (h == s.originalCharacter and (P and s.originalPivot)) then
		h:PivotTo(s.originalPivot);
		P.AssemblyLinearVelocity = Vector3.zero;
		P.AssemblyAngularVelocity = Vector3.zero;
		if s.originalRootAnchored ~= nil then
			P.Anchored = s.originalRootAnchored;
		end;
	end;
	if s.originalSize then
		y(s.originalSize);
	end;
	s:StopStableCamera();
	local I = p:FindFirstChild("Backpack");
	local T = h and h:FindFirstChild("Punch");
	if T and I then
		T.Parent = I;
	end;
	s.originalCharacter = nil;
	s.originalPivot = nil;
	s.originalSize = nil;
	s.originalRootAnchored = nil;
	s.engagedBoss = nil;
	s.lastPlayerHealth = nil;
	s.safeAttackPosition = nil;
	if s._wasFarming then
		R = true;
		s._wasFarming = nil;
	end;
end;
function a.CollectChest(h, s)
	if type(fireproximityprompt) ~= "function" then
		return false;
	end;
	local P = false;
	local T;
	local V = I:FindFirstChild("rEvents");
	local k = V and V:FindFirstChild("bossChestOpenedEvent");
	if k and k:IsA("RemoteEvent") then
		T = k.OnClientEvent:Connect(function()
				P = true;
			end);
	end;
	local function v(s)
		if T then
			T:Disconnect();
		end;
		return s;
	end;
	local D = os.clock() + ((tonumber(s) or 15));
	local G, F, A = false, false, 0;
	while h.active and os.clock() < D do
		if P then
			return v(true);
		end;
		local s, h;
		for P, I in ipairs(O:GetTagged("BossEventChest")) do
			h = I:FindFirstChild("bossChestPrompt", true);
			if h then
				s = I;
				break;
			end;
		end;
		if not h then
			local P = workspace:FindFirstChild("Events");
			h = P and P:FindFirstChild("bossChestPrompt", true);
			s = h and h:FindFirstAncestorOfClass("Model");
		end;
		local I = p:GetAttribute("BossChestEligible") == true;
		local T = p:GetAttribute("BossChestPending") == true;
		if T then
			G = true;
		elseif F and G then
			return v(true);
		end;
		local V = s and s:GetAttribute("BossChestEmerging") == true;
		if h and (h:IsA("ProximityPrompt") and (I and (T and not V))) then
			local s = c();
			local P = Y();
			local I = h.Parent;
			if s and (P and (I and I:IsA("BasePart"))) then
				s:PivotTo(I.CFrame * CFrame.new(0, math.max(4, I.Size.Y * .5 + 3), 0));
				P.AssemblyLinearVelocity = Vector3.zero;
				P.AssemblyAngularVelocity = Vector3.zero;
				task.wait(.12);
			end;
			if h.Enabled and os.clock() - A >= .45 then
				A = os.clock();
				F = pcall(fireproximityprompt, h) or F;
			end;
		end;
		task.wait(.1);
	end;
	return v(P or (F and (G and p:GetAttribute("BossChestPending") ~= true)));
end;
function a.Fight(h, s)
	if not h:BeginBattle(s) then
		return;
	end;
	local P = X();
	local I = 0;
	while h.active and (s.Parent and workspace:GetAttribute("BossActive") == true) do
		local T, V, k = Z();
		if T ~= s or not V or not k then
			break;
		end;
		local v = c();
		local O = Y();
		local p = e();
		local D = w();
		if not v or not O or not p or p.Health <= 0 or not D then
			h.status = "Esperando personaje";
			h:UpdateUi();
			task.wait(.25);
		else
			if h.lastPlayerHealth and p.Health < h.lastPlayerHealth then
				h.safetyTriggered = true;
				h.active = false;
				h.status = "Proteccion activada (te golpearon)";
				h:SetAntiLag(false);
				h:UpdateUi();
				break;
			end;
			h.lastPlayerHealth = p.Health;
			local s = k.Position.Y + k.Size.Y * .5;
			local T = math.max(6, O.Size.Y * .5 + 4);
			local G = Vector3.new(V.Position.X, s + T, V.Position.Z);
			if not h.safeAttackPosition or ((G - h.safeAttackPosition)).Magnitude > 45 then
				h.safeAttackPosition = G;
			else
				h.safeAttackPosition = h.safeAttackPosition:Lerp(G, .16);
			end;
			local F = h.safeAttackPosition;
			local A = k.Position + Vector3.new(0, k.Size.Y * .32, 0);
			h.cameraFocusPosition = h.cameraFocusPosition and h.cameraFocusPosition:Lerp(A, .08) or A;
			v:PivotTo(CFrame.lookAt(F, A));
			O.AssemblyLinearVelocity = Vector3.zero;
			O.AssemblyAngularVelocity = Vector3.zero;
			local q = os.clock();
			if q - I >= h.hitInterval then
				I = q;
				pcall(D.Deactivate, D);
				pcall(D.Activate, D);
				h.attacks = h.attacks + (1);
			end;
			local E = X();
			if E < P then
				h.confirmedDamage = h.confirmedDamage + ((P - E));
			end;
			P = E;
			h.status = ((workspace:GetAttribute("BossDisplayName") or "Boss")) .. ("  dano " .. b(h.confirmedDamage));
			h:UpdateUi();
			task.wait(.04);
		end;
	end;
	local T = workspace:GetAttribute("BossActive") ~= true or X() <= 0;
	if T and h.active then
		h.status = "Boss derrotado  reclamando recompensa";
		h:UpdateUi();
		h:CollectChest(12);
	end;
	h:RestoreBattle();
end;
function a.Set(h, s)
	s = s == true;
	h.generation = h.generation + (1);
	local P = h.generation;
	h.active = s;
	if not s then
		h.status = "Sin boss activo";
		h:RestoreBattle();
		h:SetAntiLag(false);
		h:UpdateUi();
		return true;
	end;
	local T = I:FindFirstChild("shared");
	T = T and T:FindFirstChild("config");
	T = T and T:FindFirstChild("BossEventConfig");
	local V, k = pcall(function()
			return T and require(T);
		end);
	if not V or type(k) ~= "table" or k.ENABLED ~= true then
		h.active = false;
		h.status = "El evento del boss no esta disponible";
		h:SetAntiLag(false);
		h:UpdateUi();
		return false;
	end;
	h:SetAntiLag(true);
	h.hitInterval = math.max(.31, ((tonumber(k.MIN_HIT_INTERVAL) or .3)) + .01);
	task.spawn(function()
		while h.active and h.generation == P do
			local s = Z();
			if s and workspace:GetAttribute("BossActive") == true then
				h:Fight(s);
			else
				h.engagedBoss = nil;
				h.status = "Sin boss activo";
				h:UpdateUi();
				task.wait(.4);
			end;
		end;
		if h.generation == P then
			h:RestoreBattle();
		end;
	end);
	h:UpdateUi();
	return true;
end;
function a.UpdateUi(s)
	if s.StatusLabel then
		s.StatusLabel.Text = s.status;
		s.StatusLabel.TextColor3 = s.engagedBoss and Color3.fromRGB(100, 255, 140) or Color3.fromRGB(160, 160, 180);
	end;
	if s.HealthLabel then
		local h = X();
		local P = math.max(h, tonumber(workspace:GetAttribute("BossMaxHealth")) or 0);
		if P > 0 and workspace:GetAttribute("BossActive") == true then
			s.HealthLabel.Text = b(h) .. (" / " .. b(P));
		else
			s.HealthLabel.Text = "-";
		end;
	end;
end;
local K = Instance.new("ScreenGui");
K.Name = "SLK_AuralGUI_Improved";
K.ResetOnSpawn = false;
K.IgnoreGuiInset = true;
K.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
K.Parent = D;
local u = Instance.new("Frame");
u.Name = "Main";
u.Size = UDim2.new(0, 360, 0, 270);
u.Position = UDim2.new(.5, -180, .5, -135);
u.BackgroundColor3 = Color3.fromRGB(18, 18, 22);
u.BorderSizePixel = 0;
u.Active = true;
u.Draggable = false;
u.Parent = K;
(Instance.new("UICorner", u)).CornerRadius = UDim.new(0, 12);
local sq = Instance.new("UIStroke");
sq.Color = Color3.fromRGB(40, 40, 50);
sq.Thickness = 1;
sq.Parent = u;
local hq = Instance.new("Frame");
hq.Name = "DragBar";
hq.Size = UDim2.new(1, -100, 0, 32);
hq.Position = UDim2.new(0, 100, 0, 0);
hq.BackgroundTransparency = 1;
hq.Active = true;
hq.Parent = u;
local Pq = Instance.new("TextLabel");
Pq.Size = UDim2.new(1, -70, 1, 0);
Pq.Position = UDim2.new(0, 12, 0, 0);
Pq.BackgroundTransparency = 1;
Pq.Text = "SLK";
Pq.TextColor3 = Color3.fromRGB(150, 150, 170);
Pq.Font = Enum.Font.GothamMedium;
Pq.TextSize = 11;
Pq.TextXAlignment = Enum.TextXAlignment.Left;
Pq.Parent = hq;
local Iq = false;
local Tq = nil;
local Vq = nil;
hq.InputBegan:Connect(function(s)
	if s.UserInputType == Enum.UserInputType.MouseButton1 or s.UserInputType == Enum.UserInputType.Touch then
		Iq = true;
		Tq = s.Position;
		Vq = u.Position;
		s.Changed:Connect(function()
			if s.UserInputState == Enum.UserInputState.End then
				Iq = false;
			end;
		end);
	end;
end);
k.InputChanged:Connect(function(s)
	if not Iq then
		return;
	end;
	if s.UserInputType ~= Enum.UserInputType.MouseMovement and s.UserInputType ~= Enum.UserInputType.Touch then
		return;
	end;
	local h = s.Position - Tq;
	u.Position = UDim2.new(Vq.X.Scale, Vq.X.Offset + h.X, Vq.Y.Scale, Vq.Y.Offset + h.Y);
end);
local kq = Instance.new("Frame");
kq.Size = UDim2.new(0, 100, 1, 0);
kq.BackgroundColor3 = Color3.fromRGB(12, 12, 16);
kq.BorderSizePixel = 0;
kq.Parent = u;
(Instance.new("UICorner", kq)).CornerRadius = UDim.new(0, 12);
local vq = Instance.new("Frame");
vq.Size = UDim2.new(1, 0, 0, 56);
vq.BackgroundTransparency = 1;
vq.Parent = kq;
local Oq = Instance.new("TextLabel");
Oq.Size = UDim2.new(0, 20, 0, 20);
Oq.Position = UDim2.new(0, 7, 0, 10);
Oq.BackgroundColor3 = Color3.fromRGB(90, 60, 220);
Oq.Text = "A";
Oq.TextColor3 = Color3.fromRGB(255, 255, 255);
Oq.Font = Enum.Font.GothamBold;
Oq.TextSize = 12;
Oq.Parent = vq;
(Instance.new("UICorner", Oq)).CornerRadius = UDim.new(0, 6);
local pq = Instance.new("TextLabel");
pq.Size = UDim2.new(1, -32, 0, 16);
pq.Position = UDim2.new(0, 31, 0, 8);
pq.BackgroundTransparency = 1;
pq.Text = "SLK Paid";
pq.TextColor3 = Color3.fromRGB(255, 255, 255);
pq.Font = Enum.Font.GothamBold;
pq.TextSize = 10;
pq.TextXAlignment = Enum.TextXAlignment.Left;
pq.Parent = vq;
local Dq = Instance.new("TextLabel");
Dq.Size = UDim2.new(1, -32, 0, 12);
Dq.Position = UDim2.new(0, 31, 0, 23);
Dq.BackgroundTransparency = 1;
Dq.Text = "Muscle Legends";
Dq.TextColor3 = Color3.fromRGB(140, 140, 160);
Dq.Font = Enum.Font.Gotham;
Dq.TextSize = 8;
Dq.TextXAlignment = Enum.TextXAlignment.Left;
Dq.Parent = vq;
local Gq = Instance.new("Frame");
Gq.Size = UDim2.new(1, -10, 1, -58);
Gq.Position = UDim2.new(0, 5, 0, 56);
Gq.BackgroundTransparency = 1;
Gq.Parent = kq;
local Fq = Instance.new("UIListLayout");
Fq.Padding = UDim.new(0, 4);
Fq.Parent = Gq;
local Aq = {};
local qq = "Farming";
local function Eq(s, h, P)
	local I = Instance.new("TextButton");
	I.Name = s;
	I.Size = UDim2.new(1, 0, 0, 29);
	I.BackgroundColor3 = Color3.fromRGB(12, 12, 16);
	I.BorderSizePixel = 0;
	I.Text = "";
	I.AutoButtonColor = false;
	I.LayoutOrder = P;
	I.Parent = Gq;
	(Instance.new("UICorner", I)).CornerRadius = UDim.new(0, 8);
	local T = Instance.new("TextLabel");
	T.Size = UDim2.new(0, 20, 1, 0);
	T.Position = UDim2.new(0, 3, 0, 0);
	T.BackgroundTransparency = 1;
	T.Text = h;
	T.TextColor3 = Color3.fromRGB(160, 160, 180);
	T.Font = Enum.Font.GothamBold;
	T.TextSize = 10;
	T.Parent = I;
	local V = Instance.new("TextLabel");
	V.Size = UDim2.new(1, -27, 1, 0);
	V.Position = UDim2.new(0, 25, 0, 0);
	V.BackgroundTransparency = 1;
	V.Text = s;
	V.TextColor3 = Color3.fromRGB(180, 180, 200);
	V.Font = Enum.Font.GothamMedium;
	V.TextSize = 10;
	V.TextXAlignment = Enum.TextXAlignment.Left;
	V.Parent = I;
	local k = Instance.new("Frame");
	k.Name = "Indicator";
	k.Size = UDim2.new(0, 3, 0, 20);
	k.Position = UDim2.new(0, 0, .5, -10);
	k.BackgroundColor3 = Color3.fromRGB(120, 80, 255);
	k.BorderSizePixel = 0;
	k.Visible = false;
	k.Parent = I;
	(Instance.new("UICorner", k)).CornerRadius = UDim.new(0, 2);
	I.MouseButton1Click:Connect(function()
		for s, h in pairs(Aq) do
			h.Visible = false;
		end;
		if Aq[s] then
			Aq[s].Visible = true;
		end;
		qq = s;
		for s, h in ipairs(Gq:GetChildren()) do
			if h:IsA("TextButton") then
				h.BackgroundColor3 = Color3.fromRGB(12, 12, 16);
				local s = h:FindFirstChild("Indicator");
				if s then
					s.Visible = false;
				end;
			end;
		end;
		I.BackgroundColor3 = Color3.fromRGB(28, 24, 45);
		k.Visible = true;
	end);
	return I;
end;
local Uq = Eq("Farming", "F", 1);
local Bq = Eq("Boss", "B", 2);
local Jq = Eq("Info", "I", 3);
local gq = Eq("Settings", "S", 4);
Uq.BackgroundColor3 = Color3.fromRGB(28, 24, 45);
(Uq:FindFirstChild("Indicator")).Visible = true;
local Rq = Instance.new("Frame");
Rq.Size = UDim2.new(1, -100, 1, 0);
Rq.Position = UDim2.new(0, 100, 0, 0);
Rq.BackgroundColor3 = Color3.fromRGB(18, 18, 22);
Rq.BorderSizePixel = 0;
Rq.Parent = u;
local Wq = Instance.new("TextButton");
Wq.Size = UDim2.new(0, 28, 0, 28);
Wq.Position = UDim2.new(1, -36, 0, 10);
Wq.BackgroundColor3 = Color3.fromRGB(30, 30, 38);
Wq.Text = "X";
Wq.TextColor3 = Color3.fromRGB(180, 180, 200);
Wq.Font = Enum.Font.GothamBold;
Wq.TextSize = 14;
Wq.Parent = Rq;
(Instance.new("UICorner", Wq)).CornerRadius = UDim.new(0, 6);
Wq.MouseButton1Click:Connect(function()
	a:Set(false);
	K:Destroy();
end);
local Nq = Instance.new("TextButton");
Nq.Name = "SLKMini";
Nq.Size = UDim2.new(0, 118, 0, 42);
Nq.Position = UDim2.new(1, -132, 0, 18);
Nq.BackgroundColor3 = Color3.fromRGB(22, 22, 30);
Nq.BorderSizePixel = 0;
Nq.Text = "SLK";
Nq.TextColor3 = Color3.fromRGB(235, 235, 255);
Nq.Font = Enum.Font.GothamBold;
Nq.TextSize = 15;
Nq.Visible = false;
Nq.AutoButtonColor = false;
Nq.Parent = K;
(Instance.new("UICorner", Nq)).CornerRadius = UDim.new(0, 12);
local Cq = Instance.new("UIStroke");
Cq.Color = Color3.fromRGB(95, 70, 190);
Cq.Thickness = 1.5;
Cq.Parent = Nq;
local tq = Instance.new("TextButton");
tq.Name = "Minimize";
tq.Size = UDim2.new(0, 28, 0, 28);
tq.Position = UDim2.new(1, -70, 0, 10);
tq.BackgroundColor3 = Color3.fromRGB(30, 30, 38);
tq.Text = "-";
tq.TextColor3 = Color3.fromRGB(210, 210, 225);
tq.Font = Enum.Font.GothamBold;
tq.TextSize = 16;
tq.Parent = Rq;
(Instance.new("UICorner", tq)).CornerRadius = UDim.new(0, 6);
tq.MouseButton1Click:Connect(function()
	u.Visible = false;
	Nq.Visible = true;
end);
Nq.MouseButton1Click:Connect(function()
	Nq.Visible = false;
	u.Visible = true;
end);
local function Hq(s, h, P, I, T, k)
	local v = Instance.new("Frame");
	v.Size = UDim2.new(1, -10, 0, 52);
	v.Position = UDim2.new(0, 0, 0, h);
	v.BackgroundColor3 = Color3.fromRGB(24, 24, 30);
	v.BorderSizePixel = 0;
	v.Parent = s;
	(Instance.new("UICorner", v)).CornerRadius = UDim.new(0, 8);
	local O = Instance.new("TextLabel");
	O.Size = UDim2.new(1, -70, 0, 20);
	O.Position = UDim2.new(0, 14, 0, 8);
	O.BackgroundTransparency = 1;
	O.Text = P;
	O.TextColor3 = Color3.fromRGB(240, 240, 250);
	O.Font = Enum.Font.GothamMedium;
	O.TextSize = 13;
	O.TextXAlignment = Enum.TextXAlignment.Left;
	O.Parent = v;
	local p = Instance.new("TextLabel");
	p.Size = UDim2.new(1, -70, 0, 16);
	p.Position = UDim2.new(0, 14, 0, 28);
	p.BackgroundTransparency = 1;
	p.Text = I;
	p.TextColor3 = Color3.fromRGB(130, 130, 150);
	p.Font = Enum.Font.Gotham;
	p.TextSize = 11;
	p.TextXAlignment = Enum.TextXAlignment.Left;
	p.Parent = v;
	local D = Instance.new("Frame");
	D.Size = UDim2.new(0, 42, 0, 24);
	D.Position = UDim2.new(1, -56, .5, -12);
	D.BackgroundColor3 = T and Color3.fromRGB(100, 70, 220) or Color3.fromRGB(50, 50, 60);
	D.BorderSizePixel = 0;
	D.Parent = v;
	(Instance.new("UICorner", D)).CornerRadius = UDim.new(1, 0);
	local G = Instance.new("Frame");
	G.Size = UDim2.new(0, 18, 0, 18);
	G.Position = T and UDim2.new(1, -21, .5, -9) or UDim2.new(0, 3, .5, -9);
	G.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	G.BorderSizePixel = 0;
	G.Parent = D;
	(Instance.new("UICorner", G)).CornerRadius = UDim.new(1, 0);
	local F = T;
	local A = Instance.new("TextButton");
	A.Size = UDim2.new(1, 0, 1, 0);
	A.BackgroundTransparency = 1;
	A.Text = "";
	A.Parent = v;
	A.MouseButton1Click:Connect(function()
		F = not F;
		local s = TweenInfo.new(.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
		if F then
			(V:Create(D, s, { BackgroundColor3 = Color3.fromRGB(100, 70, 220) })):Play();
			(V:Create(G, s, { Position = UDim2.new(1, -21, .5, -9) })):Play();
		else
			(V:Create(D, s, { BackgroundColor3 = Color3.fromRGB(50, 50, 60) })):Play();
			(V:Create(G, s, { Position = UDim2.new(0, 3, .5, -9) })):Play();
		end;
		if k then
			k(F);
		end;
	end);
	return v;
end;
local function mq(s, h, P)
	local I = Instance.new("TextLabel");
	I.Size = UDim2.new(1, 0, 0, 20);
	I.Position = UDim2.new(0, 0, 0, h);
	I.BackgroundTransparency = 1;
	I.Text = P;
	I.TextColor3 = Color3.fromRGB(120, 100, 200);
	I.Font = Enum.Font.GothamBold;
	I.TextSize = 11;
	I.TextXAlignment = Enum.TextXAlignment.Left;
	I.Parent = s;
	return I;
end;
local jq = Instance.new("ScrollingFrame");
jq.Name = "Farming";
jq.Size = UDim2.new(1, -20, 1, -50);
jq.Position = UDim2.new(0, 10, 0, 45);
jq.BackgroundTransparency = 1;
jq.BorderSizePixel = 0;
jq.ScrollBarThickness = 4;
jq.ScrollingEnabled = true;
jq.Active = true;
jq.ScrollBarImageColor3 = Color3.fromRGB(80, 60, 160);
jq.CanvasSize = UDim2.new(0, 0, 0, 350);
jq.Parent = Rq;
Aq.Farming = jq;
local Sq = Instance.new("TextLabel");
Sq.Size = UDim2.new(1, 0, 0, 28);
Sq.BackgroundTransparency = 1;
Sq.Text = "Farming";
Sq.TextColor3 = Color3.fromRGB(255, 255, 255);
Sq.Font = Enum.Font.GothamBold;
Sq.TextSize = 20;
Sq.TextXAlignment = Enum.TextXAlignment.Left;
Sq.Parent = jq;
local Qq = Instance.new("TextLabel");
Qq.Size = UDim2.new(1, 0, 0, 18);
Qq.Position = UDim2.new(0, 0, 0, 26);
Qq.BackgroundTransparency = 1;
Qq.Text = "Strength, rebirth, boosts";
Qq.TextColor3 = Color3.fromRGB(140, 140, 160);
Qq.Font = Enum.Font.Gotham;
Qq.TextSize = 12;
Qq.TextXAlignment = Enum.TextXAlignment.Left;
Qq.Parent = jq;
local cq = Instance.new("Frame");
cq.Size = UDim2.new(1, -10, 0, 64);
cq.Position = UDim2.new(0, 0, 0, 55);
cq.BackgroundColor3 = Color3.fromRGB(24, 24, 30);
cq.BorderSizePixel = 0;
cq.Parent = jq;
(Instance.new("UICorner", cq)).CornerRadius = UDim.new(0, 8);
local eq = Instance.new("TextLabel");
eq.Size = UDim2.new(1, -110, 0, 22);
eq.Position = UDim2.new(0, 14, 0, 8);
eq.BackgroundTransparency = 1;
eq.Text = "OP Farm";
eq.TextColor3 = Color3.fromRGB(240, 240, 250);
eq.Font = Enum.Font.GothamBold;
eq.TextSize = 14;
eq.TextXAlignment = Enum.TextXAlignment.Left;
eq.Parent = cq;
local Yq = Instance.new("TextLabel");
Yq.Size = UDim2.new(1, -110, 0, 18);
Yq.Position = UDim2.new(0, 14, 0, 32);
Yq.BackgroundTransparency = 1;
Yq.Text = "Target:  OP |FARM";
Yq.TextColor3 = Color3.fromRGB(135, 135, 155);
Yq.Font = Enum.Font.Gotham;
Yq.TextSize = 11;
Yq.TextXAlignment = Enum.TextXAlignment.Left;
Yq.Parent = cq;
local bq = Instance.new("TextButton");
bq.Size = UDim2.new(0, 78, 0, 32);
bq.Position = UDim2.new(1, -90, .5, -16);
bq.BackgroundColor3 = Color3.fromRGB(45, 45, 55);
bq.Text = "OFF";
bq.TextColor3 = Color3.fromRGB(190, 190, 205);
bq.Font = Enum.Font.GothamBold;
bq.TextSize = 12;
bq.Parent = cq;
(Instance.new("UICorner", bq)).CornerRadius = UDim.new(0, 8);
local function zq(s)
	if s then
		bq.Text = "ON";
		bq.BackgroundColor3 = Color3.fromRGB(100, 70, 220);
		bq.TextColor3 = Color3.fromRGB(255, 255, 255);
	else
		bq.Text = "OFF";
		bq.BackgroundColor3 = Color3.fromRGB(45, 45, 55);
		bq.TextColor3 = Color3.fromRGB(190, 190, 205);
	end;
end;
bq.MouseButton1Click:Connect(function()
	R = not R;
	zq(R);
end);
mq(jq, 135, "REBIRTH");
Hq(jq, 158, "Auto Rebirth", "Rebirth when strength reaches threshold", false, function(s)
	W = s;
end);
mq(jq, 205, "FAST REBIRTH");
Hq(jq, 228, "Fast Rebirth", "Speed -> Farm -> Packs -> Rebirth -> Golems", false, function(s)
	N = s;
	t = t + (1);
	if s then
		R = true;
		zq(true);
	else
		C = "Idle";
	end;
end);
local nq = Instance.new("TextLabel");
nq.Size = UDim2.new(1, -10, 0, 34);
nq.Position = UDim2.new(0, 0, 0, 291);
nq.BackgroundColor3 = Color3.fromRGB(24, 24, 30);
nq.BorderSizePixel = 0;
nq.Text = "Fast Rebirth: Idle";
nq.TextColor3 = Color3.fromRGB(150, 150, 175);
nq.Font = Enum.Font.GothamMedium;
nq.TextSize = 12;
nq.TextXAlignment = Enum.TextXAlignment.Left;
nq.Parent = jq;
(Instance.new("UICorner", nq)).CornerRadius = UDim.new(0, 8);
local xq = Instance.new("UIPadding", nq);
xq.PaddingLeft = UDim.new(0, 12);
mq(jq, 340, "SESSION STATS");
local lq = Instance.new("Frame");
lq.Size = UDim2.new(1, -10, 0, 90);
lq.Position = UDim2.new(0, 0, 0, 363);
lq.BackgroundColor3 = Color3.fromRGB(24, 24, 30);
lq.BorderSizePixel = 0;
lq.Parent = jq;
(Instance.new("UICorner", lq)).CornerRadius = UDim.new(0, 8);
local oq = Instance.new("TextLabel");
oq.Size = UDim2.new(1, -20, 0, 22);
oq.Position = UDim2.new(0, 14, 0, 12);
oq.BackgroundTransparency = 1;
oq.Text = "Session Rebirths: 0";
oq.TextColor3 = Color3.fromRGB(160, 255, 160);
oq.Font = Enum.Font.GothamMedium;
oq.TextSize = 13;
oq.TextXAlignment = Enum.TextXAlignment.Left;
oq.Parent = lq;
local Mq = Instance.new("TextLabel");
Mq.Size = UDim2.new(1, -20, 0, 20);
Mq.Position = UDim2.new(0, 14, 0, 36);
Mq.BackgroundTransparency = 1;
Mq.Text = "Time: 0h 0m";
Mq.TextColor3 = Color3.fromRGB(180, 180, 210);
Mq.Font = Enum.Font.Gotham;
Mq.TextSize = 12;
Mq.TextXAlignment = Enum.TextXAlignment.Left;
Mq.Parent = lq;
local Lq = Instance.new("TextLabel");
Lq.Size = UDim2.new(1, -20, 0, 20);
Lq.Position = UDim2.new(0, 14, 0, 58);
Lq.BackgroundTransparency = 1;
Lq.Text = "Rate: 0 /h";
Lq.TextColor3 = Color3.fromRGB(140, 190, 255);
Lq.Font = Enum.Font.Gotham;
Lq.TextSize = 12;
Lq.TextXAlignment = Enum.TextXAlignment.Left;
Lq.Parent = lq;
local rq = Instance.new("ScrollingFrame");
rq.Name = "Boss";
rq.Size = UDim2.new(1, -20, 1, -50);
rq.Position = UDim2.new(0, 10, 0, 45);
rq.BackgroundTransparency = 1;
rq.BorderSizePixel = 0;
rq.ScrollBarThickness = 4;
rq.ScrollingEnabled = true;
rq.Active = true;
rq.ScrollBarImageColor3 = Color3.fromRGB(80, 60, 160);
rq.CanvasSize = UDim2.new(0, 0, 0, 380);
rq.Visible = false;
rq.Parent = Rq;
Aq.Boss = rq;
local dq = Instance.new("TextLabel");
dq.Size = UDim2.new(1, 0, 0, 28);
dq.BackgroundTransparency = 1;
dq.Text = "Boss";
dq.TextColor3 = Color3.fromRGB(255, 255, 255);
dq.Font = Enum.Font.GothamBold;
dq.TextSize = 20;
dq.TextXAlignment = Enum.TextXAlignment.Left;
dq.Parent = rq;
local iq = Instance.new("TextLabel");
iq.Size = UDim2.new(1, 0, 0, 18);
iq.Position = UDim2.new(0, 0, 0, 26);
iq.BackgroundTransparency = 1;
iq.Text = "Auto Boss Event";
iq.TextColor3 = Color3.fromRGB(140, 140, 160);
iq.Font = Enum.Font.Gotham;
iq.TextSize = 12;
iq.TextXAlignment = Enum.TextXAlignment.Left;
iq.Parent = rq;
mq(rq, 55, "AUTO BOSS");
local aq = Instance.new("Frame");
aq.Size = UDim2.new(1, -10, 0, 42);
aq.Position = UDim2.new(0, 0, 0, 78);
aq.BackgroundColor3 = Color3.fromRGB(24, 24, 30);
aq.BorderSizePixel = 0;
aq.Parent = rq;
(Instance.new("UICorner", aq)).CornerRadius = UDim.new(0, 8);
local Zq = Instance.new("TextLabel");
Zq.Size = UDim2.new(0, 70, 1, 0);
Zq.Position = UDim2.new(0, 14, 0, 0);
Zq.BackgroundTransparency = 1;
Zq.Text = "Status:";
Zq.TextColor3 = Color3.fromRGB(160, 160, 180);
Zq.Font = Enum.Font.Gotham;
Zq.TextSize = 12;
Zq.TextXAlignment = Enum.TextXAlignment.Left;
Zq.Parent = aq;
a.StatusLabel = Instance.new("TextLabel");
a.StatusLabel.Size = UDim2.new(1, -90, 1, 0);
a.StatusLabel.Position = UDim2.new(0, 80, 0, 0);
a.StatusLabel.BackgroundTransparency = 1;
a.StatusLabel.Text = "Sin boss activo";
a.StatusLabel.TextColor3 = Color3.fromRGB(160, 160, 180);
a.StatusLabel.Font = Enum.Font.GothamMedium;
a.StatusLabel.TextSize = 13;
a.StatusLabel.TextXAlignment = Enum.TextXAlignment.Left;
a.StatusLabel.Parent = aq;
local Xq = Instance.new("Frame");
Xq.Size = UDim2.new(1, -10, 0, 42);
Xq.Position = UDim2.new(0, 0, 0, 128);
Xq.BackgroundColor3 = Color3.fromRGB(24, 24, 30);
Xq.BorderSizePixel = 0;
Xq.Parent = rq;
(Instance.new("UICorner", Xq)).CornerRadius = UDim.new(0, 8);
local yq = Instance.new("TextLabel");
yq.Size = UDim2.new(0, 100, 1, 0);
yq.Position = UDim2.new(0, 14, 0, 0);
yq.BackgroundTransparency = 1;
yq.Text = "Boss Health:";
yq.TextColor3 = Color3.fromRGB(160, 160, 180);
yq.Font = Enum.Font.Gotham;
yq.TextSize = 12;
yq.TextXAlignment = Enum.TextXAlignment.Left;
yq.Parent = Xq;
a.HealthLabel = Instance.new("TextLabel");
a.HealthLabel.Size = UDim2.new(1, -120, 1, 0);
a.HealthLabel.Position = UDim2.new(0, 110, 0, 0);
a.HealthLabel.BackgroundTransparency = 1;
a.HealthLabel.Text = "-";
a.HealthLabel.TextColor3 = Color3.fromRGB(100, 200, 255);
a.HealthLabel.Font = Enum.Font.GothamMedium;
a.HealthLabel.TextSize = 13;
a.HealthLabel.TextXAlignment = Enum.TextXAlignment.Left;
a.HealthLabel.Parent = Xq;
Hq(rq, 185, "Attack Boss", "Auto farm for Boss event (pauses OP Farm)", false, function(s)
	local h = a:Set(s);
	if h == false then
 
	end;
end);
mq(rq, 255, "INFO");
local fq = Instance.new("TextLabel");
fq.Size = UDim2.new(1, -10, 0, 80);
fq.Position = UDim2.new(0, 0, 0, 278);
fq.BackgroundColor3 = Color3.fromRGB(24, 24, 30);
fq.BorderSizePixel = 0;
fq.Text = " Detecta automatically cuando aparece el Boss\n Cambia tamano a 5, ataca desde arriba\n Anti-lag + stable camera\n Reclama el cofre al derrotarlo\n Se apaga si te hacen dano (proteccion)";
fq.TextColor3 = Color3.fromRGB(150, 150, 170);
fq.Font = Enum.Font.Gotham;
fq.TextSize = 12;
fq.TextXAlignment = Enum.TextXAlignment.Left;
fq.TextYAlignment = Enum.TextYAlignment.Top;
fq.Parent = rq;
(Instance.new("UICorner", fq)).CornerRadius = UDim.new(0, 8);
(Instance.new("UIPadding", fq)).PaddingTop = UDim.new(0, 10);
(Instance.new("UIPadding", fq)).PaddingLeft = UDim.new(0, 12);
local wq = Instance.new("ScrollingFrame");
wq.Name = "Info";
wq.Size = UDim2.new(1, -20, 1, -50);
wq.Position = UDim2.new(0, 10, 0, 45);
wq.BackgroundTransparency = 1;
wq.BorderSizePixel = 0;
wq.ScrollBarThickness = 4;
wq.ScrollingEnabled = true;
wq.Active = true;
wq.ScrollBarImageColor3 = Color3.fromRGB(80, 60, 160);
wq.CanvasSize = UDim2.new(0, 0, 0, 360);
wq.Visible = false;
wq.Parent = Rq;
Aq.Info = wq;
local Kq = Instance.new("TextLabel");
Kq.Size = UDim2.new(1, 0, 0, 28);
Kq.BackgroundTransparency = 1;
Kq.Text = "Info";
Kq.TextColor3 = Color3.fromRGB(255, 255, 255);
Kq.Font = Enum.Font.GothamBold;
Kq.TextSize = 20;
Kq.TextXAlignment = Enum.TextXAlignment.Left;
Kq.Parent = wq;
local uq = Instance.new("TextLabel");
uq.Size = UDim2.new(1, 0, 0, 18);
uq.Position = UDim2.new(0, 0, 0, 28);
uq.BackgroundTransparency = 1;
uq.Text = "Session performance and farming rates";
uq.TextColor3 = Color3.fromRGB(140, 140, 160);
uq.Font = Enum.Font.Gotham;
uq.TextSize = 12;
uq.TextXAlignment = Enum.TextXAlignment.Left;
uq.Parent = wq;
mq(wq, 58, "RATES PER HOUR");
local sT = Instance.new("Frame");
sT.Size = UDim2.new(1, -10, 0, 150);
sT.Position = UDim2.new(0, 0, 0, 84);
sT.BackgroundColor3 = Color3.fromRGB(24, 24, 30);
sT.BorderSizePixel = 0;
sT.Parent = wq;
(Instance.new("UICorner", sT)).CornerRadius = UDim.new(0, 8);
local hT = Instance.new("TextLabel");
hT.Size = UDim2.new(1, -28, 0, 32);
hT.Position = UDim2.new(0, 14, 0, 12);
hT.BackgroundTransparency = 1;
hT.Text = "Strength per hour: 0";
hT.TextColor3 = Color3.fromRGB(150, 210, 255);
hT.Font = Enum.Font.GothamMedium;
hT.TextSize = 14;
hT.TextXAlignment = Enum.TextXAlignment.Left;
hT.Parent = sT;
local PT = Instance.new("TextLabel");
PT.Size = UDim2.new(1, -28, 0, 32);
PT.Position = UDim2.new(0, 14, 0, 52);
PT.BackgroundTransparency = 1;
PT.Text = "Rebirths per hour: 0";
PT.TextColor3 = Color3.fromRGB(160, 255, 160);
PT.Font = Enum.Font.GothamMedium;
PT.TextSize = 14;
PT.TextXAlignment = Enum.TextXAlignment.Left;
PT.Parent = sT;
local IT = Instance.new("TextLabel");
IT.Size = UDim2.new(1, -28, 0, 32);
IT.Position = UDim2.new(0, 14, 0, 92);
IT.BackgroundTransparency = 1;
IT.Text = "Session time: 0m";
IT.TextColor3 = Color3.fromRGB(180, 180, 210);
IT.Font = Enum.Font.Gotham;
IT.TextSize = 12;
IT.TextXAlignment = Enum.TextXAlignment.Left;
IT.Parent = sT;
local function TT()
	local s = math.max(0, tick() - H);
	local h = math.floor(s / 3600);
	local P = math.floor(((s % 3600)) / 60);
	local I = s > 0 and math.floor(((S / s)) * 3600) or 0;
	local T = s > 0 and math.floor(((m / s)) * 3600) or 0;
	if hT then
		hT.Text = "Strength per hour: " .. b(I);
	end;
	if PT then
		PT.Text = "Rebirths per hour: " .. T;
	end;
	if IT then
		IT.Text = string.format("Session time: %dh %dm", h, P);
	end;
	if oq then
		oq.Text = "Session Rebirths: " .. m;
	end;
	if Mq then
		Mq.Text = string.format("Time: %dh %dm", h, P);
	end;
	if Lq then
		Lq.Text = "Rate: " .. (T .. " /h");
	end;
	if nq then
		nq.Text = "Fast Rebirth: " .. C;
	end;
end;
task.spawn(function()
	while K and K.Parent do
		TT();
		task.wait(1);
	end;
end);
local VT = Instance.new("TextLabel");
VT.Size = UDim2.new(1, -10, 0, 70);
VT.Position = UDim2.new(0, 0, 0, 250);
VT.BackgroundColor3 = Color3.fromRGB(24, 24, 30);
VT.BorderSizePixel = 0;
VT.Text = "Rates are calculated from this session.\nStrength counts cumulative gains, including strength earned before rebirth.\nShort sessions may show 0 until enough data is collected.";
VT.TextColor3 = Color3.fromRGB(150, 150, 170);
VT.Font = Enum.Font.Gotham;
VT.TextSize = 11;
VT.TextXAlignment = Enum.TextXAlignment.Left;
VT.TextYAlignment = Enum.TextYAlignment.Center;
VT.Parent = wq;
(Instance.new("UICorner", VT)).CornerRadius = UDim.new(0, 8);
local kT = Instance.new("UIPadding", VT);
kT.PaddingLeft = UDim.new(0, 12);
local vT = Instance.new("ScrollingFrame");
vT.Name = "Settings";
vT.Size = UDim2.new(1, -20, 1, -50);
vT.Position = UDim2.new(0, 10, 0, 45);
vT.BackgroundTransparency = 1;
vT.BorderSizePixel = 0;
vT.ScrollBarThickness = 4;
vT.ScrollingEnabled = true;
vT.Active = true;
vT.CanvasSize = UDim2.new(0, 0, 0, 390);
vT.Visible = false;
vT.Parent = Rq;
Aq.Settings = vT;
local OT = Instance.new("TextLabel");
OT.Size = UDim2.new(1, 0, 0, 28);
OT.BackgroundTransparency = 1;
OT.Text = "Settings";
OT.TextColor3 = Color3.fromRGB(255, 255, 255);
OT.Font = Enum.Font.GothamBold;
OT.TextSize = 20;
OT.TextXAlignment = Enum.TextXAlignment.Left;
OT.Parent = vT;
local pT = Instance.new("TextLabel");
pT.Size = UDim2.new(1, 0, 0, 18);
pT.Position = UDim2.new(0, 0, 0, 28);
pT.BackgroundTransparency = 1;
pT.Text = "Performance, UI and stability";
pT.TextColor3 = Color3.fromRGB(140, 140, 160);
pT.Font = Enum.Font.Gotham;
pT.TextSize = 12;
pT.TextXAlignment = Enum.TextXAlignment.Left;
pT.Parent = vT;
local DT = setmetatable({}, { __mode = "k" });
local GT = false;
local function FT(s)
	GT = s == true;
	for h, P in ipairs(workspace:GetDescendants()) do
		if P:IsA("ParticleEmitter") or P:IsA("Trail") or P:IsA("Beam") or P:IsA("Fire") or P:IsA("Smoke") or P:IsA("Sparkles") or P:IsA("PointLight") or P:IsA("SpotLight") or P:IsA("SurfaceLight") or P:IsA("Highlight") then
			if DT[P] == nil then
				DT[P] = P.Enabled;
			end;
			pcall(function()
				P.Enabled = not s;
			end);
		elseif P:IsA("BasePart") then
			if DT[P] == nil then
				DT[P] = P.CastShadow;
			end;
			pcall(function()
				P.CastShadow = not s;
			end);
		end;
	end;
	if not s then
		for s, h in pairs(DT) do
			if s and s.Parent then
				pcall(function()
					s.Enabled = h;
				end);
				pcall(function()
					s.CastShadow = h;
				end);
			end;
			DT[s] = nil;
		end;
	end;
end;
mq(vT, 58, "PERFORMANCE");
Hq(vT, 82, "Performance Mode", "Reduce particulas, luces, highlights y sombras", false, FT);
Hq(vT, 145, "Stable UI", "Reduce animaciones visuales para bajar trabajo del cliente", true, function(s)
	_G.ARGZxStableUI = s;
end);
mq(vT, 210, "FARM STABILITY");
local AT = Instance.new("TextLabel");
AT.Size = UDim2.new(1, -10, 0, 70);
AT.Position = UDim2.new(0, 0, 0, 234);
AT.BackgroundColor3 = Color3.fromRGB(24, 24, 30);
AT.BorderSizePixel = 0;
AT.Text = "OP Farm target: 800 reps/s\nThe client sends in controlled batches; server limits may still apply.\nFast Rebirth order: Speed -> Farm -> Packs -> Rebirth -> Golems";
AT.TextColor3 = Color3.fromRGB(155, 155, 175);
AT.Font = Enum.Font.Gotham;
AT.TextSize = 12;
AT.TextXAlignment = Enum.TextXAlignment.Left;
AT.TextYAlignment = Enum.TextYAlignment.Center;
AT.Parent = vT;
(Instance.new("UICorner", AT)).CornerRadius = UDim.new(0, 8);
local qT = Instance.new("UIPadding", AT);
qT.PaddingLeft = UDim.new(0, 12);
local function ET(s, h)
	local P = s:FindFirstChildOfClass("UIListLayout");
	if P then
		local function I()
			s.CanvasSize = UDim2.new(0, 0, 0, P.AbsoluteContentSize.Y + ((h or 16)));
		end;
		(P:GetPropertyChangedSignal("AbsoluteContentSize")):Connect(I);
		I();
	end;
end;
ET(jq, 24);
ET(rq, 24);
ET(wq, 24);
ET(vT, 24);
k.InputBegan:Connect(function(s, h)
	if h then
		return;
	end;
	if s.KeyCode == Enum.KeyCode.RightControl then
		if u.Visible then
			u.Visible = false;
			Nq.Visible = true;
		else
			Nq.Visible = false;
			u.Visible = true;
		end;
	end;
end);
a:UpdateUi();
print("ARGZx GUI + Auto Boss loaded");
