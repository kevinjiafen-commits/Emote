--[[
  KiciaRebuild — Ragebot + Flickbot
  Extracted from the full script, complete and unabridged.

  Shared globals required by both features (reproduced from the loader):
    v86          — obfuscator constant table
    flag2, flag3 — integrity flags (both true = real branches execute)
    cloneref     — executor cloneref or identity function
    v107         — pcall (aliased from loader)
    v108         — setfflag (for FastFlag manipulation)
    v112         — game.__newindex (for FallenPartsDestroyHeight patch)
    tbl17        — module cache table ({cache={}})
    n25, n26     — obfuscator counters (3870 / 4800)

  Module dependency graph (all defined below, in order):
    jv  — DirectionToOrientation / OrientationLookingAt helpers
    jw  — Flickbot controller
    jy  — Riot-shield orientation helper (shared by jD/jE/jz)
    jz  — Defensive CFrame/ViewAngles helpers
    jA  — ShootLock (fire-rate gate)
    jB  — TargetSelection (enemy filter + hacker priority)
    jC  — Flat CFrame lookAt helper
    jD  — HitscanStrategy (gun ragebot planner)
    jE  — MeleeStrategy (melee ragebot planner)
    jF  — Random ring-point generator
    jG  — Surface normal finder
    jH  — ProjectileBreakerTeleport
    jI  — Random evasion compute
    jJ  — SpatialLimitGate (shot timing gate)
    jK  — Translocate evasion compute
    jL  — Ring-position tables (normal / immune zones)
    jM  — Weapon action resolver
    jN  — Riot-shield state helper
    jO  — Main Ragebot controller (wires everything together)
]]

-- ============================================================
-- Shared preamble — copy these from the loader if running
-- this block standalone.
-- ============================================================
local v86 = {
    [2]="ReactiveStore",[3]="Toggle",[4]="UIListLayout",[5]="BackgroundColor3",
    [6]=0,[7]=60,[8]=60,[9]=20,[12]=12,[13]=14,[14]="Settings",[15]=120,
    [16]="min",[17]=200,[18]="0",[19]=200,[20]="Vector3",[21]="Always",
    [22]="",[23]=1.4707963267948965,[24]="Roboto",[25]=24,[26]=4,[27]="Color",
    [28]=0.2,[29]="Size",[30]=0.35,[31]=29,[32]=24,[33]="Button",[34]=true,
    [35]="ConfigManager",[36]="ApplyMigrations",[37]="TextBounds",[38]="DeleteFile",
    [39]="Slider",[40]="...",[42]="left",[43]="Proggy Clean",[44]="Enabled",
    [45]=90,[46]="UIGradient",[47]="CanvasGroup",[48]=0.3,[49]=2,[50]="Side",
    [51]=" ",[52]="BottomRight",[53]=92,[54]=6,[55]="Mode",[56]=2,[57]="TextColor",
    [58]=80,[59]="Font",[60]=29,[61]=20,[62]=0.1,[63]=1,[64]="ScrollingFrame",
    [65]=200,[66]=0.5,[67]=100,[68]="table",[69]="Catalog unavailable",[70]="GradientDark",
    [71]=10,[72]=12,[73]="Keybind",[74]=0.9,[75]="None",[76]="LoadFromFile",
    [77]="FireServer",[78]=720,[79]=255,[80]="Text",[81]=1,
    [82]="Realize() can only be called on the root",[83]=64,[84]=0.5,[85]="UIStroke",
    [87]=0.8,[88]="TabHighlight",[89]="Loading",[90]="Gradient",[91]=100,
    [92]="TextButton",[93]="ColorSequence",[94]="Options",[95]="number",
    [96]="Unselected",[97]="Mode",[98]="UICorner",[99]="ExportToJson",[100]=14,
    [101]=0.5,[102]=231,[103]=52,[104]="Fonts",[105]=0.85,[106]="Menu Keybind",
    [107]=40,[108]=255,[109]=77,[110]=70,[111]="Fetching items...",[112]="Invisible",
    [113]="UIPadding",[114]="primary",[115]="Color3",[116]="boolean",[118]=16,
    [119]=159,[120]="Outline",[121]="ImageButton",[122]=8,[123]=19,[124]="X",
    [125]="Proggy Tiny",[126]=0.15,[127]="CFrame",[128]="Frame",[129]="Show Watermark",
    [131]="AbsoluteSize",[132]="Breathing",[133]=10,[134]="GradientTop",[135]="TextLabel",
    [136]="Unselected Text",[137]=256,[138]=0.85,[139]="Accent",[140]="danger",
    [141]="GradientDeep",[142]="Silent Load",[143]=32,[144]=20,
    [145]="Dialog has been destroyed",[146]="ImageLabel",[147]=0.1,[148]="TextBox",
    [149]=1,[150]="stop",[151]="family",[153]=false,[154]="ScrollBarImageColor3",
    [155]=3,[156]="ImageColor3",[157]=20,[158]="secondary",[159]=20,[160]=50,
    [161]=0.5,[162]=8,[163]=80,[164]="hue",[165]="string",[166]="family",
    [167]="TextColor3",[168]="ElementBackground",[169]="FromJson",[170]=9,
    [172]="none",[173]=0.88,[174]="Unselected",[175]=5,[176]="UISizeConstraint",
    [177]="Try a different search.",[178]="ElementBackground",[181]=10,
    [182]="HttpService",[183]=72,[184]="Color",[186]=0,[187]="GradientMid",
    [189]="Position",[190]="Search...",[191]="TabShadow",[192]=30,[193]=0,
    [194]="Hold",[195]=0.7,[196]="Viewport",[197]="Y",[198]=400,[199]="Unload",[200]=26,
}

local flag2, flag3 = true, true
local n25, n26 = 3870, 4800

local tbl17 = { cache = {} }
local v102, v103, v107 = rawget, rawset, pcall

local cloneref = (function()
    local ok, fn
    pcall(function() fn = getgenv and getgenv()["cloneref"] end)
    return (type(fn) == "function") and fn or function(x) return x end
end)()

local function clonefn(f)
    local c
    pcall(function() c = getgenv and getgenv()["clonefunction"] end)
    if c and f then local ok, r = pcall(c, f); if ok and r then return r end end
    return f
end

local v108 = clonefn((function()
    local fn; pcall(function() fn = getgenv()["setfflag"] end)
    return type(fn) == "function" and fn or function() end
end)())

local v112 = clonefn((function()
    local mt = getmetatable(game)
    return mt and mt.__newindex or function() end
end)())

-- ============================================================
-- MODULE jv — Direction/Orientation math helpers
-- ============================================================
do -- jv
local function fn35()
local tbl18
tbl18 = {
DirectionToOrientation = function(l)local I,W=CFrame.lookAt(Vector3.zero,l):ToOrientation();return I,W;end,
OrientationLookingAt = function(I,W)return tbl18.DirectionToOrientation(W-I);end,
}
return tbl18
end

tbl17.jv = function()
local jv = tbl17.cache.jv
if not jv then
local jv2 = { c = fn35() }
tbl17.cache.jv = jv2
jv = jv2
end
return jv.c
end
end

-- ============================================================
-- MODULE jw — Flickbot controller
-- ============================================================
do -- jw
local function fn35()
local v115 = tbl17.cn()   -- aimbot shared utils (buildMeasure, buildHitboxSelectionMode)
local v116 = tbl17.co()   -- camera claim/release
local v117 = tbl17.jv()   -- direction→orientation
local set = tbl17.cp().set -- camera orientation setter
local v118 = tbl17.bG()   -- reactive data store
tbl17.c_()
tbl17.cF()
local v119 = tbl17.c4()   -- keybind observer
tbl17.cX()
tbl17.cE()
local v120 = tbl17.cd()   -- FlickTrajectory generator
local v121 = tbl17.dc()   -- target filter
local v122 = tbl17.ci()   -- target selection (closest/measure)
local v123 = tbl17.k()    -- Trove
local v124 = tbl17.aH()   -- hitbox profile constants
local v125 = tbl17.de()   -- hitbox selection observer builder
local v126 = tbl17.df()   -- hitbox part observer
local v127 = tbl17.dg()   -- viewport centre point
local v128 = cloneref(game:GetService("Workspace"))
local data = v118.Data
local index2 = {}
index2.__index = index2

-- WorldToViewport — returns Vector2 screen pos or nil if behind camera
local function fn36(arg)
local v129 = v128.CurrentCamera:WorldToViewportPoint(arg.Position)
return v129.Z > 0 and Vector2.new(v129.X, v129.Y) or nil
end

-- Constructor
index2.new = function(arg, arg2, arg3)
local flickbot = v123.new("flickbot")
local aimbot = data.Aimbot
local v129 = v121.new(arg2, arg, aimbot.TargetConditions, aimbot.TargetHitboxes[v124.DefaultProfile.Class], function(I,W)return(arg3:Check(I,W,W.Parent));end)

local tbl18 = {
_trove = flickbot,
_playerContext = arg2,
_targetSelection = v122.new(v129, v115.buildMeasure(aimbot.Fov.Radius, aimbot.TargetConditions.WithinFov), v126),
_state = "Idle",    -- "Idle" | "Flicking" | "PostShot" | "Cooldown"
_selected = nil,
_trajectory = nil,
_trajectoryIndex = v86[63],  -- 1
_elapsedMs = 0,
_totalMs = 0,
_bakedEndDirection = Vector3.zAxis,
_timer = 0,
_isEnabledHeld = v86[153],  -- false
}

setmetatable(tbl18, index2)

-- Observe keybind state
flickbot:Add(v119:ObserveEnabledKeybind({ "Flickbot" }, function(arg4)
tbl18:_OnKeybindChanged(arg4)
end))

-- Keep hitbox / FOV / conditions in sync with store changes
local v130 = v125(arg2, flickbot, "features.Aimbot", v129, function() return data.Aimbot.TargetHitboxes end)
local function fn37(selection) tbl18._targetSelection:SetHitboxSelectionMode(v115.buildHitboxSelectionMode(selection)) end
flickbot:Connect(v118:GetPropertyChangedSignal({ "Aimbot", "Fov" }), function(f) tbl18._targetSelection:SetMeasure(v115.buildMeasure(f.Radius, data.Aimbot.TargetConditions.WithinFov)) end)
flickbot:Connect(v118:GetPropertyChangedSignal({ "Aimbot", "TargetConditions" }), function(c)
v129:SetConditions(c)
tbl18._targetSelection:SetMeasure(v115.buildMeasure(data.Aimbot.Fov.Radius, c.WithinFov))
end)
flickbot:Connect(v118:GetPropertyChangedSignal({ "Aimbot", "TargetHitboxes" }), v130)
flickbot:Connect(v118:GetPropertyChangedSignal({ "Aimbot", "HitboxSelection" }), fn37)
fn37(aimbot.HitboxSelection)
v130()
return tbl18
end

-- Keybind state change handler
index2._OnKeybindChanged = function(arg, arg2)
if not arg2 then
arg._isEnabledHeld = false
return
end
if arg._isEnabledHeld then
return
end
arg._isEnabledHeld = true
if arg._state ~= "Idle" then
return
end
arg:_StartFlick()
end

-- Begin a flick: pick best target, bake trajectory, enter Flicking state
index2._StartFlick = function(arg)
local currentCamera = v128.CurrentCamera
local v129, v130 = arg._targetSelection:SelectBest(nil)
if v129 == nil or v130 == nil then
return
end
local selected = { Target = v129, Part = v130 }
local v131 = fn36(v130)
if v131 == nil then
return
end
local v132 = v127()          -- current viewport centre
local v133 = v120.new()      -- FlickTrajectory instance
local flickbot = v118.Data.Flickbot
-- Apply user-configured flick profile (duration, curvature, humanness)
v133:ApplyFlickProfile({ DurationMs = flickbot.FlickDuration, Curvature = flickbot.Curvature, Humanness = flickbot.Humanness })
local trajectory = {}

-- Generate per-frame direction samples along the curved path
for k, v134 in v133:Generate(v132.X, v132.Y, v131.X, v131.Y), nil, nil do
trajectory[k] = { Direction = currentCamera:ViewportPointToRay(v134.X, v134.Y).Direction, T = v134.T }
end

arg._trajectory = trajectory
arg._trajectoryIndex = 1
arg._elapsedMs = v86[186]  -- 0
arg._totalMs = trajectory[#trajectory].T
arg._bakedEndDirection = trajectory[#trajectory].Direction
arg._selected = selected
arg._state = "Flicking"
v116.claim("Flickbot", 10)  -- claim camera control at priority 10
end

-- Transition to Cooldown (or Idle if cooldown == 0)
index2._FinishToCooldown = function(arg)
arg._selected = nil
arg._trajectory = nil
v116.release("Flickbot")
local cooldown = v118.Data.Flickbot.Cooldown

if cooldown > 0 then
arg._state = "Cooldown"
arg._timer = cooldown / 1000
else
arg._state = "Idle"
end
end

-- Advance trajectory index and interpolate camera direction for this frame
index2._SampleTrajectory = function(arg, arg2, arg3)
arg._elapsedMs = arg._elapsedMs + arg3 * 1000
local trajectoryIndex = arg._trajectoryIndex

while trajectoryIndex < #arg2 and arg2[trajectoryIndex + 1].T <= arg._elapsedMs do
trajectoryIndex += 1
end

arg._trajectoryIndex = trajectoryIndex
local v129 = arg2[trajectoryIndex]
local v130 = arg2[trajectoryIndex + 1]
if v130 == nil then
return arg2[#arg2].Direction, true  -- true = reached end
end
local n = v130.T - v129.T
local n33 = 1

if n > 0 then
n33 = math.clamp((arg._elapsedMs - v129.T) / n, 0, 1)
end

return v129.Direction:Lerp(v130.Direction, n33), false
end

-- Per-frame update — called from RenderStepped / Heartbeat loop
index2.Update = function(arg, arg2)
local state = arg._state

if state == "Flicking" then
local selected = arg._selected
local trajectory = arg._trajectory

if selected == nil or trajectory == nil then
arg:_FinishToCooldown()
if not flag2 then return end
return
end

if selected.Part.Parent == nil then
arg:_FinishToCooldown()
return
end
local unit, v129 = arg:_SampleTrajectory(trajectory, arg2)

-- Compensate for target movement vs baked direction
if v86[186] < arg._totalMs then
unit = (unit + ((selected.Part.Position - v128.CurrentCamera.CFrame.Position).Unit - arg._bakedEndDirection) * math.clamp(arg._elapsedMs / arg._totalMs, 0, 1)).Unit
end

local v130, v131 = v117.DirectionToOrientation(unit)
set(Vector2.new(v130, v131))   -- write camera orientation

if v129 then   -- reached end of trajectory
local flickbot = v118.Data.Flickbot

if flickbot.Shoot then
arg._state = "PostShot"
arg._timer = flickbot.ShotDelay / 1000
else
arg:_FinishToCooldown()
end
end

elseif state == "PostShot" then
arg._timer = arg._timer - arg2

if arg._timer <= 0 then
arg:_FireShot()
arg:_FinishToCooldown()
end

elseif state == "Cooldown" then
arg._timer = arg._timer - arg2

if arg._timer <= 0 then
arg._state = "Idle"
end
end
end

-- Fire a shot via the FighterState input system
index2._FireShot = function(arg)
local inner = arg._playerContext.Inner
if inner == nil then
return
end
inner.FighterState:Input("StartShooting")
end

index2.Destroy = function(arg)
v116.release("Flickbot")
arg._trove:Destroy()
end

return index2
end

tbl17.jw = function()
local jw = tbl17.cache.jw
if not jw then
jw = { c = fn35() }
tbl17.cache.jw = jw
end
return jw.c
end
end

-- ============================================================
-- MODULE jy — Riot-shield orientation helper
--   Returns "Above" | "Below" | nil based on equipped state
--   and current camera pitch.
-- ============================================================
do -- jy
local function fn35()
tbl17.cF()
tbl17.jx()

local function fn36(arg)
local itemObserver = arg.ItemObserver
local equippedItem = itemObserver:GetEquippedItem()

if equippedItem ~= nil and equippedItem.Name == "Riot Shield" then
local v115 = math.deg(arg:GetCameraRotation().X)
if v115 > 22 and v115 < 91 then
return "Below"
end
return "Above"
end

for _, v115 in itemObserver:GetItems() do
if v115.Name == "Riot Shield" then
local v116 = math.deg(arg:GetCameraRotation().X)
if v116 > 315 and v116 < 360 or v116 > 0 and v116 < 91 then
return "Above"
end
return "Below"
end
end

return v86[75]  -- "None"
end

if not flag2 then return end
return fn36
end

tbl17.jy = function()
local jy = tbl17.cache.jy
if not jy then
local jy2 = { c = fn35() }
tbl17.cache.jy = jy2
jy = jy2
end
return jy.c
end
end

-- ============================================================
-- MODULE jz — Defensive CFrame / ViewAngles generators
--   Used by the ragebot planner when not actively targeting.
-- ============================================================
do -- jz
local function fn35()
tbl17.cE()
tbl17.jx()
tbl17.cI()
local v115 = tbl17.jy()
local v116 = Random.new()

return {
getDefensiveCFrame = function(arg, arg2, arg3, arg4)
if arg2 == "Equipped" then
return CFrame.new(arg.Position, arg4.Position)
end

if arg2 == "Unequipped" then
return CFrame.new(arg.Position, arg.Position + arg.Position - arg4.Position)
end
local v117 = arg3.ItemObserver:EquippedItemAsMelee()

if v117 ~= nil and v117.Name == "Knife" then
local cframe = CFrame.fromOrientation
local nextNumber = v116.NextNumber
local tau = math.tau
return CFrame.new(arg.Position) * cframe(v116:NextNumber(0, math.tau), v116:NextNumber(0, math.tau), nextNumber(v116, 0, tau))
end

return arg
end,
getDefensiveViewAngles = function(arg, arg2)
if arg == "None" then
return nil
end

return {
Kind = "Normalized",
Pitch = (arg == "Equipped") ~= (v115(arg2) ~= "Below") and v86[45] or -90,  -- 90 or -90
Yaw = v116:NextNumber(0, 360),
}
end,
}
end

tbl17.jz = function()
local jz = tbl17.cache.jz
if not jz then
jz = { c = fn35() }
tbl17.cache.jz = jz
end
return jz.c
end
end

-- ============================================================
-- MODULE jA — ShootLock
--   Prevents repeat-fire too quickly; tracks lock expiry.
-- ============================================================
do -- jA
local function fn35()
local index2 = {}
index2.__index = index2

index2.new = function()
return setmetatable({}, index2)
end

-- arg2 = didFire (bool), arg3 = lockDuration (seconds)
-- Returns true if a shot should register (either firing now or still within prior lock window)
index2.ShouldFire = function(arg, arg2, arg3)
local now2 = os.clock()
local lockedUntil = arg._lockedUntil
local flag19 = lockedUntil ~= nil and now2 < lockedUntil

if arg2 then
arg._lockedUntil = now2 + arg3
end

return flag19 or arg2
end

index2.Reset = function(arg)
arg._lockedUntil = nil
end

return index2
end

tbl17.jA = function()
local ja = tbl17.cache.jA
if not ja then
local ja2 = { c = fn35() }
tbl17.cache.jA = ja2
ja = ja2
end
return ja.c
end
end

-- ============================================================
-- MODULE jB — TargetSelection
--   Iterates enemies; respects PrioritizeHackers setting.
--   Filters invincible / dead / deflecting targets.
-- ============================================================
do -- jB
local function fn35()
tbl17.cr()
local v115 = tbl17.bG()
tbl17.cF()
tbl17.bM()

-- Returns false if this fighter should not be targeted
local function fn36(arg)
if not arg.IsEnemy or arg:IsInvincible() then
return false
end
if not arg.Character.State.Alive then
return false
end
local v116 = arg.ItemObserver:EquippedItemAsMelee()
if v116 ~= nil and v116:IsDeflecting() then
return false
end
return true
end

-- Bundles FighterState + AliveState into a target record
local function fn37(arg)
return { FighterState = arg, AliveState = arg.Character.State }
end

local index2 = {}
index2.__index = index2

index2.new = function(arg, arg2)
return setmetatable({ _fighters = arg, _playerTags = arg2 }, index2)
end

index2.GetTarget = function(arg)
local prioritizeHackers = v115.Data.Ragebot.PrioritizeHackers

-- First pass: tagged hackers (if PrioritizeHackers enabled)
if prioritizeHackers then
for _, v116 in arg._playerTags:GetPlayersWith("Hacker") do
local v117 = arg._fighters.StateByPlayer[v116]
if v117 ~= nil and fn36(v117) then
return fn37(v117)
end
end
end

-- Second pass: all enemies (skipping hackers already checked)
for k, v116 in arg._fighters.EnemyByPlayer, nil, nil do
if prioritizeHackers and arg._playerTags:Has(k, "Hacker") then
continue
end
if fn36(v116) then
return fn37(v116)
end
end

return nil
end

index2.HasTargets = function(arg)
for _, v116 in arg._fighters.EnemyByPlayer, nil, nil do
if fn36(v116) then
return true
end
end
return v86[153]  -- false
end

index2.IsSameTarget = function(arg, arg2)
return arg.FighterState == arg2.FighterState and arg.AliveState == arg2.AliveState
end

return index2
end

tbl17.jB = function()
local jb = tbl17.cache.jB
if not jb then
jb = { c = fn35() }
tbl17.cache.jB = jb
end
return jb.c
end
end

-- ============================================================
-- MODULE jC — Flat CFrame helper
--   lookAt that ignores Y difference (flat on XZ plane).
-- ============================================================
do -- jC
local function fn35()
local vector = Vector3.new(0, -v86[63], 0)   -- (0,-1,0)
local vector2 = Vector3.new(0, 0, -v86[63])  -- (0,0,-1)

return function(arg, arg2)
local n = arg2 - arg
local vector3 = Vector3.new(n.X, v86[186], n.Z)

if vector3.Magnitude < 0.001 then
vector3 = vector2
end

return CFrame.lookAt(arg, arg + vector3, vector)
end
end

tbl17.jC = function()
local jc = tbl17.cache.jC
if not jc then
jc = { c = fn35() }
tbl17.cache.jC = jc
end
return jc.c
end
end

-- ============================================================
-- MODULE jD — HitscanStrategy
--   Plans gun-ragebot: picks aim CFrame and fire callback.
--   Respects Riot Shield orientation; gates fire rate via ShootLock.
-- ============================================================
do -- jD
local function fn35()
local v115 = tbl17.bG()
tbl17.cR()
tbl17.gA()
local v116 = tbl17.jA()   -- ShootLock
tbl17.jB()
local v117 = tbl17.jy()   -- shield orientation
local v118 = tbl17.jC()   -- flat CFrame helper
-- Encoded shot parameters: four tables covering Above/Below × Min/Max ranges
-- These feed into the game's ShootEncoded remotes.
local vector = Vector3.new(0, -0.7, 0.05)
local vector2 = Vector3.new(0, -3.85, 0.05)

local tbl18 = { ["\0"]=-9e37,["\1"]=0,["\2"]=v86[186],["\3"]=-1.5707963267948966,["\4"]=3.1415926535897931,["\5"]=3.1415926535897931 }
local tbl19 = { ["\0"]=v86[186],["\1"]=-90000000,["\2"]=0,["\3"]=-1.5707963267948966,["\4"]=3.1415926535897931,["\5"]=3.1415926535897931 }
local tbl20 = { ["\0"]=-9e37,["\1"]=v86[186],["\2"]=0,["\3"]=1.5707963267948966,["\4"]=3.1415926535897931,["\5"]=3.1415926535897931 }
local tbl21 = { ["\0"]=0,["\1"]=90000000,["\2"]=0,["\3"]=1.5707963267948966,["\4"]=3.1415926535897931,["\5"]=3.1415926535897931 }
local tbl22 = { ["\0"]=0,["\1"]=1,["\2"]=v86[186],["\3"]=v86[186],["\4"]=0,["\5"]=0 }

local index2 = {}
index2.__index = index2

index2.new = function(arg)
return setmetatable({ _partGlue = arg, _shootLock = v116.new() }, index2)
end

-- Returns (aimCFrame, fireCallback | nil)
-- fireCallback = nil when ShootLock says not yet, in which case a random OOB CFrame is returned
index2.Plan = function(arg, arg2, arg3, arg4, arg5, arg6)
local hitboxHead = arg3.AliveState.HitboxHead
local flag19 = v117(arg3.FighterState) ~= "Below"
local ragebot = v115.Data.Ragebot
local v119 = flag19 and vector or vector2
local v120 = arg._partGlue:Acquire(arg5, hitboxHead)
local n

if flag19 then
n = v120 + v119
else
n = v118(v120.Position + v119, hitboxHead.Position)
end

-- ShootFrames gates: fire once per N frames
if not arg._shootLock:ShouldFire(arg6, arg2 * ragebot.ShootFrames) then
local random2 = math.random
-- Return dummy OOB position so position is wrong but aim angle is safe
return CFrame.new(math.random(-1000000, 1000000), math.random(5000, 10000), random2(-1000000, 1000000)), nil
end

local v121 = (flag19 and { tbl18 } or { tbl20 })[1]
local v122 = (flag19 and { tbl19 } or { tbl21 })[v86[63]]

return n, function()
arg4:ShootEncoded(v121, v122, hitboxHead, tbl22)
end
end

return index2
end

tbl17.jD = function()
local jd = tbl17.cache.jD
if not jd then
local jd2 = { c = fn35() }
tbl17.cache.jD = jd2
jd = jd2
end
return jd.c
end
end

-- ============================================================
-- MODULE jE — MeleeStrategy
--   Plans melee ragebot: normal attack or backstab (Knife).
--   Tracks backstab hitbox window (0.625 s) and cooldown (1.25 s).
-- ============================================================
do -- jE
local function fn35()
tbl17.cJ()
local v115 = tbl17.bG()
tbl17.cS()
tbl17.gA()
local v116 = tbl17.jA()
tbl17.jB()
local v117 = tbl17.jy()
local v118 = tbl17.jC()
local vector = Vector3.new(0, -v86[195], 0.05)   -- (0,-0.7,0.05)
local vector2 = Vector3.new(v86[186], -3.85, 0.05)

local tbl18 = { ["\0"]=-9e37,["\1"]=0,["\2"]=0,["\3"]=-1.5707963267948966,["\4"]=3.1415926535897931,["\5"]=3.1415926535897931 }
local tbl19 = { ["\0"]=0,["\1"]=-90000000,["\2"]=v86[186],["\3"]=-1.5707963267948966,["\4"]=3.1415926535897931,["\5"]=3.1415926535897931 }
local tbl20 = { ["\0"]=-9e37,["\1"]=0,["\2"]=v86[186],["\3"]=1.5707963267948966,["\4"]=3.1415926535897931,["\5"]=3.1415926535897931 }
local tbl21 = { ["\0"]=0,["\1"]=90000000,["\2"]=v86[186],["\3"]=1.5707963267948966,["\4"]=3.1415926535897931,["\5"]=3.1415926535897931 }
local tbl22 = { ["\0"]=0,["\1"]=1,["\2"]=v86[186],["\3"]=0,["\4"]=0,["\5"]=0 }

local function fn36()
local random2 = math.random
return CFrame.new(math.random(-10000000, -100000), math.random(5000, 10000), random2(-10000000, -100000))
end

local function fn37(arg, arg2)
return { Kind = "Normalized", Pitch = math.deg(arg), Yaw = math.deg(arg2) }
end

local function fn38(arg, arg2, arg3, arg4)
return { ["\0"]=arg["\0"],["\1"]=arg["\1"],["\2"]=arg["\2"],["\3"]=arg2,["\4"]=arg3,["\5"]=arg4 }
end

local index2 = {}
index2.__index = index2

index2.new = function(arg)
return setmetatable({ _partGlue = arg, _shootLock = v116.new(), _hitboxWindowUntil = -1, _attackCooldown = -1 }, index2)
end

-- Returns (aimCFrame, viewAngles | nil, attackCallback | nil)
index2.Plan = function(arg, arg2, arg3, arg4, gluedOurPart, arg5)
local aliveState = arg3.AliveState
local hitboxHead = aliveState.HitboxHead
local flag19 = v117(arg3.FighterState) ~= "Below"
local ragebot = v115.Data.Ragebot
local v119 = flag19 and vector or vector2
local v120 = arg._partGlue:Acquire(gluedOurPart, hitboxHead)
arg._gluedOurPart = gluedOurPart
local n

if flag19 then
n = v120 + v119
else
n = v118(v120.Position + v119, hitboxHead.Position)
end

local v121, v122, v123 = aliveState.RootPart.CFrame:ToOrientation()
local n33 = flag19 and -1.5707963267948966 or 1.5707963267948966
local v124 = (flag19 and { tbl18 } or { tbl20 })[1]
local v125 = (flag19 and { tbl19 } or { tbl21 })[1]
local v126 = fn38(v124, n33, v122, v123)
local v127 = fn38(v125, n33, v122, v123)
local now2 = os.clock()

-- Still inside the backstab hitbox window — keep attacking
if now2 < arg._hitboxWindowUntil then
return n, fn37(v121, v122), function()
arg4:HeavyAttackEncoded(v126, v127, hitboxHead, tbl22)
end
end

if not arg._shootLock:ShouldFire(arg5, arg2 * ragebot.ShootFrames) then
return fn36(), nil, nil
end

if now2 < arg._attackCooldown then
return fn36(), nil, nil
end

-- Knife: use HeavyAttack (backstab) and record the window
if arg4.Name == "Knife" then
arg:_RecordBackstab()
return n, fn37(v121, v122), function()
arg4:HeavyAttackEncoded(v126, v127, hitboxHead, tbl22)
end
end

return n, nil, function()
arg4:AttackEncoded(v126, v127, hitboxHead, tbl22)
end
end

-- Record backstab timing: 0.625 s hitbox window, 1.25 s attack cooldown
index2._RecordBackstab = function(arg)
local now2 = os.clock()
arg._hitboxWindowUntil = now2 + 0.625
arg._attackCooldown = now2 + 1.25
end

index2.ResetState = function(arg)
arg._hitboxWindowUntil = -1
arg._attackCooldown = -1
arg._shootLock:Reset()
local gluedOurPart = arg._gluedOurPart
if gluedOurPart ~= nil then
arg._partGlue:Free(gluedOurPart)
arg._gluedOurPart = nil
end
end

return index2
end

tbl17.jE = function()
local je = tbl17.cache.jE
if not je then
local je2 = { c = fn35() }
tbl17.cache.jE = je2
je = je2
end
return je.c
end
end

-- ============================================================
-- MODULE jF — Random ring-point generator
--   Picks a random position within a radius band centred on
--   a given origin, with a fully random orientation.
-- ============================================================
do -- jF
local function fn35()
local v115 = Random.new()

return function(arg, arg2, arg3)
local v116 = v115:NextNumber(0, 6.2831853071795862)
local v117 = v115:NextNumber(arg2, arg3)
local cframe = CFrame.new(arg + Vector3.new(math.cos(v116) * v117, 0, math.sin(v116) * v117))
local nextNumber = v115.NextNumber
return cframe * CFrame.fromOrientation(v115:NextNumber(0, 6.2831853071795862), v115:NextNumber(0, 6.2831853071795862), nextNumber(v115, 0, 6.2831853071795862))
end
end

tbl17.jF = function()
local jf = tbl17.cache.jF
if not jf then
jf = { c = fn35() }
tbl17.cache.jF = jf
end
return jf.c
end
end

-- ============================================================
-- MODULE jG — Surface normal finder
--   Samples a BasePart surface normal at the closest point
--   to a given position.
-- ============================================================
do -- jG
local function fn35()
return function(arg, arg2)
local closestPointOnSurface = arg:GetClosestPointOnSurface(arg2)
local n = arg2 - closestPointOnSurface
if n.Magnitude < 1e-06 then
return closestPointOnSurface, nil
end
-- Estimate normal from three offset samples
local n33 = arg:GetClosestPointOnSurface(arg2 + Vector3.xAxis * 0.05) - closestPointOnSurface
local n34 = arg:GetClosestPointOnSurface(arg2 + Vector3.yAxis * 0.05) - closestPointOnSurface
local n35 = arg:GetClosestPointOnSurface(arg2 + Vector3.zAxis * 0.05) - closestPointOnSurface
local n36 = n34:Cross(n33)

if n36.Magnitude < 1e-06 then n36 = n34:Cross(n35) end
if n36.Magnitude < 1e-06 then n36 = n33:Cross(n35) end
if n36.Magnitude < 1e-06 then return closestPointOnSurface, nil end
if n36:Dot(n) < 0 then n36 = -n36 end

return closestPointOnSurface, n36.Unit
end
end

tbl17.jG = function()
local jg = tbl17.cache.jG
if not jg then
local jg2 = { c = fn35() }
tbl17.cache.jG = jg2
jg = jg2
end
return jg.c
end
end

-- ============================================================
-- MODULE jH — ProjectileBreakerTeleport
--   For Slingshot countering: finds surfaces inside the map
--   that break the projectile line of sight, then oscillates
--   the server CFrame behind them using jG surface normals.
-- ============================================================
do -- jH
local function fn35()
local v115 = tbl17.bG()
tbl17.cF()
tbl17.cX()
local v116 = tbl17.k()    -- Trove
local v117 = tbl17.jF()   -- random ring point
local v118 = tbl17.jG()   -- surface normal
local v119 = cloneref(game:GetService("CollectionService"))
local v120 = Random.new()
local vector = Vector3.new(5, 5, 5)
local overlapParams = OverlapParams.new()
overlapParams.FilterType = Enum.RaycastFilterType.Exclude
overlapParams.FilterDescendantsInstances = {}
overlapParams.BruteForceAllSlow = v86[34]  -- true

-- Build a local frame from surface point, normal, and part orientation
local function fn36(arg, arg2, arg3)
local unit = arg2.Unit
local n = arg3.Position - arg
local n33 = n - unit * n:Dot(unit)

if n33.Magnitude < 0.0001 then
local lookVector = arg3.CFrame.LookVector
n33 = lookVector - unit * lookVector:Dot(unit)
if n33.Magnitude < 0.0001 then
n33 = Vector3.xAxis - unit * unit:Dot(Vector3.xAxis)
end
end

local unit2 = n33.Unit:Cross(unit).Unit
return { SurfacePosition = arg, Right = unit2, Up = unit, Forward = unit:Cross(unit2).Unit }
end

-- Oscillate depth along a sine wave driven by clock
local function fn37(arg, arg2)
local n = 6.2831853071795862 * arg2
return arg.Min + (arg.Max - arg.Min) * (math.sin(os.clock() * n) + 1) * v86[101]
end

local function fn38()
local projectileBreaker = v115.Data.Ragebot.Evasion.ProjectileBreaker
return fn37(projectileBreaker.DepthUp, projectileBreaker.DepthUpFrequency)
end

local function fn39()
local projectileBreaker = v115.Data.Ragebot.Evasion.ProjectileBreaker
return fn37(projectileBreaker.DepthForward, projectileBreaker.DepthForwardFrequency)
end

-- Build a CFrame behind a surface at given up/forward depth offsets
local function fn40(arg, arg2, arg3)
return CFrame.fromMatrix(arg.SurfacePosition - arg.Up * 0.01 - arg.Up * arg2 + arg.Forward * arg3, arg.Right, arg.Up, -arg.Forward)
end

local function fn41(arg)
return arg.Name == "Barriers" or arg:HasTag("OutOfBoundsPart") or arg:HasTag("KillBrick")
end

local function fn42(arg)
for _, v121 in workspace:GetPartBoundsInBox(CFrame.new(arg), vector, overlapParams), nil, nil do
if fn41(v121) then return true end
end
return false
end

-- Find a valid upward-facing surface on a BasePart
local function fn43(arg)
if arg.Transparency == 1 then return nil end
local size = arg.Size
if size.X * size.Y * size.Z < 64 then return nil end
local n = size.Magnitude + 1000

for i = 1, v86[175] do  -- 5 random probes
local v121, v122 = v118(arg, arg.Position + v120:NextUnitVector() * n)
if v122 == nil or v122.Y < 0.98 then continue end
return fn36(v121, v122, arg)
end

local v121, v122 = v118(arg, arg.Position + Vector3.yAxis * n)
if v122 ~= nil and v122.Y >= 0.98 then
return fn36(v121, v122, arg)
end
return nil
end

-- Fallback: random ring position (used when no surface found)
local function fn44(arg)
local projectileBreaker = v115.Data.Ragebot.Evasion.ProjectileBreaker
local fallbackBaseRadius = projectileBreaker.FallbackBaseRadius
local n = fallbackBaseRadius + fallbackBaseRadius * projectileBreaker.FallbackRadiusRandomFactor
local position = arg.Position
local v121 = v117(projectileBreaker.FallbackAnchorFromCharacter and position or Vector3.new(v86[186], position.Y, v86[186]), fallbackBaseRadius, n)
local v122 = v120:NextInteger(v86[63], 3)
local position2 = v121.Position
local x = position2.X
local y = position2.Y
local z = position2.Z

if v122 == 1 then
x = 1073741824
elseif v122 == v86[56] then
y = 1073741824
else
z = 1073741824
end

return v121 - position2 + Vector3.new(x, y, z)
end

local index2 = {}
index2.__index = index2

index2.new = function(arg, arg2)
local ProjectileBreakerTeleport = v116.new("ragebot.ProjectileBreakerTeleport")

local tbl18 = {
_trove = ProjectileBreakerTeleport,
_fighters = arg,
_nextPositionCooldown = -v86[63],
_poolEnvironmentId = nil,
_pool = {},
_processedPartSet = {},
}

setmetatable(tbl18, index2)

ProjectileBreakerTeleport:Add(arg2:ObserveContext("ragebot.ProjectileBreakerTeleport", function(arg3, arg4)
tbl18:_BindEnvironment(arg3.FighterState.EnvironmentId)
arg4:Connect(arg3.FighterState.EnvironmentIdChanged, function(arg5)
tbl18:_BindEnvironment(arg5)
end)
end))

ProjectileBreakerTeleport:Connect(arg2.ContextRemoved, function()
tbl18:_BindEnvironment(nil)
end)

return tbl18
end

index2.Destroy = function(arg)
arg._trove:Destroy()
end

index2._BindEnvironment = function(arg, poolEnvironmentId)
arg._poolEnvironmentId = poolEnvironmentId
arg._pool = {}
arg._processedPartSet = {}
end

-- Main compute: return a CFrame behind a blocking surface, or fallback
index2.Compute = function(arg, arg2)
local nextPositionCooldown = arg._nextPositionCooldown

if os.clock() < nextPositionCooldown then
local lastBreakSurface = arg._lastBreakSurface
if lastBreakSurface ~= nil then
return fn40(lastBreakSurface, fn38(), fn39())
end
end

if not arg:_HasProjectileThreat() then
arg._lastBreakSurface = nil
return fn44(arg2)
end
local v121 = arg:_BreakLine()
if v121 ~= nil then
arg._lastBreakSurface = v121
return fn40(v121, fn38(), fn39())
end
return fn44(arg2)
end

-- Only activate for Slingshot (non-raycast projectile weapon)
index2._HasProjectileThreat = function(arg)
for _, v121 in arg._fighters.EnemyByPlayer, nil, nil do
local v122 = v121.ItemObserver:EquippedItemAsGun()
if v122 ~= nil and not v122.IsRaycast and v122.Name == "Slingshot" then
return true
end
end
return false
end

-- Scan up to 64 tagged parts and 30 valid surfaces per batch
index2._ScanBatch = function(arg, arg2)
local projectileBreaker = v115.Data.Ragebot.Evasion.ProjectileBreaker
local n = (projectileBreaker.DepthUp.Min + projectileBreaker.DepthUp.Max) * v86[101]
local n33 = (projectileBreaker.DepthForward.Min + projectileBreaker.DepthForward.Max) * 0.5
local v121 = v86[186]

local function fn45(arg3)
if not arg3:IsA("BasePart") or arg._processedPartSet[arg3] then return end
arg._processedPartSet[arg3] = true
v121 += 1
local v122 = fn43(arg3)
if v122 == nil then return end
if fn42(fn40(v122, n, n33).Position) then return end
table.insert(arg._pool, v122)
end

for _, v122 in v119:GetTagged("RaycastWhitelist" .. arg2) do
if fn41(v122) then continue end
fn45(v122)
if v121 >= v86[83] or #arg._pool >= 30 then return end

for _, v123 in v122:GetDescendants() do
if fn41(v123) then continue end
fn45(v123)
if v121 >= 64 or #arg._pool >= v86[192] then return end
end
end
end

index2._BreakLine = function(arg)
local poolEnvironmentId = arg._poolEnvironmentId
if poolEnvironmentId == nil then return nil end

if #arg._pool < 30 then
arg:_ScanBatch(poolEnvironmentId)
end

if #arg._pool < 30 then return nil end
local repositionInterval = v115.Data.Ragebot.Evasion.ProjectileBreaker.RepositionInterval
arg._nextPositionCooldown = os.clock() + repositionInterval
return arg._pool[v120:NextInteger(1, #arg._pool)]
end

index2.ResetState = function(arg)
arg._nextPositionCooldown = -1
arg._lastBreakSurface = nil
end

return index2
end

tbl17.jH = function()
local jh = tbl17.cache.jH
if not jh then
jh = { c = fn35() }
tbl17.cache.jH = jh
end
return jh.c
end
end

-- ============================================================
-- MODULE jI — Random evasion compute
--   Picks a position in a radius band around origin (or map
--   centre if AnchorFromCharacter is false), with one axis
--   clamped to 1073741824 (OOB sentinel).
-- ============================================================
do -- jI
local function fn35()
local v115 = tbl17.bG()
local v116 = tbl17.jF()
local v117 = Random.new()

return { compute = function(arg)
local random2 = v115.Data.Ragebot.Evasion.Random
local baseRadius = random2.BaseRadius
local n = baseRadius + baseRadius * random2.RadiusRandomFactor
local position = arg.Position
local v118 = v116(random2.AnchorFromCharacter and position or Vector3.new(0, position.Y, 0), baseRadius, n)
local v119 = v117:NextInteger(v86[63], 3)
local position2 = v118.Position
local x = position2.X
local y = position2.Y
local z = position2.Z

if v119 == 1 then
x = 1073741824
elseif v119 == 2 then
y = 1073741824
else
z = 1073741824
end

return v118 - position2 + Vector3.new(x, y, z)
end }
end

tbl17.jI = function()
local ji = tbl17.cache.jI
if not ji then
ji = { c = fn35() }
tbl17.cache.jI = ji
end
return ji.c
end
end

-- ============================================================
-- MODULE jJ — SpatialLimitGate
--   Tracks when the server CFrame is inside OOB sentinel space
--   (|component| >= 4194304).  Gates shots to only fire while
--   inside the limit zone, calibrating expected duration from
--   prior history.
-- ============================================================
do -- jJ
local function fn35()
local v115 = tbl17.bG()
tbl17.cF()
tbl17.jB()
local v116 = tbl17.k()

local function fn36(arg)
return math.abs(arg.X) >= 4194304 or math.abs(arg.Y) >= 4194304 or math.abs(arg.Z) >= 4194304
end

local index2 = {}
index2.__index = index2

index2.new = function(arg)
local tbl18 = { _trove = v116.new("ragebot.SpatialLimitGate"), _measurementByFighterState = {} }
setmetatable(tbl18, index2)
tbl18:_Initialize(arg)
return tbl18
end

index2._Initialize = function(arg, arg2)
arg._trove:Add(arg2:ObserveRemoteStates(function(arg3)
arg._measurementByFighterState[arg3] = { ExpectedDuration = 1 }
end, function(arg3)
arg._measurementByFighterState[arg3] = nil
end))
end

-- Returns true if the shot should be suppressed this tick
index2.Tick = function(arg, arg2)
local now2 = os.clock()
local fighterState = arg2.FighterState
local v117 = arg._measurementByFighterState[fighterState]
local limitEntryTime = v117.LimitEntryTime
local flag19 = fighterState.ItemObserver:GetEquippedAmmoState() ~= false

if not fn36(arg2.AliveState.RootPart.Position) then
if limitEntryTime ~= nil then
if flag19 then
v117.ExpectedDuration = now2 - limitEntryTime
end
v117.LimitEntryTime = nil
end
return false
end

if limitEntryTime == nil then
v117.LimitEntryTime = now2
limitEntryTime = now2
end

if flag19 then
if v117.ExpectedDuration - v115.Data.Ragebot.Stability <= now2 - limitEntryTime then
return false
end
end

return v86[34]  -- true = suppress
end

index2.Destroy = function(arg)
arg._trove:Destroy()
end

return index2
end

tbl17.jJ = function()
local jj = tbl17.cache.jJ
if not jj then
jj = { c = fn35() }
tbl17.cache.jJ = jj
end
return jj.c
end
end

-- ============================================================
-- MODULE jK — Translocate evasion compute
--   Uses OutOfBoundsPart with KillDelay==0 to teleport under
--   the kill floor, with a configurable offset.
-- ============================================================
do -- jK
local function fn35()
local v115 = tbl17.bG()
local v116 = tbl17.jF()
local v117 = cloneref(game:GetService("CollectionService"))

return { compute = function(arg, arg2)
if not arg2 then
return v116(arg.Position, 10000, 1e9)
end
local v118 = nil

for _, v119 in v117:GetTagged("OutOfBoundsPart") do
if v119:GetAttribute("KillDelay") == 0 then
v118 = v119
break
else
v118 = nil
end
end

if v118 == nil then
return v116(arg.Position, 10000, 1e9)
end
-- Sit at the floor of the OOB part + user offset
return v118.CFrame * CFrame.new(0, -v118.Size.Y / 2 + v115.Data.Ragebot.Evasion.Translocate.Offset, 0)
end }
end

tbl17.jK = function()
local jk = tbl17.cache.jK
if not jk then
jk = { c = fn35() }
tbl17.cache.jK = jk
end
return jk.c
end
end

-- ============================================================
-- MODULE jL — Ring-position tables
--   Deterministic pseudorandom positions in two concentric
--   rings (normal / immune zones).  Uses a session-seeded
--   hash for position derivation — not truly random but
--   unpredictable per-session.
-- ============================================================
do -- jL
local function fn35()
local n = 1121
local v115 = Random.new()

local function fn36()
return v115:NextInteger(0, 65535) * 65536 + v115:NextInteger(v86[186], 65535)
end

local v116 = fn36()
local v117 = fn36()
local v118 = fn36()
local v119 = fn36()

local function fn37(arg, arg2)
local n33 = (bit32.bxor(arg, arg2, v116) + v117) % 4294967296
local n34 = (bit32.bxor(n33, bit32.lrotate(n33, 7)) + v118) % 4294967296
local n35 = (bit32.bxor(n34, bit32.rrotate(n34, 11)) + v119) % 4294967296
return (bit32.bxor(n35, bit32.lrotate(n35, 17)))
end

local function fn38(arg, arg2)
local n33 = arg + 400 + v86[83]
return {
Min = arg, Max = arg2,
Cells = (arg2 - arg) / 2048,
YMin = n33,
YSpan = arg2 - 400 - 64 - n33 + 1,
Salt = fn36(),
}
end

local v120 = fn38(65536, 524288)     -- normal ring
local v121 = fn38(134217728, 1073741824)  -- immune ring

local function fn39(arg, arg2, arg3, arg4)
local bxor = bit32.bxor
local salt = arg.Salt
return fn37(bit32.bxor(arg2, bit32.lshift(arg3, v86[118])), bxor(arg4, salt))
end

local function fn40(arg, arg2, arg3, arg4)
return fn39(arg, arg2, arg3, arg4) % n - 560
end

local function fn41(arg, arg2, arg3)
local n33 = arg.Min + 1024
local ySpan = arg.YSpan
return Vector3.new(
n33 + arg2 * 2048 + fn40(arg, arg2, arg3, 324508639),
arg.YMin + fn39(arg, arg2, arg3, 826366246) % ySpan,
n33 + arg3 * 2048 + fn40(arg, arg2, arg3, 610839776)
)
end

local function fn42(arg)
local n33 = arg.Cells - 1
local nextInteger = v115.NextInteger
local v122 = v86[186]
local v123 = fn41(arg, v115:NextInteger(0, n33), nextInteger(v115, v122, n33))
local n34 = 200 * v115:NextNumber() ^ 0.33333333333333331
local v124 = v115:NextNumber(-1, 1)
local v125 = math.sqrt(1 - v124 * v124)
local v126 = v115:NextNumber(0, 6.2831853071795862)
return v123 + Vector3.new(n34 * v125 * math.cos(v126), n34 * v124, n34 * v125 * math.sin(v126))
end

local function fn43(arg, arg2)
local min = arg.Min; local max = arg.Max
local x = arg2.X; local y = arg2.Y; local z = arg2.Z
if x <= min or x >= max or y <= min or y >= max or z <= min or z >= max then return false end
local n33 = math.floor((x - min) / 2048)
local n34 = math.floor((z - min) / 2048)
return (arg2 - fn41(arg, n33, n34)).Magnitude < 400
end

local function fn44(arg)
local cframe = CFrame.fromOrientation
local nextNumber = v115.NextNumber
return CFrame.new(arg) * cframe(v115:NextNumber(-3.1415926535897931, 3.1415926535897931), v115:NextNumber(-3.1415926535897931, 3.1415926535897931), nextNumber(v115, -3.1415926535897931, 3.1415926535897931))
end

return {
SphereRadius = 400,
isInAnyRing = function(arg) return fn43(v120, arg) or fn43(v121, arg) end,
isInNormalRing = function(arg) return fn43(v120, arg) end,
isInImmuneRing = function(arg)
if not flag3 then return end
return fn43(v121, arg)
end,
getNormal = function() return fn44(fn42(v120)) end,
getImmune = function() return fn44(fn42(v121)) end,
}
end

tbl17.jL = function()
local jl = tbl17.cache.jL
if not jl then
jl = { c = fn35() }
tbl17.cache.jL = jl
end
return jl.c
end
end

-- ============================================================
-- MODULE jM — Weapon action resolver
--   Given ItemBehaviors, picks the highest-priority enabled
--   weapon and returns an action record:
--     { Type = "Attack"|"Swap"|"Reload", Item = <item> }
-- ============================================================
do -- jM
local function fn35()
local v115 = tbl17.bG()
tbl17.cU()
tbl17.cX()

local function fn36(arg)
local index2 = arg.Index
return index2 == v86[63] and "Primary" or index2 == 2 and "Secondary" or index2 == 3 and "Melee" or nil
end

local function fn37(arg)
return v115.Data.Ragebot.Weapons.Enabled[arg]
end

return { getAction = function(arg)
local weapons = v115.Data.Ragebot.Weapons
local onEmpty = weapons.OnEmpty
local huge = math.huge
local huge2 = math.huge
local flag19 = false
local v116 = nil  -- best usable weapon
local v117 = nil  -- best empty-but-reloadable weapon

for _, v118 in arg.ItemBehaviors:GetItems(), nil, nil do
local v119 = fn36(v118)

if not (v119 == nil or not fn37(v119)) then
flag19 = v86[34]
local huge3 = table.find(weapons.Priority, v119) or math.huge

if v118.__type == "Gun" and v118:GetAmmo() == 0 then
if not (v118:GetAmmoReserve() <= 0) then
if huge3 < huge2 then
if onEmpty == "Reload" then
v116 = v118
huge = huge3
else
huge2 = huge3
v117 = v118
end
end
end
elseif v116 == nil or huge3 < huge then
v116 = v118
huge = huge3
end
end
end

if not flag19 then return nil end

if v116 ~= nil then
local flag20 = v116.__type == "Gun"
if flag20 then
local v118 = v86[186]
flag20 = v116:GetAmmo() == v118
end

if v116:IsEquipped() then
if flag20 then return { Type = "Reload", Item = v116 } end
return { Type = "Attack", Item = v116 }
end
return { Type = "Swap", Item = v116 }
end

if onEmpty == "Swap" then return nil end

if v117 ~= nil then
if v117:IsEquipped() then return { Type = "Reload", Item = v117 } end
return { Type = "Swap", Item = v117 }
end

return nil
end }
end

tbl17.jM = function()
local jm = tbl17.cache.jM
if not jm then
jm = { c = fn35() }
tbl17.cache.jM = jm
end
return jm.c
end
end

-- ============================================================
-- MODULE jN — Riot-shield state helper
--   Returns "Equipped" | "Unequipped" | "None"
-- ============================================================
do -- jN
local function fn35()
tbl17.cU()
tbl17.jx()

return function(arg)
local v115 = arg:FindMeleeByName("Riot Shield")
if v115 == nil then return "None" end
return v115:IsEquipped() and "Equipped" or "Unequipped"
end
end

tbl17.jN = function()
local jn = tbl17.cache.jN
if not jn then
jn = { c = fn35() }
tbl17.cache.jN = jn
end
return jn.c
end
end

-- ============================================================
-- MODULE jO — Main Ragebot controller
--   Wires all sub-modules together.
--   Per-tick flow:
--     1. Check enabled + context valid
--     2. Resolve weapon action (attack / swap / reload)
--     3. If Translocate mode: apply translocate CFrame directly
--     4. Else: get target → plan CFrame + fire callback
--     5. Apply plan via characterController
--     6. Handle reload transport (teleport to immune ring while
--        reloading, fire reload remote at right time)
-- ============================================================
do -- jO
local function fn35()
local v115 = tbl17.bG()
tbl17.cU()
tbl17.cX()
local v116 = tbl17.jz()   -- defensive CFrame / ViewAngles
tbl17.cF()
local v117 = tbl17.jD()   -- HitscanStrategy
tbl17.cU()
local v118 = tbl17.c4()   -- keybind observer
local v119 = tbl17.jE()   -- MeleeStrategy
tbl17.gA()
tbl17.cX()
tbl17.bM()
local v120 = tbl17.jH()   -- ProjectileBreakerTeleport
local v121 = tbl17.jI()   -- Random evasion
local v122 = tbl17.cG()   -- replication delay estimator
local v123 = tbl17.jJ()   -- SpatialLimitGate
tbl17.g_()
local v124 = tbl17.jB()   -- TargetSelection
local v125 = tbl17.jK()   -- Translocate evasion
local v126 = tbl17.k()    -- Trove
local v127 = tbl17.jL()   -- ring tables
local v128 = tbl17.jM()   -- weapon action resolver
local v129 = tbl17.jN()   -- riot shield state
local fallenPartsDestroyHeight = workspace.FallenPartsDestroyHeight

-- Shortcut: immune-ring CFrame used while reloading
local function fn36()
return { CFrame = v127.getImmune(), ShouldSkipDefense = true }
end

local index2 = {}
index2.__index = index2

index2.new = function(arg, arg2, arg3, arg4, arg5)
local ragebot = v126.new("ragebot")
local v130 = ragebot:Add(v123.new(arg))   -- SpatialLimitGate instance

local tbl18 = {
_trove = ragebot,
_enabled = false,
_lastTargetWorld = nil,
_lastDefensiveViewAngles = nil,
_playerContext = arg3,
_targetSelection = v124.new(arg, arg2),
_spatialLimitGate = v130,
_hitscanStrategy = v117.new(arg5),
_meleeStrategy = v119.new(arg5),
_projectileBreakerTeleport = ragebot:Add(v120.new(arg, arg3)),
_stateHook = arg4,
_reloadGun = nil,
_reloadReadyAt = nil,
_reloadAcknowledgementDeadline = nil,
_pendingDepletionAmmo = nil,
}

setmetatable(tbl18, index2)
tbl18:_Initialize()
return tbl18
end

index2._Initialize = function(arg)
arg._trove:Add(arg._playerContext:ObserveContext("ragebot", function(innerContext)
if not flag2 then return end
arg._innerContext = innerContext
arg:_ClearReloadTransport()
end))

arg._trove:Connect(arg._playerContext.ContextRemoved, function()
arg:_Reset()
arg._innerContext = nil
end)

arg._trove:Add(v118:ObserveEnabledKeybind({ "Ragebot" }, function(arg2)
arg:SetEnabled(arg2)
arg:_Reset()
end))
end

-- Enable/disable: patch game properties for extended OOB lifetime
index2.SetEnabled = function(arg, enabled)
if arg._enabled == enabled then return end
arg._enabled = enabled
-- Remove fall-death floor when enabled so OOB positions don't kill the character
v112(workspace, "FallenPartsDestroyHeight", enabled and (0/0) or fallenPartsDestroyHeight)
-- Increase physics send rate and history buffer for smoother server-side position
v107(v108, "DFIntS2PhysicsSenderRate", enabled and "120" or "15")
v107(v108, "DFIntAssemblyHistoryBufferSize", enabled and "2147483648" or "15")
v107(v108, "DFIntAssemblyHistorySkipSize", enabled and v86[18] or "8")  -- "0" or "8"

if not enabled then
arg:_ClearReloadTransport()
end
end

-- Per-tick update
index2.Update = function(arg, arg2)
local innerContext = arg._innerContext
if innerContext == nil then arg:_Reset(); return end
local fighterState = innerContext.FighterState
if fighterState.EnvironmentId == nil or not arg._enabled then arg:_Reset(); return end
local state = fighterState.Character.State
if not state.Alive then arg:_Reset(); return end

local characterController = innerContext.CharacterController
local clientCFrame = characterController:GetClientCFrame()
local mode = v115.Data.Ragebot.Evasion.Mode
local v130 = v128.getAction(innerContext)

-- Translocate mode: bypass targeting entirely
if mode == "Translocate" and arg._reloadGun == nil and (v130 == nil or v130.Type ~= "Reload") then
arg:_ApplyForcedCrouch(v86[153])
characterController:SetServerCFrame(v125.compute(clientCFrame, arg._targetSelection:HasTargets()))
return
end

local target = arg._targetSelection:GetTarget()

if target ~= nil then
arg._lastTargetWorld = target.AliveState.RootPart.Position
else
arg._lastTargetWorld = nil
end

local v131 = arg:_Plan(arg2, v130, target, state.RootPart, clientCFrame, mode)
arg:_ApplyPlan(v131, target, innerContext)
local reloadGun = arg._reloadGun

-- Track when the currently-reloading gun finishes
if reloadGun ~= nil and arg._reloadReadyAt == nil and arg._pendingDepletionAmmo == nil and not reloadGun:IsReloading() then
arg._reloadReadyAt = os.clock() + v122.getEstimatedReplicationDelay()
end

arg:_ApplyForcedCrouch(v131.ShouldForceCrouch == true)
local v132 = innerContext.ItemBehaviors:EquippedItemAsGun()
local ammo = v132 ~= nil and v132:GetAmmo() or 0
local shotRequestCount = v132 ~= nil and v132.ShotRequestCount or 0
local weaponAction = v131.WeaponAction

if weaponAction ~= nil then
weaponAction()

-- If a shot depleted the gun, enter reload transport
if v132 ~= nil and (v132 ~= nil and v132.ShotRequestCount - shotRequestCount or 0) > 0 and v132:GetExpectedAmmoAfterPendingShots() <= 0 then
innerContext.CharacterController:SetServerCFrame(v127.getImmune())
local now2 = os.clock()
arg._reloadGun = v132
arg._reloadReadyAt = now2 + v122.getEstimatedReplicationDelay()
arg._pendingDepletionAmmo = ammo
arg._reloadAcknowledgementDeadline = now2 + v122.getEstimatedRemoteDelay() + v122.getEstimatedReplicationDelay()
end
end
end

-- Build a plan record for this tick
index2._Plan = function(arg, arg2, arg3, arg4, arg5, arg6, arg7)
local flag19 = arg4 ~= nil and not arg._spatialLimitGate:Tick(arg4)
local v130 = arg:_PlanReloadTransport(arg3)
if v130 ~= nil then return v130 end

if arg3 == nil then return arg:_EvadePlan(arg6, arg7) end

if arg3.Type == "Swap" then
local item = arg3.Item
local v131 = arg:_EvadePlan(arg6, arg7)
v131.WeaponAction = function() item:Equip() end
return v131
end

if arg3.Type == "Reload" then return fn36() end

if arg4 == nil then return arg:_EvadePlan(arg6, arg7) end
local item = arg3.Item

if item.__type == "Gun" then
if item:IsReloading() then return fn36() end
local v131, v132 = arg._hitscanStrategy:Plan(arg2, arg4, item, arg5, flag19)
return { CFrame = v131, WeaponAction = v132, ShouldForceCrouch = true, IsAimPose = v132 ~= nil }
end

if item.__type == "Melee" then
local v131, v132, v133 = arg._meleeStrategy:Plan(arg2, arg4, item, arg5, flag19)
return {
CFrame = v131,
ViewAngles = v132,
WeaponAction = v133,
ShouldSkipDefense = v86[34],
ShouldForceCrouch = true,
}
end

return {}
end

index2._ClearReloadTransport = function(arg)
arg._reloadGun = nil
arg._reloadReadyAt = nil
arg._reloadAcknowledgementDeadline = nil
arg._pendingDepletionAmmo = nil
end

-- Manages the immune-ring hold during reload and fires the Reload remote at the right time
index2._PlanReloadTransport = function(arg, arg2)
local reloadGun = arg._reloadGun
local now2 = os.clock()

if reloadGun ~= nil then
if (arg._innerContext ~= nil and arg._innerContext.ItemBehaviors:EquippedItemAsGun() or nil) ~= reloadGun or arg2 ~= nil and (arg2.Type == "Swap" or arg2.Type == "Attack") and arg2.Item ~= reloadGun then
arg:_ClearReloadTransport()
return nil
end

if reloadGun:IsReloading() then
arg._reloadReadyAt = nil
arg._pendingDepletionAmmo = nil
arg._reloadAcknowledgementDeadline = nil
return fn36()
end

local ammo = reloadGun:GetAmmo()

if arg._pendingDepletionAmmo ~= nil then
local reloadAcknowledgementDeadline = arg._reloadAcknowledgementDeadline

if not (ammo <= 0 and reloadGun:GetAmmoReserve() > 0) then
local flag19 = reloadAcknowledgementDeadline == nil or now2 >= reloadAcknowledgementDeadline
if not flag19 then
local v130 = v86[186]
flag19 = reloadGun:GetExpectedAmmoAfterPendingShots() > v130
end
if flag19 then
arg:_ClearReloadTransport()
return nil
end
return fn36()
end

arg._pendingDepletionAmmo = nil
arg._reloadAcknowledgementDeadline = nil
end

if ammo > 0 or reloadGun:GetAmmoReserve() <= 0 then
arg:_ClearReloadTransport()
return nil
end

local reloadReadyAt = arg._reloadReadyAt
if reloadReadyAt == nil then
reloadReadyAt = now2 + v122.getEstimatedReplicationDelay()
arg._reloadReadyAt = reloadReadyAt
end

local v130 = fn36()
local reloadAcknowledgementDeadline = arg._reloadAcknowledgementDeadline

if now2 >= reloadReadyAt and (reloadAcknowledgementDeadline == nil or now2 >= reloadAcknowledgementDeadline) then
v130.WeaponAction = function()
if reloadGun:Reload() then
arg._reloadAcknowledgementDeadline = os.clock() + v122.getEstimatedRemoteDelay() + v122.getEstimatedReplicationDelay()
end
end
end

return v130
end

if arg2 == nil or arg2.Type ~= "Reload" then return nil end
arg._reloadGun = arg2.Item
arg._reloadReadyAt = nil
arg._reloadAcknowledgementDeadline = nil
arg._pendingDepletionAmmo = nil
return fn36()
end

-- Choose evasion CFrame based on mode
index2._EvadePlan = function(arg, arg2, arg3)
if arg3 == "Off" then return {} end

if arg3 == "ProjectileBreaker" then
return { CFrame = arg._projectileBreakerTeleport:Compute(arg2), ShouldSkipDefense = v86[34] }
end

return { CFrame = v121.compute(arg2) }
end

-- Write plan to the server via characterController
index2._ApplyPlan = function(arg, arg2, arg3, arg4)
local characterController = arg4.CharacterController
local cFrame = arg2.CFrame

if cFrame == nil or arg3 == nil or arg2.ShouldSkipDefense then
characterController:SetServerCFrame(cFrame)
characterController:SendViewAngles(20, arg2.ViewAngles)
return
end

local aliveState = arg3.AliveState
local v130 = v129(arg4.ItemBehaviors)
local v131 = v116.getDefensiveCFrame(cFrame, v130, arg3.FighterState, aliveState.RootPart)
characterController:SetServerCFrame(v131)

if arg2.IsAimPose or arg2.ShouldDefendInPlace then
arg._lastDefensiveViewAngles = v116.getDefensiveViewAngles(v130, arg3.FighterState)
end

characterController:SendViewAngles(v86[9], arg2.ViewAngles or arg._lastDefensiveViewAngles)
end

index2.GetLastTargetWorld = function(arg)
return arg._lastTargetWorld
end

index2._ApplyForcedCrouch = function(arg, arg2)
if arg2 then
arg._stateHook:SetForced("IsCrouching", true)
else
arg._stateHook:ClearForced("IsCrouching")
end
end

index2._Reset = function(arg)
arg:_ClearReloadTransport()
arg._lastTargetWorld = nil
arg._lastDefensiveViewAngles = nil
arg:_ApplyForcedCrouch(false)
arg._meleeStrategy:ResetState()
arg._projectileBreakerTeleport:ResetState()
local innerContext = arg._innerContext
if innerContext == nil then return end
innerContext.CharacterController:SetServerCFrame(nil)
innerContext.CharacterController:SendViewAngles(20, nil)
end

index2.Destroy = function(arg)
arg._trove:Destroy()
end

return index2
end

tbl17.jO = function()
local jo = tbl17.cache.jO
if not jo then
jo = { c = fn35() }
tbl17.cache.jo = jo
end
return jo.c
end
end
