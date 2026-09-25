-- ShinobiHub by @christisloveisnx
pcall(function()
local p = game:GetService("Players").LocalPlayer
local pg = p:WaitForChild("PlayerGui")

for _, n in ipairs({"ShinobiHub","ShinobiMini","ShinobiTag"}) do
    local o = pg:FindFirstChild(n)
    if o then o:Destroy() end
end

local AC = Color3.fromRGB(220, 30, 40)
local OFF = Color3.fromRGB(45, 45, 50)
local BG = Color3.fromRGB(18, 18, 20)
local CD = Color3.fromRGB(35, 35, 38)
local TX = Color3.fromRGB(255, 255, 255)

-- ═══════════════════════════════════════════
-- 🔧 IDs DAS IMAGENS
-- ═══════════════════════════════════════════
local OPTIONS_BG = "rbxassetid://10760342849"      -- imagem atrás das opções
local MINI_BG    = "rbxassetid://9736161053"       -- imagem do botão de abrir o hub
local TIKTOK_ICON = "rbxassetid://84157643184125"  -- ícone da tag acima do player
local OPTIONS_OVERLAY = 0.25

local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local L = game:GetService("Lighting")
local PPS = game:GetService("ProximityPromptService")

local function draggable(frame, handle)
    handle = handle or frame
    local dragging, dragStart, startPos
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
        end
    end)
    handle.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch) then
            local d = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + d.X,
                startPos.Y.Scale, startPos.Y.Offset + d.Y
            )
        end
    end)
end

local g = Instance.new("ScreenGui")
g.Name = "ShinobiHub"
g.ResetOnSpawn = false
g.IgnoreGuiInset = true
g.DisplayOrder = 999999
g.Parent = pg

local f = Instance.new("Frame", g)
f.Size = UDim2.new(0, 420, 0, 290)
f.Position = UDim2.new(0.5, -210, 0.5, -145)
f.BackgroundColor3 = BG
f.BorderSizePixel = 0
Instance.new("UICorner", f).CornerRadius = UDim.new(0, 12)
local fs = Instance.new("UIStroke", f)
fs.Color = AC
fs.Thickness = 2

local optBg = Instance.new("ImageLabel", f)
optBg.Name = "OptionsBackground"
optBg.Size = UDim2.new(1, -110, 1, -30)
optBg.Position = UDim2.new(0, 105, 0, 15)
optBg.BackgroundTransparency = 1
optBg.Image = OPTIONS_BG
optBg.ScaleType = Enum.ScaleType.Crop
optBg.ZIndex = 1
Instance.new("UICorner", optBg).CornerRadius = UDim.new(0, 10)

local optOv = Instance.new("Frame", optBg)
optOv.Size = UDim2.new(1, 0, 1, 0)
optOv.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
optOv.BackgroundTransparency = OPTIONS_OVERLAY
optOv.BorderSizePixel = 0
optOv.ZIndex = 2
Instance.new("UICorner", optOv).CornerRadius = UDim.new(0, 10)

local sb = Instance.new("Frame", f)
sb.Size = UDim2.new(0, 100, 1, 0)
sb.BackgroundColor3 = CD
sb.BorderSizePixel = 0
sb.ZIndex = 3
Instance.new("UICorner", sb).CornerRadius = UDim.new(0, 12)

local kj = Instance.new("TextLabel", sb)
kj.Size = UDim2.new(1, 0, 0, 40)
kj.Position = UDim2.new(0, 0, 0, 6)
kj.BackgroundTransparency = 1
kj.Text = "SH"
kj.TextColor3 = AC
kj.TextSize = 30
kj.Font = Enum.Font.SourceSansBold
kj.ZIndex = 4

local promo = Instance.new("TextLabel", sb)
promo.Size = UDim2.new(1, -8, 0, 26)
promo.Position = UDim2.new(0, 4, 1, -56)
promo.BackgroundTransparency = 1
promo.Text = "promo channel in tiktok:\nhelloguysiamsweetchicken"
promo.TextColor3 = AC
promo.TextSize = 8
promo.Font = Enum.Font.SourceSansBold
promo.TextWrapped = true
promo.TextYAlignment = Enum.TextYAlignment.Top
promo.ZIndex = 4

local tk = Instance.new("TextLabel", sb)
tk.Size = UDim2.new(1, -8, 0, 12)
tk.Position = UDim2.new(0, 4, 1, -28)
tk.BackgroundTransparency = 1
tk.Text = "@christisloveisnx"
tk.TextColor3 = Color3.fromRGB(180, 180, 185)
tk.TextSize = 9
tk.Font = Enum.Font.SourceSansBold
tk.ZIndex = 4

local ct = Instance.new("Frame", f)
ct.Size = UDim2.new(1, -110, 1, -30)
ct.Position = UDim2.new(0, 105, 0, 15)
ct.BackgroundTransparency = 1
ct.ZIndex = 3

local nms = {"Speed", "Hit", "Extras"}
local tB, pages = {}, {}

for i, n in ipairs(nms) do
    local b = Instance.new("TextButton", sb)
    b.Size = UDim2.new(1, -16, 0, 32)
    b.Position = UDim2.new(0, 8, 0, 54 + (i - 1) * 38)
    b.BackgroundColor3 = (i == 1) and AC or OFF
    b.TextColor3 = TX
    b.Text = n
    b.TextSize = 12
    b.Font = Enum.Font.SourceSansBold
    b.AutoButtonColor = false
    b.ZIndex = 5
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    tB[i] = b

    local pp = Instance.new("Frame", ct)
    pp.Size = UDim2.new(1, 0, 1, 0)
    pp.BackgroundTransparency = 1
    pp.Visible = (i == 1)
    pp.ZIndex = 4
    pages[i] = pp
end

local function st(n)
    for i, b in ipairs(tB) do
        b.BackgroundColor3 = (i == n) and AC or OFF
        pages[i].Visible = (i == n)
    end
end
for i, b in ipairs(tB) do
    b.MouseButton1Click:Connect(function() st(i) end)
end

local cb = Instance.new("TextButton", f)
cb.Size = UDim2.new(0, 22, 0, 22)
cb.Position = UDim2.new(1, -28, 0, 8)
cb.BackgroundColor3 = OFF
cb.TextColor3 = AC
cb.TextSize = 13
cb.Text = "X"
cb.Font = Enum.Font.SourceSansBold
cb.AutoButtonColor = false
cb.ZIndex = 10
Instance.new("UICorner", cb).CornerRadius = UDim.new(0, 5)

-- ═══════════════════════════════════════════
-- 🔘 BOTÃO DE ABRIR O HUB — SÓ A IMAGEM
-- ═══════════════════════════════════════════
local mi = Instance.new("TextButton", g)
mi.Name = "MiniButton"
mi.Size = UDim2.new(0, 100, 0, 100)
mi.Position = UDim2.new(0, 20, 0.5, -50)
mi.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- fundo preto caso imagem falhe
mi.Text = ""                                    -- sem texto
mi.AutoButtonColor = false
mi.Visible = false
mi.ClipsDescendants = true
Instance.new("UICorner", mi).CornerRadius = UDim.new(0, 12)

-- Imagem cobrindo TODO o botão (ZIndex alto, sem texto em cima)
local miBg = Instance.new("ImageLabel", mi)
miBg.Name = "MiniBg"
miBg.Size = UDim2.new(1, 0, 1, 0)
miBg.Position = UDim2.new(0, 0, 0, 0)
miBg.BackgroundTransparency = 1
miBg.Image = MINI_BG
miBg.ScaleType = Enum.ScaleType.Crop
miBg.ZIndex = 5                                 -- ⬅️ ZIndex alto pra garantir que fica na frente
Instance.new("UICorner", miBg).CornerRadius = UDim.new(0, 12)

-- Borda vermelha por cima de tudo
local mis = Instance.new("UIStroke", mi)
mis.Color = AC
mis.Thickness = 3

cb.MouseButton1Click:Connect(function()
    f.Visible = false
    mi.Visible = true
end)
mi.MouseButton1Click:Connect(function()
    mi.Visible = false
    f.Visible = true
end)

draggable(f, sb)
draggable(mi)

local function mk(pp, t, y)
    local b = Instance.new("TextButton", pp)
    b.Size = UDim2.new(1, 0, 0, 26)
    b.Position = UDim2.new(0, 0, 0, y)
    b.BackgroundColor3 = OFF
    b.BackgroundTransparency = 0.15
    b.TextColor3 = TX
    b.Text = t
    b.TextSize = 11
    b.Font = Enum.Font.SourceSansBold
    b.AutoButtonColor = false
    b.ZIndex = 5
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    local s = Instance.new("UIStroke", b)
    s.Name = "Stroke"
    s.Color = Color3.fromRGB(70, 70, 75)
    s.Thickness = 1
    s.Transparency = 0.5
    return b
end

local function lb(pp, t, y)
    local l = Instance.new("TextLabel", pp)
    l.Size = UDim2.new(1, 0, 0, 14)
    l.Position = UDim2.new(0, 0, 0, y)
    l.BackgroundTransparency = 1
    l.Text = t
    l.TextColor3 = TX
    l.TextSize = 9
    l.Font = Enum.Font.SourceSansBold
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.ZIndex = 5
    return l
end

local function on(b)
    if not b then return end
    b.BackgroundColor3 = AC
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    local s = b:FindFirstChild("Stroke")
    if s then s.Color = Color3.fromRGB(255, 60, 70) s.Transparency = 0 end
end
local function off(b)
    if not b then return end
    b.BackgroundColor3 = OFF
    b.TextColor3 = TX
    local s = b:FindFirstChild("Stroke")
    if s then s.Color = Color3.fromRGB(70, 70, 75) s.Transparency = 0.5 end
end

local sp = mk(pages[1], "Speed Bypass: OFF", 0)
local vL = lb(pages[1], "Velocidade: 120", 30)

local sB = Instance.new("Frame", pages[1])
sB.Size = UDim2.new(1, 0, 0, 8)
sB.Position = UDim2.new(0, 0, 0, 46)
sB.BackgroundColor3 = CD
sB.BorderSizePixel = 0
sB.ZIndex = 5
Instance.new("UICorner", sB).CornerRadius = UDim.new(1, 0)

local sF = Instance.new("Frame", sB)
sF.Size = UDim2.new(0.24, 0, 1, 0)
sF.BackgroundColor3 = AC
sF.BorderSizePixel = 0
sF.ZIndex = 6
Instance.new("UICorner", sF).CornerRadius = UDim.new(1, 0)

local mx = mk(pages[1], "MAX (500)", 62)
local ds = mk(pages[1], "Desync: OFF", 92)
lb(pages[1], "Pronto", 124)

local tp = mk(pages[2], "Anti Hit: OFF", 0)
local fv = mk(pages[2], "FOV 120: OFF", 30)
local rr = mk(pages[2], "Anti Ragdoll: OFF", 60)

local gr = mk(pages[3], "Instant Grab: OFF", 0)
local fb = mk(pages[3], "FPS Boost: OFF", 30)
local rx = mk(pages[3], "RTX: OFF", 60)
local hd = mk(pages[3], "HD Graphics: OFF", 90)
local sh = mk(pages[3], "Server Hop", 120)

local MN, MX, sv, so = 16, 500, 120, false
local hC2, aC, cC
local TP = Vector3.new(543, 71, -369)
local SR, SM = 30, 200

local function an(c)
    if not c then return end
    local h = c:WaitForChild("Humanoid", 5)
    if not h then return end
    local a = h:FindFirstChildOfClass("Animator")
    if not a then return end
    if aC then aC:Disconnect() end
    aC = a.AnimationPlayed:Connect(function(t)
        if not so then return end
        local n = string.lower(t.Name)
        if string.find(n, "run") or string.find(n, "walk") then
            pcall(function() t:Stop(0.1) end)
        end
    end)
end

local function stSp()
    local c = p.Character
    if c then
        local h = c:FindFirstChildOfClass("Humanoid")
        if h then h.WalkSpeed = sv end
    end
    an(c)
    if hC2 then hC2:Disconnect() end
    hC2 = RS.Heartbeat:Connect(function()
        if not so then return end
        local c = p.Character
        if not c then return end
        local h = c:FindFirstChildOfClass("Humanoid")
        local r = c:FindFirstChild("HumanoidRootPart")
        if not h then return end
        if h.Health < h.MaxHealth then
            pcall(function() h.Health = h.MaxHealth end)
        end
        local tg = sv
        if r then
            local d = (r.Position - TP).Magnitude
            if d < SR then tg = SM + (sv - SM) * (d / SR) end
        end
        if math.abs(h.WalkSpeed - tg) > 2 then h.WalkSpeed = tg end
    end)
    if cC then cC:Disconnect() end
    cC = p.CharacterAdded:Connect(function(c)
        task.wait(0.5)
        if so then
            local h = c:FindFirstChildOfClass("Humanoid")
            if h then h.WalkSpeed = sv end
            an(c)
        end
    end)
end

sp.MouseButton1Click:Connect(function()
    so = not so
    if so then
        on(sp) sp.Text = "Speed Bypass: ON"
        stSp()
    else
        off(sp) sp.Text = "Speed Bypass: OFF"
        if hC2 then hC2:Disconnect() hC2 = nil end
        local c = p.Character
        if c then
            local h = c:FindFirstChildOfClass("Humanoid")
            if h then h.WalkSpeed = 16 end
        end
    end
end)

ds.MouseButton1Click:Connect(function()
    on(ds) ds.Text = "Desync: ON"
    task.delay(0.3, function() off(ds) ds.Text = "Desync: OFF" end)
end)

mx.MouseButton1Click:Connect(function()
    sv = 500
    vL.Text = "Velocidade: 500"
    sF.Size = UDim2.new(1, 0, 1, 0)
    if so then
        local c = p.Character
        if c then
            local h = c:FindFirstChildOfClass("Humanoid")
            if h then h.WalkSpeed = 500 end
        end
    end
end)

local tOn, pc2 = false, false
local function tpTo(po)
    local c = p.Character
    if not c then return end
    local r = c:FindFirstChild("HumanoidRootPart")
    if not r then return end
    if r.Anchored then r.Anchored = false end
    local rt = r.CFrame - r.CFrame.Position
    pcall(function() c:PivotTo(CFrame.new(po) * rt) end)
end
local function doR()
    if pc2 then return end
    pc2 = true
    local c = p.Character
    local r = c and c:FindFirstChild("HumanoidRootPart")
    if not r then pc2 = false return end
    local op = r.Position
    tpTo(TP)
    task.wait(0.5)
    tpTo(op)
    pc2 = false
end

tp.MouseButton1Click:Connect(function()
    tOn = not tOn
    if tOn then on(tp) tp.Text = "Anti Hit: ON" else off(tp) tp.Text = "Anti Hit: OFF" end
end)

PPS.PromptTriggered:Connect(function(_, w)
    if not tOn or w ~= p or pc2 then return end
    task.spawn(doR)
end)

local fo, fO = false, nil
fv.MouseButton1Click:Connect(function()
    local c = workspace.CurrentCamera
    if not c then return end
    if not fo then
        fO = c.FieldOfView
        fo = true
        c.FieldOfView = 120
        on(fv) fv.Text = "FOV 120: ON"
    else
        fo = false
        c.FieldOfView = fO or 70
        off(fv) fv.Text = "FOV 120: OFF"
    end
end)

local rrOn = false
local rrConn = nil
local function lockStates(h)
    if not h then return end
    pcall(function()
        h:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
        h:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
        h:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
        h:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding, false)
        if h.PlatformStand then h.PlatformStand = false end
    end)
end

rr.MouseButton1Click:Connect(function()
    rrOn = not rrOn
    if rrOn then
        on(rr) rr.Text = "Anti Ragdoll: ON"
        local c = p.Character
        if c then
            local h = c:FindFirstChildOfClass("Humanoid")
            lockStates(h)
        end
        if rrConn then rrConn:Disconnect() end
        rrConn = RS.Heartbeat:Connect(function()
            if not rrOn then return end
            local c = p.Character
            if not c then return end
            local h = c:FindFirstChildOfClass("Humanoid")
            local r = c:FindFirstChild("HumanoidRootPart")
            if not h or not r then return end
            lockStates(h)
            local vel = r.AssemblyLinearVelocity
            local horiz = Vector3.new(vel.X, 0, vel.Z)
            if horiz.Magnitude > 100 and not r.Anchored then
                r.Anchored = true
                r.AssemblyLinearVelocity = Vector3.zero
                r.AssemblyAngularVelocity = Vector3.zero
                task.delay(0.2, function()
                    if r and r.Parent then
                        r.Anchored = false
                        r.AssemblyLinearVelocity = Vector3.zero
                    end
                end)
            end
            if r.AssemblyAngularVelocity.Magnitude > 1 then
                r.AssemblyAngularVelocity = Vector3.zero
            end
        end)
    else
        off(rr) rr.Text = "Anti Ragdoll: OFF"
        if rrConn then rrConn:Disconnect() rrConn = nil end
    end
end)

local rxOn = false
rx.MouseButton1Click:Connect(function()
    rxOn = not rxOn
    if rxOn then
        on(rx) rx.Text = "RTX: ON"
        pcall(function()
            L.Ambient = Color3.fromRGB(70, 70, 78)
            L.OutdoorAmbient = Color3.fromRGB(130, 135, 148)
            L.Brightness = 3
            L.ClockTime = 17
        end)
    else
        off(rx) rx.Text = "RTX: OFF"
    end
end)

local hdOn = false
hd.MouseButton1Click:Connect(function()
    hdOn = not hdOn
    if hdOn then on(hd) hd.Text = "HD Graphics: ON" else off(hd) hd.Text = "HD Graphics: OFF" end
end)

local fbo = false
fb.MouseButton1Click:Connect(function()
    fbo = not fbo
    if fbo then on(fb) fb.Text = "FPS Boost: ON" else off(fb) fb.Text = "FPS Boost: OFF" end
end)

local go = false
gr.MouseButton1Click:Connect(function()
    go = not go
    if go then
        on(gr) gr.Text = "Instant Grab: ON"
        for _, v in ipairs(workspace:GetDescendants()) do
            if v:IsA("ProximityPrompt") then
                pcall(function() v.HoldDuration = 0 end)
            end
        end
    else
        off(gr) gr.Text = "Instant Grab: OFF"
    end
end)

sh.MouseButton1Click:Connect(function()
    local TS = game:GetService("TeleportService")
    local HS = game:GetService("HttpService")
    local pid = game.PlaceId
    local url = "https://games.roblox.com/v1/games/" .. pid .. "/servers/Public?sortOrder=Asc&limit=100"
    local ok, res = pcall(function()
        return HS:JSONDecode(game:HttpGet(url))
    end)
    if ok and res and res.data then
        for _, srv in ipairs(res.data) do
            if srv.playing < srv.maxPlayers and srv.id ~= game.JobId then
                pcall(function() TS:TeleportToPlaceInstance(pid, srv.id, p) end)
                return
            end
        end
    end
end)

-- TAG ACIMA DO PLAYER
local function criarTag(char)
    if not char then return end
    pcall(function()
        local head = char:FindFirstChild("Head") or char:WaitForChild("Head", 5)
        if not head then return end
        local antiga = head:FindFirstChild("ShinobiTag")
        if antiga then antiga:Destroy() end

        local bb = Instance.new("BillboardGui")
        bb.Name = "ShinobiTag"
        bb.Size = UDim2.new(0, 300, 0, 45)
        bb.StudsOffset = Vector3.new(0, 3, 0)
        bb.AlwaysOnTop = true
        bb.LightInfluence = 0
        bb.MaxDistance = 300
        bb.Parent = head

        local iSh = Instance.new("ImageLabel", bb)
        iSh.Size = UDim2.new(0, 40, 0, 40)
        iSh.Position = UDim2.new(0, 2, 0.5, -18)
        iSh.BackgroundTransparency = 1
        iSh.Image = TIKTOK_ICON
        iSh.ImageColor3 = Color3.fromRGB(0, 0, 0)
        iSh.ScaleType = Enum.ScaleType.Fit

        local iMn = Instance.new("ImageLabel", bb)
        iMn.Size = UDim2.new(0, 40, 0, 40)
        iMn.Position = UDim2.new(0, 0, 0.5, -20)
        iMn.BackgroundTransparency = 1
        iMn.Image = TIKTOK_ICON
        iMn.ImageColor3 = AC
        iMn.ScaleType = Enum.ScaleType.Fit

        local tSh = Instance.new("TextLabel", bb)
        tSh.BackgroundTransparency = 1
        tSh.Size = UDim2.new(1, -45, 1, 0)
        tSh.Position = UDim2.new(0, 47, 0, 2)
        tSh.Font = Enum.Font.SourceSansBold
        tSh.Text = "By:@christisloveisnx"
        tSh.TextColor3 = Color3.fromRGB(0, 0, 0)
        tSh.TextScaled = true
        tSh.TextXAlignment = Enum.TextXAlignment.Left

        local tMn = Instance.new("TextLabel", bb)
        tMn.BackgroundTransparency = 1
        tMn.Size = UDim2.new(1, -45, 1, 0)
        tMn.Position = UDim2.new(0, 45, 0, 0)
        tMn.Font = Enum.Font.SourceSansBold
        tMn.Text = "By:@christisloveisnx"
        tMn.TextColor3 = AC
        tMn.TextScaled = true
        tMn.TextXAlignment = Enum.TextXAlignment.Left
    end)
end

if p.Character then criarTag(p.Character) end
p.CharacterAdded:Connect(function(c)
    task.wait(0.5)
    criarTag(c)
end)

st(1)
print("ShinobiHub by @christisloveisnx OK")
end)
