-- Clearance proxy
local ts = game:GetService("TweenService")

local clearance = {
	["[SCP] Card-Omni"] = true, 
	["[SCP] Card-L5"] = true, 
	["[SCP] Card-L4"] = true,
	["[SCP] Card-L3"] = false,
	["[SCP] Card-L2"] = false,
	["[SCP] Card-L1"] = false,
	["[SCP] Card-L0"] = false
}

local d1, d2 = script.Parent.Door1, script.Parent.Door2
local tws = {
	open = TweenInfo.new(1.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
	close = TweenInfo.new(1.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
	d1o = {CFrame = d1.CFrame * CFrame.new(3.5, 0, 0)},
	d2o = {CFrame = d2.CFrame * CFrame.new(3.5, 0, 0)},
	d1c = {CFrame = d1.CFrame},
	d2c = {CFrame = d2.CFrame}
}
local d1o, d2o, d1c, d2c = ts:Create(d1, tws.open, tws.d1o), ts:Create(d2, tws.open, tws.d2o), ts:Create(d1, tws.close, tws.d1c), ts:Create(d2, tws.close, tws.d2c)
local s1, s2, db, op, cd = script.Parent.scanner1, script.Parent.scanner2, false, false, false

local function getPlayer(userId)
	for _, p in ipairs(game:GetService("Players"):GetPlayers()) do
		if p.UserId == userId then
			return p
		end
	end
end

local function hasValidCard(player)
	local bp, ch = player:FindFirstChild("Backpack"), player:FindFirstChild("Character")
	if ch then
		for _, t in ipairs(ch:GetChildren()) do
			if t:IsA("Tool") and clearance[t.Name] then
				return true
			end
		end
	end
	if bp then
		for _, t in ipairs(bp:GetChildren()) do
			if t:IsA("Tool") and clearance[t.Name] then
				return true
			end
		end
	end
	return false
end

local function handleDoors(player)
	if not db and not op then
		db = true
		script.Parent.KeycardAccepted:Play()
		script.Parent.Door1["Open" .. math.random(1, 3)]:Play()
		d1o:Play()
		d2o:Play()
		op = true
		task.wait(5)
		if op then
			script.Parent.Door1["Close" .. math.random(1, 3)]:Play()
			d1c:Play()
			d2c:Play()
			op = false
		end
		db = false
	elseif not db and op then
		db = true
		script.Parent.KeycardAccepted:Play()
		script.Parent.Door1["Close" .. math.random(1, 3)]:Play()
		d1c:Play()
		d2c:Play()
		op = false
		db = false
	end
end

s1.ProximityPrompt.Triggered:Connect(function(promptee)
	local player = getPlayer(promptee.UserId)
	if player and hasValidCard(player) then
		handleDoors(player)
	else
		script.Parent.KeycardDenied:Play()
	end
end)

s2.ProximityPrompt.Triggered:Connect(function(promptee)
	local player = getPlayer(promptee.UserId)
	if player and hasValidCard(player) then
		handleDoors(player)
	else
		script.Parent.KeycardDenied:Play()
	end
end)

