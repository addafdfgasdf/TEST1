-- Сервисы
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- Пути
local gameFolder = Workspace:WaitForChild("#GAME", 10)
local foldersFolder = gameFolder and gameFolder:WaitForChild("Folders", 5)
local humanoidFolder = foldersFolder and foldersFolder:WaitForChild("HumanoidFolder", 5)
local NPCFolder = humanoidFolder and humanoidFolder:WaitForChild("NPCFolder", 5)

local eventsFolder = ReplicatedStorage:WaitForChild("Events", 10)
local MainAttackEvent = eventsFolder and eventsFolder:WaitForChild("MainAttack", 5)

local function getGun()
    return gameFolder and gameFolder:FindFirstChild("Folders") 
        and gameFolder.Folders:FindFirstChild("AccessoryFolder") 
        and gameFolder.Folders.AccessoryFolder:FindFirstChild("The Eggsterminator")
end

-- 🔍 Проверка: "живая" ли часть (не оторвана, не едят)
local function isDeadPart(part)
    if not part or not part.Parent then return true end
    if not part:IsDescendantOf(Workspace) then return true end
    if part:GetAttribute("IsGettingEaten") then return true end
    return false
end

-- 🔍 Получаем список NPC, по которым можно стрелять
local function getValidTargets()
    local validTargets = {}
    if not NPCFolder then return validTargets end

    for _, npc in ipairs(NPCFolder:GetChildren()) do
        if not npc:IsA("Model") then continue end

        -- Игнорируем по имени
        if string.find(npc.Name, "Dead", 1, true) or npc.Name == "CrackedBas" then
            continue
        end

        -- Проверяем жив ли NPC
        local humanoid = npc:FindFirstChildOfClass("Humanoid")
        if not humanoid or humanoid.Health <= 0 then
            continue
        end

        -- Ищем HumanoidRootPart (или Torso / UpperTorso)
        local targetPart = npc:FindFirstChild("HumanoidRootPart")
            or npc:FindFirstChild("Torso")
            or npc:FindFirstChild("UpperTorso")

        if targetPart and not isDeadPart(targetPart) then
            table.insert(validTargets, {
                NPC = npc,
                Part = targetPart
            })
        end
    end

    return validTargets
end

-- Позиция выстрела
local function getShootOrigin()
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    return hrp and hrp.Position + Vector3.new(0, 2, 0) or Camera.CFrame.Position
end

-- Основная функция
local function autoShoot()
    if not LocalPlayer.Character or not MainAttackEvent then return end

    local gun = getGun()
    if not gun then return end

    -- Получаем валидные цели с живым HumanoidRootPart
    local validTargets = getValidTargets()
    if #validTargets == 0 then return end

    -- Выбираем цель по приоритету (Amethyst, Ruby и т.д.)
    local priorityNames1 = { "Amethyst", "Ruby", "Emerald", "Diamond" }
    local priorityNames2 = { "d" }

    local function findPriority(list, keywords)
        for _, keyword in ipairs(keywords) do
            for _, target in ipairs(list) do
                if target.NPC.Name:find(keyword, 1, true) then
                    return target
                end
            end
        end
        return nil
    end

    local chosen = findPriority(validTargets, priorityNames1)
        or findPriority(validTargets, priorityNames2)

    -- Если нет приоритетной — случайная
    if not chosen then
        chosen = validTargets[math.random(1, #validTargets)]
    end

    local npc = chosen.NPC
    local targetPart = chosen.Part
    local origin = getShootOrigin()
    local direction = (targetPart.Position - origin).Unit

    -- Защита от NaN
    if not direction or direction.Magnitude == 0 or tostring(direction) == "NaN, NaN, NaN" then
        direction = Camera.CFrame.LookVector
    end

    -- 1. Выстрел: The Eggsterminator
    local shootArgs = {
        {
            A = LocalPlayer.Character,
            AN = "The Eggsterminator",
            O = origin,
            D = direction,
            T = gun,
            SP = origin,
            HP = targetPart.Position,
            RS = origin
        }
    }
    MainAttackEvent:FireServer(unpack(shootArgs))

    -- 2. Взрыв: The EggsterminatorExplode
    spawn(function()
        wait(0.1)
        local explodeArgs = {
            {
                ALV = origin,
                A = LocalPlayer.Character,
                AN = "The EggsterminatorExplode",
                EP = targetPart.Position
            }
        }
        MainAttackEvent:FireServer(unpack(explodeArgs))
        print(`💥 Взрыв по {npc.Name} в {targetPart.Position}`)
    end)
end

-- Цикл
while true do
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        pcall(autoShoot)
    end
    wait(0.1)
end
