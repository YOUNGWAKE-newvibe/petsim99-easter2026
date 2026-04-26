-- Easter Event Auto-Join for Pet Simulator 99
-- Скрипт автоматически входит в ивент при запуске

local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local VirtualInput = game:GetService("VirtualInputManager")

-- Функция поиска и нажатия кнопки "Join Event!"
local function joinEvent()
    -- Ищем кнопку через CoreGui
    local gui = game:GetService("CoreGui")
    
    for _, screenGui in pairs(gui:GetChildren()) do
        if screenGui:IsA("ScreenGui") then
            for _, button in pairs(screenGui:GetDescendants()) do
                if button:IsA("TextButton") and button.Visible then
                    local text = button.Text or ""
                    -- Ищем кнопку с текстом Join Event
                    if text:find("Join") and text:find("Event") then
                        button:Click()
                        print("✅ Joined Easter Event!")
                        return true
                    end
                end
            end
        end
    end
    
    -- Если не нашли через GUI, пробуем клик по координатам
    print("🔍 Searching by coordinates...")
    VirtualInput:SendMouseButtonEvent(960, 400, 0, true, game, 0)
    wait(0.1)
    VirtualInput:SendMouseButtonEvent(960, 400, 0, false, game, 0)
    return false
end

-- Ждём загрузки игры
repeat
    wait(1)
    print("⏳ Waiting for game to load...")
until localPlayer and localPlayer:FindFirstChild("PlayerGui")

-- Даём время на появление интерфейса
wait(3)

-- Входим в ивент
print("🎯 Attempting to join Easter Event...")
joinEvent()

-- Опционально: продолжаем проверять каждые 10 секунд
while true do
    wait(10)
    -- Проверяем, не вылетел ли из ивента
    local stillInEvent = false
    local gui = game:GetService("CoreGui")
    
    for _, screenGui in pairs(gui:GetChildren()) do
        if screenGui:IsA("ScreenGui") then
            for _, v in pairs(screenGui:GetDescendants()) do
                if v:IsA("TextLabel") and v.Text and v.Text:find("Easter") then
                    stillInEvent = true
                    break
                end
            end
        end
    end
    
    if not stillInEvent then
        print("🔄 Left event, rejoining...")
        joinEvent()
    end
end
