local function Main()
    local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Nuke Tycoon Nuclear",
   Icon = 0,
   LoadingTitle = "Nuke Tycoon Nuclear",
   LoadingSubtitle = "by Minecrafteksperten",
   Theme = "Amethyst",
   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false,
   ConfigurationSaving = {
      Enabled = false,
      FolderName = nil,
      FileName = "Big Hub"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
   },
   KeySystem = false,
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided",
      FileName = "Key",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"Hello"}
   }
})

local Tab = Window:CreateTab("Main", 4483362458)
local Section = Tab:CreateSection("Main")

local base = tonumber(game.Players.LocalPlayer.Team.Name:match("%d"))

local Button = Tab:CreateButton({
   Name = "Auto Collect Cash",
   Callback = function()
    local Players = game.Players
    local player = Players.LocalPlayer
    local p = workspace["The Nuke Tycoon Entirely Model"].Tycoons["Base " ..base].Essentials.Giver

    local function start()
        local character = player.Character or player.CharacterAdded:Wait()
        local h = character:WaitForChild("HumanoidRootPart")

        while character and character.Parent do
            firetouchinterest(h, p, 0)
            wait(0.2)
            firetouchinterest(h, p, 1)
            wait(1)
        end
    end

    start()

    player.CharacterAdded:Connect(function()
        start()
    end)
   end,
})

local Button = Tab:CreateButton({
   Name = "Auto Dropper",
   Callback = function()
   while wait(0.1) do
    fireclickdetector(workspace["The Nuke Tycoon Entirely Model"].Tycoons["Base " .. base].PurchasedObjects.Mine.Clicker.ClickDetector)
    end
   end,
})

local Button = Tab:CreateButton({
   Name = "Auto Buy Buttons",
   Callback = function()
   local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

local baseName = "Base " .. tostring(base)
local tycoonButtons = workspace:WaitForChild("The Nuke Tycoon Entirely Model"):WaitForChild("Tycoons"):WaitForChild(baseName):WaitForChild("Buttons")

local function fireAllButtons()
    for _, buttonModel in ipairs(tycoonButtons:GetChildren()) do
        local acsNoDamagePart = buttonModel:FindFirstChild("ACS_NoDamage")
        if acsNoDamagePart and acsNoDamagePart:FindFirstChild("TouchInterest") then
            firetouchinterest(hrp, acsNoDamagePart, 1)
            wait(0.1)
            firetouchinterest(hrp, acsNoDamagePart, 0)
        end
    end
end

while true do
    fireAllButtons()
    wait(5)
end

   end,
})

local Button = Tab:CreateButton({
   Name = "Claim Center",
   Callback = function()
   local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local function touchCycle()
    while true do
        firetouchinterest(character.HumanoidRootPart, workspace.Point1.Point, 0)
        wait(0.1)
        firetouchinterest(character.HumanoidRootPart, workspace.Point1.Point, 1)
        wait(1)
    end
end

character:WaitForChild("HumanoidRootPart")
touchCycle()

player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    character:WaitForChild("HumanoidRootPart")
    touchCycle()
end)

   end,
})

local Button = Tab:CreateButton({
   Name = "Disable Middle Popups (Reccomended with Auto Dropper)",
   Callback = function()
   local Players = game:GetService("Players")
   local player = Players.LocalPlayer

   local function destroyMiddlePopups()
       local gui = player:FindFirstChild("PlayerGui")
       if gui then
           local main = gui:FindFirstChild("Main")
           if main then
               local popup = main:FindFirstChild("MiddlePopups")
               if popup then
                   popup:Destroy()
               end
           end
       end
   end

   local function onCharacterAdded(character)
       task.delay(0.1, destroyMiddlePopups)
   end

   destroyMiddlePopups()
   player.CharacterAdded:Connect(onCharacterAdded)
   end,
})

local Button = Tab:CreateButton({
   Name = "Remove Collect particles",
   Callback = function()
   local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local workspace = game:GetService("Workspace")

-- Function to move CollectOrb parts to an off-screen location and then remove them
local function moveAndRemoveCollectOrb(obj)
	if obj:IsA("BasePart") and obj.Name == "CollectOrb" then
		-- Move the CollectOrb out of view by setting its CFrame
		obj.CFrame = CFrame.new(1, 1, 1)

		-- Delay for 0.5 seconds and then remove the part
		wait(0.5)
		obj:Destroy()
	end
end

-- Function to remove SpawnEffect particles from the HumanoidRootPart
local function removeSpawnEffect(hrp)
	for _, obj in ipairs(hrp:GetChildren()) do
		if obj:IsA("ParticleEmitter") and obj.Name == "SpawnEffect" then
			-- Set the texture to make the particles invisible
			obj.Texture = "rbxassetid://0"
		end
	end

	-- Watch for new SpawnEffect particles added to the HumanoidRootPart
	hrp.ChildAdded:Connect(function(child)
		if child:IsA("ParticleEmitter") and child.Name == "SpawnEffect" then
			-- Set the texture to make the particles invisible
			child.Texture = "rbxassetid://0"
		end
	end)
end

-- Monitor LocalPlayer's character for HumanoidRootPart and its SpawnEffect particles
local function monitorCharacter(character)
	local hrp = character:FindFirstChild("HumanoidRootPart")
	if hrp then
		removeSpawnEffect(hrp)
	else
		character.ChildAdded:Connect(function(child)
			if child.Name == "HumanoidRootPart" then
				removeSpawnEffect(child)
			end
		end)
	end
end

-- Watch for CollectOrb parts in the workspace
local function monitorCollectOrbs()
	for _, obj in ipairs(workspace:GetDescendants()) do
		if obj:IsA("BasePart") and obj.Name == "CollectOrb" then
			-- Move and remove CollectOrb parts
			moveAndRemoveCollectOrb(obj)
		end
	end

	-- Listen for new CollectOrbs being added
	workspace.DescendantAdded:Connect(function(descendant)
		if descendant:IsA("BasePart") and descendant.Name == "CollectOrb" then
			moveAndRemoveCollectOrb(descendant)
		end
	end)
end

-- Start watching CollectOrbs in the workspace
monitorCollectOrbs()

-- Monitor the LocalPlayer's character for SpawnEffect particles
if LocalPlayer.Character then
	monitorCharacter(LocalPlayer.Character)
end
LocalPlayer.CharacterAdded:Connect(monitorCharacter)

   end,
})

local Button = Tab:CreateButton({
   Name = "Disable Buy Cash Popup",
   Callback = function()
   local Players = game:GetService("Players")
   local player = Players.LocalPlayer

   local function destroyBuyUi()
       local gui = player:FindFirstChild("PlayerGui")
       if gui then
           local buy = gui:FindFirstChild("BuyGui")
           if buy then
               local popup = buy:FindFirstChild("Button")
               if popup then
                   popup:Destroy()
               end
           end
       end
   end

   local function onCharacterAdded(character)
       task.delay(0.5, destroyBuyUi)
   end

   destroyBuyUi()
   player.CharacterAdded:Connect(onCharacterAdded)
   end,
})

local Button = Tab:CreateButton({
   Name = "Instant Proximity Prompt",
   Callback = function()
    for _, prom in next, workspace:GetDescendants() do
        if prom:IsA("ProximityPrompt") then
            prom.PromptButtonHoldBegan:Connect(function()
                if prom.HoldDuration <= 0 then return end
                fireproximityprompt(prom, 0)
            end)
        end
    end

    workspace.DescendantAdded:Connect(function(class)
        if class:IsA("ProximityPrompt") then
            class.PromptButtonHoldBegan:Connect(function()
                if class.HoldDuration <= 0 then return end
                fireproximityprompt(class, 0)
            end)
        end
    end)
   end,
})

local Button = Tab:CreateButton({
   Name = "Auto Gem Collect (Buggy/Experimental Right Control to Toggle)",
   Callback = function()
    local Players = game:GetService("Players")
    local StarterGui = game:GetService("StarterGui")
    local UserInputService = game:GetService("UserInputService")

    local player = Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local workspace = game:GetService("Workspace")
    local robbingFolder = workspace:WaitForChild("RobbingFolder")

    local savedCFrame = nil
    local alreadyTeleported = false
    local enabled = true
    local skipBaseNumber = base

    StarterGui:SetCore("SendNotification", {
        Title = "Loaded",
        Text = "Made by Minecrafteksperten",
        Duration = 5
    })

    local function getHRP()
        return character:FindFirstChild("HumanoidRootPart")
    end

    local function isSitting()
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            return humanoid.Sit
        else
            return false
        end
    end

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.RightControl then
            enabled = not enabled

            local title = enabled and "Toggled On" or "Toggled Off"
            StarterGui:SetCore("SendNotification", {
                Title = title,
                Text = "Press Right Control to Toggle",
                Duration = 5
            })
        end
    end)

    while true do
        task.wait(1)

        if not enabled or alreadyTeleported then continue end

        for i = 1, 6 do
            if skipBaseNumber == i then
                continue
            end

            local base = robbingFolder:FindFirstChild("Base " .. i)
            if base then
                local chosen = base:FindFirstChild("Chosen")
                if chosen and chosen:IsA("BoolValue") and chosen.Value == true then
                    local hrp = getHRP()

                    if isSitting() then
                        continue
                    end

                    if hrp then
                        savedCFrame = hrp.CFrame
                        alreadyTeleported = true

                        local gems = base:FindFirstChild("Gems")
                        if gems and gems:IsA("Model") then
                            local targetPart = gems:FindFirstChild("Part")
                            if targetPart and targetPart:IsA("BasePart") then
                                hrp.CFrame = targetPart.CFrame + Vector3.new(0, 3, 0)
                                wait(0.2)
                                fireproximityprompt(gems.Parent.ProximityPrompt)
                            end
                        end

                        while chosen.Value == true do
                            task.wait(0.1)
                        end

                        task.wait(0.1)

                        if savedCFrame then
                            local updatedHRP = getHRP()
                            if updatedHRP then
                                updatedHRP.CFrame = savedCFrame
                            end
                        end

                        alreadyTeleported = false
                        break
                    end
                end
            end
        end
    end
    wait(2)
   end,
})

local Button = Tab:CreateButton({
   Name = "Rob everyone (Development)",
   Callback = function()
   local Players = game.Players
local player = Players.LocalPlayer

local function start()
    local character = player.Character or player.CharacterAdded:Wait()
    local h = character:WaitForChild("HumanoidRootPart")

    while character and character.Parent do
        for otherBase = 1, 6 do
            local giverPath = workspace:FindFirstChild("The Nuke Tycoon Entirely Model")
            if giverPath then
                local tycoon = giverPath:FindFirstChild("Tycoons")
                if tycoon then
                    local base = tycoon:FindFirstChild("Base " .. otherBase)
                    if base then
                        local p = base:FindFirstChild("Essentials")
                        if p and p:FindFirstChild("Giver") then
                            local giver = p.Giver
                            firetouchinterest(h, giver, 0)
                            wait(0.05)
                            firetouchinterest(h, giver, 1)
                        end
                    end
                end
            end
        end
        wait(0.05)
    end
end

start()

player.CharacterAdded:Connect(function()
    start()
end)

   end,
})

local Tab = Window:CreateTab("Teleports", 4483362458)
local Section = Tab:CreateSection("Teleports")

local baseTp = 0

local Slider = Tab:CreateSlider({
   Name = "Tp Base Number",
   Range = {1, 6},
   Increment = 1,
   Suffix = "",
   CurrentValue = 0,
   Flag = "GotoBaseSlider",
   Callback = function(Value)
      baseTp = Value
   end,
})

local Button = Tab:CreateButton({
   Name = "Go to Base",
   Callback = function()
      if baseTp >= 1 and baseTp <= 6 then
         local tobase = workspace["The Nuke Tycoon Entirely Model"].Tycoons:FindFirstChild("Base " .. baseTp)

         if tobase then
            local spawn = tobase:WaitForChild("Essentials"):WaitForChild("Spawn")
            local hrp = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
            if hrp then
               hrp.CFrame = spawn.CFrame
            end
         else
            warn("Base " .. baseTp .. " not found.")
         end
      else
         warn("Invalid baseTp value: " .. baseTp)
      end
   end,
})

local Button = Tab:CreateButton({
   Name = "Home",
   Callback = function()
      if base >= 1 and base <= 6 then
         local tobase = workspace["The Nuke Tycoon Entirely Model"].Tycoons:FindFirstChild("Base " .. base)

         if tobase then
            local spawn = tobase:WaitForChild("Essentials"):WaitForChild("Spawn")
            local hrp = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
            if hrp then
               hrp.CFrame = spawn.CFrame
            end
         else
            warn("Base " .. base .. " not found.")
         end
      else
      print("Please select a base in main before using this!")
      end
   end,
})

local Button = Tab:CreateButton({
   Name = "Volcano",
   Callback = function()
   local h = game.Players.LocalPlayer.Character.HumanoidRootPart
   local v = workspace.Badge_Giver

   h.CFrame = v.CFrame
   end,
})

local Tab = Window:CreateTab("Misc", 4483362458)
local Section = Tab:CreateSection("Misc")

local Button = Tab:CreateButton({
   Name = "Infinite Yeild",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
   end,
})

local Button = Tab:CreateButton({
   Name = "Anti Fall Damage",
   Callback = function()
    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local player = Players.LocalPlayer

    local function destroyDamageEvent()
        local damageEvent = ReplicatedStorage:FindFirstChild("ACS_Engine")
        if damageEvent then
            local events = damageEvent:FindFirstChild("Events")
            if events then
                local damage = events:FindFirstChild("Damage")
                if damage then
                    damage:Destroy()
                end
            end
        end
    end

    local function onCharacterAdded(character)
        task.delay(0.1, destroyDamageEvent)
    end

    destroyDamageEvent()
    player.CharacterAdded:Connect(onCharacterAdded)
   end,
})

local Button = Tab:CreateButton({
   Name = "Rebirth (Requires 100% and cash)",
   Callback = function()
   -- Function to repeatedly fire the RebirthEvent every second
local function fireRebirthEvent()
    while true do
        -- Fire the event with the local player
        game:GetService("ReplicatedStorage"):WaitForChild("RebirthEvent"):FireServer(game.Players.LocalPlayer)
        
        -- Wait for 1 second before firing again
        wait(1)
    end
end

-- Event listener to restart the loop after the player's character respawns
game.Players.LocalPlayer.CharacterAdded:Connect(function()
    -- Start the loop when the character is added (on respawn)
    fireRebirthEvent()
end)

-- Start the loop immediately if the player already has a character
if game.Players.LocalPlayer.Character then
    fireRebirthEvent()
end

   end,
})
end

if game.Players.LocalPlayer.Name == "VortexFlashSkater" then
    Main()
end
