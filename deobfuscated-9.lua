-- This file was generated at discord.gg/syncrypt

local t1 = {}
local v2 = unpack or table.unpack
t1.value1 = game:GetService("Players")
t1.value2 = game:GetService("UserInputService")
t1.value3 = game:GetService("RunService")
t1.value4 = game:GetService("ReplicatedStorage")
t1.value5 = game:GetService("TweenService")
t1.value6 = game:GetService("Workspace")
t1.value7 = game:GetService("HttpService")
t1.value8 = t1.value1.LocalPlayer
local PlayerGui = t1.value8:WaitForChild("PlayerGui")
t1.value9 = t1.value6.CurrentCamera
t1.value10 = t1.value2.TouchEnabled and not t1.value2.KeyboardEnabled
local v4 = not t1.value2.TouchEnabled
local color3 = Color3.fromRGB(0, 150, 255)
local color3_2 = Color3.fromRGB(5, 5, 5)
local color3_3 = Color3.fromRGB(15, 15, 15)
local color3_4 = Color3.fromRGB(25, 25, 25)
local color3_5 = Color3.fromRGB(200, 200, 200)
local color3_6 = Color3.fromRGB(100, 100, 100)
local color3_7 = Color3.fromRGB(0, 150, 255)
local color3_8 = Color3.fromRGB(40, 40, 40)
local color3_9 = Color3.fromRGB(0, 150, 255)
local color3_10 = Color3.fromRGB(30, 30, 30)
local color3_11 = Color3.fromRGB(0, 150, 255)
local GothamBold = Enum.Font.GothamBold
local GothamMedium = Enum.Font.GothamMedium
local color3_12 = Color3.fromRGB(30, 180, 255)
local color3_13 = Color3.fromRGB(40, 40, 40)
local color3_14 = Color3.fromRGB(0, 100, 200)
local color3_15 = Color3.fromRGB(35, 35, 35)
local color3_16 = Color3.fromRGB(40, 40, 40)
local color3_17 = Color3.fromRGB(0, 150, 255)
t1.value11 = {
	Accent = color3,
	Background = color3_2,
	Surface = color3_3,
	SurfaceLight = color3_4,
	Text = color3_5,
	TextSecondary = color3_6,
	ToggleOn = color3_7,
	ToggleOff = color3_8,
	TabActive = color3_9,
	TabInactive = color3_10,
	Border = color3_11,
	Font = GothamBold,
	FontMedium = GothamMedium,
	HoverAccent = color3_12,
	HoverSurface = color3_13,
	ClickAccent = color3_14,
	ClickSurface = color3_15,
	DropdownHover = color3_16,
	DropdownSelected = color3_17
}
local t2 = {
	Ragebot = false,
	AutoShoot = false,
	AutoShootShootAttempt = 0,
	RapidFire = false,
	Fly = false,
	FlySpeed = 80,
	InfiniteJump = false,
	Noclip = false,
	Esp = false,
	EspBoxes = true,
	EspNames = true,
	EspHealth = true,
	EspDistance = false,
	EspHealthNumber = false,
	EspChams = false,
	AnimationEnabled = false,
	AnimationPreset = "Underground Glitch",
	AnimationSpeed = 2,
	AutoCollect = false,
	FOVEnabled = false,
	FOVShow = true,
	FOVRadius = 100,
	FOVFollowMuzzle = false,
	FOVFilled = false,
	FOVSpin = false,
	FOVSpinSpeed = 1,
	FOVAnimated = false,
	AutoQueueEnabled = false,
	AutoQueueMode = "1v1",
	MainFOVEnabled = false,
	MainFOVRadius = 300,
	MainFOVShow = true
}
t1.value12 = nil
t1.value12 = t2
function t1.value13()
    pcall(function()
        if not isfolder or not makefolder then
            return
        end

        if not isfolder("oishi_hub") then
            makefolder("oishi_hub")
        end

        writefile("oishi_hub/settings.json", t1.value7:JSONEncode(t1.value12))
    end)
end
local v25 = (function()
    local ok, result = pcall(function()
        if not isfolder or not makefolder then
            return nil
        end

        if not isfolder("oishi_hub") then
            makefolder("oishi_hub")
        end

        if isfile("oishi_hub/settings.json") then
            local value7 = t1.value7
            local t3 = { readfile("oishi_hub/settings.json") }

            return value7:JSONDecode(v2(t3))
        end

        return nil
    end)

    if ok and result then
        return result
    end

    return nil
end)()
if v25 then
    for k, _ in pairs(t1.value12) do
        local v28 = k

        if v25[v28] ~= nil then
            t1.value12[v28] = v25[v28]
        end
    end
end
local function v29(p1)
    if not p1 then
        return false
    end

    local Team = t1.value8.Team
    local v70 = Team and Team.TeamColor
    local TeamID = t1.value8:GetAttribute("TeamID")
    local Team2 = p1.Team
    local v73 = Team2 and Team2.TeamColor
    local TeamID2 = p1:GetAttribute("TeamID")

    if Team and (Team2 and Team == Team2) then
        return true
    end

    if v70 and (v73 and v70 == v73) then
        return true
    end

    if TeamID and (TeamID2 and TeamID == TeamID2) then
        return true
    end

    return false
end
if PlayerGui:FindFirstChild("OishiHub") then
    PlayerGui.OishiHub:Destroy()
end
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "OishiHub"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 999999
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
t1.value14 = if not v4 then math.min(500, t1.value9.ViewportSize.X - 20) else 400
t1.value15 = if not v4 then math.min(350, t1.value9.ViewportSize.Y * 0.4) else 400
t1.value16 = Instance.new("Frame")
t1.value16.Size = UDim2.new(0, t1.value14, 0, t1.value15)
t1.value16.Position = UDim2.new(0.5, -t1.value14 / 2, 0.5, -t1.value15 / 2)
t1.value16.BackgroundColor3 = t1.value11.Background
t1.value16.BackgroundTransparency = 1
t1.value16.BorderSizePixel = 0
t1.value16.Active = true
t1.value16.Visible = false
t1.value16.ZIndex = 10
t1.value16.Parent = ScreenGui
t1.value17 = Instance.new("UIStroke")
t1.value17.Color = t1.value11.Border
t1.value17.Thickness = 2
t1.value17.Transparency = 0
t1.value17.Parent = t1.value16
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(1, 0, 0, 24)
Frame.BackgroundColor3 = t1.value11.Surface
Frame.BackgroundTransparency = 0
Frame.BorderSizePixel = 0
Frame.ZIndex = 11
Frame.Parent = t1.value16
local TextLabel = Instance.new("TextLabel")
TextLabel.Size = UDim2.new(0, 140, 0, 14)
TextLabel.Position = UDim2.new(0, 10, 0, 5)
TextLabel.BackgroundTransparency = 1
TextLabel.Text = "OISHI HUB V1.02"
TextLabel.Font = t1.value11.Font
TextLabel.TextSize = 10
TextLabel.TextColor3 = t1.value11.Accent
TextLabel.TextXAlignment = Enum.TextXAlignment.Left
TextLabel.ZIndex = 12
TextLabel.Parent = Frame
local TextButton = Instance.new("TextButton")
TextButton.Size = UDim2.new(0, 16, 0, 16)
TextButton.Position = UDim2.new(1, -22, 0, 4)
TextButton.BackgroundTransparency = 1
TextButton.Text = "X"
TextButton.Font = t1.value11.Font
TextButton.TextSize = 9
TextButton.TextColor3 = t1.value11.TextSecondary
TextButton.ZIndex = 12
TextButton.Parent = Frame
local function v34()
    t1.value16.Visible = true
    t1.value16.BackgroundTransparency = 1
    t1.value16.Position = UDim2.new(0.5, -t1.value14 / 2, 0.5, -t1.value15 / 2 + 30)
    t1.value17.Transparency = 1

    local value5 = t1.value5
    local value16 = t1.value16
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local new = UDim2.new
    local Create = value5.Create
    local v87 = new(0.5, -t1.value14 / 2, 0.5, -t1.value15 / 2)

    Create(value5, value16, tweenInfo, {
		BackgroundTransparency = 0,
		Position = v87
	}):Play()
    t1.value5:Create(t1.value17, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Transparency = 0
	}):Play()
end
function t1.value18()
    local value5 = t1.value5
    local value16 = t1.value16
    local new = TweenInfo.new
    local EasingStyle = Enum.EasingStyle
    local Create = value5.Create
    local v80 = new(0.2, EasingStyle.Quad, Enum.EasingDirection.In)
    local uDim2 = UDim2.new(0.5, -t1.value14 / 2, 0.5, -t1.value15 / 2 + 30)

    Create(value5, value16, v80, {
		BackgroundTransparency = 1,
		Position = uDim2
	}):Play()
    t1.value5:Create(t1.value17, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
		Transparency = 1
	}):Play()
    task.wait(0.2)
    t1.value16.Visible = false
end
TextButton.MouseButton1Click:Connect(function()
    t1.value18()

    if t1.value10 and ToggleBtn then
        ToggleBtn.Text = ">"
    end
end)
local Frame2 = Instance.new("Frame")
Frame2.Size = UDim2.new(1, 0, 0, 22)
Frame2.Position = UDim2.new(0, 0, 0, 24)
Frame2.BackgroundColor3 = t1.value11.Surface
Frame2.BackgroundTransparency = 0
Frame2.BorderSizePixel = 0
Frame2.ZIndex = 11
Frame2.Parent = t1.value16
local t4 = {
	{
		name = "Main"
	},
	{
		name = "Ragebot"
	},
	{
		name = "ESP"
	},
	{
		name = "Auto"
	},
	{
		name = "Misc"
	},
	{
		name = "Settings"
	}
}
t1.value19 = "Main"
t1.value20 = {}
t1.value21 = {}
local Frame3 = Instance.new("Frame")
Frame3.Size = UDim2.new(1, 0, 1, -46)
Frame3.Position = UDim2.new(0, 0, 0, 46)
Frame3.BackgroundTransparency = 1
Frame3.BorderSizePixel = 0
Frame3.ClipsDescendants = true
Frame3.ZIndex = 11
Frame3.Parent = t1.value16
for v40, v41 in ipairs(t4) do

    local v42 = v41
    local TextButton2 = Instance.new("TextButton")

    TextButton2.Size = UDim2.new(0.16666666666667, -1.5, 0, 18)
    TextButton2.Position = UDim2.new((v40 - 1) * 0.16666666666667, 0.75, 0, 2)
    TextButton2.BackgroundColor3 = v42.name == t1.value19 and t1.value11.TabActive or t1.value11.TabInactive
    TextButton2.BackgroundTransparency = v42.name ~= t1.value19 and 0.5 or 0.3
    TextButton2.BorderSizePixel = 0
    TextButton2.Text = v42.name
    TextButton2.Font = t1.value11.Font
    TextButton2.TextSize = 6
    TextButton2.TextColor3 = v42.name == t1.value19 and Color3.new(1, 1, 1) or t1.value11.Text
    TextButton2.ZIndex = 12
    TextButton2.AutoButtonColor = false
    TextButton2.Parent = Frame2
    t1.value20[v42.name] = TextButton2
    TextButton2.MouseEnter:Connect(function()
        local v88 = t1.value19 == v42.name
        local value5 = t1.value5
        local v90 = TextButton2
        local tweenInfo = TweenInfo.new(0.2)
        local v92 = v88 and t1.value11.HoverAccent or t1.value11.HoverSurface
        local v93 = v88 and 0.2
        local Create = value5.Create
        local v95 = v93 or 0.3

        Create(value5, v90, tweenInfo, {
			BackgroundColor3 = v92,
			BackgroundTransparency = v95
		}):Play()
    end)
    TextButton2.MouseLeave:Connect(function()
        local v96 = t1.value19 == v42.name
        local value5 = t1.value5
        local v98 = TextButton2
        local tweenInfo = TweenInfo.new(0.2)
        local v100 = v96 and t1.value11.TabActive or t1.value11.TabInactive
        local Create = value5.Create
        local v102 = not v96 and 0.5 or 0.3

        Create(value5, v98, tweenInfo, {
			BackgroundColor3 = v100,
			BackgroundTransparency = v102
		}):Play()
    end)
    TextButton2.MouseButton1Down:Connect(function()
        t1.value5:Create(TextButton2, TweenInfo.new(0.05), {
			BackgroundColor3 = t1.value11.ClickAccent,
			BackgroundTransparency = 0.1
		}):Play()
    end)
    TextButton2.MouseButton1Up:Connect(function()
        local v103 = t1.value19 == v42.name
        local value5 = t1.value5
        local v105 = TextButton2
        local tweenInfo = TweenInfo.new(0.1)
        local v107 = v103 and t1.value11.HoverAccent or t1.value11.HoverSurface
        local Create = value5.Create
        local v109 = not v103 and 0.3 or 0.2

        Create(value5, v105, tweenInfo, {
			BackgroundColor3 = v107,
			BackgroundTransparency = v109
		}):Play()
    end)

    local Frame4 = Instance.new("Frame")

    Frame4.Size = UDim2.new(1, 0, 1, 0)
    Frame4.Position = UDim2.new(0, 0, 0, 0)
    Frame4.BackgroundTransparency = 1
    Frame4.BorderSizePixel = 0
    Frame4.Visible = v42.name == t1.value19
    Frame4.ZIndex = 11
    Frame4.Parent = Frame3

    local ScrollingFrame = Instance.new("ScrollingFrame")

    ScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
    ScrollingFrame.BackgroundTransparency = 1
    ScrollingFrame.BorderSizePixel = 0
    ScrollingFrame.ScrollBarThickness = 2
    ScrollingFrame.ScrollBarImageColor3 = t1.value11.Accent
    ScrollingFrame.ScrollBarImageTransparency = 0.5
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 200)
    ScrollingFrame.ZIndex = 12
    ScrollingFrame.Parent = Frame4

    local UIPadding = Instance.new("UIPadding")

    UIPadding.PaddingTop = UDim.new(0, 4)
    UIPadding.PaddingLeft = UDim.new(0, 8)
    UIPadding.PaddingRight = UDim.new(0, 8)
    UIPadding.Parent = ScrollingFrame

    local UIGridLayout = Instance.new("UIGridLayout")

    UIGridLayout.CellPadding = UDim2.new(0, 4, 0, 3)
    UIGridLayout.CellSize = UDim2.new(0.5, -6, 0, 32)
    UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIGridLayout.Parent = ScrollingFrame
    t1.value21[v42.name] = {
		frame = Frame4,
		scroll = ScrollingFrame,
		layout = UIGridLayout
	}
end
for k, v in pairs(t1.value20) do
    v.MouseButton1Click:Connect(function()
        if t1.value19 == k then
            return
        end
        local value19 = t1.value19
        t1.value19 = k
        for v113, v114 in pairs(t1.value20) do

            if v113 == k then
                local value5 = t1.value5
                local tweenInfo = TweenInfo.new(0.2)
                local TabActive = t1.value11.TabActive
                local color3_18 = Color3.new(1, 1, 1)

                value5:Create(v114, tweenInfo, {
					BackgroundColor3 = TabActive,
					BackgroundTransparency = 0.3,
					TextColor3 = color3_18
				}):Play()
            else
                local value5 = t1.value5
                local tweenInfo = TweenInfo.new(0.2)
                local TabInactive = t1.value11.TabInactive
                local value11Text = t1.value11.Text

                value5:Create(v114, tweenInfo, {
					BackgroundColor3 = TabInactive,
					BackgroundTransparency = 0.5,
					TextColor3 = value11Text
				}):Play()
            end
        end
        local v123 = t1.value21[value19]
        local v124 = k
        local v125 = t1.value21[v124]
        if v123 and v125 then
            v123.frame.Visible = true
            v125.frame.Visible = false
            v125.frame.Position = UDim2.new(1, 0, 0, 0)
            t1.value5:Create(v123.frame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				Position = UDim2.new(-1, 0, 0, 0)
			}):Play()
            task.wait(0.2)
            v123.frame.Visible = false
            v123.frame.Position = UDim2.new(0, 0, 0, 0)
            v125.frame.Visible = true
            v125.frame.Position = UDim2.new(1, 0, 0, 0)
            t1.value5:Create(v125.frame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Position = UDim2.new(0, 0, 0, 0)
			}):Play()
        end
    end)
end
local function v50(p2, p3, p4, p5)
    local v130 = t1.value21[p2]

    if not v130 then
        return
    end

    local Frame5 = Instance.new("Frame")

    Frame5.Size = UDim2.new(1, 0, 1, 0)
    Frame5.BackgroundColor3 = t1.value11.Surface
    Frame5.BackgroundTransparency = 0
    Frame5.BorderSizePixel = 0
    Frame5.ZIndex = 12
    Frame5.Parent = v130.scroll

    local TextLabel2 = Instance.new("TextLabel")

    TextLabel2.Size = UDim2.new(0, 80, 0, 12)
    TextLabel2.Position = UDim2.new(0, 6, 0, 4)
    TextLabel2.BackgroundTransparency = 1
    TextLabel2.Text = p3
    TextLabel2.Font = t1.value11.FontMedium
    TextLabel2.TextSize = 9
    TextLabel2.TextColor3 = t1.value11.Text
    TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel2.ZIndex = 13
    TextLabel2.Parent = Frame5

    local TextButton3 = Instance.new("TextButton")

    TextButton3.Size = UDim2.new(0, 28, 0, 16)
    TextButton3.Position = UDim2.new(1, -34, 0, 4)

    local v134 = t1.value12[p4]

    if v134 then
        v134 = t1.value11.ToggleOn
    end

    TextButton3.BackgroundColor3 = v134 or t1.value11.ToggleOff
    TextButton3.BorderSizePixel = 0
    TextButton3.Text = ""
    TextButton3.AutoButtonColor = false
    TextButton3.ZIndex = 13
    TextButton3.Parent = Frame5

    local UIStroke = Instance.new("UIStroke")

    UIStroke.Color = t1.value11.Border
    UIStroke.Thickness = 1
    UIStroke.Transparency = not t1.value12[p4] and 0.8 or 0.3
    UIStroke.Parent = TextButton3

    local Frame6 = Instance.new("Frame")

    Frame6.Size = UDim2.new(0, 12, 0, 12)
    Frame6.Position = t1.value12[p4] and UDim2.new(0, 15, 0, 2) or UDim2.new(0, 1, 0, 2)
    Frame6.BackgroundColor3 = Color3.new(1, 1, 1)
    Frame6.BorderSizePixel = 0
    Frame6.ZIndex = 14
    Frame6.Parent = TextButton3
    TextButton3.MouseButton1Click:Connect(function()
        local v428 = t1.value12[p4]

        t1.value12[p4] = not v428
        t1.value13()
        t1.value5:Create(UIStroke, TweenInfo.new(0.2), {
			Transparency = not t1.value12[p4] and 0.8 or 0.3
		}):Play()

        if t1.value12[p4] then
            t1.value5:Create(TextButton3, TweenInfo.new(0.2), {
				BackgroundColor3 = t1.value11.ToggleOn
			}):Play()
            t1.value5:Create(Frame6, TweenInfo.new(0.2), {
				Position = UDim2.new(0, 15, 0, 2)
			}):Play()
        else
            t1.value5:Create(TextButton3, TweenInfo.new(0.2), {
				BackgroundColor3 = t1.value11.ToggleOff
			}):Play()
            t1.value5:Create(Frame6, TweenInfo.new(0.2), {
				Position = UDim2.new(0, 1, 0, 2)
			}):Play()
        end

        if p5 then
            p5(t1.value12[p4])
        end
    end)

    return Frame5
end
local function v51(p6, p7, p8, p9, p10, p11, p12, p13, p14)
    local v146 = t1.value21[p6]

    if not v146 then
        return
    end

    local Frame7 = Instance.new("Frame")

    Frame7.Size = UDim2.new(1, 0, 0, 48)
    Frame7.BackgroundColor3 = t1.value11.Surface
    Frame7.BackgroundTransparency = 0
    Frame7.BorderSizePixel = 0
    Frame7.ZIndex = 12
    Frame7.Parent = v146.scroll

    local TextLabel3 = Instance.new("TextLabel")

    TextLabel3.Size = UDim2.new(0, 80, 0, 10)
    TextLabel3.Position = UDim2.new(0, 6, 0, 3)
    TextLabel3.BackgroundTransparency = 1
    TextLabel3.Text = p7
    TextLabel3.Font = t1.value11.FontMedium
    TextLabel3.TextSize = 8
    TextLabel3.TextColor3 = t1.value11.Text
    TextLabel3.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel3.ZIndex = 13
    TextLabel3.Parent = Frame7

    local TextButton4 = Instance.new("TextButton")

    TextButton4.Size = UDim2.new(0, 28, 0, 16)
    TextButton4.Position = UDim2.new(1, -34, 0, 2)
    TextButton4.BackgroundColor3 = t1.value12[p8] and t1.value11.ToggleOn or t1.value11.ToggleOff
    TextButton4.BorderSizePixel = 0
    TextButton4.Text = ""
    TextButton4.AutoButtonColor = false
    TextButton4.ZIndex = 13
    TextButton4.Parent = Frame7

    local UIStroke = Instance.new("UIStroke")

    UIStroke.Color = t1.value11.Border
    UIStroke.Thickness = 1
    UIStroke.Transparency = not t1.value12[p8] and 0.8 or 0.3
    UIStroke.Parent = TextButton4

    local Frame8 = Instance.new("Frame")

    Frame8.Size = UDim2.new(0, 12, 0, 12)
    Frame8.Position = t1.value12[p8] and UDim2.new(0, 15, 0, 2) or UDim2.new(0, 1, 0, 2)
    Frame8.BackgroundColor3 = Color3.new(1, 1, 1)
    Frame8.BorderSizePixel = 0
    Frame8.ZIndex = 14
    Frame8.Parent = TextButton4

    local TextLabel4 = Instance.new("TextLabel")

    TextLabel4.Size = UDim2.new(0, 40, 0, 10)
    TextLabel4.Position = UDim2.new(1, -46, 0, 22)
    TextLabel4.BackgroundTransparency = 1
    TextLabel4.Text = tostring(t1.value12[p11] or p9) .. (p12 or "")
    TextLabel4.Font = t1.value11.FontMedium
    TextLabel4.TextSize = 8
    TextLabel4.TextColor3 = t1.value11.Accent
    TextLabel4.TextXAlignment = Enum.TextXAlignment.Right
    TextLabel4.ZIndex = 13
    TextLabel4.Parent = Frame7

    local Frame9 = Instance.new("Frame")

    Frame9.Size = UDim2.new(1, -12, 0, 2)
    Frame9.Position = UDim2.new(0, 6, 0, 36)
    Frame9.BackgroundColor3 = t1.value11.SurfaceLight
    Frame9.BorderSizePixel = 0
    Frame9.ZIndex = 13
    Frame9.Parent = Frame7

    local Frame10 = Instance.new("Frame")
    local v155 = (t1.value12[p11] or p9 - p9) / (p10 - p9)

    Frame10.Size = UDim2.new(v155, 0, 1, 0)
    Frame10.BackgroundColor3 = t1.value11.Accent
    Frame10.BorderSizePixel = 0
    Frame10.ZIndex = 14
    Frame10.Parent = Frame9

    local Frame11 = Instance.new("Frame")

    Frame11.Size = UDim2.new(0, 10, 0, 10)
    Frame11.Position = UDim2.new(1, -5, 0.5, -5)
    Frame11.BackgroundColor3 = Color3.new(1, 1, 1)
    Frame11.BorderSizePixel = 0
    Frame11.ZIndex = 15
    Frame11.Parent = Frame10
    TextButton4.MouseButton1Click:Connect(function()
        local v429 = t1.value12[p8]

        t1.value12[p8] = not v429
        t1.value13()
        t1.value5:Create(UIStroke, TweenInfo.new(0.2), {
			Transparency = not t1.value12[p8] and 0.8 or 0.3
		}):Play()

        if t1.value12[p8] then
            t1.value5:Create(TextButton4, TweenInfo.new(0.2), {
				BackgroundColor3 = t1.value11.ToggleOn
			}):Play()
            t1.value5:Create(Frame8, TweenInfo.new(0.2), {
				Position = UDim2.new(0, 15, 0, 2)
			}):Play()
        else
            t1.value5:Create(TextButton4, TweenInfo.new(0.2), {
				BackgroundColor3 = t1.value11.ToggleOff
			}):Play()
            t1.value5:Create(Frame8, TweenInfo.new(0.2), {
				Position = UDim2.new(0, 1, 0, 2)
			}):Play()
        end

        if p13 then
            p13(t1.value12[p8])
        end
    end)

    local function v157(p15)
        local v431 = math.clamp((p15.Position.X - Frame9.AbsolutePosition.X) / Frame9.AbsoluteSize.X, 0, 1)
        local v432 = math.floor(p9 + (p10 - p9) * v431)

        t1.value12[p11] = v432
        t1.value13()
        TextLabel4.Text = tostring(v432) .. (p12 or "")
        t1.value5:Create(Frame10, TweenInfo.new(0.1), {
			Size = UDim2.new(v431, 0, 1, 0)
		}):Play()

        if p14 then
            p14(v432)
        end
    end

    Frame9.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            v157(input)
            local connection
            local connection2 = t1.value2.InputChanged:Connect(function(input2)
                if input2.UserInputType == Enum.UserInputType.MouseMovement or input2.UserInputType == Enum.UserInputType.Touch then
                    v157(input2)
                end
            end)
            connection = t1.value2.InputEnded:Connect(function(input3)
                if input3.UserInputType == Enum.UserInputType.MouseButton1 or input3.UserInputType == Enum.UserInputType.Touch then
                    if connection2 then
                        connection2:Disconnect()
                    end

                    if connection then
                        connection:Disconnect()
                    end
                end
            end)
        end
    end)

    return Frame7
end
local function v52(p16, p17, p18, p19, p20)
    local v179 = t1.value21[p16]

    if not v179 then
        return
    end

    local Frame12 = Instance.new("Frame")

    Frame12.Size = UDim2.new(1, 0, 0, 48)
    Frame12.BackgroundColor3 = t1.value11.Surface
    Frame12.BackgroundTransparency = 0
    Frame12.BorderSizePixel = 0
    Frame12.ZIndex = 12
    Frame12.Parent = v179.scroll

    local TextLabel5 = Instance.new("TextLabel")

    TextLabel5.Size = UDim2.new(0, 80, 0, 10)
    TextLabel5.Position = UDim2.new(0, 6, 0, 3)
    TextLabel5.BackgroundTransparency = 1
    TextLabel5.Text = p17
    TextLabel5.Font = t1.value11.FontMedium
    TextLabel5.TextSize = 8
    TextLabel5.TextColor3 = t1.value11.Text
    TextLabel5.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel5.ZIndex = 13
    TextLabel5.Parent = Frame12

    local TextButton5 = Instance.new("TextButton")

    TextButton5.Size = UDim2.new(1, -12, 0, 20)
    TextButton5.Position = UDim2.new(0, 6, 0, 16)
    TextButton5.BackgroundColor3 = t1.value11.SurfaceLight
    TextButton5.BorderSizePixel = 0
    TextButton5.Text = t1.value12[p18] or p19[1]
    TextButton5.Font = t1.value11.FontMedium
    TextButton5.TextSize = 8
    TextButton5.TextColor3 = t1.value11.Text
    TextButton5.ZIndex = 13
    TextButton5.AutoButtonColor = false
    TextButton5.Parent = Frame12

    local UIStroke = Instance.new("UIStroke")

    UIStroke.Color = t1.value11.Border
    UIStroke.Thickness = 1
    UIStroke.Transparency = 0.3
    UIStroke.Parent = TextButton5

    local TextLabel6 = Instance.new("TextLabel")

    TextLabel6.Size = UDim2.new(0, 14, 0, 14)
    TextLabel6.Position = UDim2.new(1, -18, 0, 3)
    TextLabel6.BackgroundTransparency = 1
    TextLabel6.Text = "▼"
    TextLabel6.Font = t1.value11.Font
    TextLabel6.TextSize = 8
    TextLabel6.TextColor3 = t1.value11.Accent
    TextLabel6.ZIndex = 14
    TextLabel6.Parent = TextButton5

    local Frame13 = Instance.new("Frame")

    Frame13.Size = UDim2.new(1, -12, 0, 0)
    Frame13.Position = UDim2.new(0, 6, 0, 38)
    Frame13.BackgroundColor3 = t1.value11.Surface
    Frame13.BackgroundTransparency = 0
    Frame13.BorderSizePixel = 0
    Frame13.ClipsDescendants = true
    Frame13.Visible = false
    Frame13.ZIndex = 100
    Frame13.Parent = Frame12

    local UIStroke2 = Instance.new("UIStroke")

    UIStroke2.Color = t1.value11.Accent
    UIStroke2.Thickness = 1
    UIStroke2.Transparency = 0.3
    UIStroke2.Parent = Frame13

    local ScrollingFrame = Instance.new("ScrollingFrame")

    ScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
    ScrollingFrame.BackgroundTransparency = 1
    ScrollingFrame.BorderSizePixel = 0
    ScrollingFrame.ScrollBarThickness = 2
    ScrollingFrame.ScrollBarImageColor3 = t1.value11.Accent
    ScrollingFrame.ScrollBarImageTransparency = 0.3
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, #p19 * 20)
    ScrollingFrame.ZIndex = 101
    ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.Y
    ScrollingFrame.Parent = Frame13

    local UIListLayout = Instance.new("UIListLayout")

    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 1)
    UIListLayout.Parent = ScrollingFrame

    local u189 = false
    local t5 = {}

    local function v191()
        u189 = false
        t1.value5:Create(Frame13, TweenInfo.new(0.1), {
			Size = UDim2.new(1, -12, 0, 0)
		}):Play()
        task.wait(0.1)
        Frame13.Visible = false
        Frame12.Size = UDim2.new(1, 0, 0, 48)
        t1.value5:Create(TextLabel6, TweenInfo.new(0.1), {
			Rotation = 0
		}):Play()
    end
    local function v192()
        u189 = true
        Frame13.Visible = true

        local v442 = math.min(#p19 * 20 + 2, 100)

        t1.value5:Create(Frame13, TweenInfo.new(0.1), {
			Size = UDim2.new(1, -12, 0, v442)
		}):Play()
        ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, #p19 * 20)
        Frame12.Size = UDim2.new(1, 0, 0, 48)
        t1.value5:Create(TextLabel6, TweenInfo.new(0.1), {
			Rotation = 180
		}):Play()
    end

    for _, v in ipairs(p19) do
        local v195 = v
        local TextButton6 = Instance.new("TextButton")

        TextButton6.Size = UDim2.new(1, 0, 0, 18)
        TextButton6.BackgroundColor3 = v195 == t1.value12[p18] and t1.value11.DropdownSelected or t1.value11.SurfaceLight
        TextButton6.BackgroundTransparency = v195 ~= t1.value12[p18] and 0.1 or 0.3
        TextButton6.BorderSizePixel = 0
        TextButton6.Text = v195
        TextButton6.Font = t1.value11.FontMedium
        TextButton6.TextSize = 8
        TextButton6.TextColor3 = v195 == t1.value12[p18] and Color3.new(1, 1, 1) or t1.value11.Text
        TextButton6.ZIndex = 102
        TextButton6.AutoButtonColor = false
        TextButton6.Parent = ScrollingFrame
        TextButton6.MouseEnter:Connect(function()
            if v195 ~= t1.value12[p18] then
                t1.value5:Create(TextButton6, TweenInfo.new(0.1), {
					BackgroundColor3 = t1.value11.DropdownHover,
					BackgroundTransparency = 0.2
				}):Play()
            end
        end)
        TextButton6.MouseLeave:Connect(function()
            if v195 ~= t1.value12[p18] then
                t1.value5:Create(TextButton6, TweenInfo.new(0.1), {
					BackgroundColor3 = t1.value11.SurfaceLight,
					BackgroundTransparency = 0.1
				}):Play()
            end
        end)
        TextButton6.MouseButton1Click:Connect(function()
            t1.value12[p18] = v195
            t1.value13()
            TextButton5.Text = v195

            for _, v3 in ipairs(t5) do
                if v3.Text == v195 then
                    local value5 = t1.value5
                    local tweenInfo = TweenInfo.new(0.1)
                    local DropdownSelected = t1.value11.DropdownSelected
                    local _Color3 = Color3
                    local Create = value5.Create
                    local v450 = _Color3.new(1, 1, 1)

                    Create(value5, v3, tweenInfo, {
						BackgroundColor3 = DropdownSelected,
						BackgroundTransparency = 0.3,
						TextColor3 = v450
					}):Play()
                else
                    local value5 = t1.value5
                    local tweenInfo = TweenInfo.new(0.1)
                    local SurfaceLight = t1.value11.SurfaceLight
                    local value11 = t1.value11
                    local Create = value5.Create
                    local value11Text = value11.Text

                    Create(value5, v3, tweenInfo, {
						BackgroundColor3 = SurfaceLight,
						BackgroundTransparency = 0.1,
						TextColor3 = value11Text
					}):Play()
                end
            end

            v191()

            if p20 then
                p20(v195)
            end
        end)
        table.insert(t5, TextButton6)
    end

    TextButton5.MouseButton1Click:Connect(function()
        if u189 then
            v191()

            return
        end

        v192()
    end)
    v179.scroll:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
        if u189 then
            v191()
        end
    end)

    return Frame12
end
local Players = game:GetService("Players")
t1.value22 = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
t1.value23 = Players.LocalPlayer
local Utility = require(ReplicatedStorage.Modules.Utility)
t1.value24 = Utility.Raycast
t1.value25 = Drawing.new("Circle")
t1.value25.Visible = t1.value12.MainFOVShow
t1.value25.Radius = t1.value12.MainFOVRadius
t1.value25.Color = Color3.fromRGB(0, 150, 255)
t1.value25.Thickness = 1
t1.value25.Filled = false
game:GetService("RunService").RenderStepped:Connect(function()
    t1.value25.Position = t1.value9.ViewportSize / 2
    t1.value25.Radius = t1.value12.MainFOVRadius
    t1.value25.Visible = t1.value12.MainFOVShow
end)
function t1.value26()
    local vector2 = Vector2.new(t1.value9.ViewportSize.X / 2, t1.value9.ViewportSize.Y / 2)
    local v198
    local MainFOVRadius = t1.value12.MainFOVRadius
    for _, v201 in t1.value22:GetTagged("Entity") do
        if v201 ~= t1.value23.Character then
            local Head = v201:FindFirstChild("Head", true)

            if Head and Head:IsA("BasePart") then
                local v203, v204 = t1.value9:WorldToViewportPoint(Head.Position)

                if v204 then
                    local Magnitude = (vector2 - Vector2.new(v203.X, v203.Y)).Magnitude

                    if Magnitude < MainFOVRadius then
                        v198 = Head
                        MainFOVRadius = Magnitude
                    end
                end
            end
        end
    end

    return v198
end
function Utility.Raycast(p21, p22, p23, p24, p25, p26, p27)
    if type(p24) ~= "number" or p24 < 100 then
        return t1.value24(p21, p22, p23, p24, p25, p26, p27)
    end

    local v213 = t1.value26()

    if not v213 then
        return t1.value24(p21, p22, p23, p24, p25, p26, p27)
    end

    local Position = v213.Position
    local Unit = (Position - p22).Unit
    local Magnitude = (Position - p22).Magnitude

    if p24 < Magnitude then
        Position = p22 + Unit * p24
        Magnitude = p24
    end

    local Material = v213.Material
    local v218 = -Unit

    return {
		Position = Position,
		Distance = Magnitude,
		Instance = v213,
		Material = Material,
		Normal = v218
	}
end
t1.value27 = nil
t1.value28 = false
t1.value29 = nil
local vector3 = Vector3.new(0, -1000, 0)
t1.value30 = nil
t1.value30 = vector3
function t1.value31()
    if t1.value27 then
        return
    end

    t1.value28 = true

    local value4 = t1.value4
    local value8 = t1.value8
    local Gun = require(value8.PlayerScripts.Modules.ItemTypes.Gun)
    local Utility2 = require(value4.Modules.Utility)
    local self = setmetatable({}, {
		__index = function(_, p29)
        local Character = value8.Character

        if not Character then
            return nil
        end

        if p29 == "root" then
            return Character:FindFirstChild("HumanoidRootPart")
        end

        if p29 == "head" then
            return Character:FindFirstChild("Head")
        end

        return nil
    end
	})

    t1.value27 = {
		Active = true
	}

    local value27 = t1.value27

    function value27.FindTarget(_)
        local Character = value8.Character
        if not Character then
            return nil
        end
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
        if not HumanoidRootPart then
            return nil
        end
        local v463
        local n1 = 1e999
        local _next = next
        local v466, v467 = t1.value1:GetPlayers()
        while true do
            local v468

            v467, v468 = _next(v466, v467)

            if not v467 then
                break
            end

            if v468 ~= value8 and not v29(v468) then
                local Character2 = v468.Character

                if Character2 then
                    local HumanoidRootPart2 = Character2:FindFirstChild("HumanoidRootPart")
                    local Head = Character2:FindFirstChild("Head")
                    local v472 = HumanoidRootPart2
                    local Humanoid = Character2:FindFirstChildWhichIsA("Humanoid")

                    if HumanoidRootPart2 then
                        if Head then
                            Head = Humanoid and Humanoid.Health > 0
                        end

                        v472 = Head
                    end

                    if v472 then
                        local Magnitude = (HumanoidRootPart.Position - HumanoidRootPart2.Position).Magnitude

                        if Magnitude < n1 then
                            n1 = Magnitude
                            v463 = v468
                        end
                    end
                end
            end
        end

        return v463
    end

    value27.Connection = t1.value3.Heartbeat:Connect(function()
        if not value27.Active then
            return
        end

        value27.Target = value27:FindTarget()

        if value27.Target and value27.Target.Character then
            local Head = value27.Target.Character:FindFirstChild("Head")

            if Head then
                local root = self.root

                if root then
                    local rootCFrame = root.CFrame
                    local rootVelocity = root.Velocity
                    local RotVelocity = root.RotVelocity

                    root.CFrame = Head.CFrame
                    root.Velocity = Vector3.zero
                    root.RotVelocity = Vector3.zero
                    t1.value29 = Head.Position
                    t1.value3:BindToRenderStep("WallbangRestore", 101, function()
                        root.CFrame = rootCFrame
                        root.Velocity = rootVelocity
                        root.RotVelocity = RotVelocity
                        t1.value3:UnbindFromRenderStep("WallbangRestore")
                    end)

                    return
                end
            end
        else
            local root = self.root

            if root then
                local rootCFrame = root.CFrame
                local rootVelocity = root.Velocity
                local RotVelocity = root.RotVelocity

                root.CFrame = CFrame.new(t1.value30)
                root.Velocity = Vector3.zero
                root.RotVelocity = Vector3.zero
                t1.value29 = t1.value30
                t1.value3:BindToRenderStep("WallbangVoid", 101, function()
                    root.CFrame = rootCFrame
                    root.Velocity = rootVelocity
                    root.RotVelocity = RotVelocity
                    t1.value3:UnbindFromRenderStep("WallbangVoid")
                end)
            end
        end
    end)

    local StartShooting = Gun.StartShooting

    value27.OldShootFunc = StartShooting

    function Gun.StartShooting(p31, ...)
        local t6 = { StartShooting(p31, ...) }

        if not p31.ClientFighter or not p31.ClientFighter.IsLocalPlayer then
            return unpack(t6)
        end

        local v486 = t6[3]

        if not v486 or typeof(v486) ~= "table" then
            return unpack(t6)
        end

        t6[4] = true

        local value27Target = value27.Target

        if not value27.Active or (not value27Target or not value27Target.Character) then
            return unpack(t6)
        end

        local Head = value27Target.Character:FindFirstChild("Head")

        if not Head then
            return unpack(t6)
        end

        local HeadPosition = Head.Position
        local v490 = Head.CFrame:ToObjectSpace(CFrame.new(HeadPosition + Vector3.new(math.random() * 0.1, math.random() * 0.1, math.random() * 0.1)))

        v486[utf8.char(0)] = Utility2:EncodeCFrame(CFrame.new(HeadPosition, HeadPosition + Head.CFrame.LookVector))

        local v491 = utf8.char(1)
        local v492 = Utility2
        local t7 = { CFrame.new(HeadPosition) }

        v486[v491] = v492:EncodeCFrame(v2(t7))
        v486[utf8.char(2)] = Head
        v486[utf8.char(3)] = Utility2:EncodeCFrame(v490)

        return unpack(t6)
    end
    function value27.Shutdown(p32)
        p32.Active = false
        t1.value29 = nil

        if p32.Connection then
            p32.Connection:Disconnect()
        end

        if p32.OldShootFunc then
            Gun.StartShooting = p32.OldShootFunc
        end

        t1.value3:UnbindFromRenderStep("WallbangRestore")
        t1.value3:UnbindFromRenderStep("WallbangVoid")
    end
end
function t1.value32()
    if t1.value27 then
        t1.value27:Shutdown()
    end

    t1.value28 = false
    t1.value29 = nil
end
t1.value33 = false
t1.value34 = nil
t1.value35 = 0
t1.value36 = false
t1.value37 = 0
t1.value38 = require(t1.value4.Modules.Utility)
t1.value39 = require(t1.value4.Modules.EnumLibrary)
t1.value40 = {
	"Medkit",
	"Grenade",
	"Flashbang",
	"Jump Pad",
	"Molotov",
	"Satchel",
	"Smoke Grenade",
	"War Horn",
	"Subspace Tripmine",
	"Warpstone"
}
function t1.value41()
    local Character = t1.value8.Character
    if not Character then
        return nil
    end
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
    if not HumanoidRootPart then
        return nil
    end
    local Head = Character:FindFirstChild("Head")
    local v244 = Head and Head.Position or HumanoidRootPart.Position
    if t1.value28 and t1.value29 then
        v244 = t1.value29
    end
    local v245
    local n2 = 1e999
    for _, player in ipairs(t1.value1:GetPlayers()) do
        if player ~= t1.value8 and not v29(player) then
            local Character3 = player.Character

            if Character3 then
                local Humanoid = Character3:FindFirstChildOfClass("Humanoid")

                if Humanoid and (Humanoid.Health > 0 and not Character3:FindFirstChildOfClass("ForceField")) then
                    local HumanoidRootPart3 = Character3:FindFirstChild("HumanoidRootPart")

                    if HumanoidRootPart3 then
                        local Magnitude = (HumanoidRootPart.Position - HumanoidRootPart3.Position).Magnitude

                        if Magnitude < n2 and (t1.value28 or not isBehindWall(v244, player)) then
                            n2 = Magnitude
                            v245 = Character3
                        end
                    end
                end
            end
        end
    end

    return v245
end
function t1.value42()
    local ViewModels = t1.value6:FindFirstChild("ViewModels")

    if not ViewModels then
        return nil
    end

    local FirstPerson = ViewModels:FindFirstChild("FirstPerson")

    if not FirstPerson then
        return nil
    end

    for _, child in ipairs(FirstPerson:GetChildren()) do
        local v233 = child.Name:find("-")

        if v233 then
            return child.Name:sub(v233 + 1):match("^%s*(.-)%s*$")
        end
    end

    return nil
end
function t1.value43()
    local v238 = t1.value12.AutoShootShootAttempt or 0

    if v238 <= 0 then
        return true
    end

    if v238 >= 100 then
        return math.random(1, 100) <= 1
    end

    return 100 - v238 >= math.random(1, 100)
end
function t1.value44()
    local v234 = t1.value12.AutoShootShootAttempt or 0

    if v234 <= 0 then
        return 0
    end

    return v234 / 100 * 0.5
end
function t1.value45()
    local Character = t1.value8.Character

    if not Character then
        return false
    end

    local Humanoid = Character:FindFirstChildOfClass("Humanoid")

    if not Humanoid or Humanoid.Health <= 0 then
        return false
    end

    return true
end
function t1.value46()
    t1.value36 = true
    t1.value37 = tick() + 6
    task.delay(6, function()
        t1.value36 = false
    end)
end
t1.value8.CharacterAdded:Connect(function(character)
    if t1.value33 then
        t1.value46()
    end

    local Humanoid = character:WaitForChild("Humanoid", 10)

    if Humanoid then
        Humanoid.Died:Connect(function()
            if t1.value33 then
                t1.value46()
            end
        end)
    end
end)
if t1.value8.Character then
    local Humanoid = t1.value8.Character:FindFirstChildOfClass("Humanoid")

    if Humanoid then
        Humanoid.Died:Connect(function()
            if t1.value33 then
                t1.value46()
            end
        end)
    end
end
function t1.value47()
    if not t1.value33 then
        return
    end

    if t1.value36 and tick() < t1.value37 then
        return
    end

    if not t1.value45() then
        return
    end

    local v266 = t1.value42()
    local g269

    if v266 then
        if not v266 then
            v266 = false
        else
            g269 = nil

            for _, v in ipairs(t1.value40) do
                if v266 == v then
                    v266 = true
                    g269 = true
                end

                if g269 then
                    break
                end
            end

            if not g269 then
                v266 = false
            end
        end
    end

    g269 = false

    if v266 then
        return
    end

    local timestamp = tick()

    if t1.value44() > timestamp - t1.value35 then
        return
    end

    if not t1.value43() then
        return
    end

    local v271 = t1.value41()

    if not v271 then
        return
    end

    local Head = v271:FindFirstChild("Head")

    if not Head then
        return
    end

    local player = t1.value1:GetPlayerFromCharacter(v271)

    if not player or v29(player) then
        return
    end

    pcall(function()
        local FighterController = require(t1.value8.PlayerScripts.Controllers.FighterController)
        local v496 = FighterController.LocalFighter and FighterController.LocalFighter.EquippedItem

        if not v496 then
            return
        end

        local v497 = v496:Get("ObjectID")

        if not v497 then
            return
        end

        local Character = t1.value8.Character
        local v499 = Character and Character:FindFirstChild("HumanoidRootPart")
        local v500 = v499 and v499.Position or Head.Position

        if t1.value28 and t1.value29 then
            v500 = t1.value29
        end

        local v501 = utf8.char(1)
        local v502 = utf8.char(0)
        local v503 = t1.value38:EncodeCFrame(CFrame.new(v500, Head.Position))
        local v504 = utf8.char(1)
        local value38 = t1.value38
        local t8 = { CFrame.new(v500, Head.Position) }
        local v507 = value38:EncodeCFrame(v2(t8))
        local v508 = utf8.char(2)
        local v509 = Head
        local v510 = utf8.char(3)
        local v511 = t1.value38:EncodeCFrame(CFrame.new(0.43, 0.25, 0.42))
        local t9 = {
			[v502] = v503,
			[v504] = v507,
			[v508] = v509,
			[v510] = v511
		}
        local value4 = t1.value4
        local t10 = {
			[v501] = t9
		}

        value4.Remotes.Replication.Fighter.UseItem:FireServer(v497, t1.value39:ToEnum("StartShooting"), t10, nil)
    end)
end
function t1.value48()
    if t1.value33 then
        return
    end

    t1.value33 = true
    t1.value3.Heartbeat:Connect(function()
        if t1.value33 then
            t1.value47()
        end
    end)
end
function t1.value49()
    t1.value33 = false
    t1.value36 = false

    if t1.value34 then
        t1.value34:Disconnect()
    end
end
t1.value50 = nil
t1.value51 = nil
t1.value51 = false
function t1.value52()
    if t1.value51 then
        return
    end

    t1.value51 = true
    pcall(function()
        local Items = require(game:GetService("ReplicatedStorage").Modules.ItemLibrary).Items

        for _, v in pairs(Items) do
            if typeof(v) == "table" then
                if v.ShootSpread then
                    v.ShootSpread = 0
                end

                if v.ShootAccuracy then
                    v.ShootAccuracy = 0
                end

                if v.ShootRecoil then
                    v.ShootRecoil = 0
                end

                if v.ShootCooldown then
                    v.ShootCooldown = 0.001
                end

                if v.ShootBurstCooldown then
                    v.ShootBurstCooldown = 0.001
                end

                if v.AttackCooldown then
                    v.AttackCooldown = 0.001
                end

                if v.SwingCooldown then
                    v.SwingCooldown = 0.001
                end

                if v.MeleeCooldown then
                    v.MeleeCooldown = 0.001
                end

                if v.Cooldown then
                    v.Cooldown = 0.001
                end

                if v.RecoveryTime then
                    v.RecoveryTime = 0.001
                end

                if v.ResetTime then
                    v.ResetTime = 0.001
                end

                if v.ReloadTime then
                    v.ReloadTime = 0.001
                end

                if v.ChargeTime then
                    v.ChargeTime = 0.001
                end
            end
        end
    end)
end
function t1.value53()
end
t1.value54 = false
t1.value55 = nil
t1.value56 = nil
t1.value57 = nil
t1.value58 = nil
t1.value59 = nil
function t1.value60()
    local v289 = t1.value8.Character or t1.value8.CharacterAdded:Wait()

    t1.value58 = v289:WaitForChild("Humanoid")
    t1.value59 = v289:WaitForChild("HumanoidRootPart")

    if t1.value54 then
        if t1.value55 then
            t1.value55:Destroy()
        end

        t1.value58.PlatformStand = true
        t1.value55 = Instance.new("Attachment", t1.value59)
        t1.value56 = Instance.new("LinearVelocity", t1.value55)
        t1.value56.MaxForce = 9000000000
        t1.value56.VectorVelocity = Vector3.zero
        t1.value56.Attachment0 = t1.value55
        t1.value57 = Instance.new("AlignOrientation", t1.value55)
        t1.value57.MaxTorque = 9000000000
        t1.value57.Responsiveness = 200
        t1.value57.Mode = Enum.OrientationAlignmentMode.OneAttachment
        t1.value57.Attachment0 = t1.value55
    end
end
t1.value8.CharacterAdded:Connect(function()
    task.wait(0.1)
    t1.value60()
end)
t1.value60()
local _require = require
local t11 = { t1.value8.PlayerScripts:WaitForChild("PlayerModule") }
t1.value61 = nil
t1.value62 = _require(v2(t11)):GetControls()
t1.value3.RenderStepped:Connect(function()
    local value54 = t1.value54

    if value54 then
        value54 = t1.value59 and (t1.value9 and (t1.value56 and t1.value57))
    end

    if value54 then
        local value9 = t1.value9
        local MoveVector = t1.value62:GetMoveVector()
        local v293 = t1.value12.FlySpeed or 80

        if MoveVector.Magnitude > 0 then
            t1.value56.VectorVelocity = (value9.CFrame.LookVector * -MoveVector.Z + value9.CFrame.RightVector * MoveVector.X).Unit * v293
        else
            t1.value56.VectorVelocity = Vector3.zero
        end

        t1.value57.CFrame = value9.CFrame
    end
end)
function t1.value63()
    t1.value60()
end
function t1.value64()
    if t1.value58 then
        t1.value58.PlatformStand = false
    end

    if t1.value55 then
        t1.value55:Destroy()
    end
end
t1.value65 = false
t1.value66 = nil
t1.value66 = nil
function t1.value67()
    if t1.value65 then
        return
    end

    t1.value65 = true
    t1.value66 = t1.value2.JumpRequest:Connect(function()
        if not t1.value65 then
            return
        end

        local Character = t1.value8.Character

        if not Character then
            return
        end

        local Humanoid = Character:FindFirstChildOfClass("Humanoid")

        if Humanoid and Humanoid.Health > 0 then
            Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
end
function t1.value68()
    if t1.value66 then
        t1.value66:Disconnect()
        t1.value66 = nil
    end
end
t1.value50 = false
t1.value61 = nil
function t1.value69()
    if t1.value50 then
        return
    end

    t1.value50 = true
    t1.value61 = t1.value3.Stepped:Connect(function()
        if not t1.value50 then
            return
        end

        local Character = t1.value8.Character

        if not Character then
            return
        end

        for _, descendant in pairs(Character:GetDescendants()) do
            if descendant:IsA("BasePart") then
                descendant.CanCollide = false
            end
        end
    end)
end
function t1.value70()
    t1.value50 = false

    if t1.value61 then
        t1.value61:Disconnect()
        t1.value61 = nil
    end
end
t1.value71 = false
t1.value72 = {}
t1.value73 = nil
function t1.value74(p33, p34)
    local drawing = Drawing.new(p33)

    for k, v in pairs(p34) do
        drawing[k] = v
    end

    return drawing
end
t1.value75 = nil
function t1.value76(_)
    local t12 = {}

    if t1.value12.EspBoxes then
        local value74 = t1.value74
        local color3_19 = Color3.new(0, 0, 0)

        t12.BoxOutline = value74("Square", {
			Visible = false,
			Thickness = 3,
			Filled = false,
			Color = color3_19
		})

        local value74_2 = t1.value74
        local color3_20 = Color3.fromRGB(0, 150, 255)

        t12.Box = value74_2("Square", {
			Visible = false,
			Thickness = 1.5,
			Filled = false,
			Color = color3_20
		})
    end

    if t1.value12.EspNames then
        local value74 = t1.value74
        local color3_21 = Color3.new(0, 0, 0)
        local color3_22 = Color3.new(1, 1, 1)

        t12.Name = value74("Text", {
			Visible = false,
			Center = true,
			Outline = true,
			OutlineColor = color3_21,
			Size = 13,
			Font = 2,
			Color = color3_22
		})
    end

    if t1.value12.EspHealth then
        local value74 = t1.value74
        local color3_23 = Color3.new(0, 0, 0)

        t12.HealthBarBG = value74("Line", {
			Visible = false,
			Thickness = 5,
			Color = color3_23
		})

        local value74_3 = t1.value74
        local color3_24 = Color3.new(0, 1, 0)

        t12.HealthBar = value74_3("Line", {
			Visible = false,
			Thickness = 3,
			Color = color3_24
		})
    end

    if t1.value12.EspDistance then
        local value74 = t1.value74
        local color3_25 = Color3.new(0, 0, 0)
        local color3_26 = Color3.new(1, 1, 1)

        t12.Distance = value74("Text", {
			Visible = false,
			Center = true,
			Outline = true,
			OutlineColor = color3_25,
			Size = 11,
			Font = 2,
			Color = color3_26
		})
    end

    if t1.value12.EspHealthNumber then
        local value74 = t1.value74
        local color3_27 = Color3.new(0, 0, 0)
        local color3_28 = Color3.new(1, 1, 1)

        t12.HealthNumber = value74("Text", {
			Visible = false,
			Center = true,
			Outline = true,
			OutlineColor = color3_27,
			Size = 11,
			Font = 2,
			Color = color3_28
		})
    end

    return t12
end
function t1.value77(p36, p37)
    local v257 = p37 / 2
    local t13 = {}
    local v259 = true

    for i = -1, 1, 2 do
        for j = -1, 1, 2 do
            for k = -1, 1, 2 do
                local v263 = p36 * Vector3.new(v257.X * i, v257.Y * j, v257.Z * k)
                local v264, v265 = t1.value9:WorldToViewportPoint(v263)

                if not v265 then
                    v259 = false
                end

                table.insert(t13, Vector2.new(v264.X, v264.Y))
            end
        end
    end

    return t13, v259
end
function t1.value78(p38)
    for _, v in pairs(p38) do
        if v and v.Visible then
            v.Visible = false
        end
    end
end
function t1.value79(p39)
    if not t1.value12.EspChams then
        return
    end

    if not p39 then
        return
    end

    for _, v in ipairs({
		"Head",
		"Torso",
		"Left Arm",
		"Right Arm",
		"Left Leg",
		"Right Leg",
		"UpperTorso",
		"LowerTorso",
		"LeftUpperArm",
		"RightUpperArm",
		"LeftLowerArm",
		"RightLowerArm",
		"LeftUpperLeg",
		"RightUpperLeg",
		"LeftLowerLeg",
		"RightLowerLeg",
		"HumanoidRootPart"
	}) do
        local v5 = p39:FindFirstChild(v)

        if v5 and v5:IsA("BasePart") then
            v5.Transparency = 0.3
            v5.Material = Enum.Material.ForceField
            v5.Color = Color3.fromRGB(0, 150, 255)
        end
    end
end
t1.value80 = nil
function t1.value80(p40)
    if not p40 then
        return
    end

    for _, v in ipairs({
		"Head",
		"Torso",
		"Left Arm",
		"Right Arm",
		"Left Leg",
		"Right Leg",
		"UpperTorso",
		"LowerTorso",
		"LeftUpperArm",
		"RightUpperArm",
		"LeftLowerArm",
		"RightLowerArm",
		"LeftUpperLeg",
		"RightUpperLeg",
		"LeftLowerLeg",
		"RightLowerLeg",
		"HumanoidRootPart"
	}) do
        local v6 = p40:FindFirstChild(v)

        if v6 and v6:IsA("BasePart") then
            v6.Transparency = 0
            v6.Material = Enum.Material.Plastic
        end
    end
end
local function v60()
    if not t1.value71 then

        for v331, v332 in pairs(t1.value72) do

            t1.value78(v332)
        end
        for _, player in ipairs(t1.value1:GetPlayers()) do
            if player ~= t1.value8 and player.Character then
                t1.value80(player.Character)
            end
        end

        return
    end

    for _, player in ipairs(t1.value1:GetPlayers()) do
        if player ~= t1.value8 then
            if v29(player) then
                if t1.value72[player] then
                    t1.value78(t1.value72[player])
                end

                if player.Character then
                    t1.value80(player.Character)
                end
            else
                local Character = player.Character
                local v338 = Character and Character:FindFirstChildOfClass("Humanoid")

                if Character and (v338 and v338.Health > 0) then
                    if t1.value12.EspChams then
                        t1.value79(Character)
                    else
                        t1.value80(Character)
                    end

                    local EspBoxes = t1.value12.EspBoxes

                    if not EspBoxes then
                        EspBoxes = t1.value12.EspNames

                        if not EspBoxes then
                            EspBoxes = t1.value12.EspHealth or (t1.value12.EspDistance or t1.value12.EspHealthNumber)
                        end
                    end

                    if EspBoxes then
                        local ok, result, v342 = pcall(Character.GetBoundingBox, Character)

                        if ok then
                            ok = result and v342
                        end

                        if ok then
                            local v343, v344 = t1.value77(result, v342)

                            if not v344 then
                                if t1.value72[player] then
                                    t1.value78(t1.value72[player])
                                end
                            else
                                local v345 = t1.value72[player] or t1.value76(player)

                                t1.value72[player] = v345

                                local n3 = 1e999
                                local n4 = -1e999
                                local n5 = -1e999
                                local n6 = 1e999

                                for _, v in ipairs(v343) do
                                    n6 = math.min(n6, v.X)
                                    n3 = math.min(n3, v.Y)
                                    n4 = math.max(n4, v.X)
                                    n5 = math.max(n5, v.Y)
                                end

                                local v352 = n4 - n6
                                local v353 = n5 - n3
                                local v354 = v352 * 0.7
                                local _math = math
                                local v356 = n6 + (v352 - v354) / 2
                                local v357 = _math.clamp(v338.Health / v338.MaxHealth, 0, 1)
                                local Head = Character:FindFirstChild("Head")

                                if v345.BoxOutline and t1.value12.EspBoxes then
                                    v345.BoxOutline.Visible = true
                                    v345.BoxOutline.Position = Vector2.new(v356 - 1, n3 - 1)
                                    v345.BoxOutline.Size = Vector2.new(v354 + 2, v353 + 2)
                                end

                                if v345.Box and t1.value12.EspBoxes then
                                    v345.Box.Visible = true
                                    v345.Box.Position = Vector2.new(v356, n3)
                                    v345.Box.Size = Vector2.new(v354, v353)
                                end

                                if v345.Name and t1.value12.EspNames then
                                    v345.Name.Visible = true
                                    v345.Name.Text = player.Name
                                    v345.Name.Position = Vector2.new(v356 + v354 / 2, n3 - 16)
                                end

                                local v359 = v353 * v357

                                if v345.HealthBarBG and t1.value12.EspHealth then
                                    v345.HealthBarBG.Visible = true
                                    v345.HealthBarBG.From = Vector2.new(v356 - 6, n5)
                                    v345.HealthBarBG.To = Vector2.new(v356 - 6, n3)
                                end

                                if v345.HealthBar and t1.value12.EspHealth then
                                    v345.HealthBar.Visible = true

                                    if v357 > 0.7 then
                                        v345.HealthBar.Color = Color3.fromRGB(0, 255, 0)
                                    elseif v357 > 0.3 then
                                        v345.HealthBar.Color = Color3.fromRGB(255, 165, 0)
                                    else
                                        v345.HealthBar.Color = Color3.fromRGB(255, 0, 0)
                                    end

                                    v345.HealthBar.From = Vector2.new(v356 - 6, n5)
                                    v345.HealthBar.To = Vector2.new(v356 - 6, n5 - v359)
                                end

                                if v345.Distance and (t1.value12.EspDistance and Head) then
                                    local v360 = t1.value8.Character and t1.value8.Character:FindFirstChild("HumanoidRootPart")

                                    if v360 then
                                        local v361 = math.floor((v360.Position - Head.Position).Magnitude)

                                        v345.Distance.Visible = true
                                        v345.Distance.Text = v361 .. "m"
                                        v345.Distance.Position = Vector2.new(v356 + v354 / 2, n5 + 4)
                                    end
                                end

                                if v345.HealthNumber and t1.value12.EspHealthNumber then
                                    v345.HealthNumber.Visible = true
                                    v345.HealthNumber.Text = math.floor(v338.Health) .. "/" .. math.floor(v338.MaxHealth)
                                    v345.HealthNumber.Position = Vector2.new(v356 + v354 / 2, n5 + 16)
                                end
                            end
                        end
                    end
                else
                    if t1.value72[player] then
                        t1.value78(t1.value72[player])
                    end

                    if Character then
                        t1.value80(Character)
                    end
                end
            end
        end
    end
end
function t1.value81()
    t1.value71 = false
    if t1.value73 then
        t1.value73:Disconnect()
        t1.value73 = nil
    end
    for v323, v324 in pairs(t1.value72) do

        local v325 = v324

        pcall(function()
            for _, v in pairs(v325) do
                if v and v.Remove then
                    v:Remove()
                end
            end
        end)
    end
    t1.value72 = {}
    for _, player in ipairs(t1.value1:GetPlayers()) do
        if player.Character then
            t1.value80(player.Character)
        end
    end
end
function t1.value75()
    if t1.value71 then
        t1.value81()
        t1.value71 = true

        if t1.value73 then
            t1.value73:Disconnect()
        end

        t1.value3.RenderStepped:Connect(v60)
    end
end
t1.value1.PlayerRemoving:Connect(function(player)
    if t1.value72[player] then
        for _, v in pairs(t1.value72[player]) do
            local v371 = v

            pcall(function()
                if v371 and v371.Remove then
                    v371:Remove()
                end
            end)
        end

        t1.value72[player] = nil
    end

    if player.Character then
        t1.value80(player.Character)
    end
end)
t1.value82 = {
	enabled = false,
	animationId = "",
	loop = true,
	speed = 2,
	serverSide = true,
	jitter = false,
	jitterId = "",
	jitterSpeed = 0.1,
	spawnProof = true
}
t1.value83 = {}
t1.value84 = {
	["Underground Glitch"] = "138847307095534",
	Orbit = "133811691098518",
	Tweaking = "114353590132838",
	["Kicking Feet"] = "131879764029003",
	["Low Cortisol"] = "125822752810863",
	Floss = "72174079036035",
	["Take the L"] = "112884830175040",
	["Upside Down"] = "128616002281906",
	["Michael Myers Shake"] = "123682198526131",
	Headless = "74738520664045",
	["Wall Peek L"] = "123671647250039",
	["Glitch Through"] = "85364072005108"
}
function t1.value85()
    for _, v in ipairs(t1.value83) do
        local v374 = v

        pcall(function()
            v374:Stop(0)
            v374:Destroy()
        end)
    end

    t1.value83 = {}
end
function t1.value86(p41)
    if not p41 then
        return nil
    end

    local Humanoid = p41:FindFirstChildOfClass("Humanoid")

    if not Humanoid then
        return nil
    end

    local Animator = Humanoid:FindFirstChildOfClass("Animator")

    if not Animator then
        Animator = Instance.new("Animator")
        Animator.Parent = Humanoid
    end

    return Animator
end
t1.value87 = nil
function t1.value87(p42)
    local ok, result = pcall(function()
        return game:GetObjects("rbxassetid://" .. p42)
    end)
    local v381 = not ok

    if not v381 then
        v381 = not result or #result == 0
    end

    if v381 then
        return nil
    end

    local v382, v383, v384 = ipairs(result)
    local v385

    repeat
        v384, v385 = v382(v383, v384)

        if not v384 then
            for _, v in ipairs(result) do
                local GetDescendants = v.GetDescendants

                for _, v7 in ipairs(GetDescendants(v)) do
                    if v7:IsA("Animation") and v7.AnimationId ~= "" then
                        return v7
                    end
                end
            end

            return nil
        end
    until v385:IsA("Animation") and v385.AnimationId ~= ""

    return v385
end
function t1.value88(p43, p44, p45, p46)
    if not p43 or p44 == "" then
        return nil
    end

    local v395 = t1.value86(p43)

    if not v395 then
        return nil
    end

    local u396 = t1.value87(p44)

    if not u396 then
        u396 = Instance.new("Animation")
        u396.AnimationId = "rbxassetid://" .. p44
    end

    local ok, result = pcall(function()
        return v395:LoadAnimation(u396)
    end)
    local v399 = not ok

    if not v399 then
        v399 = not result
    end

    if v399 then
        pcall(function()
            u396:Destroy()
        end)

        return nil
    end

    result.Looped = p46
    result.Priority = Enum.AnimationPriority.Action4
    result:Play(0.1, 1, p45)

    return result
end
function t1.value89()
    t1.value85()

    if not t1.value82.enabled or t1.value82.animationId == "" then
        return
    end

    local Character = t1.value8.Character

    if Character then
        local v401 = t1.value88(Character, t1.value82.animationId, t1.value82.speed, t1.value82.loop)

        if v401 then
            table.insert(t1.value83, v401)
        end
    end

    local Live = t1.value6:FindFirstChild("Live")

    if Live then
        local t1value8Name = Live:FindFirstChild(t1.value8.Name)

        if t1value8Name then
            local v404 = t1.value88(t1value8Name, t1.value82.animationId, t1.value82.speed, t1.value82.loop)

            if v404 then
                table.insert(t1.value83, v404)
            end
        end
    end
end
t1.value3.Heartbeat:Connect(function()
    if not t1.value82.enabled then
        return
    end

    if #t1.value83 == 0 and t1.value82.animationId ~= "" then
        t1.value89()
    end

    for _, v in ipairs(t1.value83) do
        local v407 = v

        pcall(function()
            v407:AdjustSpeed(t1.value82.speed)
        end)
    end
end)
t1.value8.CharacterAdded:Connect(function()
    task.wait(0.5)

    if t1.value82.enabled and t1.value82.spawnProof then
        t1.value89()
    end
end)
local function v61(p47)
    if p47 then
        t1.value82.enabled = true

        local v409 = t1.value84[t1.value12.AnimationPreset]

        if v409 then
            t1.value82.animationId = v409
        end

        t1.value82.speed = t1.value12.AnimationSpeed
        t1.value82.loop = true
        t1.value82.serverSide = true
        t1.value89()

        return
    end

    t1.value82.enabled = false
    t1.value85()
end
t1.value90 = nil
local function v62(p48)
    if p48 then
        t1.value90 = t1.value3.RenderStepped:Connect(function()
            local Character = t1.value8.Character

            if not Character then
                return
            end

            local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

            if not HumanoidRootPart then
                return
            end

            local Humanoid = Character:FindFirstChild("Humanoid")
            local v528 = Humanoid and Humanoid.Health < Humanoid.MaxHealth

            for _, child in pairs(t1.value6:GetChildren()) do
                if child.Name == "_drop" and child:IsA("BasePart") then
                    if child:FindFirstChild("Health") and v528 then
                        firetouchinterest(HumanoidRootPart, child, 0)
                        firetouchinterest(HumanoidRootPart, child, 1)
                    end

                    if child:FindFirstChild("Ammo") then
                        firetouchinterest(HumanoidRootPart, child, 0)
                        firetouchinterest(HumanoidRootPart, child, 1)
                    end
                end
            end
        end)

        return
    end

    if t1.value90 then
        t1.value90:Disconnect()
    end
end
t1.value91 = {
	enabled = false,
	mode = "1v1",
	ranked = false
}
task.spawn(function()
    while true do
        if t1.value91.enabled then
            pcall(function()
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Matchmaking"):WaitForChild("JoinQueue"):InvokeServer(t1.value91.mode, t1.value91.ranked)
            end)
        end

        task.wait(1)
    end
end)
t1.value91.mode = t1.value12.AutoQueueMode or "1v1"
t1.value91.ranked = t1.value91.mode:find("ranked") ~= nil
v50("Main", "Enable FOV Circle", "MainFOVEnabled", function(p49)
    t1.value12.MainFOVEnabled = p49
    t1.value12.MainFOVShow = p49
    t1.value13()
    t1.value25.Visible = p49
end);
(function(p50, p51, p52, p53, p54, p55, p56)
    local v165 = t1.value21[p50]

    if not v165 then
        return
    end

    local Frame14 = Instance.new("Frame")

    Frame14.Size = UDim2.new(1, 0, 1, 0)
    Frame14.BackgroundColor3 = t1.value11.Surface
    Frame14.BackgroundTransparency = 0
    Frame14.BorderSizePixel = 0
    Frame14.ZIndex = 12
    Frame14.Parent = v165.scroll

    local TextLabel7 = Instance.new("TextLabel")

    TextLabel7.Size = UDim2.new(0, 80, 0, 10)
    TextLabel7.Position = UDim2.new(0, 6, 0, 3)
    TextLabel7.BackgroundTransparency = 1
    TextLabel7.Text = p51
    TextLabel7.Font = t1.value11.FontMedium
    TextLabel7.TextSize = 8
    TextLabel7.TextColor3 = t1.value11.Text
    TextLabel7.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel7.ZIndex = 13
    TextLabel7.Parent = Frame14

    local TextLabel8 = Instance.new("TextLabel")

    TextLabel8.Size = UDim2.new(0, 40, 0, 10)
    TextLabel8.Position = UDim2.new(1, -46, 0, 3)
    TextLabel8.BackgroundTransparency = 1
    TextLabel8.Text = tostring(t1.value12[p54] or p52) .. (p55 or "")
    TextLabel8.Font = t1.value11.FontMedium
    TextLabel8.TextSize = 8
    TextLabel8.TextColor3 = t1.value11.Accent
    TextLabel8.TextXAlignment = Enum.TextXAlignment.Right
    TextLabel8.ZIndex = 13
    TextLabel8.Parent = Frame14

    local Frame15 = Instance.new("Frame")

    Frame15.Size = UDim2.new(1, -12, 0, 2)
    Frame15.Position = UDim2.new(0, 6, 0, 17)
    Frame15.BackgroundColor3 = t1.value11.SurfaceLight
    Frame15.BorderSizePixel = 0
    Frame15.ZIndex = 13
    Frame15.Parent = Frame14

    local Frame16 = Instance.new("Frame")
    local v171 = (t1.value12[p54] or p52 - p52) / (p53 - p52)

    Frame16.Size = UDim2.new(v171, 0, 1, 0)
    Frame16.BackgroundColor3 = t1.value11.Accent
    Frame16.BorderSizePixel = 0
    Frame16.ZIndex = 14
    Frame16.Parent = Frame15

    local Frame17 = Instance.new("Frame")

    Frame17.Size = UDim2.new(0, 10, 0, 10)
    Frame17.Position = UDim2.new(1, -5, 0.5, -5)
    Frame17.BackgroundColor3 = Color3.new(1, 1, 1)
    Frame17.BorderSizePixel = 0
    Frame17.ZIndex = 15
    Frame17.Parent = Frame16

    local function v173(p57)
        local v437 = math.clamp((p57.Position.X - Frame15.AbsolutePosition.X) / Frame15.AbsoluteSize.X, 0, 1)
        local v438 = math.floor(p52 + (p53 - p52) * v437)

        t1.value12[p54] = v438
        t1.value13()
        TextLabel8.Text = tostring(v438) .. (p55 or "")
        t1.value5:Create(Frame16, TweenInfo.new(0.1), {
			Size = UDim2.new(v437, 0, 1, 0)
		}):Play()

        if p56 then
            p56(v438)
        end
    end

    Frame15.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            v173(input)
            local connection
            local connection3 = t1.value2.InputChanged:Connect(function(input4)
                if input4.UserInputType == Enum.UserInputType.MouseMovement or input4.UserInputType == Enum.UserInputType.Touch then
                    v173(input4)
                end
            end)
            connection = t1.value2.InputEnded:Connect(function(input5)
                if input5.UserInputType == Enum.UserInputType.MouseButton1 or input5.UserInputType == Enum.UserInputType.Touch then
                    if connection3 then
                        connection3:Disconnect()
                    end

                    if connection then
                        connection:Disconnect()
                    end
                end
            end)
        end
    end)

    return Frame14
end)("Main", "FOV Radius", 50, 500, "MainFOVRadius", "", function(p58)
    t1.value12.MainFOVRadius = p58
    t1.value13()
    t1.value25.Radius = p58
end)
v50("Ragebot", "Ragebot", "Ragebot", function(p59)
    if p59 then
        t1.value31()

        return
    end

    t1.value32()
end)
v51("Ragebot", "Auto Shoot", "AutoShoot", 0, 100, "AutoShootShootAttempt", "%", function(p60)
    if p60 then
        t1.value48()

        return
    end

    t1.value49()
end, function(p61)
    t1.value12.AutoShootShootAttempt = p61
    t1.value13()
end)
v50("Ragebot", "Rapid Fire", "RapidFire", function(p62)
    if p62 then
        t1.value52()

        return
    end

    t1.value53()
end)
v50("ESP", "Enable ESP", "Esp", function(p63)
    if p63 then
        t1.value71 = true

        if t1.value73 then
            t1.value73:Disconnect()
        end

        t1.value3.RenderStepped:Connect(v60)

        return
    end

    t1.value81()
end)
v50("ESP", "Box ESP", "EspBoxes", function(p64)
    t1.value12.EspBoxes = p64
    t1.value13()
    t1.value75()
end)
v50("ESP", "Health Bar ESP", "EspHealth", function(p65)
    t1.value12.EspHealth = p65
    t1.value13()
    t1.value75()
end)
v50("ESP", "Name ESP", "EspNames", function(p66)
    t1.value12.EspNames = p66
    t1.value13()
    t1.value75()
end)
v50("ESP", "Distance ESP", "EspDistance", function(p67)
    t1.value12.EspDistance = p67
    t1.value13()
    t1.value75()
end)
v50("ESP", "Health Number", "EspHealthNumber", function(p68)
    t1.value12.EspHealthNumber = p68
    t1.value13()
    t1.value75()
end)
v50("ESP", "Cham", "EspChams", function(p69)
    t1.value12.EspChams = p69
    t1.value13()
    t1.value75()
end)
v50("Auto", "Auto Collect", "AutoCollect", v62)
v50("Auto", "Auto Queue", "AutoQueueEnabled", function(p70)
    t1.value91.enabled = p70
    t1.value12.AutoQueueEnabled = p70
    t1.value13()
end)
v52("Auto", "Queue Mode", "AutoQueueMode", {
	"1v1",
	"2v2",
	"3v3",
	"4v4",
	"5v5",
	"ranked 1v1",
	"ranked 2v2",
	"ranked 3v3"
}, function(p71)
    t1.value91.mode = p71
    t1.value91.ranked = p71:find("ranked") ~= nil
    t1.value12.AutoQueueMode = p71
    t1.value13()
end)
v51("Misc", "Fly Mode", "Fly", 20, 200, "FlySpeed", "", function(p72)
    if p72 then
        t1.value63()

        return
    end

    t1.value64()
end, function(p73)
    t1.value12.FlySpeed = p73
    t1.value13()
end)
v50("Misc", "Infinite Jump", "InfiniteJump", function(p74)
    if p74 then
        t1.value67()

        return
    end

    t1.value68()
end)
v50("Misc", "Noclip", "Noclip", function(p75)
    if p75 then
        t1.value69()

        return
    end

    t1.value70()
end)
v50("Settings", "Enable Animation", "AnimationEnabled", v61)
v52("Settings", "Anim Preset", "AnimationPreset", {
	"Underground Glitch",
	"Orbit",
	"Tweaking",
	"Kicking Feet",
	"Low Cortisol",
	"Floss",
	"Take the L",
	"Upside Down",
	"Michael Myers Shake",
	"Headless",
	"Wall Peek L",
	"Glitch Through"
}, function(p76)
    t1.value12.AnimationPreset = p76
    t1.value13()

    local v411 = t1.value84[p76]

    if v411 then
        t1.value82.animationId = v411

        if t1.value82.enabled then
            t1.value89()
        end
    end
end)
task.wait(0.1)
for _, v in pairs(t1.value21) do
    v.scroll.CanvasSize = UDim2.new(0, 0, 0, v.layout.AbsoluteContentSize.Y + 10)
end
t1.value92 = false
t1.value93 = nil
t1.value94 = nil
t1.value16.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        t1.value92 = true
        t1.value93 = input.Position
        t1.value94 = t1.value16.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                t1.value92 = false
            end
        end)
    end
end)
t1.value2.InputChanged:Connect(function(input)
    if t1.value92 and input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        local v417 = input.Position - t1.value93

        t1.value16.Position = UDim2.new(t1.value94.X.Scale, t1.value94.X.Offset + v417.X, t1.value94.Y.Scale, t1.value94.Y.Offset + v417.Y)
    end
end)
t1.value95 = nil
if t1.value10 then
    t1.value95 = Instance.new("TextButton")
    t1.value95.Size = UDim2.new(0, 24, 0, 24)
    t1.value95.Position = UDim2.new(0, 6, 0.5, -12)
    t1.value95.BackgroundColor3 = t1.value11.Surface
    t1.value95.BackgroundTransparency = 0
    t1.value95.BorderSizePixel = 0
    t1.value95.Text = ">"
    t1.value95.Font = t1.value11.Font
    t1.value95.TextSize = 12
    t1.value95.TextColor3 = t1.value11.Accent
    t1.value95.ZIndex = 999999
    t1.value95.AutoButtonColor = false
    t1.value95.Parent = ScreenGui

    local UIStroke = Instance.new("UIStroke")

    UIStroke.Color = t1.value11.Border
    UIStroke.Thickness = 1
    UIStroke.Transparency = 0
    UIStroke.Parent = t1.value95
    t1.value95.MouseButton1Click:Connect(function()
        if t1.value16.Visible then
            t1.value18()
            t1.value95.Text = ">"

            return
        end

        v34()
        t1.value95.Text = "X"
    end)
end
if v4 then
    t1.value2.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then
            return
        end

        if input.KeyCode == Enum.KeyCode.RightShift then
            if t1.value16.Visible then
                t1.value18()

                return
            end

            v34()
        end
    end)
end
if t1.value12.Ragebot then
    t1.value31()
end
if t1.value12.AutoShoot then
    t1.value48()
end
if t1.value12.RapidFire then
    t1.value52()
end
if t1.value12.Fly then
    t1.value63()
end
if t1.value12.InfiniteJump then
    t1.value67()
end
if t1.value12.Noclip then
    t1.value69()
end
if t1.value12.Esp then
    t1.value71 = true

    if t1.value73 then
        t1.value73:Disconnect()
    end

    t1.value3.RenderStepped:Connect(v60)
end
if t1.value12.AnimationEnabled then
    v61(true)
end
if t1.value12.AutoCollect then
    v62(true)
end
if t1.value12.MainFOVEnabled then
    t1.value12.MainFOVShow = true
    t1.value25.Visible = true
end
if t1.value12.MainFOVRadius then
    t1.value25.Radius = t1.value12.MainFOVRadius
end
if t1.value12.AutoQueueEnabled then
    t1.value91.enabled = true
end
pcall(function()
    if writefile and (isfolder and makefolder) then
        if not isfolder("autoexec") then
            makefolder("autoexec")
        end

        local source = debug.getinfo(1, "S").source

        if source and source:sub(1, 1) == "@" then
            local v421 = source:sub(2)

            if isfile(v421) then
                local v422 = readfile(v421)

                writefile("autoexec/oishi_hub.lua", v422)
            end
        end
    end
end)
v34()
