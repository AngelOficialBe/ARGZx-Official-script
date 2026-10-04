-- ARGZx Ping Control Integration
-- Apply to your existing ARGZx-Update.lua.
-- This module is intentionally standalone: it does not alter remotes or attempt to
-- falsify/force network latency. It adapts client-side farming load.

local ARGZxPing = {}

local Stats = game:GetService("Stats")
local Workspace = game:GetService("Workspace")

ARGZxPing.Enabled = true
ARGZxPing.PingReducer = false
ARGZxPing.PING_GOOD = 180
ARGZxPing.PING_STABLE = 250
ARGZxPing.PING_HIGH = 500
ARGZxPing.PING_CRITICAL = 1000
ARGZxPing.CheckInterval = 0.75

ARGZxPing.CurrentPing = 0
ARGZxPing.State = "Unknown"
ARGZxPing.Paused = false

function ARGZxPing:GetPing()
    local ok, result = pcall(function()
        local network = Stats:FindFirstChild("Network")
        local serverStats = network and network:FindFirstChild("ServerStatsItem")
        local dataPing = serverStats and serverStats:FindFirstChild("Data Ping")
        if not dataPing then return nil end
        return tonumber(string.match(dataPing:GetValueString(), "%d+"))
    end)
    return ok and result or nil
end

function ARGZxPing:GetState(ping)
    if not ping then return "Unknown" end
    if ping <= self.PING_GOOD then return "Excellent" end
    if ping <= self.PING_STABLE then return "Stable" end
    if ping <= self.PING_HIGH then return "High" end
    return "Critical"
end

-- Returns a conservative client-side multiplier. It does not increase request
-- rates beyond the rate already chosen by the script.
function ARGZxPing:GetMultiplier()
    if not self.Enabled then return 1 end
    local p = self.CurrentPing
    if p <= 0 then return 1 end
    if p <= self.PING_GOOD then return 1 end
    if p <= self.PING_STABLE then return 0.80 end
    if p <= self.PING_HIGH then return 0.55 end
    if p <= self.PING_CRITICAL then return 0.30 end
    return 0
end

function ARGZxPing:Start(onCriticalPause, onResume)
    task.spawn(function()
        while true do
            task.wait(self.CheckInterval)

            if not self.Enabled then
                self.State = "Disabled"
                self.Paused = false
                continue
            end

            local ping = self:GetPing()
            if ping then
                self.CurrentPing = ping
                self.State = self:GetState(ping)

                if ping >= self.PING_CRITICAL and not self.Paused then
                    self.Paused = true
                    if onCriticalPause then
                        pcall(onCriticalPause)
                    end
                elseif self.Paused and ping <= self.PING_STABLE then
                    self.Paused = false
                    if onResume then
                        pcall(onResume)
                    end
                end
            end
        end
    end)
end

-- Optional client visual optimization used by "Ping Reducer".
local saved = setmetatable({}, {__mode = "k"})

function ARGZxPing:SetPingReducer(enabled)
    self.PingReducer = enabled == true

    if self.PingReducer then
        for _, obj in ipairs(Workspace:GetDescendants()) do
            local prop
            if obj:IsA("ParticleEmitter") or obj:IsA("Trail")
                or obj:IsA("Beam") or obj:IsA("Fire")
                or obj:IsA("Smoke") or obj:IsA("Sparkles")
                or obj:IsA("PointLight") or obj:IsA("SpotLight")
                or obj:IsA("SurfaceLight") or obj:IsA("Highlight") then
                prop = "Enabled"
            elseif obj:IsA("BasePart") then
                prop = "CastShadow"
            end

            if prop and saved[obj] == nil then
                saved[obj] = {property = prop, value = obj[prop]}
                pcall(function() obj[prop] = false end)
            end
        end
    else
        for obj, data in pairs(saved) do
            if obj and obj.Parent then
                pcall(function() obj[data.property] = data.value end)
            end
            saved[obj] = nil
        end
    end
end

return ARGZxPing
