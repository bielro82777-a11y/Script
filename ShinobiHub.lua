--==============================================================
-- TrueChad Hub
-- By: @christisloveisnx
--==============================================================
print("[HUB] Iniciando...")

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local CoreGui = game:GetService("CoreGui")
local RS = game:GetService("ReplicatedStorage")
local WS = game:GetService("Workspace")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local G = getgenv and getgenv() or _G
G.TrueChadHub = G.TrueChadHub or {}

local CFG = {
    MUSIC_ID = "rbxassetid://110919391228823",
    MUSIC_VOL = 0.5,
    ALERT_SOUND = "rbxassetid://127859692805098",
    ALERT_VOL = 0.6,
    ALERT_DURATION = 10,
    ALERT_COOLDOWN = 15,
    Base = Vector3.new(545.8, 70.6, -367.4),
    SpeedUp = 40,
    GrabRadius = 40,
    MaxPerBiome = 10,
    GodHealth = 1e9,
    RiseHeight = 15,
}

local TH = {
    Blue=Color3.fromRGB(60,150,255), BlueLight=Color3.fromRGB(120,190,255),
    BgDark=Color3.fromRGB(10,18,35), Card=Color3.fromRGB(20,35,60),
    Cyan=Color3.fromRGB(80,220,255), White=Color3.fromRGB(235,245,255),
    Gray=Color3.fromRGB(130,160,200), Green=Color3.fromRGB(60,180,90),
    GreenL=Color3.fromRGB(100,240,130), Red=Color3.fromRGB(200,50,50),
    CardActive=Color3.fromRGB(40,90,160), CreditBg=Color3.fromRGB(15,40,90),
}

local RC = {
    Divine=Color3.fromRGB(255,220,80), Eternal=Color3.fromRGB(255,140,60),
    Secret=Color3.fromRGB(255,255,255), Cosmic=Color3.fromRGB(90,150,255),
    Mythic=Color3.fromRGB(230,90,180), Legendary=Color3.fromRGB(255,200,60),
    Epic=Color3.fromRGB(180,90,220), Rare=Color3.fromRGB(90,200,220),
    Uncommon=Color3.fromRGB(100,220,130), Common=Color3.fromRGB(180,180,180),
}

local BIOMES = {
    {n="Forest",x=593},{n="Lake",x=720},{n="Desert",x=897},{n="Jungle",x=1143},
    {n="Snow",x=1428},{n="Volcano",x=1778},{n="Ocean",x=2218},{n="Prehistoric",x=2757},
    {n="Cosmic",x=3376},{n="Cherry Blossom",x=3999},{n="Titan Temple",x=4759},{n="Angels & Demons",x=5620},
}

local function new(c,p,par) local o=Instance.new(c) for k,v in pairs(p) do o[k]=v end o.Parent=par return o end
local function round(o,r) new("UICorner",{CornerRadius=UDim.new(0,r)},o) end
local function outline(o,c,t) new("UIStroke",{Color=c,Thickness=t or 1},o) end

--==============================================================
-- 🎬 LOADING
--==============================================================
pcall(function() if CoreGui:FindFirstChild("TrueChadLoading") then CoreGui.TrueChadLoading:Destroy() end end)
local LG = new("ScreenGui",{Name="TrueChadLoading",ResetOnSpawn=false,IgnoreGuiInset=true,DisplayOrder=99999},(gethui and gethui()) or playerGui)
new("Frame",{Size=UDim2.new(1,0,1,0),BackgroundColor3=Color3.fromRGB(0,0,0),BorderSizePixel=0},LG)

local BB = new("Frame",{Size=UDim2.new(0,320,0,120),Position=UDim2.new(0.5,-160,0.5,-60),BackgroundColor3=Color3.fromRGB(30,90,180),BorderSizePixel=0},LG)
round(BB,12)
local BS = new("UIStroke",{Color=Color3.fromRGB(60,150,255),Thickness=2},BB)
local MT = new("TextLabel",{Size=UDim2.new(1,-20,0,45),Position=UDim2.new(0,10,0.5,-35),BackgroundTransparency=1,Text="By:@christisloveisnx",TextColor3=Color3.fromRGB(255,255,255),TextSize=26,Font=Enum.Font.GothamBlack},BB)
local ST = new("TextLabel",{Size=UDim2.new(1,-20,0,25),Position=UDim2.new(0,10,0.5,15),BackgroundTransparency=1,Text="in tik tok",TextColor3=Color3.fromRGB(180,200,230),TextSize=16,Font=Enum.Font.GothamSemibold},BB)

task.wait(3)
TweenService:Create(BB,TweenInfo.new(0.6),{BackgroundTransparency=1}):Play()
TweenService:Create(BS,TweenInfo.new(0.6),{Transparency=1}):Play()
TweenService:Create(MT,TweenInfo.new(0.6),{TextTransparency=1}):Play()
TweenService:Create(ST,TweenInfo.new(0.6),{TextTransparency=1}):Play()
task.wait(0.6)

local CL = new("TextLabel",{Size=UDim2.new(1,-40,0,100),Position=UDim2.new(0,20,0.5,-50),BackgroundTransparency=1,Text="",TextSize=48,Font=Enum.Font.GothamBlack,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center},LG)
local function showN(n,col) CL.Text="miusic in: "..n CL.TextColor3=col CL.TextSize=70 TweenService:Create(CL,TweenInfo.new(0.25,Enum.EasingStyle.Back),{TextSize=48}):Play() task.wait(1) end
showN(3,Color3.fromRGB(60,220,100))
showN(2,Color3.fromRGB(255,210,60))
showN(1,Color3.fromRGB(220,40,40))
TweenService:Create(CL,TweenInfo.new(0.4),{TextTransparency=1}):Play()
task.wait(0.4)
LG:Destroy()
print("[HUB] Loading OK")

--==============================================================
-- 🎵 MÚSICA
--==============================================================
local oldM = SoundService:FindFirstChild("TrueChadMusic")
if oldM then oldM:Destroy() end
local Music = Instance.new("Sound")
Music.Name = "TrueChadMusic"
Music.SoundId = CFG.MUSIC_ID
Music.Volume = CFG.MUSIC_VOL
Music.Looped = true
Music.Parent = SoundService
Music:Play()
G.TrueChadHub.Music = Music
print("[HUB] Music OK")

--==============================================================
-- MÓDULOS
--==============================================================
local Modules = {}
G.TrueChadHub.Modules = Modules
local function loadMod(path)
    local obj = RS
    for _, s in ipairs(path) do
        obj = obj and obj:FindFirstChild(s)
        if not obj then return nil end
    end
    local ok, m = pcall(require, obj)
    return ok and m or nil
end
task.spawn(function()
    for i = 1, 30 do
        if not Modules.EggState then Modules.EggState = loadMod({"Client","EggState"}) end
        if not Modules.Assets then Modules.Assets = loadMod({"Data","Assets"}) end
        if Modules.EggState and Modules.Assets then break end
        task.wait(0.5)
    end
    print("[HUB] EggState:", Modules.EggState ~= nil, "Assets:", Modules.Assets ~= nil)
end)

--==============================================================
-- HELPERS
--==============================================================
local function getHRP()
    local c = player.Character
    if not c then return nil, nil end
    return c, c:FindFirstChild("HumanoidRootPart")
end
G.TrueChadHub.getHRP = getHRP

local function getBiome(pos)
    if not pos then return "?" end
    local best, bd = "?", math.huge
    for _, b in ipairs(BIOMES) do
        local d = math.abs(pos.X - b.x)
        if d < bd then bd, best = d, b.n end
    end
    return best
end

local function assetInfo(cat)
    local dir = Modules.Assets and Modules.Assets.Directory
    local raw = type(dir) == "table" and dir[cat] or nil
    local rar = type(raw) == "table" and raw.Rarity or nil
    local rn, col = "Common", Color3.fromRGB(255,255,255)
    if type(rar) == "table" then
        rn = tostring(rar.DisplayName or rar._id or "Common")
        if typeof(rar.Color) == "Color3" then col = rar.Color end
    end
    if RC[rn] then col = RC[rn] end
    local nm = tostring(raw and (raw.DisplayName or cat) or cat)
    local ic = type(raw) == "table" and raw.Icon or nil
    if ic and tonumber(ic) then ic = "rbxassetid://"..tostring(ic) end
    return {Name=nm, Rarity=rn, Color=col, Icon=ic}
end

local function stateOK(s)
    if s == nil then return true end
    if type(s) ~= "string" then return true end
    if s:lower() == "carried" then return false end
    return true
end

local function readEggs()
    local E = Modules.EggState
    if type(E) ~= "table" or type(E.ReadFieldEggs) ~= "function" then return nil end
    local ok, r = pcall(E.ReadFieldEggs)
    if not ok or type(r) ~= "table" or type(r.Records) ~= "table" then return nil end
    return r.Records
end

--==============================================================
-- 🎨 GUI
--==============================================================
pcall(function() if CoreGui:FindFirstChild("TrueChadHub") then CoreGui.TrueChadHub:Destroy() end end)

local SG = new("ScreenGui",{Name="TrueChadHub",ResetOnSpawn=false,IgnoreGuiInset=true,DisplayOrder=999},(gethui and gethui()) or playerGui)

local TB = new("TextButton",{
    Size=UDim2.new(0,60,0,60),Position=UDim2.new(0,20,0.5,-30),
    BackgroundColor3=Color3.fromRGB(20,40,80),BorderSizePixel=0,
    Text="🥚",TextSize=28,TextColor3=Color3.fromRGB(255,255,255),
    Font=Enum.Font.GothamBold,AutoButtonColor=false,Draggable=true,Active=true,
},SG)
round(TB,30) outline(TB,TH.Blue,2)

local PN = new("Frame",{
    Size=UDim2.new(0,340,0,700),Position=UDim2.new(0,90,0.5,-350),
    BackgroundColor3=TH.BgDark,BorderSizePixel=0,ClipsDescendants=true,
    Visible=false,Draggable=true,Active=true,
},SG)
round(PN,12) outline(PN,TH.Blue,1.5)

local HD = new("Frame",{Size=UDim2.new(1,0,0,50),BackgroundColor3=Color3.fromRGB(15,25,45),BorderSizePixel=0},PN)
round(HD,12)

new("TextLabel",{Size=UDim2.new(1,-50,0,22),Position=UDim2.new(0,15,0,6),BackgroundTransparency=1,Text="TrueChad Hub",TextColor3=TH.Blue,TextSize=16,Font=Enum.Font.GothamBlack,TextXAlignment=Enum.TextXAlignment.Left},HD)
new("TextLabel",{Size=UDim2.new(1,-50,0,14),Position=UDim2.new(0,15,0,28),BackgroundTransparency=1,Text="By:@christisloveisnx",TextColor3=TH.Gray,TextSize=10,Font=Enum.Font.Gotham,TextXAlignment=Enum.TextXAlignment.Left},HD)

local CB = new("TextButton",{Size=UDim2.new(0,30,0,30),Position=UDim2.new(1,-40,0,10),BackgroundColor3=Color3.fromRGB(180,60,60),Text="✕",TextColor3=Color3.fromRGB(255,255,255),TextSize=14,Font=Enum.Font.GothamBold,BorderSizePixel=0,AutoButtonColor=false},HD)
round(CB,8)

local SC = new("ScrollingFrame",{Size=UDim2.new(1,-20,1,-70),Position=UDim2.new(0,10,0,60),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=4,ScrollBarImageColor3=TH.Blue,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y},PN)
new("UIListLayout",{Padding=UDim.new(0,6),SortOrder=Enum.SortOrder.LayoutOrder},SC)
new("UIPadding",{PaddingTop=UDim.new(0,5),PaddingBottom=UDim.new(0,10)},SC)

-- Crédito
new("TextLabel",{Size=UDim2.new(1,0,0,22),BackgroundTransparency=1,Text="⚙️ Sistema",TextColor3=TH.Gray,TextSize=11,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Left,LayoutOrder=0},SC)

local CR = new("Frame",{Size=UDim2.new(1,0,0,44),BackgroundColor3=TH.CreditBg,BackgroundTransparency=0.15,BorderSizePixel=0,LayoutOrder=1},SC)
round(CR,8) outline(CR,TH.Blue,1.5)
new("ImageLabel",{Size=UDim2.fromOffset(32,32),Position=UDim2.new(0,8,0.5,-16),BackgroundTransparency=1,Image="rbxassetid://84157643184125",ImageColor3=Color3.fromRGB(60,150,255),ScaleType=Enum.ScaleType.Fit},CR)
new("TextLabel",{Size=UDim2.new(1,-95,1,0),Position=UDim2.new(0,48,0,0),BackgroundTransparency=1,Text="By:@christisloveisnx",TextColor3=Color3.fromRGB(60,150,255),TextSize=14,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Center},CR)
new("ImageLabel",{Size=UDim2.fromOffset(32,32),Position=UDim2.new(1,-40,0.5,-16),BackgroundTransparency=1,Image="rbxassetid://84157643184125",ImageColor3=Color3.fromRGB(60,150,255),ScaleType=Enum.ScaleType.Fit},CR)

-- Música
new("TextLabel",{Size=UDim2.new(1,0,0,22),BackgroundTransparency=1,Text="🎵 Música",TextColor3=TH.Cyan,TextSize=11,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Left,LayoutOrder=2},SC)
local MB = new("TextButton",{Size=UDim2.new(1,0,0,36),BackgroundColor3=TH.Green,BorderSizePixel=0,Text="🎵 Música: ON",TextColor3=Color3.fromRGB(255,255,255),TextSize=13,Font=Enum.Font.GothamBold,AutoButtonColor=false,LayoutOrder=3},SC)
round(MB,10) outline(MB,TH.GreenL,1.5)
MB.MouseButton1Click:Connect(function()
    if Music.IsPlaying then
        Music:Pause() MB.BackgroundColor3=TH.Red MB.Text="🎵 Música: OFF"
    else
        Music:Resume() MB.BackgroundColor3=TH.Green MB.Text="🎵 Música: ON"
    end
end)

-- Velocidade
new("TextLabel",{Size=UDim2.new(1,0,0,22),BackgroundTransparency=1,Text="⚡ Velocidade",TextColor3=TH.Cyan,TextSize=11,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Left,LayoutOrder=10},SC)
local SpdCont = new("Frame",{Size=UDim2.new(1,0,0,42),BackgroundTransparency=1,LayoutOrder=11},SC)
new("UIListLayout",{Padding=UDim.new(0,4),FillDirection=Enum.FillDirection.Horizontal},SpdCont)

G.TrueChadHub.Speed = 250
local SpdLbl = new("TextLabel",{Size=UDim2.new(1,0,0,18),BackgroundTransparency=1,Text="⚡ Atual: 250",TextColor3=TH.GreenL,TextSize=10,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Left,LayoutOrder=12},SC)

for _, spd in ipairs({100,150,200,250,287,300,350,400}) do
    local b = new("TextButton",{Size=UDim2.new(0,50,1,0),BackgroundColor3=spd==250 and TH.Green or TH.Card,Text=tostring(spd),TextColor3=Color3.fromRGB(255,255,255),TextSize=10,Font=Enum.Font.GothamBold,BorderSizePixel=0,AutoButtonColor=false},SpdCont)
    round(b,8)
    b.MouseButton1Click:Connect(function()
        G.TrueChadHub.Speed = spd
        SpdLbl.Text = "⚡ Atual: " .. spd
        for _, btn in ipairs(SpdCont:GetChildren()) do
            if btn:IsA("TextButton") then
                btn.BackgroundColor3 = (btn.Text == tostring(spd)) and TH.Green or TH.Card
            end
        end
    end)
end

-- Filtros
new("TextLabel",{Size=UDim2.new(1,0,0,22),BackgroundTransparency=1,Text="🌍 Filtros",TextColor3=TH.Cyan,TextSize=11,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Left,LayoutOrder=20},SC)
local FC = new("ScrollingFrame",{Size=UDim2.new(1,0,0,42),BackgroundColor3=Color3.fromRGB(15,25,45),BackgroundTransparency=0.3,BorderSizePixel=0,ScrollBarThickness=3,ScrollBarImageColor3=TH.Blue,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.X,ScrollingDirection=Enum.ScrollingDirection.X,LayoutOrder=21},SC)
round(FC,8)
new("UIListLayout",{Padding=UDim.new(0,4),FillDirection=Enum.FillDirection.Horizontal},FC)
new("UIPadding",{PaddingLeft=UDim.new(0,4),PaddingRight=UDim.new(0,4),PaddingTop=UDim.new(0,4)},FC)

G.TrueChadHub.Filter = "TODOS"
G.TrueChadHub.FB = {}
local function sfb(b,ac)
    if ac then b.BackgroundColor3=TH.CardActive b.TextColor3=Color3.fromRGB(255,255,255)
    else b.BackgroundColor3=TH.Card b.TextColor3=Color3.fromRGB(180,210,255) end
end

local AB = new("TextButton",{Size=UDim2.new(0,60,0,34),BackgroundColor3=TH.CardActive,BorderSizePixel=0,Text="TODOS",TextColor3=Color3.fromRGB(255,255,255),TextSize=10,Font=Enum.Font.GothamBold,AutoButtonColor=false,LayoutOrder=0},FC)
round(AB,8)
G.TrueChadHub.FB["TODOS"] = AB
AB.MouseButton1Click:Connect(function()
    G.TrueChadHub.Filter = "TODOS"
    for k, b in pairs(G.TrueChadHub.FB) do sfb(b, k == "TODOS") end
end)

for i, b in ipairs(BIOMES) do
    local bt = new("TextButton",{Size=UDim2.new(0,80,0,34),BackgroundColor3=TH.Card,BorderSizePixel=0,Text=b.n,TextColor3=Color3.fromRGB(180,210,255),TextSize=9,Font=Enum.Font.GothamBold,AutoButtonColor=false,LayoutOrder=i},FC)
    round(bt,8)
    G.TrueChadHub.FB[b.n] = bt
    bt.MouseButton1Click:Connect(function()
        G.TrueChadHub.Filter = b.n
        for k, x in pairs(G.TrueChadHub.FB) do sfb(x, k == b.n) end
    end)
end

-- ESP
new("TextLabel",{Size=UDim2.new(1,0,0,22),BackgroundTransparency=1,Text="🥚 Ovos spawnados",TextColor3=TH.Blue,TextSize=11,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Left,LayoutOrder=30},SC)
local StatusL = new("TextLabel",{Size=UDim2.new(1,0,0,18),BackgroundTransparency=1,Text="Carregando...",TextColor3=TH.Gray,TextSize=10,Font=Enum.Font.Gotham,TextXAlignment=Enum.TextXAlignment.Left,LayoutOrder=31},SC)

local EC = new("Frame",{Size=UDim2.new(1,0,0,10),BackgroundTransparency=1,LayoutOrder=32,AutomaticSize=Enum.AutomaticSize.Y},SC)
new("UIListLayout",{Padding=UDim.new(0,4),SortOrder=Enum.SortOrder.LayoutOrder},EC)

-- Abrir/fechar
local isOpen = false
local function toggle()
    isOpen = not isOpen
    if isOpen then
        PN.Visible = true
        PN.Size = UDim2.new(0,0,0,700)
        TweenService:Create(PN,TweenInfo.new(0.25),{Size=UDim2.new(0,340,0,700)}):Play()
    else
        local t = TweenService:Create(PN,TweenInfo.new(0.2),{Size=UDim2.new(0,0,0,700)})
        t:Play()
        t.Completed:Connect(function() PN.Visible = false end)
    end
end
TB.MouseButton1Click:Connect(toggle)
CB.MouseButton1Click:Connect(function() if isOpen then toggle() end end)

print("[HUB] GUI OK")

--==============================================================
-- 🛡️ GODMODE + TWEEN
--==============================================================
local fly = {on=false, token=0, healConn=nil}

local function enableGod(c, h)
    pcall(function() h.MaxHealth = CFG.GodHealth h.Health = CFG.GodHealth end)
    if fly.healConn then fly.healConn:Disconnect() end
    fly.healConn = RunService.Heartbeat:Connect(function()
        if not fly.on then return end
        pcall(function()
            if h.Health < CFG.GodHealth then h.Health = CFG.GodHealth end
            if h.MaxHealth < CFG.GodHealth then h.MaxHealth = CFG.GodHealth end
        end)
    end)
end

local function disableGod(c)
    if fly.healConn then fly.healConn:Disconnect() fly.healConn = nil end
    if c then
        local h = c:FindFirstChildOfClass("Humanoid")
        if h then
            pcall(function() h.MaxHealth = 100 h.Health = 100 end)
        end
    end
end

local function moveTo(tx, tz, lbl)
    if fly.on then return end
    fly.on = true
    fly.token = fly.token + 1
    local tk = fly.token
    print("[HUB] Movendo:", lbl or "")
    
    task.spawn(function()
        local c, hrp = getHRP()
        if not c or not hrp then fly.on = false return end
        local h = c:FindFirstChildOfClass("Humanoid")
        if not h then fly.on = false return end
        
        pcall(function() hrp.Anchored = false h.PlatformStand = false end)
        local ow = h.WalkSpeed
        pcall(function() h.WalkSpeed = 0 h.PlatformStand = true end)
        pcall(function() hrp:SetNetworkOwner(player) end)
        enableGod(c, h)
        
        local old = hrp:FindFirstChild("TCBV")
        if old then old:Destroy() end
        
        local bv = Instance.new("BodyVelocity")
        bv.Name = "TCBV"
        bv.MaxForce = Vector3.new(2e6, 0, 2e6)
        bv.P = 15000
        bv.Parent = hrp
        
        local t0 = tick()
        while tk == fly.token do
            if not hrp or not hrp.Parent then break end
            if tick() - t0 > 60 then break end
            local cp = hrp.Position
            local dir = Vector3.new(tx, cp.Y, tz) - cp
            local ds = dir.Magnitude
            if ds < 8 then break end
            local s = math.min(G.TrueChadHub.Speed or 250, ds * 2)
            local u = Vector3.new(dir.X, 0, dir.Z).Unit
            bv.Velocity = Vector3.new(u.X * s, 0, u.Z * s)
            task.wait(0.03)
        end
        
        bv:Destroy()
        pcall(function() h.WalkSpeed = ow h.PlatformStand = false end)
        fly.on = false
        disableGod(c)
    end)
    
    while fly.on do task.wait(0.1) end
end

local function vert(ty)
    if fly.on then return end
    fly.on = true
    fly.token = fly.token + 1
    local tk = fly.token
    
    task.spawn(function()
        local c, hrp = getHRP()
        if not c or not hrp then fly.on = false return end
        local h = c:FindFirstChildOfClass("Humanoid")
        if not h then fly.on = false return end
        
        pcall(function() hrp.Anchored = false end)
        local ow = h.WalkSpeed
        pcall(function() h.WalkSpeed = 0 h.PlatformStand = true end)
        pcall(function() hrp:SetNetworkOwner(player) end)
        enableGod(c, h)
        
        local old = hrp:FindFirstChild("TCBV")
        if old then old:Destroy() end
        
        local bv = Instance.new("BodyVelocity")
        bv.Name = "TCBV"
        bv.MaxForce = Vector3.new(0, 2e6, 0)
        bv.P = 15000
        bv.Parent = hrp
        
        local t0 = tick()
        while tk == fly.token do
            if not hrp or not hrp.Parent then break end
            if tick() - t0 > 10 then break end
            local yd = ty - hrp.Position.Y
            if math.abs(yd) < 1.5 then break end
            local vy = m
