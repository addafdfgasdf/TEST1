-- Сервисы
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- === Кэширование (один раз при старте) ===
local gameFolder = Workspace:FindFirstChild("#GAME") or Workspace:WaitForChild("#GAME", 10)
if not gameFolder then return end

local NPCFolder = (((gameFolder:FindFirstChild("Folders")
    and gameFolder.Folders:FindFirstChild("HumanoidFolder"))
    and gameFolder.Folders.HumanoidFolder:FindFirstChild("NPCFolder")))

local MainAttackEvent = (ReplicatedStorage:FindFirstChild("Events")
    and ReplicatedStorage.Events:FindFirstChild("MainAttack"))

local AccessoryFolder = gameFolder:FindFirstChild("Folders")
    and gameFolder.Folders:FindFirstChild("AccessoryFolder")

local Gun = AccessoryFolder and AccessoryFolder:FindFirstChild("The Eggsterminator")

if not (NPCFolder and MainAttackEvent and Gun) then
    warn("Autofire: Не найдены ключевые объекты.")
    return
end

-- === Приоритеты (быстрый lookup) ===
local PRIORITIES = {
    Amethyst = 1, Ruby = 1, Emerald = 1, Diamond = 1, BULL = 1,
    Golden = 2
}

-- === Переменные состояния ===
local autoFireEnabled = false
local lastShotTime = 0
local SHOOT_COOLDOWN = 0.08 -- ~12 выстрелов/сек (как в оригинале)

-- === Утилиты ===
local function isAlivePart(part)
    return part
        and part.Parent
        and part:IsDescendantOf(Workspace)
        and not part:GetAttribute("IsGettingEaten")
end

local function getOrigin()
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    return hrp and hrp.Position + Vector3.new(0, 2, 0) or Camera.CFrame.Position
end

-- === Поиск лучшей цели (оптимизировано: минимум вызовов, максимум скорости) ===
local function getBestTarget()
    local character = LocalPlayer.Character
    local myHrp = character and character:FindFirstChild("HumanoidRootPart")
    local myPos = myHrp and myHrp.Position or Camera.CFrame.Position

    local bestTarget = nil
    local bestScore = 1/0 -- inf

    local children = NPCFolder:GetChildren() -- кэшируем список
    for i = 1, #children do
        local npc = children[i]
        if not npc:IsA("Model") then continue end

        local name = npc.Name
        if name:sub(1, 4) == "Dead" or name == "CrackedBas" then
            continue
        end

        local humanoid = npc:FindFirstChildOfClass("Humanoid")
        if not humanoid or humanoid.Health <= 0 then continue end

        local targetPart = npc:FindFirstChild("HumanoidRootPart")
            or npc:FindFirstChild("Torso")
            or npc:FindFirstChild("UpperTorso")

        if not targetPart or not isAlivePart(targetPart) then continue end

        local dist = (targetPart.Position - myPos).Magnitude

        -- Определяем приоритет
        local priority = 3
        for k, v in pairs(PRIORITIES) do
            if name:find(k, 1, true) then
                priority = v
                break
            end
        end

        -- Лучше: меньше расстояние ИЛИ выше приоритет
        local score = dist + priority * 50
        if score < bestScore then
            bestScore = score
            bestTarget = targetPart
        end
    end

    return bestTarget
end

-- === Один вызов для выстрела и взрыва ===
local function shoot(targetPart)
    local origin = getOrigin()
    local dirVec = targetPart.Position - origin
    if dirVec.Magnitude < 0.1 then return end
    local direction = dirVec.Unit

    -- Выстрел
    MainAttackEvent:FireServer({
        A = LocalPlayer.Character,
        AN = "The Eggsterminator",
        O = origin,
        D = direction,
        T = Gun,
        SP = origin,
        HP = targetPart.Position,
        RS = origin
    })

    -- Взрыв через 0.1 сек
    task.delay(0.1, function()
        MainAttackEvent:FireServer({
            ALV = origin,
            A = LocalPlayer.Character,
            AN = "The EggsterminatorExplode",
            EP = targetPart.Position
        })
    end)
end

-- === Основной цикл: 60 Гц через Heartbeat (плавно, без wait) ===
RunService.Heartbeat:Connect(function()
    if not autoFireEnabled then return end

    local now = tick()
    if now - lastShotTime < SHOOT_COOLDOWN then return end

    local character = LocalPlayer.Character
    local humanoid = character and character:FindFirstChild("Humanoid")
    if not (character and humanoid and humanoid.Health > 0) then return end

    local target = getBestTarget()
    if not target then return end

    pcall(shoot, target)
    lastShotTime = now
end)

-- === Переключение по Q ===
UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.Q then
        autoFireEnabled = not autoFireEnabled
        local status = autoFireEnabled and "включена" or "выключена"
        print("Автострельба " .. status)
        game.StarterGui:SetCore("SendNotification", {
            Title = "Автострельба",
            Text = "Автострельба " .. status,
            Duration = 2
        })
    end
end)
