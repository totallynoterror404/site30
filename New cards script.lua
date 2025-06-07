-- Stable support (Version 1.0.0)
-- This script is designed to work with the SCP:SL card system.
-- It now supports O5 cards, Facility Manager cards, Guard cards, MTF cards, Scientist cards, Janitor cards, and CI cards.

local tweenservice = game:GetService("TweenService")

local clearance = { 
	["05Card"] = true, 
	["FacilityManagerCard"] = true,
	["GuardCard"] = true,
	["MTFCard"] = true,
	["ScientistCard"] = true,
	["JanitorCard"] = true
	["CICard"] = true
	["SrScientist"] = true
	["GOC_Card"] = true 
}



local door1 = script.Parent.Door1
local door2 = script.Parent.Door2



local tweensettings = {
	opendoor = TweenInfo.new(1.3,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),
	closedoor = TweenInfo.new(1.3,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),
	door1open = {CFrame = door1.CFrame * CFrame.new(3.5,0,0)},
	door2open = {CFrame = door2.CFrame * CFrame.new(3.5,0,0)},
	door1close = {CFrame = door1.CFrame},
	door2close = {CFrame = door2.CFrame}


}

local door1open = tweenservice:Create(door1,tweensettings.opendoor,tweensettings.door1open)
local door2open = tweenservice:Create(door2,tweensettings.opendoor,tweensettings.door2open)


local door1close = tweenservice:Create(door1,tweensettings.closedoor,tweensettings.door1close)
local door2close = tweenservice:Create(door2,tweensettings.closedoor,tweensettings.door2close)


local scanner1 = script.Parent.scanner1
local scanner2 = script.Parent.scanner2

local debounce = false
local opened = false
local cooldown = false


scanner1.Touched:Connect(function(hit)
	if hit.Name == "Handle" and clearance[hit.Parent.Name] then
		if not debounce and not opened then
			debounce = true
			script.Parent.KeycardAccepted:Play()
			script.Parent.Door1["Open" .. math.random(1,3)]:Play()
			door1open:Play()
			door2open:Play()
			opened = true

			wait(5)

			if opened then
				script.Parent.Door1["Close" .. math.random(1,3)]:Play()
				door1close:Play()
				door2close:Play()
				opened = false
			end

			debounce = false
		elseif not debounce and opened then
			debounce = true
			script.Parent.KeycardAccepted:Play()
			script.Parent.Door1["Close" .. math.random(1,3)]:Play()
			door1close:Play()
			door2close:Play()
			opened = false
			debounce = false
		end
	elseif hit.Name == "Handle" and not clearance[hit.Parent.Name] then
		if not cooldown then
			cooldown = true
			script.Parent.KeycardDenied:Play()
			wait(5)
			cooldown = false
		end
	end
end)

scanner2.Touched:Connect(function(hit)
	if hit.Name == "Handle" and clearance[hit.Parent.Name] then
		if not debounce and not opened then
			debounce = true
			script.Parent.KeycardAccepted:Play()
			script.Parent.Door1["Open" .. math.random(1,3)]:Play()
			door1open:Play()
			door2open:Play()
			opened = true

			wait(5)

			if opened then
				script.Parent.Door1["Close" .. math.random(1,3)]:Play()
				door1close:Play()
				door2close:Play()
				opened = false
			end

			debounce = false
		elseif not debounce and opened then
			debounce = true
			script.Parent.KeycardAccepted:Play()
			script.Parent.Door1["Close" .. math.random(1,3)]:Play()
			door1close:Play()
			door2close:Play()
			opened = false
			debounce = false
		end
	elseif hit.Name == "Handle" and not clearance[hit.Parent.Name] then
		if not cooldown then
			cooldown = true
			script.Parent.KeycardDenied:Play()
			wait(5)
			cooldown = false
		end
	end
end)