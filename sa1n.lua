-- Сервисы
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Путь к NPCFolder
local function getNPCFolder()
    local GAME = Workspace:FindFirstChild("#GAME")
    return GAME and GAME:FindFirstChild("Folders") 
        and GAME.Folders:FindFirstChild("HumanoidFolder") 
        and GAME.Folders.HumanoidFolder:FindFirstChild("NPCFolder")
end

-- Аксессуар пушки (нужен для T)
local function getGun()
    local GAME = Workspace:FindFirstChild("#GAME")
    return GAME and GAME:FindFirstChild("Folders") 
        and GAME.Folders:FindFirstChild("AccessoryFolder") 
        and GAME.Folders.AccessoryFolder:FindFirstChild("The Eggsterminator")
end

-- Событие
local MainAttackEvent = ReplicatedStorage:WaitForChild("Events"):WaitForChild("MainAttack")

-- Позиция игрока (для SP, HP, RS, O)
local function getPlayerShootOrigin()
    local char = LocalPlayer.Character
    if not char then return Vector3.zero end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    return hrp and hrp.CFrame * Vector3.new(0, 5, -5) or Vector3.zero
end

-- Основная функция: авто-выстрел + взрыв по NPC
local function autoShoot()
    if not LocalPlayer.Character then return end

    local gun = getGun()
    if not gun then
        warn("Пушка 'The Eggsterminator' не найдена!")
        return
    end

    local npcFolder = getNPCFolder()
    if not npcFolder then
        warn("NPCFolder не найдена!")
        return
    end

    -- Ищем ближайшего NPC (кроме CrackedBas)
    local targetPosition = Vector3.new(0, 0, -200)
    local foundTarget = false
    local closestDist = math.huge
    local myHrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    local myPos = myHrp and myHrp.Position or Vector3.zero

    for _, npc in ipairs(npcFolder:GetChildren()) do
        if npc.Name == "CrackedBas" then continue end
        local hrp = npc:FindFirstChild("HumanoidRootPart")
        local humanoid = npc:FindFirstChild("Humanoid")
        if hrp and humanoid and humanoid.Health > 0 then
            local dist = (hrp.Position - myPos).Magnitude
            if dist < closestDist then
                closestDist = dist
                targetPosition = hrp.Position
                foundTarget = true
            end
        end
    end

    if not foundTarget then
        warn("Нет подходящих NPC для атаки.")
        return
    end

    -- Позиции для выстрела
    local origin = getPlayerShootOrigin()
    local direction = (targetPosition - origin).unit

    -- Вызываем выстрел (The Eggsterminator)
    local shootArgs = {
        {
            A = LocalPlayer.Character,
            AN = "The Eggsterminator",
            O = origin, -- Origin
            D = direction, -- Direction
            T = gun, -- The Eggsterminator tool
            SP = origin, -- Shoot Position
            HP = origin + Vector3.new(0, 1, 0), -- Hit Position (условно)
            RS = origin -- Ray Start
        }
    }
    MainAttackEvent:FireServer(unpack(shootArgs))

    -- Сразу вызываем взрыв по NPC
    spawn(function()
        wait(0.1) -- небольшая задержка, чтобы сервер успел обработать выстрел
        local explodeArgs = {
            {
                ALV = origin,
                A = LocalPlayer.Character,
                AN = "The EggsterminatorExplode",
                EP = targetPosition
            }
        }
        MainAttackEvent:FireServer(unpack(explodeArgs))
        print(`Автовзрыв по NPC: {targetPosition}`)
    end)
end

-- Запускаем авто-стрельбу с интервалом
local AUTO_FIRE_RATE = 0.1 -- стреляем раз в 0.5 сек (можно уменьшить/увеличить)
while true do
    autoShoot()
    wait(AUTO_FIRE_RATE)
end
