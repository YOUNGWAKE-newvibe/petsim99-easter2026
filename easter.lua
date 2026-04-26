-- Easter Event Joiner - с повторением
local VirtualInput = game:GetService("VirtualInputManager")

local buttonX = 960   -- ← ИЗМЕНИ НА СВОИ КООРДИНАТЫ
local buttonY = 400   -- ← ИЗМЕНИ НА СВОИ КООРДИНАТЫ

local function clickAt(x, y)
    VirtualInput:SendMouseButtonEvent(x, y, 0, true, game, 0)
    wait(0.05)
    VirtualInput:SendMouseButtonEvent(x, y, 0, false, game, 0)
end

-- Ждём загрузки
wait(5)

-- Кликаем 3 раза с интервалом
for i = 1, 3 do
    clickAt(buttonX, buttonY)
    print("Clicked " .. i .. " time at " .. buttonX .. ", " .. buttonY)
    wait(1)
end

print("Done! If not joined, adjust coordinates.")
