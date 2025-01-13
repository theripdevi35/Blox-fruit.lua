local localPlayer = game:GetService("Players").LocalPlayer
local npcFolder = workspace:WaitForChild("NPCs") -- Adjusted for Blox Fruits NPCs
local Remote = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("MainEvent")
local chestFolder = workspace:WaitForChild("Chests")
local fruitsFolder = localPlayer:WaitForChild("Backpack")

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()

local Window = Library:NewWindow("Blox Fruits Hub")

-- OP THINGS SECTION
local Section = Window:NewSection("OP THINGS")

-- Collect All Chests
Section:CreateButton("Collect All Chests", function()
    for _, chest in ipairs(chestFolder:GetChildren()) do
        if chest:IsA("BasePart") then
            firetouchinterest(localPlayer.Character.HumanoidRootPart, chest, 0)
            firetouchinterest(localPlayer.Character.HumanoidRootPart, chest, 1)
        end
    end
end)

-- Kill All NPCs
Section:CreateButton("Kill All NPCs", function()
    for _, npc in ipairs(npcFolder:GetChildren()) do
        if npc:IsA("Model") and npc:FindFirstChild("Humanoid") then
            Remote:FireServer("DamageNPC", {
                Target = npc,
                Damage = 9999,
                Weapon = "Melee"
            })
        end
    end
end)

-- Fling All NPCs
Section:CreateButton("Fling All NPCs", function()
    for _, npc in ipairs(npcFolder:GetChildren()) do
        if npc:IsA("Model") and npc:FindFirstChild("HumanoidRootPart") then
            npc.HumanoidRootPart.Velocity = Vector3.new(0, 1000, 0)
        end
    end
end)

-- FRUITS SECTION
local Section = Window:NewSection("FRUITS")

-- Spawn Fruit Dropdown
Section:CreateDropdown("Select Fruit", {
    "Dragon (West)", "Dragon (East)", "Leopard", "Dough", "Magma", "Venom", "Light", "Ice", "Phoenix", "Gravity"
}, 1, function(selectedFruit)
    Remote:FireServer("SpawnFruit", {
        FruitName = selectedFruit,
        Backpack = localPlayer.Backpack
    })
end)

-- INF MASTERY SECTION
local Section = Window:NewSection("INF MASTERY")

-- Max Mastery for All Fruits
Section:CreateButton("Max Mastery All Fruits", function()
    for _, fruit in ipairs(fruitsFolder:GetChildren()) do
        Remote:FireServer("GrantMastery", {
            Player = localPlayer,
            Tool = fruit,
            MasteryEXP = 99999999
        })
    end
end)
