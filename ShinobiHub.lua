local plr=game:GetService("Players").LocalPlayer
local function gp()if gethui then local o,h=pcall(gethui)if o and h then return h end end return plr:WaitForChild("PlayerGui")end
local PPS=game:GetService("ProximityPromptService")local RS=game:GetService("RunService")local LG=game:GetService("Lighting")local SS=game:GetService("SoundService")local D=game:GetService("Debris")local UIS=game:GetService("UserInputService")
local function S(i,v,p)pcall(function()local x=Instance.new("Sound",SS)x.SoundId="rbxassetid://"..i x.Volume=.05 x.PlaybackSpeed=p or 1 x:Play()D:AddItem(x,5)end)end
local function sOn()S("5232182059",.08,1.6)end
local function sOff()S("5232182059",.07,1.4)end
for _,n in ipairs({"ShinobiHub"})do local o=plr.PlayerGui:FindFirstChild(n)if o then o:Destroy()end end
local RB=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(255,0,0)),ColorSequenceKeypoint.new(.16,Color3.fromRGB(255,150,0)),ColorSequenceKeypoint.new(.33,Color3.fromRGB(255,255,0)),ColorSequenceKeypoint.new(.5,Color3.fromRGB(0,255,100)),ColorSequenceKeypoint.new(.66,Color3.fromRGB(0,180,255)),ColorSequenceKeypoint.new(.83,Color3.fromRGB(150,0,255)),ColorSequenceKeypoint.new(1,Color3.fromRGB(255,0,0))})
local tg,tl
local function mkTag(c)if not c then return end local h=c:FindFirstChild("Head")or c:WaitForChild("Head",5)if not h then return end if tg and tg.Parent then tg:Destroy()end tg=Instance.new("BillboardGui",h)tg.Size=UDim2.new(0,260,0,34)tg.StudsOffset=Vector3.new(0,3.2,0)tg.AlwaysOnTop=true tg.MaxDistance=200 local f=Instance.new("Frame",tg)f.Size=UDim2.new(1,0,1,0)f.BackgroundColor3=Color3.fromRGB(0,0,0)f.BackgroundTransparency=.15 f.BorderSizePixel=0 Instance.new("UICorner",f).CornerRadius=UDim.new(0,8)local s=Instance.new("UIStroke",f)s.Color=Color3.fromRGB(255,30,30)s.Thickness=1.5 tl=Instance.new("TextLabel",f)tl.Size=UDim2.new(1,-8,1,0)tl.Position=UDim2.new(0,4,0,0)tl.BackgroundTransparency=1 tl.Text="by:@christisloveisnx"tl.TextColor3=Color3.fromRGB(255,255,255)tl.TextSize=15 tl.Font=Enum.Font.GothamBlack end
task.spawn(function()while true do if tl and tl.Parent then tl.TextColor3=Color3.fromHSV(tick()%1,1,1)end RS.RenderStepped:Wait()end end)
local function hC(c)if not c then return end task.spawn(function()c:WaitForChild("Head",10)mkTag(c)end)end
hC(plr.Character or plr.CharacterAdded:Wait())plr.CharacterAdded:Connect(hC)
local W,H=280,370
local gui=Instance.new("ScreenGui",gp())gui.Name="ShinobiHub"gui.ResetOnSpawn=false gui.IgnoreGuiInset=true gui.DisplayOrder=999999
local fr=Instance.new("Frame",gui)fr.Size=UDim2.new(0,W,0,H)fr.Position=UDim2.new(0.5,-W/2,0.5,-H/2)fr.BackgroundColor3=Color3.fromRGB(6,6,10)fr.BorderSizePixel=0 fr.Active=true fr.Draggable=true
Instance.new("UICorner",fr).CornerRadius=UDim.new(0,16)
local fS=Instance.new("UIStroke",fr)fS.Color=Color3.fromRGB(200,20,30)fS.Thickness=2.5
local kj=Instance.new("TextLabel",fr)kj.Size=UDim2.new(0,44,0,44)kj.Position=UDim2.new(0,10,0,4)kj.BackgroundTransparency=1 kj.Text="🗡️"kj.TextColor3=Color3.fromRGB(255,255,255)kj.TextSize=32 kj.Font=Enum.Font.GothamBlack
task.spawn(function()while kj.Parent do kj.Rotation=(kj.Rotation+3)%360 task.wait(.03)end end)
local ttl=Instance.new("TextLabel",fr)ttl.Size=UDim2.new(1,-70,0,22)ttl.Position=UDim2.new(0,60,0,6)ttl.BackgroundTransparency=1 ttl.Text="🗡️ ShinobiHub"ttl.TextColor3=Color3.fromRGB(255,255,255)ttl.TextSize=17 ttl.Font=Enum.Font.GothamBlack ttl.TextXAlignment=Enum.TextXAlignment.Left
local sb=Instance.new("TextLabel",fr)sb.Size=UDim2.new(1,-70,0,14)sb.Position=UDim2.new(0,60,0,28)sb.BackgroundTransparency=1 sb.Text="By:christisloveisnx"sb.TextColor3=Color3.fromRGB(255,200,50)sb.TextSize=10 sb.Font=Enum.Font.GothamBold sb.TextXAlignment=Enum.TextXAlignment.Left
task.spawn(function()while sb.Parent do sb.TextColor3=Color3.fromRGB(255,200,50)task.wait(.45)sb.TextColor3=Color3.fromRGB(255,130,30)task.wait(.45)end end)
local mB=Instance.new("TextButton",fr)mB.Size=UDim2.new(0,28,0,28)mB.Position=UDim2.new(1,-36,0,12)mB.BackgroundColor3=Color3.fromRGB(120,10,15)mB.TextColor3=Color3.fromRGB(255,255,255)mB.TextSize=18 mB.Text="—"mB.Font=Enum.Font.GothamBlack
Instance.new("UICorner",mB).CornerRadius=UDim.new(0,8)
local dv=Instance.new("Frame",fr)dv.Size=UDim2.new(1,-24,0,1)dv.Position=UDim2.new(0,12,0,56)dv.BackgroundColor3=Color3.fromRGB(200,20,30)dv.BackgroundTransparency=.4
local tb=Instance.new("Frame",fr)tb.Size=UDim2.new(1,-24,0,32)tb.Position=UDim2.new(0,12,0,66)tb.BackgroundTransparency=1
local names={"⚡ Speed","🗡️ Hit","⚙️ Extras"}local tBtns={}local pages={}
local ct=Instance.new("Frame",fr)ct.Size=UDim2.new(1,-24,1,-134)ct.Position=UDim2.new(0,12,0,106)ct.BackgroundTransparency=1
for i,n in ipairs(names)do local b=Instance.new("TextButton",tb)b.Size=UDim2.new(1/3,-3,1,0)b.Position=UDim2.new((i-1)/3,0,0,0)b.BackgroundColor3=Color3.fromRGB(15,15,22)b.TextColor3=Color3.fromRGB(140,140,155)b.Text=n b.TextSize=10 b.Font=Enum.Font.GothamBold b.AutoButtonColor=false Instance.new("UICorner",b).CornerRadius=UDim.new(0,8)tBtns[i]=b local p=Instance.new("Frame",ct)p.Size=UDim2.new(1,0,1,0)p.BackgroundTransparency=1 p.Visible=(i==1)pages[i]=p end
local function st(n)for i,b in ipairs(tBtns)do b.BackgroundColor3=(i==n)and Color3.fromRGB(120,10,15)or Color3.fromRGB(15,15,22)b.TextColor3=(i==n)and Color3.fromRGB(255,255,255)or Color3.fromRGB(140,140,155)pages[i].Visible=(i==n)end end
for i,b in ipairs(tBtns)do b.MouseButton1Click:Connect(function()st(i)end)end
local promo=Instance.new("TextLabel",fr)promo.Size=UDim2.new(1,-24,0,18)promo.Position=UDim2.new(0,12,1,-22)promo.BackgroundTransparency=1 promo.Text="⭐ Promotional channel: helloguysiamsweetchicken ⭐"promo.TextColor3=Color3.fromRGB(180,180,200)promo.TextSize=10 promo.Font=Enum.Font.GothamBold promo.TextStrokeTransparency=.4 promo.TextStrokeColor3=Color3.fromRGB(0,0,0)
task.spawn(function()while promo.Parent do promo.TextColor3=Color3.fromRGB(180,180,200)task.wait(.5)promo.TextColor3=Color3.fromRGB(255,200,50)task.wait(.5)end end)
local mi=Instance.new("TextButton",gui)mi.Size=UDim2.new(0,90,0,90)mi.Position=UDim2.new(0,20,0.5,-45)mi.BackgroundColor3=Color3.fromRGB(0,0,0)mi.BackgroundTransparency=.2 mi.Text="🗡️"mi.TextColor3=Color3.fromRGB(255,255,255)mi.TextSize=48 mi.Font=Enum.Font.GothamBlack mi.Visible=false mi.Draggable=true mi.AutoButtonColor=false
Instance.new("UICorner",mi).CornerRadius=UDim.new(1,0)
local mis=Instance.new("UIStroke",mi)mis.Color=Color3.fromRGB(200,20,30)mis.Thickness=2
task.spawn(function()while mi.Parent do mis.Transparency=.3+math.abs(math.sin(tick()*2))*.4 mi.Rotation=(mi.Rotation+2)%360 task.wait(.03)end end)
mB.MouseButton1Click:Connect(function()sOff()fr.Visible=false mi.Visible=true end)
mi.MouseButton1Click:Connect(function()sOn()mi.Visible=false fr.Visible=true end)
local function mBtn(p,t,y,c)local b=Instance.new("TextButton",p)b.Size=UDim2.new(1,0,0,34)b.Position=UDim2.new(0,0,0,y)b.BackgroundColor3=c or Color3.fromRGB(120,10,15)b.TextColor3=Color3.fromRGB(255,255,255)b.Text=t b.TextSize=12 b.Font=Enum.Font.GothamBlack b.AutoButtonColor=false Instance.new("UICorner",b).CornerRadius=UDim.new(0,10)local s=Instance.new("UIStroke",b)s.Color=Color3.fromRGB(255,40,50)s.Thickness=1 s.Transparency=.4 return b end
local function mL(p,t,y,c,s)local l=Instance.new("TextLabel",p)l.Size=UDim2.new(1,0,0,18)l.Position=UDim2.new(0,0,0,y)l.BackgroundTransparency=1 l.Text=t l.TextColor3=c or Color3.fromRGB(180,180,190)l.TextSize=s or 10 l.Font=Enum.Font.GothamBold return l end
local spd=mBtn(pages[1],"⚡ Speed Bypass: OFF",0)
local vL=mL(pages[1],"Velocidade: 120",44,Color3.fromRGB(255,255,255),12)
local sBg=Instance.new("Frame",pages[1])sBg.Size=UDim2.new(1,0,0,14)sBg.Position=UDim2.new(0,0,0,70)sBg.BackgroundColor3=Color3.fromRGB(50,40,25)sBg.BorderSizePixel=0
Instance.new("UICorner",sBg).CornerRadius=UDim.new(1,0)
local sF=Instance.new("Frame",sBg)sF.Size=UDim2.new(.36,0,1,0)sF.BackgroundColor3=Color3.fromRGB(255,200,50)sF.BorderSizePixel=0
Instance.new("UICorner",sF).CornerRadius=UDim.new(1,0)
local sK=Instance.new("Frame",sBg)sK.Size=UDim2.new(0,22,0,22)sK.Position=UDim2.new(.36,-11,.5,-11)sK.BackgroundColor3=Color3.fromRGB(255,255,255)sK.BorderSizePixel=0 sK.ZIndex=2
Instance.new("UICorner",sK).CornerRadius=UDim.new(1,0)
local maxB=mBtn(pages[1],"🔥 MÁXIMO (300)",96,Color3.fromRGB(180,60,10))maxB.TextSize=11
local st1=mL(pages[1],"Pronto",136)
local tpB=mBtn(pages[2],"⚔ TP: OFF",0)
local fvB=mBtn(pages[2],"👁 FOV 120: OFF",38,Color3.fromRGB(60,50,20))
local st2=mL(pages[2],"Destino: 543, 71, -369",76)
local grB=mBtn(pages[3],"🎯 Instant Grab: OFF",0,Color3.fromRGB(60,50,20))
local fbB=mBtn(pages[3],"⚡ FPS Boost: OFF",38)
local rx2=mBtn(pages[3],"🏔️ RTX: OFF",76,Color3.fromRGB(60,50,20))
local st3=mL(pages[3],"Pronto",118)
local MI=16 local MA=300 local spdVal=120 local speedOn=false
local hC2,aC,cC,oI,mt
local TP_POS=Vector3.new(543,71,-369)
local SLOW_RADIUS=120
local SLOW_MIN=40
local function hook()if mt then return end if not getrawmetatable then return end pcall(function()local m=getrawmetatable(game)oI=m.__index setreadonly(m,false)m.__index=newcclosure(function(s,k)if not checkcaller()then if k=="WalkSpeed"and speedOn and typeof(s)=="Instance"and s:IsA("Humanoid")then local c=plr.Character if c and s:IsDescendantOf(c)then return 16 end end end return oI(s,k)end)setreadonly(m,true)mt=true end)end
local function anim(c)if not c then return end local h=c:WaitForChild("Humanoid",5)if not h then return end local a=h:FindFirstChildOfClass("Animator")if not a then return end if aC then aC:Disconnect()end aC=a.AnimationPlayed:Connect(function(t)if not speedOn then return end local n=string.lower(t.Name)if string.find(n,"run")or string.find(n,"walk")then pcall(function()t:Stop(.1)end)end end)end
local function stSp()
local c=plr.Character if c then local h=c:FindFirstChildOfClass("Humanoid")if h then h.WalkSpeed=spdVal end end anim(c)
if hC2 then hC2:Disconnect()end
hC2=RS.Heartbeat:Connect(function()if not speedOn then return end local ch=plr.Character if not ch then return end local h=ch:FindFirstChildOfClass("Humanoid")local r=ch:FindFirstChild("HumanoidRootPart")if not h then return end if h.Health<h.MaxHealth then pcall(function()h.Health=h.MaxHealth end)end local target=spdVal if r then local dist=(r.Position-TP_POS).Magnitude if dist<SLOW_RADIUS then target=SLOW_MIN+(spdVal-SLOW_MIN)*(dist/SLOW_RADIUS)end end if math.abs(h.WalkSpeed-target)>2 then h.WalkSpeed=target end end)
if cC then cC:Disconnect()end cC=plr.CharacterAdded:Connect(function(ch)task.wait(.5)if speedOn then local h=ch:FindFirstChildOfClass("Humanoid")if h then h.WalkSpeed=spdVal end anim(ch)end end)end
spd.MouseButton1Click:Connect(function()speedOn=not speedOn if speedOn then sOn()hook()spd.BackgroundColor3=Color3.fromRGB(20,160,60)spd.Text="⚡ Speed Bypass: ON"st1.Text="Slow antes da chegada ativo"st1.TextColor3=Color3.fromRGB(80,220,130)stSp()else sOff()spd.BackgroundColor3=Color3.fromRGB(120,10,15)spd.Text="⚡ Speed Bypass: OFF"st1.Text="Speed off"st1.TextColor3=Color3.fromRGB(180,180,190)if hC2 then hC2:Disconnect()hC2=nil end local c=plr.Character if c then local h=c:FindFirstChildOfClass("Humanoid")if h then h.WalkSpeed=16 end end end end)
maxB.MouseButton1Click:Connect(function()spdVal=300 vL.Text="Velocidade: 300"sF.Size=UDim2.new(1,0,1,0)sK.Position=UDim2.new(1,-11,.5,-11)S("5232182059",.08,1.6)st1.Text="🔥 Máximo: 300"st1.TextColor3=Color3.fromRGB(255,180,50)if speedOn then local c=plr.Character if c then local h=c:FindFirstChildOfClass("Humanoid")if h then h.WalkSpeed=300 end end end end)
local dr=false
local function upd(p)local v=math.floor(MI+(MA-MI)*p)spdVal=v vL.Text="Velocidade: "..v sF.Size=UDim2.new(p,0,1,0)sK.Position=UDim2.new(p,-11,.5,-11)end
local function pc(i)return math.clamp((i.Position.X-sBg.AbsolutePosition.X)/sBg.AbsoluteSize.X,0,1)end
sBg.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dr=true upd(pc(i))end end)
sBg.InputChanged:Connect(function(i)if dr and(i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch)then upd(pc(i))end end)
sBg.InputEnded:Connect(function()dr=false end)
UIS.InputChanged:Connect(function(i)if dr and(i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch)then upd(pc(i))end end)
UIS.InputEnded:Connect(function()dr=false end)
local tp=false local proc=false local CD=.5
local function tpTo(p)local c=plr.Character if not c then return end local r=c:FindFirstChild("HumanoidRootPart")if not r then return end if r.Anchored then r.Anchored=false end local rt=r.CFrame-r.CFrame.Position local t=CFrame.new(p)*rt pcall(function()c:PivotTo(t)end)pcall(function()r.CFrame=t end)pcall(function()r.AssemblyLinearVelocity=Vector3.zero end)end
local function hold(p,s)local c=plr.Character if not c then return end local r=c:FindFirstChild("HumanoidRootPart")if not r then return end local rt=r.CFrame-r.CFrame.Position local t=CFrame.new(p)*rt local et=tick()+s local cn cn=RS.Heartbeat:Connect(function()if tick()>=et then cn:Disconnect()return end if r and r.Parent then r.CFrame=t r.AssemblyLinearVelocity=Vector3.zero end end)task.wait(s)if cn then cn:Disconnect()end end
local function doR()if proc then return end proc=true local c=plr.Character local r=c and c:FindFirstChild("HumanoidRootPart")if not r then proc=false return end local op=r.Position S("5232182059",.06,.9)tpTo(TP_POS)hold(TP_POS,CD)S("5232182059",.06,.9)tpTo(op)task.wait(.1)proc=false end
tpB.MouseButton1Click:Connect(function()tp=not tp if tp then sOn()tpB.BackgroundColor3=Color3.fromRGB(20,160,60)tpB.Text="⚔ TP: ON"else sOff()tpB.BackgroundColor3=Color3.fromRGB(120,10,15)tpB.Text="⚔ TP: OFF"end end)
PPS.PromptTriggered:Connect(function(_,w)if not tp or w~=plr or proc then return end task.spawn(doR)end)
local fovOn=false local fovOrig=nil
fvB.MouseButton1Click:Connect(function()local c=workspace.CurrentCamera if not c then return end if not fovOn then fovOrig=c.FieldOfView fovOn=true c.FieldOfView=120 fvB.BackgroundColor3=Color3.fromRGB(20,160,60)fvB.Text="👁 FOV 120: ON"sOn()else fovOn=false c.FieldOfView=fovOrig or 70 fvB.BackgroundColor3=Color3.fromRGB(60,50,20)fvB.Text="👁 FOV 120: OFF"sOff()end end)
task.spawn(function()while true do if fovOn then local c=workspace.CurrentCamera if c and c.FieldOfView~=120 then c.FieldOfView=120 end end task.wait(.3)end end)
local rtxOn=false local rO,rM=nil,{}
local function tRtx()rtxOn=not rtxOn if rtxOn then rO={LG.Ambient,LG.OutdoorAmbient,LG.Brightness,LG.ClockTime,LG.GlobalShadows,LG.ShadowSoftness,LG.EnvironmentDiffuseScale,LG.EnvironmentSpecularScale,LG.ExposureCompensation,LG.FogEnd,LG.FogStart,LG.ColorShift_Top,LG.ColorShift_Bottom}LG.Ambient=Color3.fromRGB(70,70,78)LG.OutdoorAmbient=Color3.fromRGB(130,135,148)LG.Brightness=3 LG.ClockTime=17 LG.GlobalShadows=true LG.ShadowSoftness=.15 LG.EnvironmentDiffuseScale=1 LG.EnvironmentSpecularScale=1 LG.ExposureCompensation=.35 LG.FogEnd=100000 LG.FogStart=0 LG.ColorShift_Top=Color3.fromRGB(255,240,220)LG.ColorShift_Bottom=Color3.fromRGB(30,30,45)
local atm=LG:FindFirstChildOfClass("Atmosphere")or Instance.new("Atmosphere",LG)atm.Density=.35 atm.Offset=.15 atm.Glare=.6 atm.Haze=1.5 table.insert(rM,atm)
local sr=LG:FindFirstChildOfClass("SunRaysEffect")or Instance.new("SunRaysEffect",LG)sr.Intensity=.15 sr.Spread=.9 table.insert(rM,sr)
local bl=LG:FindFirstChildOfClass("BloomEffect")or Instance.new("BloomEffect",LG)bl.Intensity=1.2 bl.Size=24 bl.Threshold=.9 table.insert(rM,bl)
local cc=LG:FindFirstChildOfClass("ColorCorrectionEffect")or Instance.new("ColorCorrectionEffect",LG)cc.Brightness=.02 cc.Contrast=.15 cc.Saturation=.15 table.insert(rM,cc)
rx2.BackgroundColor3=Color3.fromRGB(20,160,60)rx2.Text="🏔️ RTX: ON"sOn()else if rO then local k={"Ambient","OutdoorAmbient","Brightness","ClockTime","GlobalShadows","ShadowSoftness","EnvironmentDiffuseScale","EnvironmentSpecularScale","ExposureCompensation","FogEnd","FogStart","ColorShift_Top","ColorShift_Bottom"}for i,v in ipairs(rO)do pcall(function()LG[k[i]]=v end)end end for _,i in ipairs(rM)do pcall(function()i:Destroy()end)end rM={}rx2.BackgroundColor3=Color3.fromRGB(60,50,20)rx2.Text="🏔️ RTX: OFF"sOff()end end
rx2.MouseButton1Click:Connect(tRtx)
local grabOn=false local grS={}
local function fx(p)if not p:IsA("ProximityPrompt")then return end if not grabOn then return end if not grS[p]then grS[p]=p.HoldDuration end pcall(function()p.HoldDuration=0 end)end
grB.MouseButton1Click:Connect(function()grabOn=not grabOn if grabOn then sOn()grB.BackgroundColor3=Color3.fromRGB(20,160,60)grB.Text="🎯 Instant Grab: ON"st3.Text="Hold=0"for _,v in ipairs(workspace:GetDescendants())do if v:IsA("ProximityPrompt")then fx(v)end end workspace.DescendantAdded:Connect(function(v)if grabOn and v:IsA("ProximityPrompt")then task.wait(.1)fx(v)end end)RS.Heartbeat:Connect(function()if not grabOn then return end for p,_ in pairs(grS)do if p and p.Parent and p.HoldDuration~=0 then pcall(function()p.HoldDuration=0 end)end end end)else sOff()grB.BackgroundColor3=Color3.fromRGB(60,50,20)grB.Text="🎯 Instant Grab: OFF"st3.Text="Pronto"for p,d in pairs(grS)do if p and p.Parent then pcall(function()p.HoldDuration=d end)end end grS={}end end)
local fbOn=false
local function kO(v)local c=v.Parent while c do if c==plr.Character then return end if c==workspace then break end c=c.Parent end pcall(function()if v:IsA("Decal")or v:IsA("Texture")then v.Transparency=1 elseif v:IsA("ParticleEmitter")or v:IsA("Smoke")or v:IsA("Fire")or v:IsA("Sparkles")or v:IsA("Trail")then v.Enabled=false end end)end
fbB.MouseButton1Click:Connect(function()fbOn=not fbOn if fbOn then sOn()fbB.BackgroundColor3=Color3.fromRGB(20,160,60)fbB.Text="⚡ FPS Boost: ON"st3.Text="Gráficos leves"LG.Ambient=Color3.fromRGB(150,150,150)LG.Brightness=2 LG.GlobalShadows=false LG.FogEnd=1000000 LG.FogStart=1000000 for _,v in ipairs(workspace:GetDescendants())do kO(v)end for _,v in ipairs(LG:GetChildren())do if v:IsA("Atmosphere")or v:IsA("PostEffect")then pcall(function()v.Enabled=false end)end end else sOff()fbB.BackgroundColor3=Color3.fromRGB(120,10,15)fbB.Text="⚡ FPS Boost: OFF"st3.Text="Pronto"LG.Ambient=Color3.fromRGB(70,70,78)LG.Brightness=3 LG.GlobalShadows=true LG.FogEnd=100000 for _,v in ipairs(LG:GetChildren())do if v:IsA("Atmosphere")or v:IsA("PostEffect")then pcall(function()v.Enabled=true end)end end end end)
st(1)
sOn()
print("🗡️ ShinobiHub — By:christisloveisnx")
