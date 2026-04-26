-- Easter Event Auto-Join with Logging
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local VirtualInput = game:GetService("VirtualInputManager")

-- Функция для логов в консоль Potassium
local function log(message)
    local timestamp = os.date("%H:%M:%S")
    print("[" .. timestamp .. "] " .. message)
end

-- Функция поиска и нажатия кнопки
local function joinEvent()
    log("🔍 Searching for Join Event button...")
    
    local gui = game:GetService("CoreGui")
    local found = false
    
    for _, screenGui in pairs(gui:GetChildren()) do
        if screenGui:IsA("ScreenGui") then
            for _, button in pairs(screenGui:GetDescendants()) do
                if button:IsA("TextButton") and button.Visible then
                    local text = button.Text or ""
                    if text:find("Join") and text:find("Event") then
                        log("✅ Found button: " .. text)
                        button:Click()
                        log("✅ Clicked Join Event!")
                        return true
                    end
                end
            end
        end
    end
    
    log("❌ Button not found, trying coordinates...")
    VirtualInput:SendMouseButtonEvent(960, 400, 0, true, game, 0)
    wait(0.1)
    VirtualInput:SendMouseButtonEvent(960, 400, 0, false, game, 0)
    log("✅ Clicked at coordinates (960, 400)")
    return false
end

-- Основная логика
log("🚀 Easter Event Script Started!")
log("⏳ Waiting for game to load...")

-- Ждём загрузки
repeat
    wait(1)
    log("📡 Waiting for PlayerGui...")
until localPlayer and localPlayer:FindFirstChild("PlayerGui")

log("✅ Game loaded!")

-- Ждём появление интерфейса
log("⏳ Waiting 5 seconds for UI to appear...")
wait(5)

-- Входим в ивент
log("🎯 Attempting to join Easter Event...")
joinEvent()

-- Проверка каждые 10 секунд
local checkCount = 0
while true do
    wait(10)
    checkCount = checkCount + 1
    log("🔄 Check #" .. checkCount .. " - Verifying event status...")
    
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
    
    if stillInEvent then
        log("✅ Still in Easter Event")
    else
        log("⚠️ Left Easter Event! Rejoining...")
        joinEvent()
    end
end
