-- ========================================================
-- KINGS HUB & PAVEL | GITHUB EDITION (WATERMARK)
-- ========================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- ССЫЛКА НА ТВОИ КЛЮЧИ
local KEY_SERVER_URL = "https://raw.githubusercontent.com/zded787-star/Kinnokey/refs/heads/main/keys.json"

local keyDurations = {}

local function fetchKeys()
    local success, result = pcall(function() return game:HttpGet(KEY_SERVER_URL) end)
    if success and result then
        local decodeSuccess, decoded = pcall(function() return HttpService:JSONDecode(result) end)
        if decodeSuccess and type(decoded) == "table" then
            keyDurations = decoded
            return true
        end
    end
    return false
end

if not fetchKeys() then
    warn("[KINGS HUB] Ошибка загрузки ключей с GitHub.")
end

local function checkKey(inputKey)
    local durationDays = keyDurations[inputKey]
    if not durationDays then return false, "Неверный ключ!", false end
    if durationDays == -1 then 
        local isSuper = (inputKey == "SUPER-VIP-PAVEL-782")
        return true, isSuper and "SUPER VIP" or "VIP (Навсегда)", isSuper 
    end
    return true, "VIP (" .. durationDays .. " дн.)", false
end

local parentGui = LocalPlayer:WaitForChild("PlayerGui")
if parentGui:FindFirstChild("KingsHubPavelVip") then
    parentGui.KingsHubPavelVip:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KingsHubPavelVip"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = parentGui

-- ОКНО АВТОРИЗАЦИИ
local AuthFrame = Instance.new("Frame")
AuthFrame.Parent = ScreenGui
AuthFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
AuthFrame.Position = UDim2.new(0.1, 0, 0.3, 0)
AuthFrame.Size = UDim2.new(0.8, 0, 0, 220)
AuthFrame.Active = true
AuthFrame.Draggable = true
Instance.new("UICorner", AuthFrame).CornerRadius = UDim.new(0, 8)
local stroke = Instance.new("UIStroke", AuthFrame) stroke.Color = Color3.fromRGB(255, 215, 0)

local authTitle = Instance.new("TextLabel", AuthFrame)
authTitle.BackgroundTransparency = 1
authTitle.Size = UDim2.new(1, 0, 0, 40)
authTitle.Font = Enum.Font.GothamBold
authTitle.Text = "KINGS HUB & PAVEL"
authTitle.TextColor3 = Color3.fromRGB(255, 215, 0)
authTitle.TextSize = 20

local keyInput = Instance.new("TextBox", AuthFrame)
keyInput.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
keyInput.Position = UDim2.new(0.1, 0, 0.25, 0)
keyInput.Size = UDim2.new(0.8, 0, 0, 45)
keyInput.Font = Enum.Font.Gotham
keyInput.PlaceholderText = "Введите ключ..."
keyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
keyInput.TextSize = 16
Instance.new("UICorner", keyInput).CornerRadius = UDim.new(0, 6)

local statusText = Instance.new("TextLabel", AuthFrame)
statusText.BackgroundTransparency = 1
statusText.Position = UDim2.new(0, 0, 0.45, 0)
statusText.Size = UDim2.new(1, 0, 0, 20)
statusText.Font = Enum.Font.GothamSemibold
statusText.TextColor3 = Color3.fromRGB(255, 50, 50)
statusText.TextSize = 14

local loginBtn = Instance.new("TextButton", AuthFrame)
loginBtn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
loginBtn.Position = UDim2.new(0.1, 0, 0.55, 0)
loginBtn.Size = UDim2.new(0.8, 0, 0, 45)
loginBtn.Font = Enum.Font.GothamBold
loginBtn.Text = "Войти"
loginBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
loginBtn.TextSize = 16
Instance.new("UICorner", loginBtn).CornerRadius = UDim.new(0, 6)

local freeBtn = Instance.new("TextButton", AuthFrame)
freeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
freeBtn.Position = UDim2.new(0.1, 0, 0.78, 0)
freeBtn.Size = UDim2.new(0.8, 0, 0, 35)
freeBtn.Font = Enum.Font.Gotham
freeBtn.Text = "Продолжить бесплатно"
freeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
freeBtn.TextSize = 14
Instance.new("UICorner", freeBtn).CornerRadius = UDim.new(0, 6)

-- ГЛАВНОЕ МЕНЮ
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.Position = UDim2.new(0.075, 0, 0.15, 0)
MainFrame.Size = UDim2.new(0.85, 0, 0.7, 0)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)
local ms = Instance.new("UIStroke", MainFrame) ms.Color = Color3.fromRGB(0, 170, 255)

local TitleBar = Instance.new("Frame", MainFrame)
TitleBar.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
TitleBar.Size = UDim2.new(1, 0, 0, 45)

local TitleText = Instance.new("TextLabel", TitleBar)
TitleText.BackgroundTransparency = 1
TitleText.Size = UDim2.new(1, -50, 1, 0)
TitleText.Font = Enum.Font.GothamBold
TitleText.Text = "KINGS HUB"
TitleText.TextColor3 = Color3.fromRGB(0, 170, 255)
TitleText.TextSize = 16
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Position = UDim2.new(0, 10, 0, 0)

local CloseBtn = Instance.new("TextButton", TitleBar)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -45, 0, 5)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 18
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

local WarningFrame = Instance.new("Frame", MainFrame)
WarningFrame.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
WarningFrame.Position = UDim2.new(0, 0, 1, -30)
WarningFrame.Size = UDim2.new(1, 0, 0, 30)
WarningFrame.BorderSizePixel = 0

local WarningText = Instance.new("TextLabel", WarningFrame)
WarningText.BackgroundTransparency = 1
WarningText.Size = UDim2.new(1, -10, 1, 0)
WarningText.Position = UDim2.new(0, 5, 0, 0)
WarningText.Font = Enum.Font.GothamSemibold
WarningText.Text = "⚠ ВНИМАНИЕ: RAGE-ФУНКЦИИ МОГУТ ПРИВЕСТИ К БАНУ! ИГРАЙТЕ НА ТВИНКАХ."
WarningText.TextColor3 = Color3.fromRGB(255, 255, 255)
WarningText.TextSize = 10
WarningText.TextScaled = true

local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
ToggleBtn.Size = UDim2.new(0, 60, 0, 60)
ToggleBtn.Position = UDim2.new(0, 20, 0, 100)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.Text = "K"
ToggleBtn.TextColor3 = Color3.fromRGB(0, 170, 255)
ToggleBtn.TextSize = 30
ToggleBtn.Active = true
ToggleBtn.Draggable = true
ToggleBtn.Visible = false
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 10)
local ts = Instance.new("UIStroke", ToggleBtn) ts.Color = Color3.fromRGB(0, 170, 255)

CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false ToggleBtn.Visible = true end)
ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = true ToggleBtn.Visible = false end)

local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
Sidebar.Position = UDim2.new(0, 0, 0, 45)
Sidebar.Size = UDim2.new(0, 100, 1, -75)
Sidebar.BorderSizePixel = 0

local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
ContentArea.Position = UDim2.new(0, 100, 0, 45)
ContentArea.Size = UDim2.new(1, -100, 1, -75)
ContentArea.BorderSizePixel = 0

local Tabs = {}
local function CreateTab(name, displayName)
    local btn = Instance.new("TextButton", Sidebar)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    btn.Size = UDim2.new(0.9, 0, 0, 45)
    btn.Font = Enum.Font.GothamSemibold
    btn.Text = displayName
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.TextSize = 14
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    local tabCount = 0
    for _ in pairs(Tabs) do tabCount = tabCount + 1 end
    btn.Position = UDim2.new(0.05, 0, 0, (tabCount * 50))

    local frame = Instance.new("ScrollingFrame", ContentArea)
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.CanvasSize = UDim2.new(0, 0, 0, 500)
    frame.ScrollBarThickness = 6
    frame.Visible = false

    local layout = Instance.new("UIListLayout", frame)
    layout.Padding = UDim.new(0, 10)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

    Tabs[name] = { Button = btn, Frame = frame, Layout = layout }
    btn.MouseButton1Click:Connect(function()
        for _, tab in pairs(Tabs) do
            tab.Button.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
            tab.Frame.Visible = false
        end
        btn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        frame.Visible = true
    end)
    return frame
end

local function AddToggle(parent, text, callback)
    local btn = Instance.new("TextButton", parent)
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    btn.Size = UDim2.new(0.9, 0, 0, 45)
    btn.Font = Enum.Font.GothamSemibold
    btn.Text = text .. " [OFF]"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    
    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        if state then
            btn.Text = text .. " [ON]"
            btn.TextColor3 = Color3.fromRGB(0, 255, 100)
        else
            btn.Text = text .. " [OFF]"
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
        callback(state)
    end)
end

local states = { 
    ESP_Text = false, ESP_Box = false, ESP_Highlight = false, 
    Noclip = false, VIP_Hitbox = false, VIP_AutoShoot = false, 
    Super_XRay = false, Rage_Speed = false, Rage_Jump = false, Rage_AutoPickup = false, Rage_AutoEvade = false
}

local hitboxTarget = "Murderer"
local espTags, espDrawings, espHighlights, espHeadHighlights = {}, {}, {}, {}
local originalTransparencies = {}
local RoleColors = { Innocent = Color3.fromRGB(0, 255, 0), Sheriff = Color3.fromRGB(0, 100, 255), Murderer = Color3.fromRGB(255, 0, 0), Unknown = Color3.fromRGB(255, 255, 255) }
local hasDrawing = pcall(function() return Drawing.new("Square") end)

local function getRole(player)
    local char = player.Character
    if not char then return "Innocent", nil end
    for _, tool in ipairs(char:GetChildren()) do
        if tool:IsA("Tool") then
            local n = tool.Name:lower()
            if n:find("knife") then return "Murderer", tool.Name end
            if n:find("gun") or n:find("revolver") then return "Sheriff", tool.Name end
        end
    end
    local bp = player:FindFirstChild("Backpack")
    if bp then
        for _, tool in ipairs(bp:GetChildren()) do
            if tool:IsA("Tool") then
                local n = tool.Name:lower()
                if n:find("knife") then return "Murderer", tool.Name end
                if n:find("gun") or n:find("revolver") then return "Sheriff", tool.Name end
            end
        end
    end
    return "Innocent", nil
end

local function setupESP(player)
    if player == LocalPlayer then return end
    local char = player.Character or player.CharacterAdded:Wait()

    local tag = Instance.new("BillboardGui", char)
    tag.Name = "KingsESPTag"
    tag.Size = UDim2.new(0, 100, 0, 30)
    tag.StudsOffset = Vector3.new(0, 2.5, 0)
    tag.AlwaysOnTop = true
    tag.Enabled = false
    local txt = Instance.new("TextLabel", tag)
    txt.BackgroundTransparency = 1
    txt.Size = UDim2.new(1, 0, 1, 0)
    txt.Font = Enum.Font.Gotham
    txt.TextSize = 12
    txt.TextStrokeTransparency = 0
    espTags[player] = tag

    local h = Instance.new("Highlight")
    h.Name = "KingsESPHighlight"
    h.FillTransparency = 0.5
    h.OutlineTransparency = 0
    h.Enabled = false
    h.Parent = char
    espHighlights[player] = h

    local hHead = Instance.new("Highlight")
    hHead.Name = "KingsESPHeadHighlight"
    hHead.FillTransparency = 0.5
    hHead.OutlineTransparency = 0
    hHead.Enabled = false
    hHead.Parent = char:FindFirstChild("Head") or char
    espHeadHighlights[player] = hHead

    if hasDrawing then
        local box = Drawing.new("Square")
        box.Thickness = 1
        box.Filled = false
        box.Visible = false
        espDrawings[player] = box
    end
end

local function setupUI(isVIP, isSuper, msg)
    MainFrame.Visible = true
    AuthFrame.Visible = false
    
    -- ВОДЯНОЙ ЗНАК ДЛЯ БЕСПЛАТНОЙ ВЕРСИИ
    if not isVIP then
        local watermark = Instance.new("TextLabel", MainFrame)
        watermark.BackgroundTransparency = 1
        watermark.Size = UDim2.new(0, 220, 0, 20)
        watermark.Font = Enum.Font.GothamSemibold
        watermark.Text = "Было сделано каналом @K1ngss_rb"
        watermark.TextColor3 = Color3.fromRGB(150, 150, 150)
        watermark.TextSize = 12
        watermark.ZIndex = 10
        
        local pos = math.random(1, 3)
        if pos == 1 then
            watermark.Position = UDim2.new(1, -230, 0, 50)
        elseif pos == 2 then
            watermark.Position = UDim2.new(1, -230, 1, -55)
        else
            watermark.Position = UDim2.new(0, 10, 1, -55)
        end
    end
    
    local espFrame = CreateTab("ESP", "ESP")
    local playerFrame = CreateTab("Player", "Игрок")
    
    local vipFrame
    if isVIP then
        vipFrame = CreateTab("VIP", "🔥 RAGE VIP 🔥")
        TitleText.Text = "KINGS HUB [" .. msg .. "]"
        TitleText.TextColor3 = Color3.fromRGB(255, 215, 0)
        vipFrame.Parent.Position = UDim2.new(0, 5, 0, 0)
        espFrame.Parent.Position = UDim2.new(0, 5, 0, 50)
    end

    local superFrame
    if isSuper then
        superFrame = CreateTab("Super", "👑 SUPER VIP")
        TitleText.Text = "KINGS HUB [SUPER VIP]"
        TitleText.TextColor3 = Color3.fromRGB(200, 100, 255)
    end

    AddToggle(espFrame, "ESP Text (Ник/Роль)", function(state) states.ESP_Text = state if not state then for _, t in pairs(espTags) do if t then t.Enabled = false end end end end)
    AddToggle(espFrame, "ESP Box (Квадраты)", function(state) states.ESP_Box = state if not state and hasDrawing then for _, b in pairs(espDrawings) do if b then b.Visible = false end end end end)
    AddToggle(espFrame, "ESP Highlight (Хитбокс)", function(state) states.ESP_Highlight = state if not state then for _, h in pairs(espHighlights) do if h then h.Enabled = false end end for _, hh in pairs(espHeadHighlights) do if hh then hh.Enabled = false end end end end)
    AddToggle(playerFrame, "Noclip", function(state) states.Noclip = state end)

    if isVIP then
        AddToggle(vipFrame, "🔥 Speed Hack (Ускорение)", function(state) 
            states.Rage_Speed = state 
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid.WalkSpeed = state and 60 or 16
            end
        end)

        AddToggle(vipFrame, "🔥 High Jump (Прыжок)", function(state) 
            states.Rage_Jump = state 
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid.JumpPower = state and 100 or 50
            end
        end)

        AddToggle(vipFrame, "🔥 Auto-Pickup (Оружие)", function(state) states.Rage_AutoPickup = state end)
        AddToggle(vipFrame, "🔥 Auto-Evade (Уклонение)", function(state) states.Rage_AutoEvade = state end)
        AddToggle(vipFrame, "⭐ Hitbox Expander", function(state) states.VIP_Hitbox = state end)
        
        AddToggle(vipFrame, "⭐ Auto-Shoot", function(state) 
            states.VIP_AutoShoot = state 
            if state then
                task.spawn(function()
                    while states.VIP_AutoShoot do
                        task.wait(0.1)
                        if getRole(LocalPlayer) == "Sheriff" then
                            for _, p in ipairs(Players:GetPlayers()) do
                                if p ~= LocalPlayer and getRole(p) == "Murderer" and p.Character and p.Character:FindFirstChild("Head") then
                                    local screenPos, onScreen = Camera:WorldToViewportPoint(p.Character.Head.Position)
                                    if onScreen then
                                        VirtualUser:CaptureController()
                                        VirtualUser:ClickButton1(Vector2.new(screenPos.X, screenPos.Y))
                                    end
                                end
                            end
                        end
                    end
                end)
            end
        end)
    end

    if isSuper then
        AddToggle(superFrame, "👑 X-Ray (Стены)", function(state)
            states.Super_XRay = state
            if state then
                for _, obj in ipairs(Workspace:GetDescendants()) do
                    if obj:IsA("BasePart") and not obj:IsDescendantOf(LocalPlayer.Character) then
                        if originalTransparencies[obj] == nil then originalTransparencies[obj] = obj.Transparency end
                        obj.Transparency = 0.5
                    end
                end
            else
                for obj, trans in pairs(originalTransparencies) do
                    if obj and obj.Parent then obj.Transparency = trans end
                end
                originalTransparencies = {}
            end
        end)
    end
    
    if Tabs["ESP"] then Tabs["ESP"].Button.MouseButton1Click:Fire() end
end

loginBtn.MouseButton1Click:Connect(function()
    local success, msg, isSuper = checkKey(keyInput.Text)
    if success then
        statusText.Text = "Успешно!"
        statusText.TextColor3 = Color3.fromRGB(0, 255, 100)
        local uiSuccess, uiError = pcall(function() setupUI(true, isSuper, msg) end)
        if not uiSuccess then warn("[KINGS HUB] ОШИБКА: " .. tostring(uiError)) end
    else
        statusText.Text = msg
    end
end)

freeBtn.MouseButton1Click:Connect(function()
    local uiSuccess, uiError = pcall(function() setupUI(false, false, "FREE") end)
    if not uiSuccess then warn("[KINGS HUB] ОШИБКА: " .. tostring(uiError)) end
end)

for _, p in ipairs(Players:GetPlayers()) do setupESP(p) end
Players.PlayerAdded:Connect(setupESP)
Players.PlayerRemoving:Connect(function(p)
    if espTags[p] then espTags[p]:Destroy() espTags[p] = nil end
    if espHighlights[p] then espHighlights[p]:Destroy() espHighlights[p] = nil end
    if espHeadHighlights[p] then espHeadHighlights[p]:Destroy() espHeadHighlights[p] = nil end
    if espDrawings[p] and hasDrawing then espDrawings[p]:Remove() espDrawings[p] = nil end
end)

for _, p in ipairs(Players:GetPlayers()) do
    p.CharacterAdded:Connect(function() 
        task.wait(0.5)
        if espTags[p] then espTags[p]:Destroy() end
        if espHighlights[p] then espHighlights[p]:Destroy() end
        if espHeadHighlights[p] then espHeadHighlights[p]:Destroy() end
        setupESP(p) 
    end)
end

RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local humanoid = char:FindFirstChild("Humanoid")

    if states.Rage_AutoPickup and hrp then
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("Tool") and (obj.Name:lower():find("gun") or obj.Name:lower():find("knife")) then
                local handle = obj:FindFirstChild("Handle")
                if handle and (handle.Position - hrp.Position).Magnitude < 15 then
                    obj.Parent = char
                end
            end
        end
    end

    if states.Rage_AutoEvade and hrp and humanoid then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and getRole(p) == "Murderer" and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local dist = (p.Character.HumanoidRootPart.Position - hrp.Position).Magnitude
                if dist < 12 then
                    humanoid.Jump = true
                    break
                end
            end
        end
    end

RunService.RenderStepped:Connect(function()
    for player, tag in pairs(espTags) do
        if not player.Parent or not player.Character then 
            if tag then tag.Enabled = false end
            if espHighlights[player] then espHighlights[player].Enabled = false end
            if espHeadHighlights[player] then espHeadHighlights[player].Enabled = false end
            if espDrawings[player] and hasDrawing then espDrawings[player].Visible = false end
            continue 
        end
        
        local char = player.Character
        local head = char:FindFirstChild("Head")
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local humanoid = char:FindFirstChild("Humanoid")

        if head and hrp and humanoid and humanoid.Health > 0 then
            local role = getRole(player)
            local color = RoleColors[role] or RoleColors.Unknown

            local shouldExpand = false
            if states.VIP_Hitbox then
                if hitboxTarget == "Both" and (role == "Murderer" or role == "Sheriff") then shouldExpand = true
                elseif hitboxTarget == "Murderer" and role == "Murderer" then shouldExpand = true
                elseif hitboxTarget == "Sheriff" and role == "Sheriff" then shouldExpand = true end
            end

            if shouldExpand then 
                head.Size = Vector3.new(4, 2, 2)
                if states.ESP_Highlight and espHeadHighlights[player] then
                    espHeadHighlights[player].Enabled = true
                    espHeadHighlights[player].FillColor = color
                    espHeadHighlights[player].OutlineColor = color
                end
            else
                head.Size = Vector3.new(2, 1, 1)
                if espHeadHighlights[player] then espHeadHighlights[player].Enabled = false end
            end

            if states.ESP_Text and tag then
                tag.Enabled = true
                local txt = tag:FindFirstChildOfClass("TextLabel")
                if txt then
                    txt.Text = player.Name .. "\n[" .. role .. "]"
                    txt.TextColor3 = color
                end
            elseif tag then tag.Enabled = false end

            local h = espHighlights[player]
            if states.ESP_Highlight and h then
                h.Enabled = true
                h.FillColor = color
                h.OutlineColor = color
            elseif h then h.Enabled = false end

            if states.ESP_Box and hasDrawing and espDrawings[player] then
                local screenPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                local headPos = Camera:WorldToViewportPoint(head.Position)
                local box = espDrawings[player]
                if onScreen then
                    local height = math.abs(headPos.Y - screenPos.Y) * 2.5
                    local width = height * 0.6
                    box.Size = Vector2.new(width, height)
                    box.Position = Vector2.new(screenPos.X - width / 2, screenPos.Y - height / 2)
                    box.Color = color
                    box.Visible = true
                else box.Visible = false end
            elseif hasDrawing and espDrawings[player] then
                espDrawings[player].Visible = false
            end
        else 
            if tag then tag.Enabled = false end
            if espHighlights[player] then espHighlights[player].Enabled = false end
            if espHeadHighlights[player] then espHeadHighlights[player].Enabled = false end
            if espDrawings[player] and hasDrawing then espDrawings[player].Visible = false end
        end
    end
end)

RunService.Stepped:Connect(function()
    if states.Noclip then
        local char = LocalPlayer.Character
        if char then for _, part in ipairs(char:GetDescendants()) do if part:IsA("BasePart") and part.CanCollide then part.CanCollide = false end end end
    end
end)

print("[KINGS HUB] Скрипт успешно загружен и запущен.")
-- КОНЕЦ СКРИПТА
