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

-- Проверка: "живая" ли часть (не оторвана, не едят)
local function isDeadPart(part)
    if not part or not part.Parent then return true end
    if not part:IsDescendantOf(Workspace) then return true end
    if part:GetAttribute("IsGettingEaten") then return true end
    return false
end

-- Получаем ближайшего подходящего NPC
local function getNearestValidTarget()
    if not NPCFolder then return nil end

    local closestTarget = nil
    local closestDist = math.huge

    local myHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    local myPos = myHrp and myHrp.Position or Camera.CFrame.Position

    -- Приоритетные имена
    local priorityNames1 = { "Amethyst", "Ruby", "Emerald", "Diamond", "BULL" }
    local priorityNames2 = { "Golden" }

    -- Функция проверки приоритета
    local function getPriority(npcName)
        for _, name in ipairs(priorityNames1) do
            if npcName:find(name, 1, true) then return 1 end
        end
        for _, name in ipairs(priorityNames2) do
            if npcName:find(name, 1, true) then return 2 end
        end
        return 3 -- обычный
    end

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

        -- Ищем центральную часть
        local targetPart = npc:FindFirstChild("HumanoidRootPart")
            or npc:FindFirstChild("Torso")
            or npc:FindFirstChild("UpperTorso")

        if not targetPart or isDeadPart(targetPart) then
            continue
        end

        -- Расстояние
        local dist = (targetPart.Position - myPos).Magnitude

        -- Приоритет + расстояние
        local priority = getPriority(npc.Name)

        -- Выбираем ближайший ИЛИ приоритетный
        if dist < closestDist or (priority < (closestTarget and getPriority(closestTarget.NPC.Name) or 3)) then
            closestDist = dist
            closestTarget = {
                NPC = npc,
                Part = targetPart,
                Priority = priority
            }
        end
    end

    return closestTarget
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

    -- Получаем ближайшую валидную цель
    local target = getNearestValidTarget()
    if not target then return end

    local npc = target.NPC
    local targetPart = target.Part
    local origin = getShootOrigin()
    local direction = (targetPart.Position - origin).Unit

    -- Защита от NaN
    if not direction or direction.Magnitude == 0 or tostring(direction) == "NaN, NaN, NaN" then
        direction = Camera.CFrame.LookVector
    end

    -- 1. Выстрел
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

    -- 2. Взрыв
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
        print(`🎯 Стреляем по {npc.Name} на расстоянии {math.floor((targetPart.Position - origin).Magnitude)} стадий`)
    end)
end

-- Цикл
while true do
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        pcall(autoShoot)
    end
    wait(0.01)
end
