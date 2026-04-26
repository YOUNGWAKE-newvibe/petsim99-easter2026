local VirtualInput = game:GetService("VirtualInputManager")

while true do
    wait(5)
    VirtualInput:SendMouseButtonEvent(960, 400, 0, true, game, 0)
    wait(0.1)
    VirtualInput:SendMouseButtonEvent(960, 400, 0, false, game, 0)
end
