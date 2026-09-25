-- ═══════════════════════════════════════════
-- SHINOBHUB + SERVER HOP INTEGRADO
-- ═══════════════════════════════════════════
local p=game:GetService("Players").LocalPlayer
local PPS=game:GetService("ProximityPromptService")
local RS=game:GetService("RunService")
local L=game:GetService("Lighting")
local U=game:GetService("UserInputService")

for _,n in ipairs({"ShinobiHub","ServerHopGUI"}) do
    local o=p.PlayerGui:FindFirstChild(n)
    if o then o:Destroy() end
end

-- Paleta
local AC=Color3.fromRGB(220,30,40)
local OFF=Color3.fromRGB(45,45,50)
local BG=Color3.fromRGB(18,18,20)
local CD=Color3.fromRGB(35,35,38)
local TX=Color3.fromRGB(255,255,255)

local function on(b) if b then b.BackgroundColor3=AC b.TextColor3=Color3.fromRGB(255,255,255) local s=b:FindFirstChild("Stroke") if s then s.Color=Color3.fromRGB(255,60,70) s.Transparency=0 end end end
local function off(b) if b then b.BackgroundColor3=OFF b.TextColor3=TX local s=b:FindFirstChild("Stroke") if s then s.Color=Color3.fromRGB(70,70,75) s.Transparency=.5 end end end

-- GUI
local g=Instance.new("ScreenGui",p:WaitForChild("PlayerGui"))
g.Name="ShinobiHub" g.ResetOnSpawn=false g.IgnoreGuiInset=true g.DisplayOrder=999999

local f=Instance.new("Frame",g)
f.Size=UDim2.new(0,420,0,290)
f.Position=UDim2.new(.5,-210,.5,-145)
f.BackgroundColor3=BG f.BorderSizePixel=0 f.Active=true f.Draggable=true
Instance.new("UICorner",f).CornerRadius=UDim.new(0,12)
local fs=Instance.new("UIStroke",f) fs.Color=AC fs.Thickness=2

local sb=Instance.new("Frame",f)
sb.Size=UDim2.new(0,100,1,0)
sb.BackgroundColor3=CD sb.BorderSizePixel=0
Instance.new("UICorner",sb).CornerRadius=UDim.new(0,12)

local kj=Instance.new("TextLabel",sb)
kj.Size=UDim2.new(1,0,0,40) kj.Position=UDim2.new(0,0,0,6)
kj.BackgroundTransparency=1 kj.Text="忍" kj.TextColor3=AC kj.TextSize=36 kj.Font=Enum.Font.GothamBlack

local nms={"Speed","Hit","Extras"} local tB={} local pages={}
local ct=Instance.new("Frame",f)
ct.Size=UDim2.new(1,-110,1,-30) ct.Position=UDim2.new(0,105,0,15) ct.BackgroundTransparency=1

for i,n in ipairs(nms) do
    local b=Instance.new("TextButton",sb)
    b.Size=UDim2.new(1,-16,0,32) b.Position=UDim2.new(0,8,0,54+(i-1)*38)
    b.BackgroundColor3=OFF b.TextColor3=TX b.Text=n b.TextSize=12 b.Font=Enum.Font.GothamBold b.AutoButtonColor=false
    Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
    tB[i]=b
    local pp=Instance.new("Frame",ct)
    pp.Size=UDim2.new(1,0,1,0) pp.BackgroundTransparency=1 pp.Visible=(i==1)
    pages[i]=pp
end

local function st(n)
    for i,b in ipairs(tB) do
        b.BackgroundColor3=(i==n) and AC or OFF
        pages[i].Visible=(i==n)
    end
end
for i,b in ipairs(tB) do b.MouseButton1Click:Connect(function() st(i) end) end

local cb=Instance.new("TextButton",f)
cb.Size=UDim2.new(0,22,0,22) cb.Position=UDim2.new(1,-28,0,8)
cb.BackgroundColor3=OFF cb.TextColor3=AC cb.TextSize=13 cb.Text="X" cb.Font=Enum.Font.GothamBlack
Instance.new("UICorner",cb).CornerRadius=UDim.new(0,5)

local mi=Instance.new("TextButton",g)
mi.Size=UDim2.new(0,60,0,60) mi.Position=UDim2.new(0,20,.5,-30)
mi.BackgroundColor3=BG mi.Text="忍" mi.TextColor3=AC mi.TextSize=32 mi.Font=Enum.Font.GothamBlack
mi.Visible=false mi.Draggable=true
Instance.new("UICorner",mi).CornerRadius=UDim.new(1,0)
local mis=Instance.new("UIStroke",mi) mis.Color=AC mis.Thickness=2

cb.MouseButton1Click:Connect(function() f.Visible=false mi.Visible=true end)
mi.MouseButton1Click:Connect(function() mi.Visible=false f.Visible=true end)

local function mk(pp,t,y)
    local b=Instance.new("TextButton",pp)
    b.Size=UDim2.new(1,0,0,26) b.Position=UDim2.new(0,0,0,y)
    b.BackgroundColor3=OFF b.TextColor3=TX b.Text=t b.TextSize=11 b.Font=Enum.Font.GothamBold b.AutoButtonColor=false
    Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
    local s=Instance.new("UIStroke",b)
    s.Name="Stroke" s.Color=Color3.fromRGB(70,70,75) s.Thickness=1 s.Transparency=.5
    return b
end

local function lb(pp,t,y)
    local l=Instance.new("TextLabel",pp)
    l.Size=UDim2.new(1,0,0,14) l.Position=UDim2.new(0,0,0,y)
    l.BackgroundTransparency=1 l.Text=t l.TextColor3=TX l.TextSize=9 l.Font=Enum.Font.GothamBold
    l.TextXAlignment=Enum.TextXAlignment.Left
    return l
end

-- ═══════════════════════════════════════════
-- ABA SPEED
-- ═══════════════════════════════════════════
local sp=mk(pages[1],"Speed Bypass: OFF",0)
local vL=lb(pages[1],"Velocidade: 120",30)

local sB=Instance.new("Frame",pages[1])
sB.Size=UDim2.new(1,0,0,8) sB.Position=UDim2.new(0,0,0,46)
sB.BackgroundColor3=CD sB.BorderSizePixel=0
Instance.new("UICorner",sB).CornerRadius=UDim.new(1,0)

local sF=Instance.new("Frame",sB)
sF.Size=UDim2.new(.24,0,1,0) sF.BackgroundColor3=AC sF.BorderSizePixel=0
Instance.new("UICorner",sF).CornerRadius=UDim.new(1,0)

local mx=mk(pages[1],"MAX (500)",62)
local ds=mk(pages[1],"Desync: OFF",92)
local st1=lb(pages[1],"Pronto",124)

-- ═══════════════════════════════════════════
-- ABA HIT
-- ═══════════════════════════════════════════
local tp=mk(pages[2],"TP: OFF",0)
local fv=mk(pages[2],"FOV 120: OFF",30)
local rr=mk(pages[2],"Anti Ragdoll: OFF",60)
local st2=lb(pages[2],"Destino: 543,71,-369",92)

-- ═══════════════════════════════════════════
-- ABA EXTRAS
-- ═══════════════════════════════════════════
local gr=mk(pages[3],"Instant Grab: OFF",0)
local fb=mk(pages[3],"FPS Boost: OFF",30)
local rx=mk(pages[3],"RTX: OFF",60)
local hd=mk(pages[3],"HD Graphics: OFF",90)
local sh=mk(pages[3],"Server Hop",120,Color3.fromRGB(60,30,90))
local st3=lb(pages[3],"Pronto",150)

-- ═══════════════════════════════════════════
-- LÓGICA SPEED / DESYNC
-- ═══════════════════════════════════════════
local MN,MX,sv,so=16,500,120,false
local hC2,aC,cC,oI,mt
local TP=Vector3.new(543,71,-369)
local SR=30
local SM=200
local dsOn=false local dCF=CFrame.new() local dsL=nil

local function hk()
    if mt then return end
    if not getrawmetatable then return end
    pcall(function()
        local m=getrawmetatable(game)
        oI=m.__index
        setreadonly(m,false)
        m.__index=newcclosure(function(s,k)
            if not checkcaller() then
                if k=="WalkSpeed" and so and typeof(s)=="Instance" and s:IsA("Humanoid") then
                    local c=p.Character
                    if c and s:IsDescendantOf(c) then return 16 end
                end
                if k=="CFrame" and dsOn and typeof(s)=="Instance" and s.Name=="HumanoidRootPart" then
                    local c=p.Character
                    if c and s:IsDescendantOf(c) then return dCF end
                end
            end
            return oI(s,k)
        end)
        setreadonly(m,true)
        mt=true
    end)
end

local function dsS()
    if dsL then return end
    dsL=RS.Heartbeat:Connect(function()
        if not dsOn then return end
        local c=p.Character
        if not c then return end
        local r=c:FindFirstChild("HumanoidRootPart")
        if r then dCF=r.CFrame end
    end)
end

local function dsX()
    if dsL then dsL:Disconnect() dsL=nil end
end

local function an(c)
    local h=c:WaitForChild("Humanoid",5)
    if not h then return end
    local a=h:FindFirstChildOfClass("Animator")
    if not a then return end
    if aC then aC:Disconnect() end
    aC=a.AnimationPlayed:Connect(function(t)
        if not so then return end
        local n=string.lower(t.Name)
        if string.find(n,"run") or string.find(n,"walk") then
            pcall(function() t:Stop(.1) end)
        end
    end)
end

local function stSp()
    local c=p.Character
    if c then
        local h=c:FindFirstChildOfClass("Humanoid")
        if h then h.WalkSpeed=sv end
    end
    an(c)
    if hC2 then hC2:Disconnect() end
    hC2=RS.Heartbeat:Connect(function()
        if not so then return end
        local c=p.Character
        if not c then return end
        local h=c:FindFirstChildOfClass("Humanoid")
        local r=c:FindFirstChild("HumanoidRootPart")
        if not h then return end
        if h.Health<h.MaxHealth then pcall(function() h.Health=h.MaxHealth end) end
        local tg=sv
        if r then
            local d=(r.Position-TP).Magnitude
            if d<SR then tg=SM+(sv-SM)*(d/SR) end
        end
        if math.abs(h.WalkSpeed-tg)>2 then h.WalkSpeed=tg end
    end)
    if cC then cC:Disconnect() end
    cC=p.CharacterAdded:Connect(function(c)
        task.wait(.5)
        if so then
            local h=c:FindFirstChildOfClass("Humanoid")
            if h then h.WalkSpeed=sv end
            an(c)
        end
    end)
end

sp.MouseButton1Click:Connect(function()
    so=not so
    if so then
        on(sp) sp.Text="Speed Bypass: ON" st1.Text="Slow 30/min 200"
        hk() stSp()
    else
        off(sp) sp.Text="Speed Bypass: OFF" st1.Text="Pronto"
        if hC2 then hC2:Disconnect() hC2=nil end
        local c=p.Character
        if c then
            local h=c:FindFirstChildOfClass("Humanoid")
            if h then h.WalkSpeed=16 end
        end
    end
end)

ds.MouseButton1Click:Connect(function()
    dsOn=not dsOn
    if dsOn then
        on(ds) ds.Text="Desync: ON" dsS()
    else
        off(ds) ds.Text="Desync: OFF" dsX()
    end
end)

mx.MouseButton1Click:Connect(function()
    sv=500 vL.Text="Velocidade: 500"
    sF.Size=UDim2.new(1,0,1,0)
    if so then
        local c=p.Character
        if c then
            local h=c:FindFirstChildOfClass("Humanoid")
            if h then h.WalkSpeed=500 end
        end
    end
end)

local dr=false
local function up(pt)
    local v=math.floor(MN+(MX-MN)*pt)
    sv=v vL.Text="Velocidade: "..v
    sF.Size=UDim2.new(pt,0,1,0)
end
local function pc(i)
    return math.clamp((i.Position.X-sB.AbsolutePosition.X)/sB.AbsoluteSize.X,0,1)
end
sB.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
        dr=true up(pc(i))
    end
end)
sB.InputChanged:Connect(function(i)
    if dr and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
        up(pc(i))
    end
end)
sB.InputEnded:Connect(function() dr=false end)
U.InputChanged:Connect(function(i)
    if dr and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
        up(pc(i))
    end
end)
U.InputEnded:Connect(function() dr=false end)

-- ═══════════════════════════════════════════
-- LÓGICA HIT
-- ═══════════════════════════════════════════
local tOn=false local pc2=false
local function tpTo(po)
    local c=p.Character
    if not c then return end
    local r=c:FindFirstChild("HumanoidRootPart")
    if not r then return end
    if r.Anchored then r.Anchored=false end
    local rt=r.CFrame-r.CFrame.Position
    pcall(function() c:PivotTo(CFrame.new(po)*rt) end)
    pcall(function() r.AssemblyLinearVelocity=Vector3.zero end)
end
local function hd2(po,s)
    local c=p.Character
    if not c then return end
    local r=c:FindFirstChild("HumanoidRootPart")
    if not r then return end
    local rt=r.CFrame-r.CFrame.Position
    local tg=CFrame.new(po)*rt
    local et=tick()+s
    local cn
    cn=RS.Heartbeat:Connect(function()
        if tick()>=et then cn:Disconnect() return end
        if r and r.Parent then
            r.CFrame=tg
            r.AssemblyLinearVelocity=Vector3.zero
        end
    end)
    task.wait(s)
    if cn then cn:Disconnect() end
end
local function doR()
    if pc2 then return end
    pc2=true
    local c=p.Character
    local r=c and c:FindFirstChild("HumanoidRootPart")
    if not r then pc2=false return end
    local op=r.Position
    tpTo(TP) hd2(TP,.5) tpTo(op)
    pc2=false
end

tp.MouseButton1Click:Connect(function()
    tOn=not tOn
    if tOn then on(tp) tp.Text="TP: ON"
    else off(tp) tp.Text="TP: OFF" end
end)
PPS.PromptTriggered:Connect(function(_,w)
    if not tOn or w~=p or pc2 then return end
    task.spawn(doR)
end)

local fo=false local fO=nil
fv.MouseButton1Click:Connect(function()
    local c=workspace.CurrentCamera
    if not c then return end
    if not fo then
        fO=c.FieldOfView fo=true c.FieldOfView=120
        on(fv) fv.Text="FOV 120: ON"
    else
        fo=false c.FieldOfView=fO or 70
        off(fv) fv.Text="FOV 120: OFF"
    end
end)

local rrOn=false
local function dR(h)
    if not h then return end
    pcall(function()
        h:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
        h:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
        h:SetStateEnabled(Enum.HumanoidStateType.Physics,false)
        h:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,false)
        h.PlatformStand=false
    end)
end
local function aR(c)
    if not c then return end
    local h=c:WaitForChild("Humanoid",5)
    if not h then return end
    dR(h)
    h.StateChanged:Connect(function(_,ns)
        if not rrOn then return end
        if ns==Enum.HumanoidStateType.Ragdoll or ns==Enum.HumanoidStateType.FallingDown or ns==Enum.HumanoidStateType.Physics or ns==Enum.HumanoidStateType.PlatformStanding then
            task.wait(.05) dR(h)
            pcall(function() h:ChangeState(Enum.HumanoidStateType.Running) end)
        end
    end)
end

rr.MouseButton1Click:Connect(function()
    rrOn=not rrOn
    if rrOn then
        on(rr) rr.Text="Anti Ragdoll: ON" st2.Text="Ragdoll off"
        aR(p.Character)
        p.CharacterAdded:Connect(function(c) task.wait(.4) if rrOn then aR(c) end end)
        task.spawn(function()
            while rrOn do
                task.wait(.15)
                local c=p.Character
                if c then
                    local h=c:FindFirstChildOfClass("Humanoid")
                    if h then
                        pcall(function()
                            if h.PlatformStand then h.PlatformStand=false end
                            dR(h)
                        end)
                    end
                end
            end
        end)
    else
        off(rr) rr.Text="Anti Ragdoll: OFF" st2.Text="Pronto"
    end
end)

-- ═══════════════════════════════════════════
-- LÓGICA EXTRAS
-- ═══════════════════════════════════════════
local rxOn=false local rO,rM=nil,{}
rx.MouseButton1Click:Connect(function()
    rxOn=not rxOn
    if rxOn then
        on(rx) rx.Text="RTX: ON"
        rO={L.Ambient,L.OutdoorAmbient,L.Brightness,L.ClockTime,L.FogEnd,L.FogStart}
        L.Ambient=Color3.fromRGB(70,70,78)
        L.OutdoorAmbient=Color3.fromRGB(130,135,148)
        L.Brightness=3 L.ClockTime=17 L.FogEnd=100000 L.FogStart=0
        local atm=L:FindFirstChildOfClass("Atmosphere") or Instance.new("Atmosphere",L)
        atm.Density=.35 table.insert(rM,atm)
        local bl=L:FindFirstChildOfClass("BloomEffect") or Instance.new("BloomEffect",L)
        bl.Intensity=1.2 table.insert(rM,bl)
    else
        off(rx) rx.Text="RTX: OFF"
        if rO then
            local k={"Ambient","OutdoorAmbient","Brightness","ClockTime","FogEnd","FogStart"}
            for i,v in ipairs(rO) do pcall(function() L[k[i]]=v end) end
        end
        for _,i in ipairs(rM) do pcall(function() i:Destroy() end) end
        rM={}
    end
end)

local hdOn=false local hdL={}
hd.MouseButton1Click:Connect(function()
    hdOn=not hdOn
    if hdOn then
        on(hd) hd.Text="HD Graphics: ON"
    else
        off(hd) hd.Text="HD Graphics: OFF"
        if hdL.Ambient then
            L.Ambient=hdL.Ambient L.OutdoorAmbient=hdL.OutdoorAmbient L.Brightness=hdL.Brightness
            L.ClockTime=hdL.ClockTime L.GlobalShadows=hdL.GlobalShadows L.ShadowSoftness=hdL.ShadowSoftness
            L.EnvironmentDiffuseScale=hdL.EnvironmentDiffuseScale L.EnvironmentSpecularScale=hdL.EnvironmentSpecularScale
            L.ExposureCompensation=hdL.ExposureCompensation L.FogEnd=hdL.FogEnd L.FogStart=hdL.FogStart
        end
        hdL={}
    end
end)

task.spawn(function()
    while 1 do
        task.wait(.3)
        if hdOn then
            hdL.Ambient=L.Ambient hdL.OutdoorAmbient=L.OutdoorAmbient hdL.Brightness=L.Brightness
            hdL.ClockTime=L.ClockTime hdL.GlobalShadows=L.GlobalShadows hdL.ShadowSoftness=L.ShadowSoftness
            hdL.EnvironmentDiffuseScale=L.EnvironmentDiffuseScale hdL.EnvironmentSpecularScale=L.EnvironmentSpecularScale
            hdL.ExposureCompensation=L.ExposureCompensation hdL.FogEnd=L.FogEnd hdL.FogStart=L.FogStart
            L.Ambient=Color3.fromRGB(95,95,105)
            L.OutdoorAmbient=Color3.fromRGB(150,150,165)
            L.Brightness=3.5 L.ClockTime=14 L.GlobalShadows=true L.ShadowSoftness=0.05
            L.EnvironmentDiffuseScale=1 L.EnvironmentSpecularScale=1 L.ExposureCompensation=0.35
            L.FogEnd=1000000 L.FogStart=1000000
            local atm=L:FindFirstChildOfClass("Atmosphere")
            if atm then atm.Density=0.25 end
            local bl=L:FindFirstChildOfClass("BloomEffect")
            if bl then bl.Intensity=1.5 bl.Size=28 bl.Threshold=0.85 end
        end
    end
end)

local fbo=false local fbL={}
local function kO(v)
    local c=v.Parent
    while c do
        if c==p.Character then return end
        if c==workspace then break end
        c=c.Parent
    end
    pcall(function()
        if v:IsA("Decal") or v:IsA("Texture") then v.Transparency=1
        elseif v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") or v:IsA("Trail") then
            v.Enabled=false
        end
    end)
end
fb.MouseButton1Click:Connect(function()
    fbo=not fbo
    if fbo then
        on(fb) fb.Text="FPS Boost: ON"
    else
        off(fb) fb.Text="FPS Boost: OFF"
        if fbL.Ambient then
            L.Ambient=fbL.Ambient L.Brightness=fbL.Brightness
            L.GlobalShadows=fbL.GlobalShadows L.FogEnd=fbL.FogEnd L.FogStart=fbL.FogStart
        end
        fbL={}
    end
end)
task.spawn(function()
    while 1 do
        task.wait(.5)
        if fbo then
            fbL.Ambient=L.Ambient fbL.Brightness=L.Brightness fbL.GlobalShadows=L.GlobalShadows
            fbL.FogEnd=L.FogEnd fbL.FogStart=L.FogStart
            L.Ambient=Color3.fromRGB(150,150,150) L.Brightness=2
            L.GlobalShadows=false L.FogEnd=1000000 L.FogStart=1000000
            for _,v in ipairs(workspace:GetDescendants()) do kO(v) end
        end
    end
end)

local go=false local gS={}
local function fx(p2)
    if not p2:IsA("ProximityPrompt") then return end
    if not go then return end
    if not gS[p2] then gS[p2]=p2.HoldDuration end
    pcall(function() p2.HoldDuration=0 end)
end
gr.MouseButton1Click:Connect(function()
    go=not go
    if go then
        on(gr) gr.Text="Instant Grab: ON" st3.Text="Hold=0"
        for _,v in ipairs(workspace:GetDescendants()) do
            if v:IsA("ProximityPrompt") then fx(v) end
        end
        workspace.DescendantAdded:Connect(function(v)
            if go and v:IsA("ProximityPrompt") then
                task.wait(.1) fx(v)
            end
        end)
    else
        off(gr) gr.Text="Instant Grab: OFF" st3.Text="Pronto"
        for k,d in pairs(gS) do
            if k and k.Parent then pcall(function() k.HoldDuration=d end) end
        end
        gS={}
    end
end)
task.spawn(function()
    while 1 do
        task.wait(.3)
        if go then
            for k,_ in pairs(gS) do
                if k and k.Parent and k.HoldDuration~=0 then
                    pcall(function() k.HoldDuration=0 end)
                end
            end
        end
    end
end)

-- ═══════════════════════════════════════════
-- SERVER HOP (integração via loadstring)
-- ═══════════════════════════════════════════
sh.MouseButton1Click:Connect(function()
    pcall(function()
        loadstring(game:HttpGet("https://pastefy.app/YoZocJ8O/raw"))()
    end)
end)

st(1)
print("忍 ShinobiHub + Server Hop OK")
