--==============================================================
-- TRUECHAD HUB - SCRIPT COMPLETO
-- Loading + Música + GUI + ESP + Tween + Alerta
-- By: @christisloveisnx
--==============================================================
print("[HUB] Iniciando script completo...")

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

--==============================================================
-- CONFIG GLOBAL
--==============================================================
local CONFIG = {
    -- 🎬 Loading
    LOADING_TIME = 3,
    
    -- 🎵 Música
    MUSIC_ID = "rbxassetid://110919391228823",
    MUSIC_VOLUME = 0.5,
    
    -- 🚨 Alerta
    RARE_RARITIES = {Divine=true, Eternal=true, Secret=true, Cosmic=false},
    ALERT_SOUND = "rbxassetid://127859692805098",
    ALERT_VOLUME = 0.6,
    ALERT_DURATION = 10,
    ALERT_COOLDOWN = 15,
    
    -- 🕊️ Tween
    Base = Vector3.new(545.8, 70.6, -367.4),
    SpeedUp = 40,
    GrabRadius = 40,
    MaxPerBiome = 10,
    MaxTimePerLeg = 90,
    MaxDistPerSec = 400,
    GodHealth = 1e9,
    HeightAboveEgg = 4,
    NearDistance = 20,
    RiseHeight = 15,
}

local TH = {
    Blue      = Color3.fromRGB(60, 150, 255),
    BlueLight = Color3.fromRGB(120, 190, 255),
    BlueDark  = Color3.fromRGB(20, 40, 80),
    Cyan      = Color3.fromRGB(80, 220, 255),
    White     = Color3.fromRGB(235, 245, 255),
    Gray      = Color3.fromRGB(130, 160, 200),
    BgDark    = Color3.fromRGB(10, 18, 35),
    CardBg    = Color3.fromRGB(20, 35, 60),
    CardActive= Color3.fromRGB(40, 90, 160),
    CreditBg  = Color3.fromRGB(15, 40, 90),
    Green     = Color3.fromRGB(60, 180, 90),
    GreenLight= Color3.fromRGB(100, 240, 130),
    Red       = Color3.fromRGB(200, 50, 50),
}

local RC = {
    ["Divine"]=Color3.fromRGB(255,220,80), ["Eternal"]=Color3.fromRGB(255,140,60),
    ["Secret"]=Color3.fromRGB(255,255,255), ["Cosmic"]=Color3.fromRGB(90,150,255),
    ["Mythic"]=Color3.fromRGB(230,90,180), ["Legendary"]=Color3.fromRGB(255,200,60),
    ["Epic"]=Color3.fromRGB(180,90,220), ["Rare"]=Color3.fromRGB(90,200,220),
    ["Uncommon"]=Color3.fromRGB(100,220,130), ["Common"]=Color3.fromRGB(180,180,180),
}

local BIOMES = {
    {n="Forest",x=593},{n="Lake",x=720},{n="Desert",x=897},{n="Jungle",x=1143},
    {n="Snow",x=1428},{n="Volcano",x=1778},{n="Ocean",x=2218},{n="Prehistoric",x=2757},
    {n="Cosmic",x=3376},{n="Cherry Blossom",x=3999},{n="Titan Temple",x=4759},{n="Angels & Demons",x=5620},
}

local function new(c, p, par) local o = Instance.new(c) for k,v in pairs(p) do o[k]=v end o.Parent=par return o end
local function round(o,r) new("UICorner",{CornerRadius=UDim.new(0,r)},o) end
local function outline(o,c,t,tr) new("UIStroke",{Color=c,Thickness=t or 1,Transparency=tr or 0},o) end

--==============================================================
-- 🎬 LOADING SCREEN
--==============================================================
local function showLoading()
    pcall(function() 
        if CoreGui:FindFirstChild("TrueChadLoading") then CoreGui.TrueChadLoading:Destroy() end 
    end)
    
    local LoadingGui = new("ScreenGui", {
        Name="TrueChadLoading", ResetOnSpawn=false, IgnoreGuiInset=true,
        ZIndexBehavior=Enum.ZIndexBehavior.Sibling, DisplayOrder=99999,
    }, (gethui and gethui()) or playerGui)
    
    new("Frame", {
        Size=UDim2.new(1,0,1,0), BackgroundColor3=Color3.fromRGB(0,0,0),
        BorderSizePixel=0, ZIndex=1,
    }, LoadingGui)
    
    local BlueBox = new("Frame", {
        Size=UDim2.new(0,320,0,120), Position=UDim2.new(0.5,-160,0.5,-60),
        BackgroundColor3=Color3.fromRGB(30,90,180), BorderSizePixel=0, ZIndex=2,
    }, LoadingGui)
    round(BlueBox, 12)
    local BoxStroke = new("UIStroke", {Color=Color3.fromRGB(60,150,255), Thickness=2}, BlueBox)
    
    local MainText = new("TextLabel", {
        Size=UDim2.new(1,-20,0,45), Position=UDim2.new(0,10,0.5,-35),
        BackgroundTransparency=1, Text="By:@christisloveisnx",
        TextColor3=Color3.fromRGB(255,255,255), TextSize=26,
        Font=Enum.Font.GothamBlack, ZIndex=3,
    }, BlueBox)
    
    local SubText = new("TextLabel", {
        Size=UDim2.new(1,-20,0,25), Position=UDim2.new(0,10,0.5,15),
        BackgroundTransparency=1, Text="in tik tok",
        TextColor3=Color3.fromRGB(180,200,230), TextSize=16,
        Font=Enum.Font.GothamSemibold, ZIndex=3,
    }, BlueBox)
    
    task.wait(CONFIG.LOADING_TIME)
    
    local fadeTime = 0.6
    for _, obj in ipairs({BlueBox, BoxStroke, MainText, SubText}) do
        local prop = obj:IsA("UIStroke") and "Transparency" or (obj:IsA("TextLabel") and "TextTransparency" or "BackgroundTransparency")
        TweenService:Create(obj, TweenInfo.new(fadeTime, Enum.EasingStyle.Quart), {[prop] = 1}):Play()
    end
    task.wait(fadeTime)
    
    -- Contagem
    local CountdownLabel = new("TextLabel", {
        Size=UDim2.new(1,-40,0,100), Position=UDim2.new(0,20,0.5,-50),
        BackgroundTransparency=1, Text="", TextSize=48,
        Font=Enum.Font.GothamBlack, TextXAlignment=Enum.TextXAlignment.Center,
        TextYAlignment=Enum.TextYAlignment.Center, ZIndex=3,
    }, LoadingGui)
    
    local function showNumber(n, color)
        CountdownLabel.Text = "miusic in: "..n
        CountdownLabel.TextColor3 = color
        CountdownLabel.TextSize = 70
        TweenService:Create(CountdownLabel, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {TextSize=48}):Play()
        task.wait(1)
    end
    
    showNumber(3, Color3.fromRGB(60,220,100))
    showNumber(2, Color3.fromRGB(255,210,60))
    showNumber(1, Color3.fromRGB(220,40,40))
    
    TweenService:Create(CountdownLabel, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {TextTransparency=1}):Play()
    task.wait(0.4)
    LoadingGui:Destroy()
end

showLoading()
print("[HUB] Loading completo")

--==============================================================
-- 🎵 MÚSICA
--==============================================================
local oldMusic = SoundService:FindFirstChild("TrueChadMusic")
if oldMusic then oldMusic:Destroy() end

local Music = Instance.new("Sound")
Music.Name = "TrueChadMusic"
Music.SoundId = CONFIG.MUSIC_ID
Music.Volume = CONFIG.MUSIC_VOLUME
Music.Looped = true
Music.Parent = SoundService
Music:Play()

G.TrueChadHub.Music = Music
print("[HUB] Música tocando")

--==============================================================
-- MÓDULOS
--==============================================================
print("[HUB] Carregando módulos...")
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
        if not Modules.Mutations then Modules.Mutations = loadMod({"Shared","Modules","Mutations"}) end
        if Modules.EggState and Modules.Assets then break end
        task.wait(0.5)
    end
    print("[HUB] EggState:", Modules.EggState ~= nil)
    print("[HUB] Assets:", Modules.Assets ~= nil)
end)

--==============================================================
-- HELPERS
--==============================================================
local function getBiomeName(pos)
    if not pos then return "?" end
    local best, bd = "?", math.huge
    for _, b in ipairs(BIOMES) do
        local d = math.abs(pos.X - b.x)
        if d < bd then bd, best = d, b.n end
    end
    return best
end

local function getHRP()
    local c = player.Character
    if not c then return nil, nil end
    return c, c:FindFirstChild("HumanoidRootPart")
end

--==============================================================
-- 🎨 GUI DO HUB
--==============================================================
pcall(function() if CoreGui:FindFirstChild("TrueChadHub") then CoreGui.TrueChadHub:Destroy() end end)

local SG = new("ScreenGui", {Name="TrueChadHub", ResetOnSpawn=false, IgnoreGuiInset=true,
    ZIndexBehavior=Enum.ZIndexBehavior.Sibling, DisplayOrder=999}, (gethui and gethui()) or playerGui)

local TB = new("ImageButton", {
    Size=UDim2.new(0,60,0,60), Position=UDim2.new(0,20,0.5,-30),
    BackgroundColor3=Color3.fromRGB(20,40,80), BackgroundTransparency=0.15,
    BorderSizePixel=0, Image="rbxassetid://6423535212",
    ImageColor3=Color3.fromRGB(60,150,255), ScaleType=Enum.ScaleType.Fit,
    AutoButtonColor=false, Draggable=true, Active=true,
}, SG)
round(TB,30) outline(TB,TH.Blue,2,0)

local P = new("Frame", {
    Size=UDim2.new(0,340,0,820), Position=UDim2.new(0,90,0.5,-410),
    BackgroundColor3=TH.BgDark, BorderSizePixel=0, ClipsDescendants=true,
    Visible=false, Draggable=true, Active=true,
}, SG)
round(P,12) outline(P,TH.Blue,1.5,0.3)

local H = new("Frame", {Size=UDim2.new(1,0,0,50), BackgroundColor3=Color3.fromRGB(15,25,45), BorderSizePixel=0, ZIndex=5}, P)
round(H,12)
new("Frame", {Size=UDim2.new(1,0,0,15), Position=UDim2.new(0,0,1,-15), BackgroundColor3=Color3.fromRGB(15,25,45), BorderSizePixel=0, ZIndex=5}, H)
new("TextLabel", {Size=UDim2.new(1,-50,0,22), Position=UDim2.new(0,15,0,6), BackgroundTransparency=1,
    Text="TrueChad Hub", TextColor3=TH.Blue, TextSize=16, Font=Enum.Font.GothamBlack,
    TextXAlignment=Enum.TextXAlignment.Left, ZIndex=6}, H)
new("TextLabel", {Size=UDim2.new(1,-50,0,14), Position=UDim2.new(0,15,0,28), BackgroundTransparency=1,
    Text="By:@christisloveisnx • in tik tok", TextColor3=TH.Gray, TextSize=10,
    Font=Enum.Font.Gotham, TextXAlignment=Enum.TextXAlignment.Left, ZIndex=6}, H)

local CB = new("TextButton", {Size=UDim2.new(0,30,0,30), Position=UDim2.new(1,-40,0,10),
    BackgroundColor3=Color3.fromRGB(180,60,60), Text="✕", TextColor3=Color3.fromRGB(255,255,255),
    TextSize=14, Font=Enum.Font.GothamBold, BorderSizePixel=0, AutoButtonColor=false, ZIndex=6}, H)
round(CB,8)

new("ImageLabel", {Size=UDim2.new(1,-20,1,-60), Position=UDim2.new(0,10,0,55),
    BackgroundColor3=Color3.fromRGB(12,20,40), BorderSizePixel=0,
    Image="rbxassetid://10812919971", ImageTransparency=0.55,
    ScaleType=Enum.ScaleType.Crop, ZIndex=1}, P)

local Sc = new("ScrollingFrame", {Size=UDim2.new(1,-20,1,-70), Position=UDim2.new(0,10,0,60),
    BackgroundTransparency=1, BorderSizePixel=0, ScrollBarThickness=4,
    ScrollBarImageColor3=TH.Blue, CanvasSize=UDim2.new(0,0,0,0),
    AutomaticCanvasSize=Enum.AutomaticSize.Y, ZIndex=2}, P)
new("UIListLayout", {Padding=UDim.new(0,6), SortOrder=Enum.SortOrder.LayoutOrder}, Sc)
new("UIPadding", {PaddingTop=UDim.new(0,5), PaddingBottom=UDim.new(0,10)}, Sc)

local open = false
local function toggle() 
    open = not open
    if open then
        P.Visible = true
        P.Size = UDim2.new(0,0,0,820)
        TweenService:Create(P,TweenInfo.new(0.25,Enum.EasingStyle.Quart),{Size=UDim2.new(0,340,0,820)}):Play()
    else
        local t = TweenService:Create(P,TweenInfo.new(0.2,Enum.EasingStyle.Quart),{Size=UDim2.new(0,0,0,820)})
        t:Play() t.Completed:Connect(function() P.Visible=false end)
    end
end
TB.MouseButton1Click:Connect(toggle)
CB.MouseButton1Click:Connect(function() if open then toggle() end end)

local function secH(text, ord, col)
    return new("TextLabel", {Size=UDim2.new(1,0,0,22), BackgroundTransparency=1, Text=text,
        TextColor3=col or TH.Cyan, TextSize=11, Font=Enum.Font.GothamBold,
        TextXAlignment=Enum.TextXAlignment.Left, LayoutOrder=ord, ZIndex=3}, Sc)
end

-- Crédito
secH("⚙️ Sistema", 0, TH.Gray)
local creditFrame = new("Frame", {Size=UDim2.new(1,0,0,44), BackgroundColor3=TH.CreditBg,
    BackgroundTransparency=0.15, BorderSizePixel=0, LayoutOrder=1, ZIndex=3}, Sc)
round(creditFrame,8) outline(creditFrame,TH.Blue,1.5,0.2)
new("ImageLabel", {Size=UDim2.fromOffset(32,32), Position=UDim2.new(0,8,0.5,-16), BackgroundTransparency=1,
    Image="rbxassetid://84157643184125", ImageColor3=Color3.fromRGB(60,150,255),
    ScaleType=Enum.ScaleType.Fit, ZIndex=4}, creditFrame)
new("TextLabel", {Size=UDim2.new(1,-95,1,0), Position=UDim2.new(0,48,0,0), BackgroundTransparency=1,
    Text="By:@christisloveisnx", TextColor3=Color3.fromRGB(60,150,255), TextSize=14,
    Font=Enum.Font.GothamBold, TextXAlignment=Enum.TextXAlignment.Center, ZIndex=4}, creditFrame)
new("ImageLabel", {Size=UDim2.fromOffset(32,32), Position=UDim2.new(1,-40,0.5,-16), BackgroundTransparency=1,
    Image="rbxassetid://84157643184125", ImageColor3=Color3.fromRGB(60,150,255),
    ScaleType=Enum.ScaleType.Fit, ZIndex=4}, creditFrame)

-- 🎵 Música toggle
secH("🎵 Música", 2, TH.Cyan)
local MusicBtn = new("TextButton", {
    Size=UDim2.new(1,0,0,36), BackgroundColor3=TH.Green, BorderSizePixel=0,
    Text="🎵 Música: ON", TextColor3=Color3.fromRGB(255,255,255), TextSize=13,
    Font=Enum.Font.GothamBold, AutoButtonColor=false, LayoutOrder=3, ZIndex=3,
}, Sc)
round(MusicBtn,10) outline(MusicBtn, TH.GreenLight, 1.5, 0.3)
MusicBtn.MouseButton1Click:Connect(function()
    if Music.IsPlaying then
        Music:Pause()
        MusicBtn.BackgroundColor3 = TH.Red
        MusicBtn.Text = "🎵 Música: OFF"
        if MusicBtn:FindFirstChildOfClass("UIStroke") then
            MusicBtn:FindFirstChildOfClass("UIStroke").Color = Color3.fromRGB(255,120,120)
        end
    else
        Music:Resume()
        MusicBtn.BackgroundColor3 = TH.Green
        MusicBtn.Text = "🎵 Música: ON"
        if MusicBtn:FindFirstChildOfClass("UIStroke") then
            MusicBtn:FindFirstChildOfClass("UIStroke").Color = TH.GreenLight
        end
    end
end)

-- ⚡ Velocidade
secH("⚡ Velocidade", 20, TH.Cyan)
local SpeedContainer = new("ScrollingFrame", {Size=UDim2.new(1,0,0,42),
    BackgroundColor3=Color3.fromRGB(15,25,45), BackgroundTransparency=0.3, BorderSizePixel=0,
    ScrollBarThickness=3, ScrollBarImageColor3=TH.Blue, CanvasSize=UDim2.new(0,0,0,0),
    AutomaticCanvasSize=Enum.AutomaticSize.X, ScrollingDirection=Enum.ScrollingDirection.X,
    LayoutOrder=21, ZIndex=3}, Sc)
round(SpeedContainer,8)
new("UIListLayout", {Padding=UDim.new(0,4), FillDirection=Enum.FillDirection.Horizontal,
    SortOrder=Enum.SortOrder.LayoutOrder}, SpeedContainer)
new("UIPadding", {PaddingLeft=UDim.new(0,4), PaddingRight=UDim.new(0,4), PaddingTop=UDim.new(0,4)}, SpeedContainer)

G.TrueChadHub.Speed = 250
G.TrueChadHub.SpeedButtons = {}

local SPEEDS = {100, 150, 200, 250, 287, 300, 350, 400}

local function setSpeedBtn(b, active)
    if active then
        b.BackgroundColor3 = TH.Green
        b.TextColor3 = Color3.fromRGB(255,255,255)
        if b:FindFirstChildOfClass("UIStroke") then
            b:FindFirstChildOfClass("UIStroke").Color = TH.GreenLight
            b:FindFirstChildOfClass("UIStroke").Transparency = 0
        end
    else
        b.BackgroundColor3 = TH.CardBg
        b.TextColor3 = Color3.fromRGB(180,210,255)
        if b:FindFirstChildOfClass("UIStroke") then
            b:FindFirstChildOfClass("UIStroke").Color = TH.BlueDark
            b:FindFirstChildOfClass("UIStroke").Transparency = 0.4
        end
    end
end

for i, spd in ipairs(SPEEDS) do
    local btn = new("TextButton", {Size=UDim2.new(0,50,0,34), BackgroundColor3=TH.CardBg,
        BorderSizePixel=0, Text=tostring(spd), TextColor3=Color3.fromRGB(180,210,255),
        TextSize=10, Font=Enum.Font.GothamBold, AutoButtonColor=false,
        LayoutOrder=i, ZIndex=4}, SpeedContainer)
    round(btn,8) outline(btn, TH.BlueDark, 1, 0.4)
    G.TrueChadHub.SpeedButtons[spd] = btn
    if spd == 250 then setSpeedBtn(btn, true) end
    btn.MouseButton1Click:Connect(function()
        G.TrueChadHub.Speed = spd
        for _, b in pairs(G.TrueChadHub.SpeedButtons) do setSpeedBtn(b, false) end
        setSpeedBtn(btn, true)
        if G.TrueChadHub.SpeedLabel then
            G.TrueChadHub.SpeedLabel.Text = "⚡ Speed atual: "..spd
        end
    end)
end

local speedLabel = new("TextLabel", {Size=UDim2.new(1,0,0,18), BackgroundTransparency=1,
    Text="⚡ Speed atual: 250", TextColor3=TH.GreenLight, TextSize=10,
    Font=Enum.Font.GothamBold, TextXAlignment=Enum.TextXAlignment.Left, LayoutOrder=22, ZIndex=3}, Sc)
G.TrueChadHub.SpeedLabel = speedLabel

-- 🌍 Filtros
secH("🌍 Filtros", 30, TH.Cyan)
local FC = new("ScrollingFrame", {Size=UDim2.new(1,0,0,42),
    BackgroundColor3=Color3.fromRGB(15,25,45), BackgroundTransparency=0.3, BorderSizePixel=0,
    ScrollBarThickness=3, ScrollBarImageColor3=TH.Blue, CanvasSize=UDim2.new(0,0,0,0),
    AutomaticCanvasSize=Enum.AutomaticSize.X, ScrollingDirection=Enum.ScrollingDirection.X,
    LayoutOrder=31, ZIndex=3}, Sc)
round(FC,8)
new("UIListLayout", {Padding=UDim.new(0,4), FillDirection=Enum.FillDirection.Horizontal,
    SortOrder=Enum.SortOrder.LayoutOrder}, FC)
new("UIPadding", {PaddingLeft=UDim.new(0,4), PaddingRight=UDim.new(0,4), PaddingTop=UDim.new(0,4)}, FC)

G.TrueChadHub.SG = SG
G.TrueChadHub.Panel = P
G.TrueChadHub.Scroll = Sc
G.TrueChadHub.FilterContainer = FC
G.TrueChadHub.Filter = "TODOS"
G.TrueChadHub.FilterButtons = {}
G.TrueChadHub.TH = TH
G.TrueChadHub.BIOMES = BIOMES
G.TrueChadHub.Helpers = {new=new, round=round, outline=outline}
G.TrueChadHub.MusicBtn = MusicBtn

local function setFilterBtn(b, active)
    if active then
        b.BackgroundColor3 = TH.CardActive
        b.TextColor3 = Color3.fromRGB(255,255,255)
        if b:FindFirstChildOfClass("UIStroke") then
            b:FindFirstChildOfClass("UIStroke").Color = TH.Blue
            b:FindFirstChildOfClass("UIStroke").Transparency = 0
        end
    else
        b.BackgroundColor3 = TH.CardBg
        b.TextColor3 = Color3.fromRGB(180,210,255)
        if b:FindFirstChildOfClass("UIStroke") then
            b:FindFirstChildOfClass("UIStroke").Color = TH.BlueDark
            b:FindFirstChildOfClass("UIStroke").Transparency = 0.4
        end
    end
end

local allB = new("TextButton", {Size=UDim2.new(0,60,0,34), BackgroundColor3=TH.CardActive,
    BorderSizePixel=0, Text="TODOS", TextColor3=Color3.fromRGB(255,255,255), TextSize=10,
    Font=Enum.Font.GothamBold, AutoButtonColor=false, LayoutOrder=0, ZIndex=4}, FC)
round(allB,8) outline(allB,TH.Blue,1,0)
G.TrueChadHub.FilterButtons["TODOS"] = allB
allB.MouseButton1Click:Connect(function()
    G.TrueChadHub.Filter = "TODOS"
    for k, b in pairs(G.TrueChadHub.FilterButtons) do setFilterBtn(b, k == "TODOS") end
end)

for i, b in ipairs(BIOMES) do
    local btn = new("TextButton", {Size=UDim2.new(0,80,0,34), BackgroundColor3=TH.CardBg,
        BorderSizePixel=0, Text=b.n, TextColor3=Color3.fromRGB(180,210,255), TextSize=9,
        Font=Enum.Font.GothamBold, AutoButtonColor=false, LayoutOrder=i, ZIndex=4}, FC)
    round(btn,8) outline(btn,TH.BlueDark,1,0.4)
    G.TrueChadHub.FilterButtons[b.n] = btn
    btn.MouseButton1Click:Connect(function()
        G.TrueChadHub.Filter = b.n
        for k, bb in pairs(G.TrueChadHub.FilterButtons) do setFilterBtn(bb, k == b.n) end
    end)
end

-- ESP Container
secH("🥚 Ovos spawnados", 100, TH.Blue)
local statusL = new("TextLabel", {Size=UDim2.new(1,0,0,18), BackgroundTransparency=1,
    Text="Aguardando módulos...", TextColor3=TH.Gray, TextSize=10, Font=Enum.Font.Gotham,
    TextXAlignment=Enum.TextXAlignment.Left, LayoutOrder=101, ZIndex=3}, Sc)
G.TrueChadHub.StatusLabel = statusL

local EC = new("Frame", {Size=UDim2.new(1,0,0,10), BackgroundTransparency=1,
    LayoutOrder=102, AutomaticSize=Enum.AutomaticSize.Y, ZIndex=3}, Sc)
new("UIListLayout", {Padd
