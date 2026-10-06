--[[ tuntung Hub — BLOCO 1/3 | CORE ]]
print("[1] BEGIN")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local LP = Players.LocalPlayer
local PG = LP:WaitForChild("PlayerGui", 10)

for _, p in ipairs({CoreGui, PG}) do
    local o = p:FindFirstChild("TuntungHubGui")
    if o then o:Destroy() end
end

local CONFIG = {
    ScanInterval=60, FlySpeed=500, ArriveDistance=5,
    PreviewSize=54, MaxRows=40,
    FixedDest=Vector3.new(33.1,-81.3,-534.5),
    UpStuds=50, WaitBeforeCollect=1, HoldTime=1,
}
local THEME = {
    Bg=Color3.fromRGB(16,16,20), Bg2=Color3.fromRGB(24,24,30), Bg3=Color3.fromRGB(34,34,42),
    Accent=Color3.fromRGB(120,200,255), Gold=Color3.fromRGB(255,200,80),
    Text=Color3.fromRGB(235,235,235), TextDim=Color3.fromRGB(150,150,160),
    Good=Color3.fromRGB(90,220,130), Bad=Color3.fromRGB(255,90,90),
    Warn=Color3.fromRGB(255,170,80),
}

local function getHRP() local c=LP.Character; return c and c:FindFirstChild("HumanoidRootPart") end
local function isAlive() local h=LP.Character and LP.Character:FindFirstChildOfClass("Humanoid"); return h and h.Health>0 end

local function cleanName(raw)
    if type(raw) ~= "string" then raw = tostring(raw) end
    local s = raw
    s = s:gsub("^[Pp]et[%s_%-]+",""):gsub("^[Ee]gg[%s_%-]+","")
    s = s:gsub("[_%-]+"," ")
    s = s:gsub("(%a)([%w']*)", function(a,b) return a:upper()..b:lower() end)
    s = s:gsub("%s+"," "):gsub("^%s+",""):gsub("%s+$","")
    if s == "" then s = raw end
    return s
end

local function getPos(inst)
    if not inst or not inst.Parent then return nil end
    if inst:IsA("BasePart") then return inst.Position end
    if inst:IsA("Model") then
        if inst.PrimaryPart then return inst.PrimaryPart.Position end
        local p = inst:FindFirstChildWhichIsA("BasePart", true)
        return p and p.Position or nil
    end
    return nil
end

local function scanPets()
    local list = {}
    pcall(function()
        for _, inst in ipairs(Workspace:GetDescendants()) do
            if (inst:IsA("Model") or inst:IsA("BasePart")) and not inst:IsA("Accessory") then
                local nm = inst.Name:lower()
                local isPet = nm:find("pet",1,true) or nm:find("egg",1,true)
                local hasPrompt = false
                if not isPet then
                    hasPrompt = inst:FindFirstChildOfClass("ProximityPrompt") ~= nil
                        or inst:FindFirstChildWhichIsA("ProximityPrompt", true) ~= nil
                end
                if isPet or hasPrompt then
                    local skip = false
                    local cur = inst
                    local d = 0
                    while cur and cur ~= Workspace and d < 5 do
                        local n = cur.Name:lower()
                        if n:find("merchant",1,true) or n:find("vendor",1,true)
                        or n:find("shop",1,true) or n:find("npc",1,true) then
                            skip = true; break
                        end
                        cur = cur.Parent; d = d + 1
                    end
                    if not skip then
                        local pos = getPos(inst)
                        if pos then
                            table.insert(list, {
                                Uid = inst:GetFullName(),
                                Instance = inst,
                                Model = inst:IsA("Model") and inst or nil,
                                Name = cleanName(inst.Name),
                                Rarity = "Common", RarityNum = 1000,
                                Color = THEME.Gold,
                                Position = pos,
                            })
                        end
                    end
                end
            end
        end
    end)
    table.sort(list, function(a,b)
        return tostring(a.Name) < tostring(b.Name)
    end)
    return list
end

_G.Tuntung = {
    Players=Players, RunService=RunService, UserInputService=UserInputService,
    Workspace=Workspace, CoreGui=CoreGui, LP=LP, PlayerGui=PG,
    CONFIG=CONFIG, THEME=THEME,
    getHRP=getHRP, isAlive=isAlive, scanEggs=scanPets, getPos=getPos,
    _conns={}, _hl={}, UI={}, currentEggs={}, currentTrip=false,
}
_G.Tuntung.track = function(c) table.insert(_G.Tuntung._conns, c); return c end

print("[1] OK → execute BLOCO 2")--[[ tuntung Hub — BLOCO 2/3 | GUI ]]
print("[2] BEGIN")
local T = _G.Tuntung
if not T then warn("[2] rode BLOCO 1"); return end
local CONFIG, THEME = T.CONFIG, T.THEME
local CoreGui, PG = T.CoreGui, T.PlayerGui

for _, p in ipairs({CoreGui, PG}) do
    local o = p:FindFirstChild("TuntungHubGui")
    if o then o:Destroy() end
end

local gui = Instance.new("ScreenGui")
gui.Name = "TuntungHubGui"; gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true; gui.DisplayOrder = 99999
local ok = pcall(function() gui.Parent = CoreGui end)
if not ok or not gui.Parent then gui.Parent = PG end
print("[2] parent =", gui.Parent and gui.Parent:GetFullName() or "NIL")

local function new(class, props, parent)
    local o = Instance.new(class)
    for k, v in pairs(props) do o[k] = v end
    if parent then o.Parent = parent end
    return o
end
local function round(o, r)
    local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, r); c.Parent = o
end
local function stroke(o, color, t, tr)
    local s = Instance.new("UIStroke")
    s.Color = color; s.Thickness = t or 1; s.Transparency = tr or 0; s.Parent = o
end

local main = new("Frame", {Name="Main", Size=UDim2.new(0,340,0,460),
    Position=UDim2.new(0,20,0,70), BackgroundColor3=THEME.Bg,
    BorderSizePixel=0, Active=true, ClipsDescendants=true}, gui)
round(main, 14); stroke(main, THEME.Accent, 1, 0.5)

local tb = new("Frame", {Size=UDim2.new(1,0,0,48), BackgroundColor3=THEME.Bg2, BorderSizePixel=0}, main)
round(tb, 14)
new("Frame", {Size=UDim2.new(1,0,0,16), Position=UDim2.new(0,0,1,-16),
    BackgroundColor3=THEME.Bg2, BorderSizePixel=0}, tb)

local logo = new("Frame", {Size=UDim2.new(0,30,0,30), Position=UDim2.new(0,12,0,9),
    BackgroundColor3=Color3.fromRGB(255,255,255), BorderSizePixel=0}, tb)
round(logo, 8)
new("ImageLabel", {BackgroundTransparency=1, Size=UDim2.fromScale(0.9,0.9),
    Position=UDim2.fromScale(0.05,0.05), Image="rbxassetid://76287583641908",
    ScaleType=Enum.ScaleType.Fit}, logo)

local titleLbl = new("TextLabel", {Text="tuntung Hub", Font=Enum.Font.GothamBold, TextSize=15,
    TextColor3=THEME.Accent, BackgroundTransparency=1, Size=UDim2.new(1,-100,0,20),
    Position=UDim2.new(0,52,0,6), TextXAlignment=Enum.TextXAlignment.Left}, tb)
new("TextLabel", {Text="Pet ESP", Font=Enum.Font.GothamMedium, TextSize=9,
    TextColor3=THEME.TextDim, BackgroundTransparency=1, Size=UDim2.new(1,-100,0,12),
    Position=UDim2.new(0,52,0,26), TextXAlignment=Enum.TextXAlignment.Left}, tb)

local minBtn = new("TextButton", {Text="—", Font=Enum.Font.GothamBold, TextSize=18,
    TextColor3=THEME.Text, BackgroundColor3=THEME.Bg3,
    Size=UDim2.new(0,30,0,30), Position=UDim2.new(1,-38,0,9),
    BorderSizePixel=0, ZIndex=5}, tb)
round(minBtn, 8)

do
    local dragging, ds, sp
    local function bd(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dragging = true; ds = i.Position; sp = main.Position
        end
    end
    titleLbl.InputBegan:Connect(bd)
    T.track(T.UserInputService.InputChanged:Connect(function(i)
        if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
            local d = i.Position - ds
            main.Position = UDim2.new(sp.X.Scale, sp.X.Offset+d.X, sp.Y.Scale, sp.Y.Offset+d.Y)
        end
    end))
    T.track(T.UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end))
end

local content = new("Frame", {Size=UDim2.new(1,0,1,-48), Position=UDim2.new(0,0,0,48), BackgroundTransparency=1}, main)

local autoBtn = new("TextButton", {Name="AutoBtn", Text="▶ AUTO-FARM",
    Font=Enum.Font.GothamBold, TextSize=12, TextColor3=THEME.Good,
    BackgroundColor3=THEME.Bg3, Size=UDim2.new(1,-20,0,30),
    Position=UDim2.new(0,10,0,8), BorderSizePixel=0, ZIndex=10,
    AutoButtonColor=false}, content)
round(autoBtn, 6)

local sb = new("Frame", {Size=UDim2.new(1,-20,0,28), Position=UDim2.new(0,10,0,46),
    BackgroundColor3=THEME.Bg2, BorderSizePixel=0}, content)
round(sb, 8)
local dot = new("Frame", {Size=UDim2.new(0,8,0,8), Position=UDim2.new(0,10,0.5,-4),
    BackgroundColor3=THEME.Accent, BorderSizePixel=0}, sb)
round(dot, 4)
local status = new("TextLabel", {Text="Iniciando...", Font=Enum.Font.GothamMedium, TextSize=12,
    TextColor3=THEME.Text, BackgroundTransparency=1, Size=UDim2.new(1,-30,1,0),
    Position=UDim2.new(0,26,0,0), TextXAlignment=Enum.TextXAlignment.Left}, sb)

local counter = new("TextLabel", {Text="0 pets", Font=Enum.Font.GothamBold, TextSize=11,
    TextColor3=THEME.Gold, BackgroundTransparency=1, Size=UDim2.new(1,-60,0,16),
    Position=UDim2.new(0,12,0,82), TextXAlignment=Enum.TextXAlignment.Left}, content)
local refreshBtn = new("TextButton", {Text="⟳", Font=Enum.Font.GothamBold, TextSize=14,
    TextColor3=THEME.Accent, BackgroundColor3=THEME.Bg2,
    Size=UDim2.new(0,30,0,22), Position=UDim2.new(1,-42,0,80), BorderSizePixel=0}, content)
round(refreshBtn, 6)

local listF = new("ScrollingFrame", {Name="List", Size=UDim2.new(1,-20,1,-116),
    Position=UDim2.new(0,10,0,106), BackgroundColor3=THEME.Bg2,
    BorderSizePixel=0, ScrollBarThickness=4, ScrollBarImageColor3=THEME.Accent,
    CanvasSize=UDim2.new(0,0,0,0), AutomaticCanvasSize=Enum.AutomaticSize.Y}, content)
round(listF, 10)
local pad = Instance.new("UIPadding", listF)
pad.PaddingTop=UDim.new(0,8); pad.PaddingBottom=UDim.new(0,8)
pad.PaddingLeft=UDim.new(0,8); pad.PaddingRight=UDim.new(0,8)
local lay = Instance.new("UIListLayout", listF)
lay.Padding = UDim.new(0,6); lay.SortOrder = Enum.SortOrder.LayoutOrder

local minimized, fullSize = false, main.Size
minBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        content.Visible = false; main.Size = UDim2.new(0,340,0,48); minBtn.Text = "+"
    else
        content.Visible = true; main.Size = fullSize; minBtn.Text = "—"
    end
end)

T.UI.Gui, T.UI.Main, T.UI.Status, T.UI.Dot = gui, main, status, dot
T.UI.Counter, T.UI.List, T.UI.Refresh, T.UI.MinBtn = counter, listF, refreshBtn, minBtn
T.UI.Content, T.UI.AutoBtn = content, autoBtn
T.setStatus = function(txt, color)
    if T.UI.Status then T.UI.Status.Text = txt end
    if T.UI.Dot and color then T.UI.Dot.BackgroundColor3 = color end
end
T.uiHelpers = { new=new, round=round, stroke=stroke }

print("[2] OK → execute BLOCO 3")--[[ tuntung Hub — BLOCO 3/3 | RUNTIME ]]
print("[3] BEGIN")
local T = _G.Tuntung
if not T or not T.UI.List then warn("[3] rode BLOCO 2"); return end
local CONFIG, THEME, UI = T.CONFIG, T.THEME, T.UI
local track = T.track
local LP = T.LP
local RunService, Workspace = T.RunService, T.Workspace
local new, round, stroke = T.uiHelpers.new, T.uiHelpers.round, T.uiHelpers.stroke
T.currentTrip = false

--==================================================
-- PREVIEW 3D
--==================================================
T.buildPreview = function(entry)
    local size = UDim2.new(0, CONFIG.PreviewSize, 0, CONFIG.PreviewSize)

    if entry.Icon then
        local box = new("Frame", {Size=size, BackgroundColor3=THEME.Bg3, BorderSizePixel=0})
        round(box, 10); stroke(box, entry.Color or THEME.Accent, 1, 0.4)
        new("ImageLabel", {BackgroundTransparency=1,
            Size=UDim2.fromScale(0.9,0.9), Position=UDim2.fromScale(0.05,0.05),
            Image=entry.Icon, ScaleType=Enum.ScaleType.Fit}, box)
        return box
    end

    local inst = entry.Model or entry.Instance
    if not inst or not inst.Parent then
        local box = new("Frame", {Size=size, BackgroundColor3=THEME.Bg3, BorderSizePixel=0})
        round(box, 10); stroke(box, entry.Color or THEME.Accent, 1, 0.4)
        new("TextLabel", {Text="🐾", Font=Enum.Font.GothamBold, TextSize=24,
            TextColor3=THEME.Gold, BackgroundTransparency=1, Size=UDim2.fromScale(1,1)}, box)
        return box
    end

    local vp = new("ViewportFrame", {
        Size=size, BackgroundColor3=THEME.Bg3, BorderSizePixel=0,
        Ambient=Color3.fromRGB(215,215,215),
        LightColor=Color3.fromRGB(255,255,255),
        LightDirection=Vector3.new(0.4,-1,-0.6),
    })
    round(vp, 10); stroke(vp, entry.Color or THEME.Accent, 1, 0.4)

    local world = new("WorldModel", {}, vp)
    local cam = new("Camera", {}, vp)
    vp.CurrentCamera = cam

    pcall(function()
        local cloned, bboxSize
        if inst:IsA("BasePart") then
            cloned = inst:Clone()
            cloned.Anchored = true; cloned.CanCollide = false
            cloned.CFrame = CFrame.new()
            cloned.Parent = world
            bboxSize = cloned.Size
        elseif inst:IsA("Model") then
            cloned = inst:Clone()
            for _, p in ipairs(cloned:GetDescendants()) do
                if p:IsA("BasePart") then
                    p.Anchored = true; p.CanCollide = false
                end
            end
            cloned.Parent = world
            pcall(function() cloned:PivotTo(CFrame.new()) end)
            local ok, s = pcall(function()
                local _, sz = cloned:GetBoundingBox(); return sz
            end)
            bboxSize = (ok and s) or Vector3.new(2,2,2)
        end
        if not cloned or not bboxSize then return end
        local cy = bboxSize.Y * 0.5
        local maxDim = math.max(bboxSize.X, bboxSize.Y, bboxSize.Z, 1)
        local dist = maxDim * 2.3
        local camPos = Vector3.new(-dist*0.35, cy + bboxSize.Y*0.08, -dist*0.95)
        cam.CFrame = CFrame.lookAt(camPos, Vector3.new(0, cy, 0))
        cam.FieldOfView = 38
    end)

    return vp
end
local buildPreview = T.buildPreview

--==================================================
-- NOCLIP
--==================================================
local function noclipOn()
    local c = LP.Character; if not c then return end
    for _, p in ipairs(c:GetDescendants()) do
        if p:IsA("BasePart") then pcall(function() p.CanCollide = false end) end
    end
end
local function noclipOff()
    local c = LP.Character; if not c then return end
    for _, p in ipairs(c:GetDescendants()) do
        if p:IsA("BasePart") then pcall(function() p.CanCollide = true end) end
    end
end

--==================================================
-- FLY
--==================================================
local function flyTo(pos, timeout)
    timeout = timeout or 20
    local hrp = T.getHRP()
    local hum = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum or hum.Health <= 0 then return false end
    noclipOn()
    pcall(function() hum.PlatformStand = true; hum.WalkSpeed = 0; hum.JumpPower = 0 end)
    local t = 0; local reached = false
    local conn
    conn = RunService.Heartbeat:Connect(function(dt)
        t = t + dt
        if t > timeout then conn:Disconnect(); return end
        local c = LP.Character
        if not c or not hrp.Parent then conn:Disconnect(); return end
        local h = c:FindFirstChildOfClass("Humanoid")
        if not h or h.Health <= 0 then conn:Disconnect(); return end
        noclipOn()
        local cur = hrp.Position
        local diff = pos - cur
        local dist = diff.Magnitude
        if dist <= CONFIG.ArriveDistance then reached = true; conn:Disconnect(); return end
        local step = diff.Unit * math.min(CONFIG.FlySpeed * dt, dist)
        hrp.CFrame = CFrame.new(cur + step)
        pcall(function() h:ChangeState(Enum.HumanoidStateType.Freefall) end)
    end)
    while conn.Connected do RunService.Heartbeat:Wait() end
    noclipOff()
    pcall(function()
        hum.PlatformStand = false
        hum.WalkSpeed = 16; hum.JumpPower = 50
        hum:ChangeState(Enum.HumanoidStateType.GettingUp)
        task.wait(0.05)
        hum:ChangeState(Enum.HumanoidStateType.Running)
    end)
    return reached
end
T.flyTo = flyTo

--==================================================
-- HIGHLIGHT
--==================================================
local function applyHighlight(inst)
    if not inst or T._hl[inst] then return end
    local ok, h = pcall(function()
        local hh = Instance.new("Highlight")
        hh.FillColor=THEME.Gold; hh.FillTransparency=0.55
        hh.OutlineColor=THEME.Accent; hh.OutlineTransparency=0
        hh.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
        hh.Adornee=inst; hh.Parent=inst
        return hh
    end)
    if ok and h then T._hl[inst] = h end
end
local function clearHighlights()
    for _, h in pairs(T._hl) do pcall(function() h:Destroy() end) end
    for k in pairs(T._hl) do T._hl[k] = nil end
end

--==================================================
-- INTERAÇÃO
--==================================================
local function tryInteract(entry)
    if not entry or not entry.Instance then return false end
    local prompt = entry.Instance:FindFirstChildOfClass("ProximityPrompt")
        or entry.Instance:FindFirstChildWhichIsA("ProximityPrompt", true)
    if prompt and prompt.Enabled then
        local d = math.max(prompt.HoldDuration or 0, CONFIG.HoldTime)
        pcall(function() prompt:InputHoldBegin() end)
        task.wait(d)
        pcall(function() prompt:InputHoldEnd() end)
        pcall(function() if fireproximityprompt then fireproximityprompt(prompt) end end)
        return true
    end
    local cd = entry.Instance:FindFirstChildOfClass("ClickDetector")
        or entry.Instance:FindFirstChildWhichIsA("ClickDetector", true)
    if cd and fireclickdetector then pcall(fireclickdetector, cd); return true end
    return false
end

--==================================================
-- CICLO
--==================================================
local function doCycle(entry)
    local hrp = T.getHRP(); if not hrp then return false end
    T.setStatus("Indo → "..entry.Name, THEME.Accent)
    if not flyTo(entry.Position, 20) then T.setStatus("Falha", THEME.Bad); return false end
    T.setStatus("Aguardando...", THEME.Warn)
    task.wait(CONFIG.WaitBeforeCollect)
    if not T.isAlive() then return false end
    T.setStatus("Coletando...", THEME.Good)
    tryInteract(entry)
    task.wait(0.8)
    T.setStatus("Voltando...", THEME.Accent)
    local h = T.getHRP()
    if h then
        local ey = h.Position.Y + CONFIG.UpStuds
        flyTo(Vector3.new(h.Position.X, ey, h.Position.Z), 10)
        flyTo(Vector3.new(CONFIG.FixedDest.X, ey, CONFIG.FixedDest.Z), 25)
        flyTo(CONFIG.FixedDest, 10)
    end
    T.setStatus("Concluído!", THEME.Good)
    return true
end

T.startFlyTo = function(entry)
    if T.currentTrip then return end
    T.currentTrip = true
    task.spawn(function()
        pcall(doCycle, entry)
        T.currentTrip = false
    end)
end

--==================================================
-- RENDER
--==================================================
local function clearList()
    for _, c in ipairs(UI.List:GetChildren()) do
        if c:IsA("Frame") or c:IsA("TextButton") then c:Destroy() end
    end
end

local function makeCard(entry, idx)
    local card = new("Frame", {
        Size=UDim2.new(1,-4,0,CONFIG.PreviewSize+16),
        BackgroundColor3=(idx==1) and Color3.fromRGB(255,245,220) or THEME.Bg3,
        BorderSizePixel=0, LayoutOrder=idx,
    }, UI.List)
    round(card, 10)
    if idx == 1 then stroke(card, THEME.Gold, 1, 0.35) end

    local preview = buildPreview(entry)
    preview.Position = UDim2.new(0,8,0.5,-CONFIG.PreviewSize/2)
    previe
