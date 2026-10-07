local plr=game.Players.LocalPlayer
local pg=plr:WaitForChild("PlayerGui")
local rs=game.ReplicatedStorage:WaitForChild("FoundryRemotes")
local vim=game:GetService("VirtualInputManager")

local old=pg:FindFirstChild("SlanceHub")
if old then old:Destroy()end

local state={offline=true,free=true,playtime=true,index=true,rebirth=true,boss=true,shoot=false,collect=false,sell=false,buy=true}
local running=false
local thread

local screen=Instance.new("ScreenGui")
screen.Name="SlanceHub"
screen.ResetOnSpawn=false
screen.IgnoreGuiInset=true
screen.Parent=pg

local toggle=Instance.new("TextButton")
toggle.Name="Toggle"
toggle.Size=UDim2.new(0,56,0,56)
toggle.Position=UDim2.new(1,-80,0,200)
toggle.BackgroundColor3=Color3.fromRGB(25,25,25)
toggle.Text="s"
toggle.TextColor3=Color3.fromRGB(220,220,220)
toggle.Font=Enum.Font.Code
toggle.TextSize=24
toggle.BorderSizePixel=0
toggle.Draggable=true
toggle.Parent=screen

local tc=Instance.new("UICorner")
tc.CornerRadius=UDim.new(0,1)
tc.Parent=toggle

local ts=Instance.new("UIStroke")
ts.Color=Color3.fromRGB(80,80,80)
ts.Thickness=2
ts.Parent=toggle

local main=Instance.new("Frame")
main.Name="Main"
main.Size=UDim2.new(0,300,0,520)
main.Position=UDim2.new(0.5,-150,0.5,-260)
main.BackgroundColor3=Color3.fromRGB(18,18,18)
main.BorderSizePixel=0
main.Visible=false
main.Draggable=true
main.Parent=screen

local mc=Instance.new("UICorner")
mc.CornerRadius=UDim.new(0,12)
mc.Parent=main

local ms=Instance.new("UIStroke")
ms.Color=Color3.fromRGB(60,60,60)
ms.Thickness=1.5
ms.Parent=main

local title=Instance.new("TextLabel")
title.Size=UDim2.new(1,0,0,38)
title.BackgroundColor3=Color3.fromRGB(28,28,28)
title.Text="slance hub"
title.TextColor3=Color3.fromRGB(230,230,230)
title.Font=Enum.Font.Code
title.TextSize=15
title.BorderSizePixel=0
title.Parent=main

local trc=Instance.new("UICorner")
trc.CornerRadius=UDim.new(0,12)
trc.Parent=title

local xBtn=Instance.new("TextButton")
xBtn.Size=UDim2.new(0,38,0,38)
xBtn.Position=UDim2.new(1,-38,0,0)
xBtn.BackgroundTransparency=1
xBtn.Text="x"
xBtn.TextColor3=Color3.fromRGB(200,80,80)
xBtn.Font=Enum.Font.Code
xBtn.TextSize=20
xBtn.Parent=title

xBtn.MouseButton1Click:Connect(function()
main.Visible=false
toggle.Visible=true
end)

toggle.MouseButton1Click:Connect(function()
main.Visible=true
toggle.Visible=false
end)

local list=Instance.new("ScrollingFrame")
list.Name="List"
list.Size=UDim2.new(1,-16,1,-100)
list.Position=UDim2.new(0,8,0,44)
list.BackgroundTransparency=1
list.BorderSizePixel=0
list.ScrollBarThickness=4
list.CanvasSize=UDim2.new(0,0,0,0)
list.AutomaticCanvasSize=Enum.AutomaticSize.Y
list.Parent=main

local lay=Instance.new("UIListLayout")
lay.Padding=UDim.new(0,6)
lay.SortOrder=Enum.SortOrder.LayoutOrder
lay.Parent=list

local function row(text,key)
local r=Instance.new("Frame")
r.Size=UDim2.new(1,-8,0,34)
r.BackgroundColor3=Color3.fromRGB(30,30,30)
r.BorderSizePixel=0
r.Parent=list
local rc=Instance.new("UICorner")
rc.CornerRadius=UDim.new(0,6)
rc.Parent=r
local l=Instance.new("TextLabel")
l.Size=UDim2.new(1,-60,1,0)
l.Position=UDim2.new(0,10,0,0)
l.BackgroundTransparency=1
l.Text=text
l.TextColor3=Color3.fromRGB(210,210,210)
l.Font=Enum.Font.Code
l.TextSize=13
l.TextXAlignment=Enum.TextXAlignment.Left
l.Parent=r
local b=Instance.new("TextButton")
b.Size=UDim2.new(0,44,0,22)
b.Position=UDim2.new(1,-52,0.5,-11)
b.BackgroundColor3=state[key]and Color3.fromRGB(60,140,80)or Color3.fromRGB(60,60,60)
b.Text=""
b.AutoButtonColor=false
b.Parent=r
local bc=Instance.new("UICorner")
bc.CornerRadius=UDim.new(0,11)
bc.Parent=b
local d=Instance.new("Frame")
d.Size=UDim2.new(0,18,0,18)
d.Position=state[key]and UDim2.new(1,-20,0.5,-9)or UDim2.new(0,2,0.5,-9)
d.BackgroundColor3=Color3.fromRGB(230,230,230)
d.BorderSizePixel=0
d.Parent=b
local dc=Instance.new("UICorner")
dc.CornerRadius=UDim.new(0,1)
dc.Parent=d
b.MouseButton1Click:Connect(function()
state[key]=not state[key]
if state[key]then
b.BackgroundColor3=Color3.fromRGB(60,140,80)
d.Position=UDim2.new(1,-20,0.5,-9)
else
b.BackgroundColor3=Color3.fromRGB(60,60,60)
d.Position=UDim2.new(0,2,0.5,-9)
end
end)
end

row("offline earnings","offline")
row("free rewards","free")
row("playtime rewards","playtime")
row("index claim","index")
row("rebirth","rebirth")
row("boss join","boss")
row("auto shoot","shoot")
row("auto collect pets","collect")
row("auto sell","sell")
row("auto buy dmg/gun","buy")

local sb=Instance.new("TextButton")
sb.Name="Btn"
sb.Size=UDim2.new(1,-16,0,38)
sb.Position=UDim2.new(0,8,1,-46)
sb.BackgroundColor3=Color3.fromRGB(50,120,70)
sb.Text="start"
sb.TextColor3=Color3.fromRGB(240,240,240)
sb.Font=Enum.Font.Code
sb.TextSize=15
sb.BorderSizePixel=0
sb.Parent=main

local sbc=Instance.new("UICorner")
sbc.CornerRadius=UDim.new(0,8)
sbc.Parent=sb

local function fireA(n)
local r=rs:FindFirstChild(n)
if not r then return end
pcall(function()
if r:IsA("RemoteEvent")then r:FireServer()
elseif r:IsA("RemoteFunction")then r:InvokeServer()end
end)
end

local function fireB(n,a)
local r=rs:FindFirstChild(n)
if not r then return end
pcall(function()
if r:IsA("RemoteEvent")then r:FireServer(a)
elseif r:IsA("RemoteFunction")then r:InvokeServer(a)end
end)
end

local function tap(b)
if not b then return end
pcall(function()
local p=b.AbsolutePosition+b.AbsoluteSize/2
vim:SendMouseButtonEvent(p.X,p.Y,0,true,game,1)
task.wait(0.06)
vim:SendMouseButtonEvent(p.X,p.Y,0,false,game,1)
end)
end

local function get(p)
local c=pg
for n in p:gmatch("[^%.]+")do
c=c:FindFirstChild(n)
if not c then return nil end
end
return c
end

local function offline()
tap(get"MainGame.Main.Frames.OfflineEarnings.ClaimButtons.Claimx10Host.Claimx10")
end

local function free()
local f=get"MainGame.Main.Frames.FreeReward.ClaimButton"
if f and f.Parent.Visible then tap(f)end
local o=get"MainGame.Main.Frames.OPReward.ClaimButton"
if o and o.Parent.Visible then tap(o)end
end

local function playtime()
local pr=get"MainGame.Main.Frames.PlaytimeRewards.Rewards"
if not pr then return end
for _,t in ipairs(pr:GetChildren())do
local b=t:FindFirstChild("Claimbutton")
if b then tap(b)end
end
end

local function idx()
for i=1,7 do
tap(get("MainGame.Main.Frames.Index.RarityBtns."..i.."BtnHost."..i.."Btn"))
end
tap(get"MainGame.Main.Frames.Index.RarityBtns.ItemsBtnHost.ItemsBtn")
end

local function rb()
local b=get"MainGame.Main.Frames.Rebirth.Buttons.RebirthButtonHost.RebirthButton"
if b and b.Parent.Visible then
tap(b)
task.wait(0.4)
tap(get"MainGame.Main.Frames.Rebirth.Buttons.SkipButtonHost.SkipButton")
end
end

local function boss()
local b=get"MainGame.HUD.HUD.Announcment.BossJoinBtn"
if b and b.Parent.Visible then tap(b)end
end

local function findEgg()
local c=plr.Character
if not c then return nil end
local my=c:GetPivot().Position
local best,bd=nil,math.huge
for _,v in ipairs(workspace:GetDescendants())do
if v:IsA("Model")then
local n=v.Name:lower()
if n:find("egg")or n:find("placed")then
local d=(v:GetPivot().Position-my).Magnitude
if d<bd then bd=d best=v end
end end end
return best
end

local function shoot()
local c=plr.Character
if not c then return end
local t=c:FindFirstChildWhichIsA("Tool")or plr.Backpack:FindFirstChildWhichIsA("Tool")
if not t then return end
if t.Parent~=c then t.Parent=c task.wait(0.3)end
local e=findEgg()
if e then
local p=e:GetPivot().Position
local h=c:FindFirstChild("HumanoidRootPart")
if h then h.CFrame=CFrame.new(h.Position,Vector3.new(p.X,h.Position.Y,p.Z))end
end
pcall(function() t:Activate()end)
fireA("weaponFire")
end

local function collect()
local c=plr.Character
if not c then return end
local my=c:GetPivot().Position
for _,v in ipairs(workspace:GetDescendants())do
if v:IsA("Model")then
local n=v.Name:lower()
if n:find("animal")or n:find("pet")or n:find("brainrot")then
local d=(v:GetPivot().Position-my).Magnitude
if d<50 then fireB("collectAnimal",v)end
end end end
end

local function loop()
while running do
if state.offline then pcall(offline)end
if state.free then pcall(free)end
if state.playtime then pcall(playtime)end
if state.index then pcall(idx)end
if state.boss then pcall(boss)end
if state.rebirth then pcall(rb)end
if state.shoot then
for i=1,5 do
if not running then break end
pcall(shoot)
task.wait(0.2)
end end
if state.collect then pcall(collect)end
if state.sell then fireA("sellAll")end
if state.buy then fireA("buyDamage")fireA("buyGun")end
task.wait(1)
end
end

sb.MouseButton1Click:Connect(function()
running=not running
if running then
sb.Text="stop"
sb.BackgroundColor3=Color3.fromRGB(140,60,60)
thread=task.spawn(loop)
else
sb.Text="start"
sb.BackgroundColor3=Color3.fromRGB(50,120,70)
if thread then task.cancel(thread)end
end
end)

print("slance hub loaded")
