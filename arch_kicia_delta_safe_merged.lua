--[[
    Arch + Kicia — Delta Safe Merge
    ------------------------------------------------------------
    这是一个 Delta-safe 的合并 UI / Config 版本。
    - 分页顺序：Legit / Rage / Visuals / Misc / Kicia / Settings
    - Kicia 位于 Config/Settings 正上方
    - 所有可选 executor API 都先检测
    - 配置读写全部使用 pcall，避免 nil / JSON 错误导致整个脚本停止
    - Kicia 中依赖 exploit / Remote hook / hidden property / 自动攻击的
      部分仅保留 UI 配置，不会执行这些操作
]]

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then
    warn("[Arch] LocalPlayer not ready")
    return
end

-- ============================================================
-- Delta-safe helpers
-- ============================================================

local function safeGetGlobal(name)
    local ok, value = pcall(function()
        if type(getgenv) == "function" then
            local env = getgenv()
            if env and env[name] ~= nil then
                return env[name]
            end
        end
        return _G[name]
    end)
    if ok then return value end
    return nil
end

local function safeCall(fn, ...)
    if type(fn) ~= "function" then
        return false, nil
    end
    return pcall(fn, ...)
end

local writefileSafe = safeGetGlobal("writefile")
local readfileSafe = safeGetGlobal("readfile")
local isfileSafe = safeGetGlobal("isfile")
local makefolderSafe = safeGetGlobal("makefolder")

local function notify(text)
    print("[Arch/Kicia] " .. tostring(text))
end

-- ============================================================
-- State
-- ============================================================

local S = {
    -- Safe UI settings
    MenuKey = "Insert",
    UIEnabled = true,

    -- Visual/UI-only settings
    CrosshairEnabled = false,
    CrosshairSize = 6,
    CrosshairThickness = 2,
    FOV = 70,

    -- Kicia settings are configuration-only in this safe build.
    Kicia = {
        Enabled = false,
        Stability = 0.15,
        ShootFrames = 1,
        PrioritizeHackers = false,
        WeaponPrimary = true,
        WeaponSecondary = true,
        WeaponMelee = true,
        OnEmpty = "SwapOrReload",

        EvasionMode = "Random",
        TranslocateOffset = -5,
        RandomBaseRadius = 100,
        RandomRadiusFactor = 0.5,
        RandomAnchorFromCharacter = false,

        FlickbotEnabled = false,
        FlickbotKeybind = "Unknown",
        FlickbotShot = false,
        FlickbotShotDelay = 0,
        FlickbotCooldown = 250,
        FlickbotDuration = 110,
        FlickbotCurvature = 12,
        FlickbotHumanness = 30,
    }
}

-- ============================================================
-- Serialization
-- ============================================================

local CONFIG_NAME = "ArchScripts_Config_DeltaSafe.json"

local function serialize(value)
    local t = typeof(value)

    if t == "Color3" then
        return {
            __type = "Color3",
            r = value.R,
            g = value.G,
            b = value.B
        }
    end

    if t == "EnumItem" then
        return {
            __type = "Enum",
            enum = tostring(value.EnumType),
            name = value.Name
        }
    end

    if type(value) == "table" then
        local result = {}
        for k, v in pairs(value) do
            if type(v) ~= "function" and typeof(v) ~= "Instance"
                and typeof(v) ~= "RBXScriptConnection"
                and typeof(v) ~= "userdata" then
                result[k] = serialize(v)
            end
        end
        return result
    end

    if type(value) == "function"
        or t == "Instance"
        or t == "RBXScriptConnection"
        or t == "userdata" then
        return nil
    end

    return value
end

local function saveConfig()
    local data = serialize(S)
    if not data then
        notify("Config serialization failed")
        return
    end

    local ok, json = pcall(function()
        return HttpService:JSONEncode(data)
    end)

    if not ok or type(json) ~= "string" then
        notify("Config JSONEncode failed")
        return
    end

    if type(writefileSafe) ~= "function" then
        notify("writefile unavailable; config was not saved")
        return
    end

    local saved = safeCall(writefileSafe, CONFIG_NAME, json)
    if saved then
        notify("Config saved")
    else
        notify("Config save failed")
    end
end

local function deserializeInto(target, source)
    if type(target) ~= "table" or type(source) ~= "table" then
        return
    end

    for k, v in pairs(source) do
        if k == "__type" then
            continue
        end

        if type(v) == "table" then
            if v.__type == "Color3" then
                if type(v.r) == "number" and type(v.g) == "number"
                    and type(v.b) == "number" then
                    target[k] = Color3.new(v.r, v.g, v.b)
                end
            elseif v.__type == "Enum" then
                -- Enum values are not required by the safe build.
                -- Unknown / invalid values are simply ignored.
            else
                if type(target[k]) == "table" then
                    deserializeInto(target[k], v)
                end
            end
        else
            if target[k] ~= nil then
                local oldType = type(target[k])
                local newType = type(v)
                if oldType == newType then
                    target[k] = v
                end
            end
        end
    end
end

local function loadConfig()
    if type(isfileSafe) ~= "function" or type(readfileSafe) ~= "function" then
        notify("readfile/isfile unavailable; using defaults")
        return
    end

    local existsOK, exists = safeCall(isfileSafe, CONFIG_NAME)
    if not existsOK or not exists then
        notify("No saved config; using defaults")
        return
    end

    local readOK, raw = safeCall(readfileSafe, CONFIG_NAME)
    if not readOK or type(raw) ~= "string" then
        notify("Config read failed")
        return
    end

    local jsonOK, data = pcall(function()
        return HttpService:JSONDecode(raw)
    end)

    if not jsonOK or type(data) ~= "table" then
        notify("Config JSON invalid")
        return
    end

    deserializeInto(S, data)
    notify("Config loaded")
end

-- ============================================================
-- UI
-- ============================================================

local function getGuiParent()
    local ok, core = pcall(function()
        return game:GetService("CoreGui")
    end)
    if ok and core then
        return core
    end
    return LocalPlayer:WaitForChild("PlayerGui")
end

local guiParent = getGuiParent()

pcall(function()
    local old = guiParent:FindFirstChild("ArchKiciaDeltaSafe")
    if old then old:Destroy() end
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ArchKiciaDeltaSafe"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = guiParent

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.fromOffset(760, 500)
Main.Position = UDim2.new(0.5, -380, 0.5, -250)
Main.BackgroundColor3 = Color3.fromRGB(24, 25, 31)
Main.BorderSizePixel = 0
Main.Visible = S.UIEnabled
Main.Parent = ScreenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 10)
mainCorner.Parent = Main

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(65, 105, 155)
Stroke.Thickness = 1
Stroke.Parent = Main

local Top = Instance.new("Frame")
Top.Size = UDim2.new(1, 0, 0, 44)
Top.BackgroundColor3 = Color3.fromRGB(29, 30, 38)
Top.BorderSizePixel = 0
Top.Parent = Main

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 1, 0)
Title.Position = UDim2.fromOffset(10, 0)
Title.BackgroundTransparency = 1
Title.Text = "Arch + Kicia | Delta Safe"
Title.TextColor3 = Color3.fromRGB(235, 235, 240)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 17
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Top

local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, -20, 0, 38)
TabBar.Position = UDim2.fromOffset(10, 54)
TabBar.BackgroundTransparency = 1
TabBar.Parent = Main

local PageContainer = Instance.new("Frame")
PageContainer.Size = UDim2.new(1, -20, 1, -104)
PageContainer.Position = UDim2.fromOffset(10, 96)
PageContainer.BackgroundColor3 = Color3.fromRGB(28, 29, 36)
PageContainer.BorderSizePixel = 0
PageContainer.Parent = Main

local pc = Instance.new("UICorner")
pc.CornerRadius = UDim.new(0, 8)
pc.Parent = PageContainer

local Pages = {}
local TabButtons = {}

local function createPage(name)
    local page = Instance.new("ScrollingFrame")
    page.Name = name
    page.Size = UDim2.new(1, -20, 1, -20)
    page.Position = UDim2.fromOffset(10, 10)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 4
    page.Visible = false
    page.CanvasSize = UDim2.fromOffset(0, 0)
    page.Parent = PageContainer

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 8)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = page

    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        page.CanvasSize = UDim2.fromOffset(0, layout.AbsoluteContentSize.Y + 15)
    end)

    Pages[name] = page
    return page
end

local function createTab(name, index)
    local b = Instance.new("TextButton")
    b.Name = name .. "Tab"
    b.Size = UDim2.fromOffset(112, 34)
    b.Position = UDim2.fromOffset((index - 1) * 116, 0)
    b.BackgroundColor3 = Color3.fromRGB(39, 40, 49)
    b.BorderSizePixel = 0
    b.Text = name
    b.TextColor3 = Color3.fromRGB(215, 215, 225)
    b.Font = Enum.Font.GothamMedium
    b.TextSize = 13
    b.Parent = TabBar

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 7)
    c.Parent = b

    TabButtons[name] = b

    b.MouseButton1Click:Connect(function()
        for pageName, page in pairs(Pages) do
            page.Visible = (pageName == name)
        end

        for buttonName, button in pairs(TabButtons) do
            button.BackgroundColor3 =
                (buttonName == name)
                and Color3.fromRGB(54, 108, 185)
                or Color3.fromRGB(39, 40, 49)
        end
    end)
end

-- Kicia is intentionally immediately before Settings.
local tabNames = {"Legit", "Rage", "Visuals", "Misc", "Kicia", "Settings"}

for i, name in ipairs(tabNames) do
    createPage(name)
    createTab(name, i)
end

local function addLabel(page, text)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -8, 0, 28)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = Color3.fromRGB(205, 205, 215)
    l.Font = Enum.Font.Gotham
    l.TextSize = 13
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = page
    return l
end

local function addButton(page, text, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -8, 0, 36)
    b.BackgroundColor3 = Color3.fromRGB(40, 41, 51)
    b.BorderSizePixel = 0
    b.Text = text
    b.TextColor3 = Color3.fromRGB(225, 225, 230)
    b.Font = Enum.Font.GothamMedium
    b.TextSize = 13
    b.Parent = page

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = b

    b.MouseButton1Click:Connect(function()
        safeCall(callback)
    end)

    return b
end

local function addToggle(page, labelText, initial, callback)
    local value = initial == true

    local b
    local function refresh()
        b.Text = labelText .. " : " .. (value and "ON" or "OFF")
    end

    b = addButton(page, "", function()
        value = not value
        if callback then
            callback(value)
        end
        refresh()
    end)

    refresh()
    return b
end

local function addNumber(page, labelText, initial, minValue, maxValue, callback)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, -8, 0, 38)
    row.BackgroundTransparency = 1
    row.Parent = page

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.62, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = labelText
    label.TextColor3 = Color3.fromRGB(205, 205, 215)
    label.Font = Enum.Font.Gotham
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = row

    local box = Instance.new("TextBox")
    box.Size = UDim2.new(0.34, 0, 1, 0)
    box.Position = UDim2.new(0.66, 0, 0, 0)
    box.BackgroundColor3 = Color3.fromRGB(38, 39, 48)
    box.BorderSizePixel = 0
    box.TextColor3 = Color3.fromRGB(230, 230, 235)
    box.Text = tostring(initial)
    box.ClearTextOnFocus = false
    box.Font = Enum.Font.Code
    box.TextSize = 13
    box.Parent = row

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = box

    box.FocusLost:Connect(function()
        local n = tonumber(box.Text)
        if n then
            n = math.clamp(n, minValue, maxValue)
            box.Text = tostring(n)
            if callback then callback(n) end
        else
            box.Text = tostring(initial)
        end
    end)

    return box
end

-- ============================================================
-- Legit
-- ============================================================

local LegitPage = Pages.Legit
addLabel(LegitPage, "Legit")
addLabel(LegitPage, "Safe build: automated targeting/input injection is disabled.")

addNumber(LegitPage, "Camera FOV", S.FOV, 40, 120, function(v)
    S.FOV = v
    pcall(function()
        local camera = workspace.CurrentCamera
        if camera then camera.FieldOfView = v end
    end)
end)

-- ============================================================
-- Rage
-- ============================================================

local RagePage = Pages.Rage
addLabel(RagePage, "Rage")
addLabel(RagePage, "The original Ragebot / trigger / automatic attack routines are disabled in this safe build.")
addButton(RagePage, "Status: Disabled for Delta-safe build", function() end)

-- ============================================================
-- Visuals
-- ============================================================

local VisualsPage = Pages.Visuals
addLabel(VisualsPage, "Visuals")

addToggle(VisualsPage, "Crosshair", S.CrosshairEnabled, function(v)
    S.CrosshairEnabled = v
end)

addNumber(VisualsPage, "Crosshair Size", S.CrosshairSize, 1, 30, function(v)
    S.CrosshairSize = v
end)

addNumber(VisualsPage, "Crosshair Thickness", S.CrosshairThickness, 1, 8, function(v)
    S.CrosshairThickness = v
end)

-- ============================================================
-- Misc
-- ============================================================

local MiscPage = Pages.Misc
addLabel(MiscPage, "Misc")
addLabel(MiscPage, "Only non-invasive client UI/config options are active.")
addButton(MiscPage, "Check Delta APIs", function()
    local names = {
        "loadstring", "readfile", "writefile", "isfile",
        "getgenv", "cloneref", "clonefunction",
        "sethiddenproperty", "getthreadidentity",
        "hookfunction", "newcclosure", "hookmetamethod"
    }

    for _, name in ipairs(names) do
        local available = type(safeGetGlobal(name)) == "function"
        print(string.format("[Delta] %-20s %s", name, available and "AVAILABLE" or "MISSING"))
    end
end)

-- ============================================================
-- Kicia
-- ============================================================

local KiciaPage = Pages.Kicia
addLabel(KiciaPage, "Kicia")
addLabel(KiciaPage, "Configuration page preserved. Exploit/Remote-hook/automatic attack execution is disabled.")

addToggle(KiciaPage, "Enabled", S.Kicia.Enabled, function(v)
    S.Kicia.Enabled = v
end)

addNumber(KiciaPage, "Stability %", (S.Kicia.Stability or 0.15) * 100, 0, 100, function(v)
    S.Kicia.Stability = v / 100
end)

addNumber(KiciaPage, "Shoot Frames", S.Kicia.ShootFrames, 1, 10, function(v)
    S.Kicia.ShootFrames = v
end)

addToggle(KiciaPage, "Prioritize Hackers", S.Kicia.PrioritizeHackers, function(v)
    S.Kicia.PrioritizeHackers = v
end)

addToggle(KiciaPage, "Primary", S.Kicia.WeaponPrimary, function(v)
    S.Kicia.WeaponPrimary = v
end)

addToggle(KiciaPage, "Secondary", S.Kicia.WeaponSecondary, function(v)
    S.Kicia.WeaponSecondary = v
end)

addToggle(KiciaPage, "Melee", S.Kicia.WeaponMelee, function(v)
    S.Kicia.WeaponMelee = v
end)

addLabel(KiciaPage, "Evasion / Desync settings")

addNumber(KiciaPage, "Translocate Offset", S.Kicia.TranslocateOffset, -20, 20, function(v)
    S.Kicia.TranslocateOffset = v
end)

addNumber(KiciaPage, "Random Radius", S.Kicia.RandomBaseRadius, 10, 500, function(v)
    S.Kicia.RandomBaseRadius = v
end)

addNumber(KiciaPage, "Radius Factor %", S.Kicia.RandomRadiusFactor * 100, 0, 200, function(v)
    S.Kicia.RandomRadiusFactor = v / 100
end)

addToggle(KiciaPage, "Anchor From Character", S.Kicia.RandomAnchorFromCharacter, function(v)
    S.Kicia.RandomAnchorFromCharacter = v
end)

addLabel(KiciaPage, "Flickbot settings")

addToggle(KiciaPage, "Flickbot Enabled", S.Kicia.FlickbotEnabled, function(v)
    S.Kicia.FlickbotEnabled = v
end)

addToggle(KiciaPage, "Shot", S.Kicia.FlickbotShot, function(v)
    S.Kicia.FlickbotShot = v
end)

addNumber(KiciaPage, "Shot Delay", S.Kicia.FlickbotShotDelay, 0, 500, function(v)
    S.Kicia.FlickbotShotDelay = v
end)

addNumber(KiciaPage, "Cooldown", S.Kicia.FlickbotCooldown, 0, 2000, function(v)
    S.Kicia.FlickbotCooldown = v
end)

addNumber(KiciaPage, "Duration", S.Kicia.FlickbotDuration, 10, 1000, function(v)
    S.Kicia.FlickbotDuration = v
end)

addNumber(KiciaPage, "Curvature", S.Kicia.FlickbotCurvature, 0, 100, function(v)
    S.Kicia.FlickbotCurvature = v
end)

addNumber(KiciaPage, "Humanness", S.Kicia.FlickbotHumanness, 0, 100, function(v)
    S.Kicia.FlickbotHumanness = v
end)

-- ============================================================
-- Settings / Config
-- ============================================================

local SettingsPage = Pages.Settings
addLabel(SettingsPage, "Config")
addButton(SettingsPage, "Save Config", saveConfig)
addButton(SettingsPage, "Load Config", loadConfig)

addButton(SettingsPage, "Reset Config", function()
    S.FOV = 70
    S.CrosshairEnabled = false
    S.CrosshairSize = 6
    S.CrosshairThickness = 2

    S.Kicia.Enabled = false
    S.Kicia.Stability = 0.15
    S.Kicia.ShootFrames = 1
    S.Kicia.PrioritizeHackers = false
    S.Kicia.WeaponPrimary = true
    S.Kicia.WeaponSecondary = true
    S.Kicia.WeaponMelee = true
    S.Kicia.TranslocateOffset = -5
    S.Kicia.RandomBaseRadius = 100
    S.Kicia.RandomRadiusFactor = 0.5
    S.Kicia.RandomAnchorFromCharacter = false
    S.Kicia.FlickbotEnabled = false
    S.Kicia.FlickbotShot = false
    S.Kicia.FlickbotShotDelay = 0
    S.Kicia.FlickbotCooldown = 250
    S.Kicia.FlickbotDuration = 110
    S.Kicia.FlickbotCurvature = 12
    S.Kicia.FlickbotHumanness = 30

    notify("Config reset")
end)

addButton(SettingsPage, "Print Config", function()
    local ok, encoded = pcall(function()
        return HttpService:JSONEncode(serialize(S))
    end)
    if ok then
        print(encoded)
    else
        print("[Arch] Config print failed")
    end
end)

addButton(SettingsPage, "Close UI", function()
    Main.Visible = false
    S.UIEnabled = false
end)

-- ============================================================
-- Menu key / mobile button
-- ============================================================

local function toggleMenu()
    S.UIEnabled = not S.UIEnabled
    Main.Visible = S.UIEnabled
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.Insert then
        toggleMenu()
    end
end)

local MobileButton = Instance.new("TextButton")
MobileButton.Size = UDim2.fromOffset(46, 46)
MobileButton.Position = UDim2.new(0, 15, 0.5, -23)
MobileButton.BackgroundColor3 = Color3.fromRGB(35, 36, 45)
MobileButton.BorderSizePixel = 0
MobileButton.Text = "A"
MobileButton.TextColor3 = Color3.fromRGB(100, 170, 240)
MobileButton.Font = Enum.Font.GothamBold
MobileButton.TextSize = 20
MobileButton.Parent = ScreenGui

local mbc = Instance.new("UICorner")
mbc.CornerRadius = UDim.new(1, 0)
mbc.Parent = MobileButton

MobileButton.MouseButton1Click:Connect(toggleMenu)

-- ============================================================
-- Drag
-- ============================================================

local dragging = false
local dragStart
local startPos

Top.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if not dragging then return end
    if input.UserInputType ~= Enum.UserInputType.MouseMovement
        and input.UserInputType ~= Enum.UserInputType.Touch then
        return
    end

    local delta = input.Position - dragStart
    Main.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- ============================================================
-- Initial state
-- ============================================================

Pages.Legit.Visible = true
TabButtons.Legit.BackgroundColor3 = Color3.fromRGB(54, 108, 185)

pcall(function()
    local camera = workspace.CurrentCamera
    if camera and type(S.FOV) == "number" then
        camera.FieldOfView = math.clamp(S.FOV, 40, 120)
    end
end)

notify("Arch + Kicia Delta-safe UI loaded")
notify("Kicia is above Settings/Config")
