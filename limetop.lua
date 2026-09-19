-- lime.cs | executor pc / mobile | бинд меню по дефолту rightshift
-- все свое с маленькой, апи роблокса с большой иначе не запустится

if getgenv().lime_loaded then
    pcall(function()
        local plr = game:GetService("Players").LocalPlayer
        local pg = plr:FindFirstChildOfClass("PlayerGui")
        if pg then
            local o = pg:FindFirstChild("lime_cs") if o then o:Destroy() end
            local old = pg:FindFirstChild("mm2_cs2") if old then old:Destroy() end
        end
        local cg = game:GetService("CoreGui")
        local o2 = cg:FindFirstChild("lime_cs") if o2 then o2:Destroy() end
        local o3 = cg:FindFirstChild("mm2_cs2") if o3 then o3:Destroy() end
        for _, p in pairs(game:GetService("Players"):GetPlayers()) do
            if p.Character then
                local e = p.Character:FindFirstChild("mm2_esp") if e then e:Destroy() end
                local h = p.Character:FindFirstChild("mm2_hl") if h then h:Destroy() end
            end
        end
    end)
    task.wait(0.2)
end
getgenv().lime_loaded = true

local players = game:GetService("Players")
local workspace = game:GetService("Workspace")
local uis = game:GetService("UserInputService")
local stats = game:GetService("Stats")
local runservice = game:GetService("RunService")
local lighting = game:GetService("Lighting")
local http = game:GetService("HttpService")
local textservice = game:GetService("TextService")
local localplayer = players.LocalPlayer

getgenv().lime = getgenv().lime or {}
local s = getgenv().lime
if s.esp == nil then s.esp = true end
if s.showinnocent == nil then s.showinnocent = true end
if s.chams == nil then s.chams = true end
if s.names == nil then s.names = true end
if s.coinfarm == nil then s.coinfarm = false end
if s.gungrab == nil then s.gungrab = false end
if s.farmdelay == nil then s.farmdelay = 0.35 end
if s.shootkey == nil then s.shootkey = "f" end
if s.menukey == nil then s.menukey = "RightShift" end
if s.theme == nil then s.theme = "black" end
if s.accent_r == nil then s.accent_r = 190 s.accent_g = 255 s.accent_b = 70 end
if s.silentaim == nil then s.silentaim = false end
if s.infjump == nil then s.infjump = false end
if s.speedon == nil then s.speedon = false end
if s.speed == nil then s.speed = 16 end
if s.jpon == nil then s.jpon = false end
if s.jp == nil then s.jp = 50 end
if s.bangon == nil then s.bangon = false end
if s.bangspeed == nil then s.bangspeed = 5 end
if s.fullbright == nil then s.fullbright = false end
if s.invisible == nil then s.invisible = false end
if s.killaura == nil then s.killaura = false end
if s.jerk == nil then s.jerk = false end
if s.jerkspeed == nil then s.jerkspeed = 6 end
if s.jerktool == nil then s.jerktool = false end
if s.tracer == nil then s.tracer = false end
if s.chinahat == nil then s.chinahat = false end
if s.jumpcircle == nil then s.jumpcircle = false end
if s.spin == nil then s.spin = false end
if s.spinspeed == nil then s.spinspeed = 30 end
if s.wallbang == nil then s.wallbang = false end
if s.triggerbot == nil then s.triggerbot = false end
if s.hitbox == nil then s.hitbox = false end
if s.hitboxsize == nil then s.hitboxsize = 8 end
if s.aura_rings == nil then s.aura_rings = false end
if s.aura_chains == nil then s.aura_chains = false end
if s.aura_spiral == nil then s.aura_spiral = false end
if s.aura_orbit == nil then s.aura_orbit = false end
if s.aura_pulse == nil then s.aura_pulse = false end
if s.anticoin == nil then s.anticoin = false end
if s.antifling == nil then s.antifling = false end
if s.lang == nil then s.lang = "ru" end
if s.trail == nil then s.trail = false end
s.bangtarget = nil

local function txt(ru, en) if s.lang == "en" then return en end return ru end
local LANGMSG = {
    ["готов"] = "ready",
    ["ты мертв"] = "you are dead",
    ["мардер не найден"] = "murderer not found",
    ["возьми ган сначала"] = "grab the gun first",
    ["нет рюкзака"] = "no backpack",
    ["мардер убит"] = "murderer down",
    ["шериф не найден"] = "sheriff not found",
    ["тп к мардеру"] = "tp to murderer",
    ["тп к шерифу"] = "tp to sheriff",
    ["тп к гану"] = "tp to gun",
    ["ган подобран, вернулся"] = "gun grabbed, back",
    ["монет на карте"] = "coins on map",
    ["уже убиваю подожди"] = "already killing wait",
    ["нужен нож, ты не мардер"] = "need knife, you are not murderer",
    ["уже флингую подожди"] = "already flinging wait",
    ["выбери чела"] = "select someone",
    ["у чела нет персонажа"] = "no character",
    ["выбери цели сначала"] = "select targets first",
    ["сидишь"] = "sitting",
    ["встал"] = "standing",
    ["день"] = "day",
    ["закат"] = "sunset",
    ["ночь"] = "night",
    ["утро"] = "morning",
    ["впиши название cfg"] = "enter cfg name",
    ["не вышло сохранить"] = "save failed",
    ["не вышло загрузить"] = "load failed",
    ["твой экзекутор без файлов"] = "your executor has no files",
    ["перезапусти скрипт"] = "re-execute script",
    ["стоп"] = "stopped",
    ["флинг стоп"] = "fling stopped",
    ["готово"] = "done",
    ["спавнов нет"] = "no spawns",
    ["silent aim вкл"] = "silent aim on",
    ["silent aim выкл"] = "silent aim off",
    ["сквозь стены вкл"] = "wallbang on",
    ["сквозь стены выкл"] = "wallbang off",
    ["jerk вкл"] = "jerk on",
    ["jerk выкл"] = "jerk off",
    ["tracer вкл"] = "tracer on",
    ["tracer выкл"] = "tracer off",
    ["инвиз вкл"] = "invisible on",
    ["инвиз выкл"] = "invisible off",
    ["kill all..."] = "kill all...",
    ["jerk тул выдан, клик - вкл/выкл"] = "jerk tool given, click toggles",
    ["jerk тул уже есть"] = "jerk tool already owned",
    ["ремоут не захвачен, бил наугад"] = "remote not captured, fired blind",
    ["anti coin вкл"] = "anti coin on",
    ["anti coin выкл"] = "anti coin off",
    ["anti fling вкл"] = "anti fling on",
    ["anti fling выкл"] = "anti fling off",
    ["triggerbot выстрел"] = "triggerbot shot",
    ["triggerbot вкл"] = "triggerbot on",
    ["triggerbot выкл"] = "triggerbot off",
}
local function trmsg(t)
    if s.lang == "en" then return LANGMSG[t] or t end
    return t
end
local LANGPRE = {
    ["выстрел в "] = "shot at ",
    ["флингую "] = "flinging ",
    ["целей: "] = "targets: ",
    ["бинд выстрела: "] = "shoot bind: ",
    ["бинд меню: "] = "menu bind: ",
    ["бинд: "] = "bind: ",
    ["cfg сохранен: "] = "cfg saved: ",
    ["cfg загружен: "] = "cfg loaded: ",
    ["кнопка добавлена: "] = "button added: ",
    ["готово, убито: "] = "done, killed: ",
    ["цель: "] = "target: ",
    ["скорость: "] = "speed: ",
    ["нажми любую клавишу"] = "press any key",
}
local function trpre(t)
    for ru, en in pairs(LANGPRE) do
        if string.sub(t, 1, #ru) == ru then
            return en .. string.sub(t, #ru + 1)
        end
    end
    return trmsg(t)
end

local function getaccent() return Color3.fromRGB(s.accent_r, s.accent_g, s.accent_b) end
local function alive()
    local c = localplayer.Character
    if not c then return nil, nil, nil end
    local h = c:FindFirstChildOfClass("Humanoid")
    local hrp = c:FindFirstChild("HumanoidRootPart")
    if not h or not hrp or h.Health <= 0 then return nil, nil, nil end
    local dead = false
    pcall(function() dead = (h:GetState() == Enum.HumanoidStateType.Dead) end)
    if dead then return nil, nil, nil end
    return c, h, hrp
end
local function mydead()
    local c, h, hrp = alive()
    if not hrp then return true end
    return false
end

-- ===== роли =====
local function getrole(plr)
    local char = plr.Character
    local bp = plr:FindFirstChildOfClass("Backpack")
    local function has(n)
        if char and char:FindFirstChild(n) then return true end
        if bp and bp:FindFirstChild(n) then return true end
        return false
    end
    if has("Knife") then return "murderer"
    elseif has("Gun") or has("Revolver") then return "sheriff"
    else return "innocent" end
end
local rc = {
    murderer = Color3.fromRGB(255,60,60),
    sheriff = Color3.fromRGB(80,140,255),
    innocent = Color3.fromRGB(90,255,110),
}
local function clearesp(plr)
    if plr.Character then
        local a = plr.Character:FindFirstChild("mm2_esp") if a then a:Destroy() end
        local b = plr.Character:FindFirstChild("mm2_hl") if b then b:Destroy() end
    end
end
local function applyesp(plr)
    if plr == localplayer then return end
    if not plr.Character or not plr.Character:FindFirstChild("Head") then return end
    clearesp(plr)
    if not s.esp then return end
    local role = getrole(plr)
    if role == "innocent" and not s.showinnocent then return end
    local col = rc[role] or rc.innocent
    if s.chams then
        local hl = Instance.new("Highlight")
        hl.Name = "mm2_hl" hl.FillColor = col hl.OutlineColor = col
        hl.FillTransparency = 0.55 hl.OutlineTransparency = 0
        hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        hl.Adornee = plr.Character hl.Parent = plr.Character
    end
    if s.names then
        local bb = Instance.new("BillboardGui")
        bb.Name = "mm2_esp" bb.Size = UDim2.new(0,200,0,40)
        bb.StudsOffset = Vector3.new(0,2.6,0) bb.AlwaysOnTop = true
        bb.Adornee = plr.Character:FindFirstChild("Head") bb.Parent = plr.Character
        local tl = Instance.new("TextLabel")
        tl.Size = UDim2.new(1,0,1,0) tl.BackgroundTransparency = 1
        tl.Font = Enum.Font.Code tl.TextSize = 14 tl.TextStrokeTransparency = 0
        tl.Text = string.lower(plr.DisplayName).." ["..role.."]" tl.TextColor3 = col
        tl.Parent = bb
    end
end
local function refreshesp()
    for _,p in pairs(players:GetPlayers()) do pcall(applyesp,p) end
end
task.spawn(function()
    while getgenv().lime_loaded do
        if s.esp then refreshesp() end
        task.wait(2)
    end
end)
for _,p in pairs(players:GetPlayers()) do
    p.CharacterAdded:Connect(function() task.wait(1) pcall(applyesp,p) end)
end
players.PlayerAdded:Connect(function(p)
    p.CharacterAdded:Connect(function() task.wait(1) pcall(applyesp,p) end)
end)

-- ===== поиск монет и гана (широкий, под все карты) =====
local function findcoins()
    local t = {}
    pcall(function()
        for _,v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") then
                local n = string.lower(v.Name)
                if string.find(n,"coin") or n == "beachball" or string.find(n,"token") or string.find(n,"money") then
                    table.insert(t,v)
                end
            end
        end
    end)
    return t
end
local function findgun()
    for _,v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and v.Name == "GunDrop" then return v end
    end
    return nil
end
local function getgun()
    local char = localplayer.Character
    if not char then return nil end
    local bp = localplayer:FindFirstChildOfClass("Backpack")
    if char:FindFirstChild("Gun") then return char:FindFirstChild("Gun") end
    if char:FindFirstChild("Revolver") then return char:FindFirstChild("Revolver") end
    if bp and bp:FindFirstChild("Gun") then return bp:FindFirstChild("Gun") end
    if bp and bp:FindFirstChild("Revolver") then return bp:FindFirstChild("Revolver") end
    return nil
end
local function getknife()
    local char = localplayer.Character
    if not char then return nil end
    local bp = localplayer:FindFirstChildOfClass("Backpack")
    if char:FindFirstChild("Knife") then return char:FindFirstChild("Knife") end
    if bp and bp:FindFirstChild("Knife") then return bp:FindFirstChild("Knife") end
    return nil
end

-- ===== статус =====
local statusText = "готов"
local function setstatus(t)
    t = string.lower(t)
    t = trpre(t)
    statusText = t
    pcall(function() if _G.lime_status then _G.lime_status.Text = statusText end end)
end
_G.lime_coins = 0

-- автофарм монет
task.spawn(function()
    while getgenv().lime_loaded do
        if s.coinfarm and not mydead() then
            local c,h,hrp = alive()
            if hrp and h then
                pcall(function()
                    local coins = findcoins()
                    _G.lime_coins = #coins
                    table.sort(coins,function(a,b) return (a.Position-hrp.Position).Magnitude < (b.Position-hrp.Position).Magnitude end)
                    for i=1, math.min(#coins,3) do
                        if not s.coinfarm or mydead() then break end
                        local _,_,hrp2 = alive() if not hrp2 then break end
                        local coin = coins[i]
                        if coin and coin.Parent then hrp2.CFrame = coin.CFrame + Vector3.new(0,3,0) task.wait(s.farmdelay) end
                    end
                    if #coins == 0 then task.wait(1) end
                end)
            else task.wait(1) end
        else
            _G.lime_coins = 0
            task.wait(0.4)
        end
    end
end)

-- подбор гана с возвратом на место
local function grabgunreturn()
    local c,h,hrp = alive()
    if not hrp then setstatus("ты мертв") return end
    if getgun() then return end
    local old = hrp.CFrame
    local t0 = tick()
    while tick() - t0 < 4 and getgenv().lime_loaded do
        if mydead() then return end
        local g = getgun()
        if g and g.Parent == localplayer.Character then break end
        local gg = findgun()
        if not gg then break end
        local _,_,h2 = alive() if not h2 then return end
        h2.CFrame = gg.CFrame + Vector3.new(0,2,0)
        task.wait(0.25)
    end
    task.wait(0.2)
    if mydead() then return end
    local _,_,h3 = alive()
    if h3 then h3.CFrame = old end
    setstatus("ган подобран, вернулся")
end
task.spawn(function()
    while getgenv().lime_loaded do
        if s.gungrab and not mydead() then
            if getgun() then task.wait(2)
            else pcall(grabgunreturn) task.wait(1) end
        else task.wait(0.5) end
    end
end)

-- ===== стрельба с меньшими миссами =====
local function findmurderer()
    for _,p in pairs(players:GetPlayers()) do
        if p ~= localplayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 and getrole(p) == "murderer" then return p end
        end
    end
    return nil
end
local cachedshoot, cachedknife = nil, nil
local function getremotes(kind)
    if kind == "shoot" and cachedshoot then return cachedshoot end
    if kind == "knife" and cachedknife then return cachedknife end
    local out = {}
    pcall(function()
        for _,v in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
            if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
                local n = string.lower(v.Name)
                if kind == "shoot" then
                    if string.find(n,"shoot") or string.find(n,"fire") or string.find(n,"gun") or string.find(n,"hit") or string.find(n,"damage") or string.find(n,"kill") then table.insert(out,v) end
                else
                    if string.find(n,"knife") or string.find(n,"stab") or string.find(n,"slash") or string.find(n,"throw") or string.find(n,"kill") or string.find(n,"damage") or string.find(n,"attack") or string.find(n,"murder") then table.insert(out,v) end
                end
            end
        end
    end)
    if kind == "shoot" then cachedshoot = out else cachedknife = out end
    return out
end
task.spawn(function() task.wait(3) pcall(getremotes,"shoot") pcall(getremotes,"knife") end)
local function shootmurderer()
    local m = findmurderer()
    if not m then setstatus("мардер не найден") return end
    local c,h,hrp = alive()
    if not hrp then setstatus("ты мертв") return end
    local mhrp = m.Character and m.Character:FindFirstChild("HumanoidRootPart")
    local mhum = m.Character and m.Character:FindFirstChildOfClass("Humanoid")
    if not mhrp or not mhum then return end
    local gun = getgun()
    if not gun then setstatus("возьми ган сначала") return end
    if gun.Parent ~= c then
        pcall(function() h:EquipTool(gun) end)
        local t0 = tick()
        while tick() - t0 < 0.2 and gun.Parent ~= c do task.wait() end
    end
    local pingms = 60
    pcall(function() pingms = math.floor(stats.Network.ServerStatsItem["Data Ping"]:GetValue()) end)
    local oldcf = hrp.CFrame
    local cam = workspace.CurrentCamera
    local oldcam = cam and cam.CFrame
    local oldmouse = nil
    pcall(function() oldmouse = uis:GetMouseLocation() end)
    s._firing = true
    for i=1,3 do
        if not getgenv().lime_loaded then break end
        local _,_,hrp2 = alive() if not hrp2 then break end
        if not m.Character then break end
        local tm = m.Character:FindFirstChild("HumanoidRootPart")
        local hd = m.Character:FindFirstChild("Head")
        local mh = m.Character:FindFirstChildOfClass("Humanoid")
        if not tm or not mh or mh.Health <= 0 then break end
        local aim = tm
        if hd and i % 2 == 0 then aim = hd end
        local lead = math.clamp(pingms / 1000, 0, 0.3) + 0.05
        local pred = aim.Position + (tm.Velocity * lead)
        -- встаем вплотную и смотрим ровно в цель: реальный выстрел попадает, потом возврат
        pcall(function()
            hrp2.CFrame = CFrame.new(tm.Position + Vector3.new(6, 1, 6), pred)
            if cam then cam.CFrame = CFrame.new(cam.CFrame.Position, pred) end
        end)
        task.wait(0.06)
        pcall(function()
            if _G.lime_tracer and s.tracer then
                local from = hrp2.Position
                local eq2 = c:FindFirstChild("Gun") or c:FindFirstChild("Revolver")
                if eq2 then local hdd = eq2:FindFirstChild("Handle") if hdd then from = hdd.Position end end
                _G.lime_tracer(from, pred)
            end
        end)
        pcall(function()
            local eq = c:FindFirstChild("Gun") or c:FindFirstChild("Revolver")
            if eq then eq:Activate() end
        end)
        task.wait(0.08)
        local _,_,hrp4 = alive()
        if hrp4 then
            local mdead = m.Character and m.Character:FindFirstChildOfClass("Humanoid")
            if not mdead or mdead.Health <= 0 then break end
        end
    end
    pcall(function()
        local _,_,hrp3 = alive()
        if hrp3 then hrp3.CFrame = oldcf end
        if cam and oldcam then cam.CFrame = oldcam end
        if oldmouse and typeof(mousemoveabs) == "function" then mousemoveabs(oldmouse.X, oldmouse.Y) end
    end)
    s._firing = false
    setstatus("выстрел в "..string.lower(m.DisplayName))
end
_G.lime_shoot = shootmurderer
-- без namecall хука специально: он ломал ремоуты и стрельбу на части экзекуторов

-- ===== kill all за мардера =====
local killing = false
local function killall()
    if killing then setstatus("уже убиваю подожди") return end
    local c,h,hrp = alive()
    if not hrp then setstatus("ты мертв") return end
    local knife = getknife()
    if not knife then setstatus("нужен нож, ты не мардер") return end
    killing = true
    setstatus("kill all...")
    local oldcf = hrp.CFrame
    pcall(function() if knife.Parent ~= c then h:EquipTool(knife) task.wait(0.2) end end)
    pcall(function()
        for _,p in pairs(players:GetPlayers()) do
            if p ~= localplayer and p.Character then
                local vhrp = p.Character:FindFirstChild("HumanoidRootPart")
                local vhum = p.Character:FindFirstChildOfClass("Humanoid")
                if vhrp and vhum and vhum.Health > 0 then
                    for _,r in pairs(getremotes("knife")) do
                        pcall(function() r:FireServer(vhrp.Position) end)
                        pcall(function() r:FireServer(p.Character) end)
                        pcall(function() r:FireServer(vhrp) end)
                        pcall(function() r:FireServer("stab", p.Character) end)
                        pcall(function() r:FireServer(vhrp.Position, vhrp, p.Character) end)
                    end
                end
            end
        end
    end)
    local killed = 0
    for pass=1,2 do
        if not getgenv().lime_loaded or not killing then break end
        for _,p in pairs(players:GetPlayers()) do
            if not getgenv().lime_loaded or not killing then break end
            if p ~= localplayer and p.Character then
                local vhrp = p.Character:FindFirstChild("HumanoidRootPart")
                local vhum = p.Character:FindFirstChildOfClass("Humanoid")
                if vhrp and vhum and vhum.Health > 0 then
                    local _,_,myhrp = alive() if not myhrp then break end
                    myhrp.CFrame = CFrame.new(vhrp.Position + Vector3.new(0,0,1.2), vhrp.Position)
                    task.wait(0.3)
        -- курсор на мардера: ган бьет туда куда смотрит курсор
        pcall(function()
            if cam and typeof(mousemoveabs) == "function" then
                local sp, on = cam:WorldToScreenPoint(pred)
                if on then mousemoveabs(sp.X, sp.Y) end
            end
        end)
        task.wait(0.05)
        pcall(function()
            local eq = c:FindFirstChild("Gun") or c:FindFirstChild("Revolver")
            if eq then eq:Activate() end
        end)
        task.wait(0.1)
                    local vh2 = p.Character and p.Character:FindFirstChildOfClass("Humanoid")
                    if not vh2 or vh2.Health <= 0 then killed = killed + 1 end
                    setstatus("kill all... "..killed)
                end
            end
        end
    end
    local _,_,myhrp2 = alive()
    if myhrp2 then myhrp2.CFrame = oldcf end
    killing = false
    setstatus("готово, убито: "..killed)
end
task.spawn(function()
    while getgenv().lime_loaded do
        if s.killaura and not killing and not mydead() then
            local knife = getknife()
            if knife then
                pcall(function()
                    local c,h,hrp = alive()
                    if hrp then
                        for _,p in pairs(players:GetPlayers()) do
                            if p ~= localplayer and p.Character then
                                local vhrp = p.Character:FindFirstChild("HumanoidRootPart")
                                local vhum = p.Character:FindFirstChildOfClass("Humanoid")
                                if vhrp and vhum and vhum.Health > 0 and (vhrp.Position - hrp.Position).Magnitude < 9 then
                                    if knife.Parent ~= c then h:EquipTool(knife) end
                                    hrp.CFrame = vhrp.CFrame + Vector3.new(0,0,0.5)
                                    local eq = c:FindFirstChild("Knife")
                                    if eq then eq:Activate() end
                                end
                            end
                        end
                    end
                end)
            end
        end
        task.wait(0.4)
    end
end)

-- ===== флинг kilasik мультитаргет (твой код, вписан в lime) =====
local flingtargets = {}
local flingactive = false
local flingoldpos = nil
local flingfpdh = workspace.FallenPartsDestroyHeight
local function flingmsg(t, tx, tm)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = t, Text = tx, Duration = tm or 3})
    end)
    setstatus(tx)
end
local function skidfling(targetplayer)
    local character = localplayer.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    local rootpart = humanoid and humanoid.RootPart
    local tchar = targetplayer.Character
    if not tchar then return end
    local thumanoid = tchar:FindFirstChildOfClass("Humanoid")
    local trootpart = nil
    if thumanoid and thumanoid.RootPart then trootpart = thumanoid.RootPart end
    local thead = tchar:FindFirstChild("Head")
    local accessory = tchar:FindFirstChildOfClass("Accessory")
    local handle = nil
    if accessory and accessory:FindFirstChild("Handle") then handle = accessory.Handle end
    if character and humanoid and rootpart then
        if rootpart.Velocity.Magnitude < 50 then flingoldpos = rootpart.CFrame end
        if thumanoid and thumanoid.Sit then flingmsg("ошибка", string.lower(targetplayer.DisplayName).." сидит", 2) return end
        pcall(function()
            if thead then workspace.CurrentCamera.CameraSubject = thead
            elseif handle then workspace.CurrentCamera.CameraSubject = handle
            elseif thumanoid and trootpart then workspace.CurrentCamera.CameraSubject = thumanoid end
        end)
        if not tchar:FindFirstChildWhichIsA("BasePart") then return end
        local function fpos(basepart, pos, ang)
            rootpart.CFrame = CFrame.new(basepart.Position) * pos * ang
            pcall(function() character:SetPrimaryPartCFrame(CFrame.new(basepart.Position) * pos * ang) end)
            rootpart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
            rootpart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
        end
        local function sfbasepart(basepart)
            local timetowait = 2
            local timestart = tick()
            local angle = 0
            repeat
                if rootpart and thumanoid then
                    if basepart.Velocity.Magnitude < 50 then
                        angle = angle + 100
                        fpos(basepart, CFrame.new(0, 1.5, 0) + thumanoid.MoveDirection * basepart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(angle),0,0))
                        task.wait()
                        fpos(basepart, CFrame.new(0, -1.5, 0) + thumanoid.MoveDirection * basepart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(angle),0,0))
                        task.wait()
                        fpos(basepart, CFrame.new(0, 1.5, 0) + thumanoid.MoveDirection * basepart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(angle),0,0))
                        task.wait()
                        fpos(basepart, CFrame.new(0, -1.5, 0) + thumanoid.MoveDirection * basepart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(angle),0,0))
                        task.wait()
                        fpos(basepart, CFrame.new(0, 1.5, 0) + thumanoid.MoveDirection, CFrame.Angles(math.rad(angle),0,0))
                        task.wait()
                        fpos(basepart, CFrame.new(0, -1.5, 0) + thumanoid.MoveDirection, CFrame.Angles(math.rad(angle),0,0))
                        task.wait()
                    else
                        fpos(basepart, CFrame.new(0, 1.5, thumanoid.WalkSpeed), CFrame.Angles(math.rad(90),0,0))
                        task.wait()
                        fpos(basepart, CFrame.new(0, -1.5, -thumanoid.WalkSpeed), CFrame.Angles(0,0,0))
                        task.wait()
                        fpos(basepart, CFrame.new(0, 1.5, thumanoid.WalkSpeed), CFrame.Angles(math.rad(90),0,0))
                        task.wait()
                        fpos(basepart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90),0,0))
                        task.wait()
                        fpos(basepart, CFrame.new(0, -1.5, 0), CFrame.Angles(0,0,0))
                        task.wait()
                        fpos(basepart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90),0,0))
                        task.wait()
                        fpos(basepart, CFrame.new(0, -1.5, 0), CFrame.Angles(0,0,0))
                        task.wait()
                    end
                end
            until timestart + timetowait < tick() or not flingactive or not getgenv().lime_loaded
        end
        workspace.FallenPartsDestroyHeight = 0/0
        local bv = Instance.new("BodyVelocity")
        bv.Velocity = Vector3.new(0,0,0)
        bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        bv.Parent = rootpart
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
        if trootpart then sfbasepart(trootpart)
        elseif thead then sfbasepart(thead)
        elseif handle then sfbasepart(handle)
        else bv:Destroy() return end
        bv:Destroy()
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
        pcall(function() workspace.CurrentCamera.CameraSubject = humanoid end)
        if flingoldpos then
            pcall(function()
                local t0 = tick()
                repeat
                    rootpart.CFrame = flingoldpos * CFrame.new(0,0.5,0)
                    pcall(function() character:SetPrimaryPartCFrame(flingoldpos * CFrame.new(0,0.5,0)) end)
                    humanoid:ChangeState("GettingUp")
                    for _, part in pairs(character:GetChildren()) do
                        if part:IsA("BasePart") then part.Velocity, part.RotVelocity = Vector3.new(), Vector3.new() end
                    end
                    task.wait()
                until (rootpart.Position - flingoldpos.p).Magnitude < 25 or tick() - t0 > 3 or not getgenv().lime_loaded
            end)
            workspace.FallenPartsDestroyHeight = flingfpdh
        end
    end
end
local function flingcount()
    local n = 0
    for _ in pairs(flingtargets) do n = n + 1 end
    return n
end
local function startfling()
    if flingactive then return end
    if flingcount() == 0 then setstatus("выбери цели сначала") return end
    flingactive = true
    setstatus("флингую "..flingcount())
    flingmsg("старт", "флингую "..flingcount(), 2)
    task.spawn(function()
        while flingactive and getgenv().lime_loaded do
            local valid = {}
            for name, plr in pairs(flingtargets) do
                if plr and plr.Parent then valid[name] = plr
                else flingtargets[name] = nil end
            end
            for _, plr in pairs(valid) do
                if flingactive and getgenv().lime_loaded then
                    skidfling(plr)
                    task.wait(0.1)
                else break end
            end
            task.wait(0.5)
        end
    end)
end
local function stopfling()
    flingactive = false
    setstatus("флинг стоп")
end

-- ===== jerk =====
task.spawn(function()
    local jerkbase = {}
    while getgenv().lime_loaded do
        if s.jerk then
            local c,h,hrp = alive()
            if c and h and hrp then
                pcall(function()
                    h.Seated = false
                    local t = tick() * (s.jerkspeed or 6)
                    local swing = math.sin(t) * 0.9
                    local torso = c:FindFirstChild("Torso")
                    if torso then
                        local sh = torso:FindFirstChild("Right Shoulder")
                        if sh then
                            if not jerkbase[sh] then jerkbase[sh] = sh.C0 end
                            sh.C0 = jerkbase[sh] * CFrame.new(0, -0.1 * math.abs(math.sin(t)), 0) * CFrame.Angles(swing * 0.4, 0, -0.5 - math.abs(swing) * 0.3)
                        end
                        local neck = torso:FindFirstChild("Neck")
                        if neck then
                            if not jerkbase[neck] then jerkbase[neck] = neck.C0 end
                            neck.C0 = jerkbase[neck] * CFrame.Angles(math.sin(t * 0.5) * 0.15, math.sin(t * 0.33) * 0.2, 0)
                        end
                    else
                        local ruarm = c:FindFirstChild("RightUpperArm")
                        if ruarm then
                            local sh2 = ruarm:FindFirstChild("RightShoulder")
                            if sh2 then
                                if not jerkbase[sh2] then jerkbase[sh2] = sh2.C0 end
                                sh2.C0 = jerkbase[sh2] * CFrame.Angles(swing * 0.5, 0, -0.4)
                            end
                        end
                        local head = c:FindFirstChild("Head")
                        if head then
                            local nm = head:FindFirstChild("Neck")
                            if nm and nm:IsA("Motor6D") then
                                if not jerkbase[nm] then jerkbase[nm] = nm.C0 end
                                nm.C0 = jerkbase[nm] * CFrame.Angles(math.sin(t * 0.5) * 0.12, 0, 0)
                            end
                        end
                    end
                end)
            end
            runservice.Heartbeat:Wait()
        else
            if next(jerkbase) ~= nil then
                pcall(function()
                    for m, cf in pairs(jerkbase) do if m and m.Parent then m.C0 = cf end end
                end)
                jerkbase = {}
            end
            task.wait(0.3)
        end
    end
end)
local function givejerktool()
    local bp = localplayer:FindFirstChildOfClass("Backpack")
    if not bp then setstatus("нет рюкзака") return end
    if bp:FindFirstChild("jerk") or (localplayer.Character and localplayer.Character:FindFirstChild("jerk")) then
        setstatus("jerk тул уже есть") return
    end
    local tool = Instance.new("Tool")
    tool.Name = "jerk" tool.RequiresHandle = false tool.CanBeDropped = false
    tool.ToolTip = "jerk вкл/выкл"
    tool.Activated:Connect(function()
        s.jerk = not s.jerk
        setstatus("jerk "..(s.jerk and "вкл" or "выкл"))
    end)
    tool.Parent = bp
    s.jerktool = true
    setstatus("jerk тул выдан, клик - вкл/выкл")
end

-- ===== bullet tracer цветом акцента =====
_G.lime_tracer = function(from, to)
    if not s.tracer then return end
    pcall(function()
        local dist = (to - from).Magnitude
        if dist < 2 or dist > 2000 then return end
        local p = Instance.new("Part")
        p.Anchored = true p.CanCollide = false p.CanQuery = false p.CanTouch = false
        p.Material = Enum.Material.Neon p.Color = getaccent()
        p.Size = Vector3.new(0.15, 0.15, dist)
        p.CFrame = CFrame.new(from + (to - from) * 0.5, to)
        p.Parent = workspace
        task.spawn(function()
            for i=1,10 do
                if not p.Parent then return end
                p.Transparency = i / 10
                task.wait(0.04)
            end
            p:Destroy()
        end)
    end)
end

-- ===== halo круг над головой под цвет акцента =====
local halodisc, halodots = nil, {}
local function haloclear()
    pcall(function() if halodisc then halodisc:Destroy() end end) halodisc = nil
    pcall(function() for _,d in pairs(halodots) do d:Destroy() end end) halodots = {}
end
local function updatechinahat() haloclear() end
task.spawn(function()
    while getgenv().lime_loaded do
        if s.chinahat then
            local c,h,hrp = alive()
            local head = c and c:FindFirstChild("Head")
            if head then
                if not halodisc or not halodisc.Parent then
                    halodisc = Instance.new("Part")
                    halodisc.Name = "lime_halo" halodisc.Shape = Enum.PartType.Cylinder
                    halodisc.Size = Vector3.new(0.1, 2.2, 2.2)
                    halodisc.Material = Enum.Material.Neon halodisc.Color = getaccent()
                    halodisc.Anchored = true halodisc.CanCollide = false halodisc.CanQuery = false halodisc.CanTouch = false
                    halodisc.Parent = workspace
                end
                halodisc.Color = getaccent()
                local t = tick()
                halodisc.CFrame = CFrame.new(head.Position + Vector3.new(0, 1.3 + math.sin(t * 2) * 0.08, 0)) * CFrame.Angles(0, 0, math.rad(90))
                for i=1,6 do
                    local d = halodots[i]
                    if not d or not d.Parent then
                        d = Instance.new("Part")
                        d.Name = "lime_halo" d.Shape = Enum.PartType.Ball
                        d.Size = Vector3.new(0.35, 0.35, 0.35)
                        d.Material = Enum.Material.Neon d.Color = getaccent()
                        d.Anchored = true d.CanCollide = false d.CanQuery = false d.CanTouch = false
                        d.Parent = workspace
                        halodots[i] = d
                    end
                    d.Color = getaccent()
                    local a = t * 2.5 + (i - 1) * math.pi / 3
                    d.CFrame = CFrame.new(head.Position + Vector3.new(math.cos(a) * 1.5, 0.9, math.sin(a) * 1.5))
                end
            else
                haloclear()
            end
            runservice.Heartbeat:Wait()
        else
            if halodisc or #halodots > 0 then haloclear() end
            task.wait(0.5)
        end
    end
end)
localplayer.CharacterAdded:Connect(function() haloclear() end)

-- ===== jump circle =====
local function hookjumpcircle(char)
    pcall(function()
        if not char then return end
        local h = char:WaitForChild("Humanoid", 5)
        if not h then return end
        h.StateChanged:Connect(function(old, new)
            if new == Enum.HumanoidStateType.Landed and s.jumpcircle and getgenv().lime_loaded then
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if not hrp then return end
                local pos = hrp.Position - Vector3.new(0, 3, 0)
                task.spawn(function()
                    local ring = Instance.new("Part")
                    ring.Anchored = true ring.CanCollide = false ring.CanQuery = false ring.CanTouch = false
                    ring.Material = Enum.Material.Neon ring.Color = getaccent()
                    ring.Shape = Enum.PartType.Cylinder
                    ring.Size = Vector3.new(0.2, 1, 1)
                    ring.CFrame = CFrame.new(pos) * CFrame.Angles(0, 0, math.rad(90))
                    ring.Parent = workspace
                    for i=1,12 do
                        if not ring.Parent then return end
                        local gr = 1 + i * 0.6
                        ring.Size = Vector3.new(0.2, gr, gr)
                        ring.Transparency = i / 12
                        task.wait(0.03)
                    end
                    ring:Destroy()
                end)
            end
        end)
    end)
end
if localplayer.Character then hookjumpcircle(localplayer.Character) end
localplayer.CharacterAdded:Connect(function(c) hookjumpcircle(c) end)

-- ===== spin =====
local spinbav = nil
local function updatespin()
    if s.spin then
        local c,h,hrp = alive()
        if hrp then
            if not spinbav or spinbav.Parent ~= hrp then
                pcall(function() if spinbav then spinbav:Destroy() end end)
                spinbav = Instance.new("BodyAngularVelocity")
                spinbav.AngularVelocity = Vector3.new(0, s.spinspeed or 30, 0)
                spinbav.MaxTorque = Vector3.new(0, 9e9, 0)
                spinbav.P = 10000
                spinbav.Parent = hrp
            else
                spinbav.AngularVelocity = Vector3.new(0, s.spinspeed or 30, 0)
            end
        end
    else
        if spinbav then pcall(function() spinbav:Destroy() end) spinbav = nil end
    end
end
task.spawn(function()
    while getgenv().lime_loaded do updatespin() task.wait(0.3) end
end)
localplayer.CharacterAdded:Connect(function() spinbav = nil end)

-- ===== wallbang сквозь стены + трассер обычных выстрелов =====
s._firing = false
local function hookgun(gun)
    pcall(function()
        gun.Activated:Connect(function()
            if mydead() then return end
            pcall(function()
                if s.tracer then
                    local hd = gun:FindFirstChild("Handle")
                    local cam = workspace.CurrentCamera
                    if hd and cam then
                        local origin = hd.Position
                        local dir = cam.CFrame.LookVector * 500
                        local hit = workspace:Raycast(origin, dir)
                        _G.lime_tracer(origin, hit and hit.Position or (origin + dir))
                    end
                end
            end)
            if not s.wallbang or s._firing then return end
            s._firing = true
            pcall(shootmurderer)
            s._firing = false
        end)
    end)
end
local function hookgunschar(c)
    if not c then return end
    for _,t in pairs(c:GetChildren()) do
        if t:IsA("Tool") and (t.Name == "Gun" or t.Name == "Revolver") then hookgun(t) end
    end
end
if localplayer.Character then
    hookgunschar(localplayer.Character)
    localplayer.Character.ChildAdded:Connect(function(ch)
        if ch:IsA("Tool") and (ch.Name == "Gun" or ch.Name == "Revolver") then hookgun(ch) end
    end)
end
localplayer.CharacterAdded:Connect(function(c)
    task.wait(0.5)
    if not getgenv().lime_loaded then return end
    hookgunschar(c)
    c.ChildAdded:Connect(function(ch)
        if ch:IsA("Tool") and (ch.Name == "Gun" or ch.Name == "Revolver") then hookgun(ch) end
    end)
end)

-- ===== инвиз (прячет и нож с ганом) =====
local invis_stored = {}
local invis_cons = {}
local function setinvisible(on)
    s.invisible = on
    local c = localplayer.Character
    if on then
        if not c then setstatus("ты мертв") s.invisible = false return end
        invis_stored = {}
        pcall(function()
            for _,v in pairs(c:GetDescendants()) do
                if v:IsA("BasePart") then invis_stored[v] = v.Transparency v.Transparency = 1
                elseif v:IsA("Decal") or v:IsA("Texture") then invis_stored[v] = v.Transparency v.Transparency = 1
                elseif v:IsA("BillboardGui") then v.Enabled = false end
            end
            local bp = localplayer:FindFirstChildOfClass("Backpack")
            if bp then
                for _,t in pairs(bp:GetChildren()) do
                    if t:IsA("Tool") then
                        for _,v in pairs(t:GetDescendants()) do
                            if v:IsA("BasePart") then invis_stored[v] = v.Transparency v.Transparency = 1
                            elseif v:IsA("Decal") or v:IsA("Texture") then invis_stored[v] = v.Transparency v.Transparency = 1 end
                        end
                    end
                end
            end
            local head = c:FindFirstChild("Head")
            if head then local f = head:FindFirstChildOfClass("Decal") if f then f.Transparency = 1 end end
        end)
        pcall(function()
            for _,cn in pairs(invis_cons) do cn:Disconnect() end
            invis_cons = {}
            local bp = localplayer:FindFirstChildOfClass("Backpack")
            if bp then
                table.insert(invis_cons, bp.ChildAdded:Connect(function(ch)
                    if s.invisible and ch:IsA("Tool") then
                        task.wait(0.1)
                        for _,v in pairs(ch:GetDescendants()) do
                            if v:IsA("BasePart") then invis_stored[v] = v.Transparency v.Transparency = 1 end
                        end
                    end
                end))
            end
            table.insert(invis_cons, c.ChildAdded:Connect(function(ch)
                if s.invisible and ch:IsA("Tool") then
                    task.wait(0.1)
                    for _,v in pairs(ch:GetDescendants()) do
                        if v:IsA("BasePart") then invis_stored[v] = v.Transparency v.Transparency = 1 end
                    end
                end
            end))
        end)
        setstatus("инвиз вкл")
    else
        pcall(function()
            for _,cn in pairs(invis_cons) do cn:Disconnect() end
            invis_cons = {}
            for o,tr in pairs(invis_stored) do pcall(function() o.Transparency = tr end) end
            if c then for _,v in pairs(c:GetDescendants()) do if v:IsA("BillboardGui") then v.Enabled = true end end end
        end)
        invis_stored = {}
        setstatus("инвиз выкл")
    end
end
localplayer.CharacterAdded:Connect(function()
    task.wait(1)
    if not getgenv().lime_loaded then return end
    if s.invisible then setinvisible(true) end
    if s.jerktool then pcall(givejerktool) end
    if s.speedon or s.jpon then
        local _,h = alive()
        if h then pcall(function() if s.speedon then h.WalkSpeed = s.speed end if s.jpon then h.UseJumpPower = true h.JumpPower = s.jp end end) end
    end
end)

-- ===== misc движение =====
uis.JumpRequest:Connect(function()
    if s.infjump then
        local c,h = alive()
        if h then pcall(function() h:ChangeState(Enum.HumanoidStateType.Jumping) end) end
    end
end)
task.spawn(function()
    while getgenv().lime_loaded do
        local c,h = alive()
        if c and h then
            pcall(function()
                if s.speedon then h.WalkSpeed = s.speed
                else if h.WalkSpeed ~= 16 then h.WalkSpeed = 16 end end
                if s.jpon then h.UseJumpPower = true h.JumpPower = s.jp end
            end)
        end
        task.wait(0.3)
    end
end)

-- ===== свет (пресеты меняют все освещение) =====
local oldlight = {clock = lighting.ClockTime, bright = lighting.Brightness, fog = lighting.FogEnd, amb = lighting.Ambient}
local function settime(clock) pcall(function() lighting.ClockTime = clock end) end
local function setfullbright(on)
    s.fullbright = on
    pcall(function()
        if on then
            oldlight.bright = lighting.Brightness oldlight.fog = lighting.FogEnd
            lighting.Brightness = 2 lighting.FogEnd = 100000 lighting.Ambient = Color3.fromRGB(255,255,255) lighting.OutdoorAmbient = Color3.fromRGB(255,255,255)
        else
            lighting.Brightness = oldlight.bright lighting.FogEnd = oldlight.fog lighting.Ambient = oldlight.amb
        end
    end)
end
local function setsky(mode)
    pcall(function()
        for _,v in pairs(lighting:GetChildren()) do if v:IsA("Sky") or v:IsA("Atmosphere") then v:Destroy() end end
        if mode == "clear" then return end
        local sky = Instance.new("Sky") sky.Parent = lighting
        if mode == "sunset" then
            sky.SkyboxBk = "rbxassetid://12064152" sky.SkyboxBd = "rbxassetid://12064152" sky.SkyboxDn = "rbxassetid://12064152"
            sky.SkyboxFt = "rbxassetid://12064152" sky.SkyboxLf = "rbxassetid://12064152" sky.SkyboxRt = "rbxassetid://12064152" sky.SkyboxUp = "rbxassetid://12064152"
            settime(17.6)
        elseif mode == "night" then
            sky.SkyboxBk = "rbxassetid://1036188" sky.SkyboxBd = "rbxassetid://1036188" sky.SkyboxDn = "rbxassetid://1036188"
            sky.SkyboxFt = "rbxassetid://1036188" sky.SkyboxLf = "rbxassetid://1036188" sky.SkyboxRt = "rbxassetid://1036188" sky.SkyboxUp = "rbxassetid://1036188"
            settime(0)
        elseif mode == "pink" then
            sky.SkyboxBk = "rbxassetid://0035504" sky.SkyboxBd = "rbxassetid://0035504" sky.SkyboxDn = "rbxassetid://0035504"
            sky.SkyboxFt = "rbxassetid://0035504" sky.SkyboxLf = "rbxassetid://0035504" sky.SkyboxRt = "rbxassetid://0035504" sky.SkyboxUp = "rbxassetid://0035504"
            settime(14)
        end
    end)
end
local function applystyle(name)
    pcall(function()
        if name == "день" then
            setfullbright(false)
            lighting.ClockTime = 14 lighting.Brightness = 1 lighting.FogEnd = 100000
            lighting.FogColor = Color3.fromRGB(200,200,200)
            lighting.Ambient = Color3.fromRGB(120,120,120) lighting.OutdoorAmbient = Color3.fromRGB(150,150,150)
            lighting.GlobalShadows = true
        elseif name == "закат" then
            setfullbright(false)
            lighting.ClockTime = 17.6 lighting.Brightness = 1.4 lighting.FogEnd = 700
            lighting.FogColor = Color3.fromRGB(255,150,80)
            lighting.Ambient = Color3.fromRGB(255,170,120) lighting.OutdoorAmbient = Color3.fromRGB(255,150,90)
            lighting.GlobalShadows = true
        elseif name == "ночь" then
            setfullbright(false)
            lighting.ClockTime = 0 lighting.Brightness = 0.8 lighting.FogEnd = 600
            lighting.FogColor = Color3.fromRGB(20,20,40)
            lighting.Ambient = Color3.fromRGB(60,60,100) lighting.OutdoorAmbient = Color3.fromRGB(40,40,80)
            lighting.GlobalShadows = true
        elseif name == "утро" then
            setfullbright(false)
            lighting.ClockTime = 7 lighting.Brightness = 1.1 lighting.FogEnd = 100000
            lighting.FogColor = Color3.fromRGB(200,200,200)
            lighting.Ambient = Color3.fromRGB(140,140,140) lighting.OutdoorAmbient = Color3.fromRGB(160,160,160)
            lighting.GlobalShadows = true
        end
    end)
    setstatus(name)
end

-- ===== cfg =====
local cfgfolder = "lime.cs"
pcall(function() if isfolder and not isfolder(cfgfolder) then makefolder(cfgfolder) end end)
local hasfiles = (typeof(writefile) == "function" and typeof(readfile) == "function" and typeof(listfiles) == "function")
local function cfgsave(name)
    if not hasfiles then setstatus("твой экзекутор без файлов") return false end
    if not name or name == "" then setstatus("впиши название cfg") return false end
    local snap = {}
    for k,v in pairs(s) do
        if k ~= "bangtarget" and k ~= "_firing" and (type(v) == "boolean" or type(v) == "number" or type(v) == "string") then
            snap[k] = v
        end
    end
    local ok, err = pcall(function()
        local data = http:JSONEncode(snap)
        writefile(cfgfolder.."/"..name..".json", data)
    end)
    if ok then setstatus("cfg сохранен: "..name) else setstatus("не вышло сохранить") end
    return ok
end
local function cfgapply()
    paint() paintbuttons()
    pcall(refreshesp)
    pcall(function() setfullbright(s.fullbright) end)
    if s.invisible then pcall(function() setinvisible(true) end) end
    pcall(function() if _G.lime_bind then _G.lime_bind.Text = "бинд выстрела: ["..string.lower(s.shootkey).."]" end end)
    pcall(function() if _G.lime_menubind then _G.lime_menubind.Text = "бинд меню: ["..string.lower(s.menukey).."]" end end)
    pcall(refreshfling) pcall(refreshtroll)
end
local function cfgload(name)
    if not hasfiles then setstatus("твой экзекутор без файлов") return false end
    local ok = pcall(function()
        local data = readfile(cfgfolder.."/"..name..".json")
        local t = http:JSONDecode(data)
        for k,v in pairs(t) do
            if k ~= "bangtarget" and k ~= "_firing" and s[k] ~= nil and type(v) == type(s[k]) then s[k] = v end
        end
    end)
    if ok then cfgapply() setstatus("cfg загружен: "..name) else setstatus("не вышло загрузить") end
    return ok
end
local function cfglist()
    local out = {}
    pcall(function()
        for _,f in pairs(listfiles(cfgfolder)) do
            local n = string.match(f, "([^/\\]+)%.json$")
            if n then table.insert(out, n) end
        end
    end)
    return out
end

-- ===== trail =====
local trailobjs = {}
local function updatetrail()
    if not s.trail then
        pcall(function() for _,o in pairs(trailobjs) do o:Destroy() end end)
        trailobjs = {}
        return
    end
    local c,h,hrp = alive()
    if not hrp then return end
    local tr = hrp:FindFirstChild("lime_trail")
    if not tr then
        pcall(function()
            local a0 = Instance.new("Attachment") a0.Name = "lime_a0" a0.Position = Vector3.new(0, 1, 0) a0.Parent = hrp
            local a1 = Instance.new("Attachment") a1.Name = "lime_a1" a1.Position = Vector3.new(0, -1, 0) a1.Parent = hrp
            tr = Instance.new("Trail")
            tr.Name = "lime_trail" tr.Attachment0 = a0 tr.Attachment1 = a1
            tr.Color = ColorSequence.new(getaccent())
            tr.Transparency = NumberSequence.new(0.2, 1)
            tr.Lifetime = 0.7 tr.MinLength = 0.1 tr.FaceCamera = true tr.LightEmission = 1
            tr.Enabled = true tr.Parent = hrp
            trailobjs = {tr, a0, a1}
        end)
    else
        pcall(function() tr.Color = ColorSequence.new(getaccent()) end)
    end
end
task.spawn(function()
    while getgenv().lime_loaded do
        if s.trail or #trailobjs > 0 then updatetrail() end
        task.wait(0.5)
    end
end)
localplayer.CharacterAdded:Connect(function() trailobjs = {} end)

-- ===== киллфид сверху =====
local function feedmsg(ru, en, color)
    local text = txt(ru, en)
    pcall(function()
        local ff = _G.lime_feed
        if not ff then return end
        local n = 0
        for _,c in pairs(ff:GetChildren()) do if c:IsA("TextLabel") then n = n + 1 end end
        while n > 3 do
            for _,c in pairs(ff:GetChildren()) do if c:IsA("TextLabel") then c:Destroy() n = n - 1 break end end
        end
        local l = Instance.new("TextLabel")
        l.Size = UDim2.new(1, 0, 0, 24)
        l.BackgroundColor3 = curtheme().bg2 l.BackgroundTransparency = 0.1
        l.Font = Enum.Font.Code l.TextSize = 13 l.TextColor3 = color or Color3.new(1,1,1)
        l.Text = text
        local cc = Instance.new("UICorner") cc.CornerRadius = UDim.new(0, 8) cc.Parent = l
        local st = Instance.new("UIStroke") st.Color = getaccent() st.Thickness = 1 st.Transparency = 0.4 st.Parent = l
        l.Parent = ff
        task.spawn(function()
            task.wait(4)
            if l.Parent then l:Destroy() end
        end)
    end)
end
local feedprev = {}
task.spawn(function()
    task.wait(3)
    while getgenv().lime_loaded do
        pcall(function()
            local myknife = getknife() ~= nil
            local mygun = getgun() ~= nil
            for _,p in pairs(players:GetPlayers()) do
                if p ~= localplayer then
                    local hum = p.Character and p.Character:FindFirstChildOfClass("Humanoid")
                    local alive2 = hum and hum.Health > 0
                    local role = getrole(p)
                    local was = feedprev[p.Name]
                    if was and was.alive and not alive2 then
                        local nick = string.lower(p.DisplayName)
                        if was.role == "murderer" then
                            if mygun then feedmsg("выстрелил: "..nick, "shooted: "..nick, Color3.fromRGB(80,140,255))
                            else feedmsg("мардер убит: "..nick, "murderer down: "..nick, Color3.fromRGB(255,60,60)) end
                        elseif was.role == "sheriff" then
                            feedmsg("gun dropped: "..nick, "gun dropped: "..nick, Color3.fromRGB(255,200,60))
                        elseif myknife then
                            feedmsg("killed: "..nick, "killed: "..nick, Color3.fromRGB(255,60,60))
                        end
                    end
                    feedprev[p.Name] = {alive = (alive2 and true or false), role = role}
                end
            end
        end)
        task.wait(1)
    end
end)

-- ===== anti coin (прячет монеты чтобы не подбирались) =====
local coinbackup = {}
local function setanticoin(on)
    s.anticoin = on
    if on then
        pcall(function()
            for _,v in pairs(findcoins()) do
                if coinbackup[v] == nil then
                    coinbackup[v] = {t = v.Transparency, c = v.CanTouch}
                    v.Transparency = 1 v.CanTouch = false
                end
            end
        end)
        setstatus(txt("anti coin вкл","anti coin on"))
    else
        pcall(function()
            for o,st in pairs(coinbackup) do pcall(function() o.Transparency = st.t o.CanTouch = st.c end) end
        end)
        coinbackup = {}
        setstatus(txt("anti coin выкл","anti coin off"))
    end
end
task.spawn(function()
    while getgenv().lime_loaded do
        if s.anticoin then
            pcall(function()
                for _,v in pairs(findcoins()) do
                    if coinbackup[v] == nil then
                        coinbackup[v] = {t = v.Transparency, c = v.CanTouch}
                        v.Transparency = 1 v.CanTouch = false
                    end
                end
            end)
        end
        task.wait(2)
    end
end)

-- ===== anti fling (гасит чужой флинг) =====
local safepos = nil
task.spawn(function()
    while getgenv().lime_loaded do
        if s.antifling then
            local c,h,hrp = alive()
            if hrp then
                local mag = hrp.Velocity.Magnitude
                if mag > 120 and not flingactive and not killing and not s.coinfarm then
                    pcall(function()
                        hrp.Velocity = Vector3.new(0,0,0) hrp.RotVelocity = Vector3.new(0,0,0)
                        if safepos and (hrp.Position - safepos).Magnitude > 40 then
                            hrp.CFrame = CFrame.new(safepos + Vector3.new(0,3,0))
                        end
                    end)
                elseif mag < 50 then
                    safepos = hrp.Position
                end
            end
            runservice.Heartbeat:Wait()
        else task.wait(0.5) end
    end
end)

-- ===== triggerbot только по мардеру =====
local trigcd = 0
task.spawn(function()
    while getgenv().lime_loaded do
        if s.triggerbot then
            pcall(function()
                local c,h,hrp = alive()
                local m = findmurderer()
                local cam = workspace.CurrentCamera
                if c and hrp and m and m.Character and cam then
                    local eq = c:FindFirstChild("Gun") or c:FindFirstChild("Revolver")
                    if not eq then
                        local g = getgun()
                        if g and g.Parent ~= c then
                            pcall(function() h:EquipTool(g) end)
                        end
                    else
                        local ml = uis:GetMouseLocation()
                        local ray = cam:ScreenPointToRay(ml.X, ml.Y)
                        local params = RaycastParams.new()
                        params.FilterType = Enum.RaycastFilterType.Blacklist
                        params.FilterDescendantsInstances = {c}
                        params.IgnoreWater = true
                        local res = workspace:Raycast(ray.Origin, ray.Direction * 1000, params)
                        if res and res.Instance and res.Instance:IsDescendantOf(m.Character) then
                            trigcd = tick()
                            eq:Activate()
                            setstatus("triggerbot выстрел")
                        end
                    end
                end
            end)
            runservice.Heartbeat:Wait()
        else task.wait(0.4) end
    end
end)

-- ===== ауры вокруг тела под цвет акцента =====
local auraparts = {}
local function auraclear()
    pcall(function() for _,p in pairs(auraparts) do p:Destroy() end end)
    auraparts = {}
end
local function auradot(i, shape, size)
    local d = auraparts[i]
    if not d or not d.Parent then
        d = Instance.new("Part")
        d.Name = "lime_aura" d.Shape = shape
        d.Size = size
        d.Material = Enum.Material.Neon d.Color = getaccent()
        d.Anchored = true d.CanCollide = false d.CanQuery = false d.CanTouch = false
        d.Parent = workspace
        auraparts[i] = d
    end
    d.Color = getaccent()
    return d
end
task.spawn(function()
    local pulsering = nil
    while getgenv().lime_loaded do
        if s.aura_rings or s.aura_chains or s.aura_spiral or s.aura_orbit or s.aura_pulse then
            local c,h,hrp = alive()
            if hrp then
                local t = tick()
                local idx = 0
                if s.aura_rings then
                    for i=1,12 do
                        idx = idx + 1
                        local d = auradot(idx, Enum.PartType.Ball, Vector3.new(0.4,0.4,0.4))
                        local a = t * 3 + (i - 1) * math.pi / 6
                        d.CFrame = CFrame.new(hrp.Position + Vector3.new(math.cos(a) * 3, 1 + math.sin(t * 2 + i) * 0.3, math.sin(a) * 3))
                    end
                    for i=1,10 do
                        idx = idx + 1
                        local d = auradot(idx, Enum.PartType.Ball, Vector3.new(0.3,0.3,0.3))
                        local a = -t * 2 + (i - 1) * math.pi / 5
                        d.CFrame = CFrame.new(hrp.Position + Vector3.new(math.cos(a) * 2.2, 0.2 + (i % 3) * 0.9, 0)) * CFrame.Angles(0, 0, math.rad(35))
                        d.Position = hrp.Position + Vector3.new(math.cos(a) * 2.2, 0.2 + (i % 3) * 0.9, math.sin(a) * 2.2)
                    end
                end
                if s.aura_chains then
                    for i=1,8 do
                        idx = idx + 1
                        local d = auradot(idx, Enum.PartType.Block, Vector3.new(0.35,0.35,0.35))
                        local a = t * 1.5 + (i - 1) * math.pi / 4
                        d.CFrame = CFrame.new(hrp.Position + Vector3.new(math.cos(a) * 2, 1 + math.sin(t * 4 + i * 1.3) * 0.9, math.sin(a) * 2)) * CFrame.Angles(a, t, 0)
                    end
                end
                if s.aura_spiral then
                    for i=1,16 do
                        idx = idx + 1
                        local d = auradot(idx, Enum.PartType.Ball, Vector3.new(0.3,0.3,0.3))
                        local a = t * 4 + i * 0.5
                        d.CFrame = CFrame.new(hrp.Position + Vector3.new(math.cos(a) * 1.8, (i / 16) * 5, math.sin(a) * 1.8))
                    end
                end
                if s.aura_orbit then
                    for i=1,4 do
                        idx = idx + 1
                        local d = auradot(idx, Enum.PartType.Ball, Vector3.new(0.8,0.8,0.8))
                        local a = t * 1.2 + (i - 1) * math.pi / 2
                        d.CFrame = CFrame.new(hrp.Position + Vector3.new(math.cos(a) * 5, 1.5 + math.sin(t + i) * 0.5, math.sin(a) * 5))
                    end
                end
                if s.aura_pulse then
                    if not pulsering or not pulsering.Parent then
                        pulsering = Instance.new("Part")
                        pulsering.Name = "lime_aura" pulsering.Shape = Enum.PartType.Cylinder
                        pulsering.Material = Enum.Material.Neon pulsering.Color = getaccent()
                        pulsering.Anchored = true pulsering.CanCollide = false pulsering.CanQuery = false pulsering.CanTouch = false
                        pulsering.Parent = workspace
                    end
                    pulsering.Color = getaccent()
                    local rr = (t * 3) % 5 + 0.5
                    pulsering.Size = Vector3.new(0.2, rr * 2, rr * 2)
                    pulsering.Transparency = rr / 5.5
                    pulsering.CFrame = CFrame.new(hrp.Position - Vector3.new(0, 2.8, 0)) * CFrame.Angles(0, 0, math.rad(90))
                elseif pulsering then
                    pcall(function() pulsering:Destroy() end)
                    pulsering = nil
                end
                -- лишние точки убрать
                for i=idx+1,#auraparts do
                    pcall(function() auraparts[i]:Destroy() end)
                    auraparts[i] = nil
                end
            else
                auraclear()
            end
            runservice.Heartbeat:Wait()
        else
            if #auraparts > 0 then auraclear() end
            if pulsering then pcall(function() pulsering:Destroy() end) pulsering = nil end
            task.wait(0.5)
        end
    end
end)
localplayer.CharacterAdded:Connect(function() auraclear() end)

-- ===== бинды =====
local listening_shoot, listening_menu = false, false
uis.InputBegan:Connect(function(input,gpe)
    if gpe then return end
    if listening_shoot then
        if input.KeyCode ~= Enum.KeyCode.Unknown then
            s.shootkey = input.KeyCode.Name listening_shoot = false
            pcall(function() if _G.lime_bind then _G.lime_bind.Text = txt("бинд выстрела: [","shoot bind: [")..string.lower(s.shootkey).."]" end end)
            setstatus("бинд выстрела: "..string.lower(s.shootkey))
        end
        return
    end
    if listening_menu then
        if input.KeyCode ~= Enum.KeyCode.Unknown then
            s.menukey = input.KeyCode.Name listening_menu = false
            pcall(function() if _G.lime_menubind then _G.lime_menubind.Text = txt("бинд меню: [","menu bind: [")..string.lower(s.menukey).."]" end end)
            setstatus("бинд меню: "..string.lower(s.menukey))
        end
        return
    end
    -- сайлент: при клике курсор сам прыгает на мардера до выстрела
    if input.UserInputType == Enum.UserInputType.MouseButton1 and s.silentaim and typeof(mousemoveabs) == "function" then
        pcall(function()
            local eq = localplayer.Character and (localplayer.Character:FindFirstChild("Gun") or localplayer.Character:FindFirstChild("Revolver"))
            local m = findmurderer()
            if eq and m and m.Character then
                local tm = m.Character:FindFirstChild("HumanoidRootPart")
                local cam2 = workspace.CurrentCamera
                if tm and cam2 then
                    local sp, on = cam2:WorldToScreenPoint(tm.Position)
                    if on then
                        local old = uis:GetMouseLocation()
                        mousemoveabs(sp.X, sp.Y)
                        task.spawn(function()
                            task.wait(0.2)
                            pcall(function() mousemoveabs(old.X, old.Y) end)
                        end)
                    end
                end
            end
        end)
    end
    pcall(function()
        if input.KeyCode.Name == s.menukey then
            local g = localplayer:FindFirstChildOfClass("PlayerGui"):FindFirstChild("lime_cs")
            if g then local m = g:FindFirstChild("main") if m then m.Visible = not m.Visible end end
        elseif input.KeyCode.Name == s.shootkey then
            shootmurderer()
        end
    end)
end)

-- ===== гуи lime.cs =====
local function guiparent()
    local ok, pg = pcall(function() return localplayer:WaitForChild("PlayerGui",2) end)
    if ok and pg then return pg end
    return game:GetService("CoreGui")
end
local gui = Instance.new("ScreenGui")
gui.Name = "lime_cs" gui.ResetOnSpawn = false gui.IgnoreGuiInset = true gui.DisplayOrder = 999
gui.Parent = guiparent()

local themes = {
    black = {bg=Color3.fromRGB(24,24,30), bg2=Color3.fromRGB(33,33,42), bg3=Color3.fromRGB(48,48,60), txt=Color3.fromRGB(255,255,255), dim=Color3.fromRGB(170,170,185)},
    white = {bg=Color3.fromRGB(245,245,248), bg2=Color3.fromRGB(225,225,232), bg3=Color3.fromRGB(205,205,215), txt=Color3.fromRGB(15,15,18), dim=Color3.fromRGB(90,90,105)}
}
local function curtheme() if s.theme == "white" then return themes.white end return themes.black end
local function paint()
    local t = curtheme() local ac = getaccent()
    for _,o in pairs(gui:GetDescendants()) do
        local ok, kind = pcall(function() return o:GetAttribute("kind") end)
        if ok and kind then
            if kind == "bg" then o.BackgroundColor3 = t.bg
            elseif kind == "bg2" then o.BackgroundColor3 = t.bg2
            elseif kind == "bg3" then o.BackgroundColor3 = t.bg3
            elseif kind == "txt" then if o:IsA("TextLabel") or o:IsA("TextButton") or o:IsA("TextBox") then o.TextColor3 = t.txt end
            elseif kind == "dim" then if o:IsA("TextLabel") or o:IsA("TextButton") then o.TextColor3 = t.dim end
            elseif kind == "accent" then o.BackgroundColor3 = ac
            elseif kind == "accenttxt" then if o:IsA("TextLabel") or o:IsA("TextButton") then o.TextColor3 = ac end
            elseif kind == "accentstroke" then if o:IsA("UIStroke") then o.Color = ac end
            end
        end
    end
end
local function mk(kind, class, props, parent)
    local o = Instance.new(class)
    for k,v in pairs(props) do pcall(function() o[k] = v end) end
    o:SetAttribute("kind", kind)
    o.Parent = parent
    return o
end
local function corner(p, r) local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, math.min((r or 4) + 4, 12)) c.Parent = p return c end
local function drag(handle, target)
    local dragging, ds, sp = false, nil, nil
    handle.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dragging = true ds = i.Position sp = target.Position
            i.Changed:Connect(function() if i.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    uis.InputChanged:Connect(function(i)
        if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
            local d = i.Position - ds
            target.Position = UDim2.new(sp.X.Scale, sp.X.Offset + d.X, sp.Y.Scale, sp.Y.Offset + d.Y)
        end
    end)
end

-- главное окно (пока скрыто, покажется после загрузки)
local main = mk("bg", "Frame", {Name = "main", Size = UDim2.new(0,640,0,400), Position = UDim2.new(0.5,-320,0.5,-200), BorderSizePixel = 0, Active = true, Visible = false}, gui)
corner(main, 4)
local mstroke = Instance.new("UIStroke", main) mstroke.Color = Color3.fromRGB(0,0,0) mstroke.Thickness = 1
local topbar = mk("accent", "Frame", {Size = UDim2.new(1,0,0,3), BorderSizePixel = 0, BackgroundColor3 = getaccent()}, main)
local header = mk("bg2", "Frame", {Size = UDim2.new(1,0,0,42), Position = UDim2.new(0,0,0,3), BorderSizePixel = 0}, main)
local htitle = mk("txt", "TextLabel", {Size = UDim2.new(1,-60,1,0), Position = UDim2.new(0,14,0,0), BackgroundTransparency = 1, Font = Enum.Font.GothamBold, TextSize = 15, TextXAlignment = Enum.TextXAlignment.Left, Text = "lime.cs"}, header)
task.spawn(function()
    local base = "lime.cs"
    while getgenv().lime_loaded and htitle.Parent do
        for i=1,#base do
            if not getgenv().lime_loaded or not htitle.Parent then return end
            htitle.Text = string.sub(base, 1, i)
            task.wait(0.35)
        end
        task.wait(0.02)
        while #htitle.Text > 0 do
            if not getgenv().lime_loaded or not htitle.Parent then return end
            htitle.Text = string.sub(htitle.Text, 1, #htitle.Text - 1)
            task.wait(0.12)
        end
        task.wait(0.3)
    end
end)
local closeb = mk("bg3", "TextButton", {Size = UDim2.new(0,32,0,26), Position = UDim2.new(1,-40,0,8), Text = "x", Font = Enum.Font.GothamBold, TextSize = 14, BorderSizePixel = 0}, header)
closeb.Name = "closeb_fix" corner(closeb, 4)
closeb.MouseButton1Click:Connect(function()
    getgenv().lime_loaded = false
    for _,p in pairs(players:GetPlayers()) do clearesp(p) end
    gui:Destroy()
end)
drag(header, main)
-- ресайз окна как в windows, тяни за угол
local grip = Instance.new("TextButton") grip.Size = UDim2.new(0,22,0,22) grip.Position = UDim2.new(1,-22,1,-22)
grip.BackgroundTransparency = 1 grip.Text = "◢" grip.Font = Enum.Font.GothamBold grip.TextSize = 14 grip.TextColor3 = curtheme().dim grip.Parent = main
grip:SetAttribute("kind","dim")
do
    local resizing, gs, sz0 = false, nil, nil
    grip.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            resizing = true gs = i.Position sz0 = main.Size
            i.Changed:Connect(function() if i.UserInputState == Enum.UserInputState.End then resizing = false end end)
        end
    end)
    uis.InputChanged:Connect(function(i)
        if resizing and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
            local d = i.Position - gs
            local nw = math.clamp(sz0.X.Offset + d.X, 560, 900)
            local nh = math.clamp(sz0.Y.Offset + d.Y, 360, 650)
            main.Size = UDim2.new(0, nw, 0, nh)
        end
    end)
end

-- фурри сидит справа над гуи
local furry = Instance.new("Frame") furry.Size = UDim2.new(0,110,0,56) furry.Position = UDim2.new(1,-100,0,-56) furry.BackgroundTransparency = 1 furry.Parent = main
local furrytxt = Instance.new("TextLabel") furrytxt.Size = UDim2.new(1,0,0,28) furrytxt.Position = UDim2.new(0,0,1,-28)
furrytxt.BackgroundTransparency = 1 furrytxt.Font = Enum.Font.GothamBold furrytxt.TextSize = 22 furrytxt.Text = "/(=^･ω･^=)\\" furrytxt.TextColor3 = getaccent() furrytxt.Parent = furry
furrytxt:SetAttribute("kind","accenttxt")
local furrytxt2 = Instance.new("TextLabel") furrytxt2.Size = UDim2.new(1,0,0,16) furrytxt2.Position = UDim2.new(0,0,1,-12)
furrytxt2.BackgroundTransparency = 1 furrytxt2.Font = Enum.Font.Code furrytxt2.TextSize = 11 furrytxt2.Text = txt("lime сидит тут","lime sits here") furrytxt2.TextColor3 = curtheme().dim furrytxt2.Parent = furry
furrytxt2:SetAttribute("kind","dim")

-- вотермарка снизу по центру, ширина под текст
local wm = mk("bg2", "Frame", {AnchorPoint = Vector2.new(0.5,1), Size = UDim2.new(0,340,0,28), Position = UDim2.new(0.5,0,1,-130), BorderSizePixel = 0, Active = true, Visible = false}, gui)
corner(wm, 4)
local wms = Instance.new("UIStroke", wm) wms.Thickness = 1 wms.Transparency = 0.4 wms.Color = getaccent() wms:SetAttribute("kind", "accentstroke")
local wmpad = Instance.new("UIPadding", wm) wmpad.PaddingLeft = UDim.new(0,12) wmpad.PaddingRight = UDim.new(0,12)
local wmtxt = mk("txt", "TextLabel", {Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Font = Enum.Font.Code, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Center, Text = "lime.cs | загрузка..."}, wm)
drag(wm, wm)
local function fitsizewm()
    pcall(function()
        local sz = textservice:GetTextSize(wmtxt.Text, 13, Enum.Font.Code, Vector2.new(2000,28))
        wm.Size = UDim2.new(0, math.clamp(sz.X + 28, 200, 700), 0, 28)
    end)
end
task.spawn(function()
    while getgenv().lime_loaded and wm.Parent do
        local fps = 60
        pcall(function() fps = math.floor(1/math.max(runservice.RenderStepped:Wait(),0.001)) end)
        local ping = "0"
        pcall(function() ping = tostring(math.floor(stats.Network.ServerStatsItem["Data Ping"]:GetValue())) end)
        local m, sher = "?","?"
        for _,p in pairs(players:GetPlayers()) do
            if p ~= localplayer and p.Character then
                local r = getrole(p)
                if r == "murderer" then m = string.lower(p.DisplayName) end
                if r == "sheriff" then sher = string.lower(p.DisplayName) end
            end
        end
        wmtxt.Text = "lime.cs | "..fps.." fps | "..ping.." ms | "..txt("м: ","m: ")..m.." | "..txt("ш: ","s: ")..sher
        fitsizewm()
        task.wait(1)
    end
end)

-- киллфид сверху по центру
local feedframe = Instance.new("Frame") feedframe.Size = UDim2.new(0,300,0,120) feedframe.Position = UDim2.new(0.5,-150,0,10)
feedframe.BackgroundTransparency = 1 feedframe.Parent = gui
local feedlay = Instance.new("UIListLayout") feedlay.Padding = UDim.new(0,4) feedlay.HorizontalAlignment = Enum.HorizontalAlignment.Center feedlay.SortOrder = Enum.SortOrder.LayoutOrder feedlay.Parent = feedframe
_G.lime_feed = feedframe
task.spawn(function()
    task.wait(3.5)
    if getgenv().lime_loaded then feedmsg("lime.cs загружен","lime.cs loaded", getaccent()) end
end)

-- карточка мардер/шериф с аватарами над вотермаркой
local thumbcache = {}
local function getthumb(plr)
    if not plr then return "" end
    if thumbcache[plr.UserId] then return thumbcache[plr.UserId] end
    local ok, content = pcall(function()
        return players:GetUserThumbnailAsync(plr.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100, false)
    end)
    if ok and content and content ~= "" then thumbcache[plr.UserId] = content return content end
    return ""
end
-- свой профиль внутри гуи: аватарка + ник
local pwin = Instance.new("Frame") pwin.Size = UDim2.new(0,210,0,86) pwin.Position = UDim2.new(0,12,1,-150)
pwin.BackgroundColor3 = curtheme().bg2 pwin.BorderSizePixel = 0 pwin.Active = true pwin.Parent = gui
corner(pwin, 6)
local pwst = Instance.new("UIStroke", pwin) pwst.Thickness = 1 pwst.Transparency = 0.4 pwst.Color = getaccent()
local pimg = Instance.new("ImageLabel") pimg.Size = UDim2.new(0,70,0,70) pimg.Position = UDim2.new(0,8,0,8)
pimg.BackgroundColor3 = curtheme().bg3 pimg.Image = getthumb(localplayer) pimg.Parent = pwin
local prow = Instance.new("UICorner") prow.CornerRadius = UDim.new(1,0) prow.Parent = pimg
local pname = Instance.new("TextLabel") pname.Size = UDim2.new(1,-92,0,26) pname.Position = UDim2.new(0,86,0,8)
pname.BackgroundTransparency = 1 pname.Font = Enum.Font.GothamBold pname.TextSize = 15 pname.TextXAlignment = Enum.TextXAlignment.Left
pname.TextColor3 = curtheme().txt pname.TextTruncate = Enum.TextTruncate.AtEnd pname.Text = string.lower(localplayer.DisplayName) pname.Parent = pwin
local psub = Instance.new("TextLabel") psub.Size = UDim2.new(1,-92,0,20) psub.Position = UDim2.new(0,86,0,36)
psub.BackgroundTransparency = 1 psub.Font = Enum.Font.Code psub.TextSize = 12 psub.TextXAlignment = Enum.TextXAlignment.Left
psub.TextColor3 = curtheme().dim psub.TextTruncate = Enum.TextTruncate.AtEnd psub.Text = "@"..string.lower(localplayer.Name) psub.Parent = pwin
local pid = Instance.new("TextLabel") pid.Size = UDim2.new(1,-92,0,18) pid.Position = UDim2.new(0,86,0,58)
pid.BackgroundTransparency = 1 pid.Font = Enum.Font.Code pid.TextSize = 11 pid.TextXAlignment = Enum.TextXAlignment.Left
pid.TextColor3 = curtheme().dim pid.Text = "id: "..localplayer.UserId pid.Parent = pwin
drag(pwin, pwin)
task.spawn(function()
    while getgenv().lime_loaded and pwin.Parent do
        pwin.BackgroundColor3 = curtheme().bg2
        pwst.Color = getaccent()
        pname.TextColor3 = curtheme().txt
        psub.TextColor3 = curtheme().dim
        pid.TextColor3 = curtheme().dim
        if pimg.Image == "" then pimg.Image = getthumb(localplayer) end
        task.wait(3)
    end
end)

local side = mk("bg2", "Frame", {Size = UDim2.new(0,140,1,-45), Position = UDim2.new(0,0,0,45), BorderSizePixel = 0}, main)
local pages, tabs = {}, {}
local function selecttab(name)
    local t = curtheme()
    for n,f in pairs(pages) do f.Visible = (n == name) end
    for n,b in pairs(tabs) do
        local on = (n == name)
        b.BackgroundColor3 = on and t.bg3 or t.bg2
        local lbl = b:FindFirstChildOfClass("TextLabel")
        if lbl then lbl.TextColor3 = on and getaccent() or t.dim end
        local bar = b:FindFirstChild("Bar")
        if bar then bar.BackgroundColor3 = getaccent() bar.Visible = on end
    end
end
local function maketab(name, order)
    local t = curtheme()
    local b = Instance.new("TextButton") b.Size = UDim2.new(1,0,0,28) b.Position = UDim2.new(0,0,0,(order-1)*28)
    b.BackgroundColor3 = t.bg2 b.BorderSizePixel = 0 b.Text = "" b.Parent = side
    local bar = Instance.new("Frame") bar.Name = "Bar" bar.Size = UDim2.new(0,3,1,0) bar.BackgroundColor3 = getaccent() bar.BorderSizePixel = 0 bar.Visible = false bar.Parent = b
    local l = Instance.new("TextLabel") l.Size = UDim2.new(1,-14,1,0) l.Position = UDim2.new(0,14,0,0)
    l.BackgroundTransparency = 1 l.Font = Enum.Font.GothamBold l.TextSize = 13 l.TextXAlignment = Enum.TextXAlignment.Left l.Text = name l.TextColor3 = t.dim l.Parent = b
    b.MouseButton1Click:Connect(function() selecttab(name) end)
    tabs[name] = b
    local page = Instance.new("Frame") page.Size = UDim2.new(1,-156,1,-100) page.Position = UDim2.new(0,148,0,53)
    page.BackgroundTransparency = 1 page.Visible = false page.Parent = main
    pages[name] = page
    return page
end

local pvis = maketab("visuals",1)
local pfarm = maketab("farm",2)
local pshoot = maketab("shoot",3)
local pkill = maketab("kill",4)
local pfling = maketab("fling",5)
local pmisc = maketab("misc",6)
local ptp = maketab("teleport",7)
local paura = maketab("aura",8)
local pquick = maketab(txt("кнопки","buttons"),9)
local pcfg = maketab("cfg",10)
local pset = maketab("settings",11)

local function seclabel(par,y,text)
    local l = Instance.new("TextLabel") l.Size = UDim2.new(1,-10,0,24) l.Position = UDim2.new(0,0,0,y)
    l.BackgroundTransparency = 1 l.Font = Enum.Font.GothamBold l.TextSize = 13 l.TextXAlignment = Enum.TextXAlignment.Left
    l.TextColor3 = getaccent() l.Text = text l.Parent = par
    l:SetAttribute("kind", "accenttxt") return l
end
local function checkbox(par, y, text, val, cb)
    local t = curtheme()
    local f = Instance.new("Frame") f.Size = UDim2.new(1,-10,0,28) f.Position = UDim2.new(0,0,0,y) f.BackgroundTransparency = 1 f.Parent = par
    local box = Instance.new("TextButton") box.Size = UDim2.new(0,18,0,18) box.Position = UDim2.new(0,0,0,5)
    box.Text = "" box.BackgroundColor3 = val and getaccent() or t.bg3 box.BorderSizePixel = 0 box.Parent = f
    corner(box, 4)
    local st = Instance.new("UIStroke") st.Thickness = 1 st.Transparency = val and 0 or 0.6 st.Color = getaccent() st.Parent = box st:SetAttribute("kind","accentstroke")
    local l = Instance.new("TextLabel") l.Size = UDim2.new(1,-28,1,0) l.Position = UDim2.new(0,28,0,0)
    l.BackgroundTransparency = 1 l.Font = Enum.Font.Gotham l.TextSize = 14 l.TextXAlignment = Enum.TextXAlignment.Left
    l.TextColor3 = t.txt l.Text = text l.Parent = f l:SetAttribute("kind","txt")
    local state = val
    box.MouseButton1Click:Connect(function()
        state = not state
        box.BackgroundColor3 = state and getaccent() or curtheme().bg3
        st.Transparency = state and 0 or 0.6
        cb(state)
    end)
    if text == "coin farm" then
        pcall(function()
            box.MouseButton2Click:Connect(function() if _G.lime_farmwin then _G.lime_farmwin.Visible = true end end)
        end)
        f.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton2 then if _G.lime_farmwin then _G.lime_farmwin.Visible = true end end end)
    end
    return f
end
local function button(par,y,text,cb)
    local b = Instance.new("TextButton") b.Size = UDim2.new(1,-10,0,32) b.Position = UDim2.new(0,0,0,y)
    b.BackgroundColor3 = curtheme().bg3 b.Text = text b.Font = Enum.Font.GothamBold b.TextSize = 14 b.TextColor3 = getaccent() b.BorderSizePixel = 0 b.Parent = par
    b:SetAttribute("kind","bg3") b.Name = "btn_"..text
    corner(b, 8)
    local st = Instance.new("UIStroke") st.Transparency = 0.55 st.Thickness = 1 st.Color = getaccent() st.Parent = b st:SetAttribute("kind","accentstroke")
    b.MouseButton1Click:Connect(cb)
    return b
end
local function paintbuttons()
    for _,o in pairs(gui:GetDescendants()) do
        if o:IsA("TextButton") and string.sub(o.Name,1,4) == "btn_" then o.TextColor3 = getaccent() end
        if o.Name == "closeb_fix" then o.TextColor3 = curtheme().dim end
    end
end
local function stepper(par, y, label, val, minv, maxv, step, cb)
    local t = curtheme()
    local l = Instance.new("TextLabel") l.Size = UDim2.new(1,-10,0,22) l.Position = UDim2.new(0,0,0,y)
    l.BackgroundTransparency = 1 l.Font = Enum.Font.Gotham l.TextSize = 13 l.TextXAlignment = Enum.TextXAlignment.Left
    l.TextColor3 = t.txt l.Text = label..": "..tostring(val) l.Parent = par l:SetAttribute("kind","txt")
    local minus = Instance.new("TextButton") minus.Size = UDim2.new(0,60,0,26) minus.Position = UDim2.new(0,0,0,y+24)
    minus.BackgroundColor3 = curtheme().bg3 minus.Text = "-" minus.Font = Enum.Font.GothamBold minus.TextSize = 16 minus.TextColor3 = getaccent() minus.BorderSizePixel = 0 minus.Parent = par minus:SetAttribute("kind","bg3") minus.Name = "btn_m"..label corner(minus,8)
    local st1 = Instance.new("UIStroke") st1.Transparency = 0.55 st1.Thickness = 1 st1.Color = getaccent() st1.Parent = minus st1:SetAttribute("kind","accentstroke")
    local plus = Instance.new("TextButton") plus.Size = UDim2.new(0,60,0,26) plus.Position = UDim2.new(0,66,0,y+24)
    plus.BackgroundColor3 = curtheme().bg3 plus.Text = "+" plus.Font = Enum.Font.GothamBold plus.TextSize = 16 plus.TextColor3 = getaccent() plus.BorderSizePixel = 0 plus.Parent = par plus:SetAttribute("kind","bg3") plus.Name = "btn_p"..label corner(plus,8)
    local st2 = Instance.new("UIStroke") st2.Transparency = 0.55 st2.Thickness = 1 st2.Color = getaccent() st2.Parent = plus st2:SetAttribute("kind","accentstroke")
    local cur = val
    minus.MouseButton1Click:Connect(function() cur = math.max(minv, cur - step) l.Text = label..": "..tostring(cur) cb(cur) paintbuttons() end)
    plus.MouseButton1Click:Connect(function() cur = math.min(maxv, cur + step) l.Text = label..": "..tostring(cur) cb(cur) paintbuttons() end)
end

-- visuals со скроллом (esp + визуалы + время)
local visscroll = Instance.new("ScrollingFrame") visscroll.Size = UDim2.new(1,-4,1,0) visscroll.Position = UDim2.new(0,0,0,0)
visscroll.BackgroundTransparency = 1 visscroll.ScrollBarThickness = 3 visscroll.CanvasSize = UDim2.new(0,0,0,480) visscroll.Parent = pvis
seclabel(visscroll,0,txt("player esp","player esp"))
checkbox(visscroll,26,txt("вкл","enabled"),s.esp,function(v) s.esp=v if not v then for _,p in pairs(players:GetPlayers()) do clearesp(p) end else refreshesp() end end)
checkbox(visscroll,54,"chams",s.chams,function(v) s.chams=v refreshesp() end)
checkbox(visscroll,82,"names + role",s.names,function(v) s.names=v refreshesp() end)
checkbox(visscroll,110,txt("показ innocent","show innocent"),s.showinnocent,function(v) s.showinnocent=v refreshesp() end)
checkbox(visscroll,138,"fullbright",s.fullbright,function(v) setfullbright(v) end)
seclabel(visscroll,166,txt("player visuals","player visuals"))
checkbox(visscroll,192,"bullet tracer",s.tracer,function(v) s.tracer=v setstatus("tracer "..(v and txt("вкл","on") or txt("выкл","off"))) end)
checkbox(visscroll,220,"halo",s.chinahat,function(v) s.chinahat=v if not v then updatechinahat() end end)
checkbox(visscroll,248,"jump circle",s.jumpcircle,function(v) s.jumpcircle=v end)
checkbox(visscroll,276,"trail",s.trail,function(v) s.trail=v if not v then updatetrail() end end)
seclabel(visscroll,304,txt("время суток","day time"))
button(visscroll,330,txt("день","day"),function() applystyle("день") end)
button(visscroll,366,txt("закат","sunset"),function() applystyle("закат") end)
button(visscroll,402,txt("ночь","night"),function() applystyle("ночь") end)
button(visscroll,438,txt("утро","morning"),function() applystyle("утро") end)

-- farm
seclabel(pfarm,0,"auto farm")
checkbox(pfarm,26,"coin farm",s.coinfarm,function(v) s.coinfarm=v end)
local farmcount = Instance.new("TextLabel") farmcount.Size = UDim2.new(1,-10,0,20) farmcount.Position = UDim2.new(0,0,0,54)
farmcount.BackgroundTransparency = 1 farmcount.Font = Enum.Font.Code farmcount.TextSize = 11 farmcount.TextXAlignment = Enum.TextXAlignment.Left
farmcount.TextColor3 = curtheme().dim farmcount.Text = txt("монет на карте: 0","coins on map: 0") farmcount.Parent = pfarm farmcount:SetAttribute("kind","dim")
task.spawn(function()
    while getgenv().lime_loaded and farmcount.Parent do
        farmcount.Text = txt("монет на карте: ","coins on map: ")..tostring(_G.lime_coins or 0)..txt(" | пкм по coin farm = настройки"," | rightclick coin farm = settings")
        task.wait(1)
    end
end)
button(pfarm,78,txt("настройки фарма (скорость)","farm settings (speed)"),function() if _G.lime_farmwin then _G.lime_farmwin.Visible = not _G.lime_farmwin.Visible end end)
button(pfarm,114,txt("подобрать ган и вернуться","grab gun and return"),function() grabgunreturn() end)
button(pfarm,150,"teleport to coins",function()
    local c,h,hrp = alive() if not hrp then return end
    local coins = findcoins() if #coins > 0 then hrp.CFrame = coins[1].CFrame + Vector3.new(0,3,0) end
end)

local farmwin = mk("bg2", "Frame", {Size = UDim2.new(0,220,0,130), Position = UDim2.new(1,-230,0,60), BorderSizePixel = 0, Visible = false}, main)
corner(farmwin, 4)
local fwst = Instance.new("UIStroke", farmwin) fwst.Color = getaccent() fwst.Thickness = 1 fwst:SetAttribute("kind","accentstroke")
local fwt = mk("txt", "TextLabel", {Size = UDim2.new(1,-10,0,24), Position = UDim2.new(0,10,0,6), BackgroundTransparency = 1, Font = Enum.Font.GothamBold, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, Text = txt("настройки фарма","farm settings")}, farmwin)
local fwclose = mk("bg3", "TextButton", {Size = UDim2.new(0,26,0,22), Position = UDim2.new(1,-32,0,6), Text = "x", Font = Enum.Font.GothamBold, TextSize = 12, BorderSizePixel = 0}, farmwin)
corner(fwclose,4) fwclose.Name = "btn_fwx"
fwclose.MouseButton1Click:Connect(function() farmwin.Visible = false end)
drag(fwt, farmwin)
_G.lime_farmwin = farmwin
local fwlabel = mk("txt", "TextLabel", {Size = UDim2.new(1,-10,0,20), Position = UDim2.new(0,10,0,34), BackgroundTransparency = 1, Font = Enum.Font.Gotham, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, Text = "скорость: "..tostring(s.farmdelay)}, farmwin)
local fwm = mk("bg3", "TextButton", {Size = UDim2.new(0,60,0,26), Position = UDim2.new(0,10,0,58), Text = "-", Font = Enum.Font.GothamBold, TextSize = 16, TextColor3 = Color3.fromRGB(190,255,70), BorderSizePixel = 0}, farmwin)
corner(fwm,8) fwm.Name = "btn_fwm"
local fwp = mk("bg3", "TextButton", {Size = UDim2.new(0,60,0,26), Position = UDim2.new(0,76,0,58), Text = "+", Font = Enum.Font.GothamBold, TextSize = 16, TextColor3 = Color3.fromRGB(190,255,70), BorderSizePixel = 0}, farmwin)
corner(fwp,8) fwp.Name = "btn_fwp"
local fwhint = mk("dim", "TextLabel", {Size = UDim2.new(1,-20,0,30), Position = UDim2.new(0,10,0,90), BackgroundTransparency = 1, Font = Enum.Font.Code, TextSize = 11, TextXAlignment = Enum.TextXAlignment.Left, TextWrapped = true, Text = txt("меньше = быстрее, но может кикать","lower = faster but may kick")}, farmwin)
fwm.MouseButton1Click:Connect(function() s.farmdelay = math.max(0.1, s.farmdelay - 0.05) fwlabel.Text = "скорость: "..string.format("%.2f", s.farmdelay) paintbuttons() end)
fwp.MouseButton1Click:Connect(function() s.farmdelay = math.min(1, s.farmdelay + 0.05) fwlabel.Text = "скорость: "..string.format("%.2f", s.farmdelay) paintbuttons() end)

-- shoot
seclabel(pshoot,0,"aim / shoot")
checkbox(pshoot,26,"silent aim",s.silentaim,function(v) s.silentaim = v setstatus("silent aim "..(v and txt("вкл","on") or txt("выкл","off"))) end)
local bindbtn = button(pshoot,54,txt("бинд выстрела: [","shoot bind: [")..string.lower(s.shootkey).."]",function()
    listening_shoot = true _G.lime_bind.Text = txt("нажми любую клавишу...","press any key...")
end)
_G.lime_bind = bindbtn
button(pshoot,90,txt("выстрелить сейчас (вплотную)","shoot now (point blank)"),function() shootmurderer() end)
local infosh = Instance.new("TextLabel") infosh.Size = UDim2.new(1,-10,0,60) infosh.Position = UDim2.new(0,0,0,126)
infosh.BackgroundTransparency = 1 infosh.Font = Enum.Font.Code infosh.TextSize = 12 infosh.TextXAlignment = Enum.TextXAlignment.Left
infosh.TextColor3 = curtheme().dim infosh.TextWrapped = true infosh.Text = txt("подходит вплотную смотрит в цель стреляет и возвращает","steps close aims shoots and returns") infosh.Parent = pshoot infosh:SetAttribute("kind","dim")
checkbox(pshoot,190,txt("сквозь стены","wallbang"),s.wallbang,function(v) s.wallbang=v setstatus(txt("сквозь стены ","wallbang ")..(v and txt("вкл","on") or txt("выкл","off"))) end)
local wbinfo = Instance.new("TextLabel") wbinfo.Size = UDim2.new(1,-10,0,40) wbinfo.Position = UDim2.new(0,0,0,218)
wbinfo.BackgroundTransparency = 1 wbinfo.Font = Enum.Font.Code wbinfo.TextSize = 11 wbinfo.TextXAlignment = Enum.TextXAlignment.Left
wbinfo.TextColor3 = curtheme().dim wbinfo.TextWrapped = true wbinfo.Text = txt("обычный клик бьет в мардера через стены","normal click hits murderer through walls") wbinfo.Parent = pshoot wbinfo:SetAttribute("kind","dim")
checkbox(pshoot,258,"triggerbot",s.triggerbot,function(v) s.triggerbot=v setstatus("triggerbot "..(v and txt("вкл","on") or txt("выкл","off"))) end)

-- скролл shoot чтобы все влезло
local shootscroll = Instance.new("ScrollingFrame") shootscroll.Size = UDim2.new(1,-4,1,0) shootscroll.Position = UDim2.new(0,0,0,0)
shootscroll.BackgroundTransparency = 1 shootscroll.ScrollBarThickness = 3 shootscroll.CanvasSize = UDim2.new(0,0,0,360) shootscroll.Parent = pshoot
for _,ch in pairs(pshoot:GetChildren()) do if ch ~= shootscroll then ch.Parent = shootscroll end end

-- kill за мардера
seclabel(pkill,0,txt("kill за мардера","kill as murderer"))
button(pkill,26,"kill all",function() killall() end)
checkbox(pkill,62,txt("kill aura (рядом бьет сам)","kill aura (hits nearby)"),s.killaura,function(v) s.killaura = v end)
local killhint = Instance.new("TextLabel") killhint.Size = UDim2.new(1,-10,0,60) killhint.Position = UDim2.new(0,0,0,92)
killhint.BackgroundTransparency = 1 killhint.Font = Enum.Font.Code killhint.TextSize = 12 killhint.TextXAlignment = Enum.TextXAlignment.Left
killhint.TextColor3 = curtheme().dim killhint.TextWrapped = true killhint.Text = txt("нужен нож в руках. сначала ремоуты потом телепорт добивка","need knife in hands. remotes first then tp finish") killhint.Parent = pkill killhint:SetAttribute("kind","dim")
button(pkill,156,txt("стоп kill","stop kill"),function() killing = false setstatus("стоп") end)

-- fling kilasik мульти выбор
seclabel(pfling,0,txt("fling - выбери цели галочками","fling - tick targets"))
local flingscroll = Instance.new("ScrollingFrame") flingscroll.Size = UDim2.new(1,-10,0,170) flingscroll.Position = UDim2.new(0,0,0,26)
flingscroll.BackgroundTransparency = 1 flingscroll.ScrollBarThickness = 3 flingscroll.CanvasSize = UDim2.new(0,0,0,0) flingscroll.AutomaticCanvasSize = Enum.AutomaticSize.Y flingscroll.Parent = pfling
local flinglayout = Instance.new("UIListLayout") flinglayout.Padding = UDim.new(0,4) flinglayout.Parent = flingscroll
local function refreshfling()
    for _,c in pairs(flingscroll:GetChildren()) do if c:IsA("Frame") then c:Destroy() end end
    local list = players:GetPlayers()
    table.sort(list, function(a,b) return a.Name:lower() < b.Name:lower() end)
    for _,p in pairs(list) do
        if p ~= localplayer then
            local role = getrole(p)
            local row = Instance.new("Frame") row.Size = UDim2.new(1,-6,0,30) row.BackgroundColor3 = curtheme().bg3 row.BorderSizePixel = 0 row.Parent = flingscroll
            corner(row,4)
            local box = Instance.new("TextButton") box.Size = UDim2.new(0,24,0,24) box.Position = UDim2.new(0,3,0.5,-12)
            box.BackgroundColor3 = Color3.fromRGB(70,70,70) box.BorderSizePixel = 0 box.Text = "" box.Parent = row
            corner(box,4)
            local mark = Instance.new("TextLabel") mark.Size = UDim2.new(1,0,1,0) mark.BackgroundTransparency = 1
            mark.Text = "x" mark.TextColor3 = Color3.fromRGB(0,255,0) mark.TextSize = 18 mark.Font = Enum.Font.GothamBold
            mark.Visible = flingtargets[p.Name] ~= nil mark.Parent = box
            local nm = Instance.new("TextLabel") nm.Size = UDim2.new(1,-35,1,0) nm.Position = UDim2.new(0,32,0,0)
            nm.BackgroundTransparency = 1 nm.Font = Enum.Font.GothamBold nm.TextSize = 12 nm.TextXAlignment = Enum.TextXAlignment.Left
            nm.TextColor3 = rc[role] or curtheme().txt nm.Text = "  "..string.lower(p.DisplayName).." ["..role.."]" nm.Parent = row
            local vic = p
            box.MouseButton1Click:Connect(function()
                if flingtargets[vic.Name] then flingtargets[vic.Name] = nil mark.Visible = false
                else flingtargets[vic.Name] = vic mark.Visible = true end
                setstatus("целей: "..flingcount())
            end)
        end
    end
end
button(pfling,202,"start fling",function() startfling() end)
button(pfling,238,"stop fling",function() stopfling() end)
local flingrow = Instance.new("Frame") flingrow.Size = UDim2.new(1,-10,0,28) flingrow.Position = UDim2.new(0,0,0,274) flingrow.BackgroundTransparency = 1 flingrow.Parent = pfling
local selall = Instance.new("TextButton") selall.Size = UDim2.new(0.5,-4,1,0) selall.Position = UDim2.new(0,0,0,0)
selall.BackgroundColor3 = curtheme().bg3 selall.Text = "select all" selall.Font = Enum.Font.GothamBold selall.TextSize = 13 selall.TextColor3 = getaccent() selall.BorderSizePixel = 0 selall.Parent = flingrow selall.Name = "btn_flingsel" selall:SetAttribute("kind","bg3") corner(selall,8)
local stsel = Instance.new("UIStroke") stsel.Transparency = 0.55 stsel.Thickness = 1 stsel.Color = getaccent() stsel.Parent = selall stsel:SetAttribute("kind","accentstroke")
local deselall = Instance.new("TextButton") deselall.Size = UDim2.new(0.5,-4,1,0) deselall.Position = UDim2.new(0.5,4,0,0)
deselall.BackgroundColor3 = curtheme().bg3 deselall.Text = "deselect all" deselall.Font = Enum.Font.GothamBold deselall.TextSize = 13 deselall.TextColor3 = getaccent() deselall.BorderSizePixel = 0 deselall.Parent = flingrow deselall.Name = "btn_flingdes" deselall:SetAttribute("kind","bg3") corner(deselall,8)
local stdes = Instance.new("UIStroke") stdes.Transparency = 0.55 stdes.Thickness = 1 stdes.Color = getaccent() stdes.Parent = deselall stdes:SetAttribute("kind","accentstroke")
selall.MouseButton1Click:Connect(function()
    for _,p in pairs(players:GetPlayers()) do if p ~= localplayer then flingtargets[p.Name] = p end end
    refreshfling() setstatus("целей: "..flingcount())
end)
deselall.MouseButton1Click:Connect(function() flingtargets = {} refreshfling() setstatus("целей: 0") end)
button(pfling,308,txt("обновить список","refresh list"),function() refreshfling() end)
refreshfling()
players.PlayerAdded:Connect(function() task.wait(1) pcall(refreshfling) end)
players.PlayerRemoving:Connect(function(plr) flingtargets[plr.Name] = nil pcall(refreshfling) end)

-- misc со скроллом
seclabel(pmisc,0,"movement + misc")
local miscscroll = Instance.new("ScrollingFrame") miscscroll.Size = UDim2.new(1,-4,1,-26) miscscroll.Position = UDim2.new(0,0,0,24)
miscscroll.BackgroundTransparency = 1 miscscroll.ScrollBarThickness = 3 miscscroll.CanvasSize = UDim2.new(0,0,0,540) miscscroll.Parent = pmisc
local function mbox(y, text, val, cb) return checkbox(miscscroll, y, text, val, cb) end
mbox(0,txt("auto grab gun","auto grab gun"),s.gungrab,function(v) s.gungrab=v end)
mbox(28,txt("infinite jump","infinite jump"),s.infjump,function(v) s.infjump=v end)
mbox(56,txt("invisible","invisible"),s.invisible,function(v) setinvisible(v) end)
mbox(84,"jerk",s.jerk,function(v) s.jerk=v setstatus("jerk "..(v and txt("вкл","on") or txt("выкл","off"))) end)
stepper(miscscroll,112,"jerk speed", s.jerkspeed, 1, 15, 1, function(v) s.jerkspeed = v end)
local jerktoolbtn = button(miscscroll,170,txt("выдать jerk тул в инвентарь","give jerk tool"),function() givejerktool() paintbuttons() end)
mbox(206,txt("speed enabled","speed enabled"),s.speedon,function(v) s.speedon=v end)
stepper(miscscroll,234,"speed", s.speed, 16, 120, 2, function(v) s.speed = v end)
mbox(292,txt("jump power enabled","jump power enabled"),s.jpon,function(v) s.jpon=v end)
stepper(miscscroll,320,"jump power", s.jp, 50, 250, 10, function(v) s.jp = v end)
mbox(378,"spin",s.spin,function(v) s.spin=v if not v then updatespin() end end)
stepper(miscscroll,406,"spin speed", s.spinspeed, 5, 100, 5, function(v) s.spinspeed = v end)
mbox(464,txt("anti coin","anti coin"),s.anticoin,function(v) setanticoin(v) end)
mbox(492,txt("anti fling","anti fling"),s.antifling,function(v) s.antifling=v setstatus("anti fling "..(v and "вкл" or "выкл")) end)

-- teleport
seclabel(ptp,0,"teleport")
button(ptp,26,txt("тп к мардеру","tp to murderer"),function()
    local m = findmurderer()
    local c,h,hrp = alive()
    if not m then setstatus("мардер не найден") return end
    if not hrp then setstatus("ты мертв") return end
    local mhrp = m.Character and m.Character:FindFirstChild("HumanoidRootPart")
    if mhrp then hrp.CFrame = mhrp.CFrame + Vector3.new(0,3,2) setstatus("тп к мардеру") end
end)
button(ptp,62,txt("тп к шерифу","tp to sheriff"),function()
    local c,h,hrp = alive()
    if not hrp then setstatus("ты мертв") return end
    for _,p in pairs(players:GetPlayers()) do
        if p ~= localplayer and getrole(p) == "sheriff" and p.Character then
            local v = p.Character:FindFirstChild("HumanoidRootPart")
            local vh = p.Character:FindFirstChildOfClass("Humanoid")
            if v and vh and vh.Health > 0 then hrp.CFrame = v.CFrame + Vector3.new(0,3,2) setstatus("тп к шерифу") return end
        end
    end
    setstatus("шериф не найден")
end)
button(ptp,98,txt("тп к гану","tp to gun"),function() grabgunreturn() end)
seclabel(ptp,134,txt("точки карты","map points"))
local spawns = {}
pcall(function()
    for _,v in pairs(workspace:GetDescendants()) do
        if v:IsA("SpawnLocation") and #spawns < 5 then table.insert(spawns, v) end
    end
end)
if #spawns == 0 then
    button(ptp,160,txt("спавнов нет","no spawns"),function() setstatus("спавнов нет") end)
else
    for i,sp in pairs(spawns) do
        local y = 160 + (i - 1) * 36
        local sv = sp
        button(ptp,y,"спавн "..i,function()
            local c,h,hrp = alive()
            if not hrp then setstatus("ты мертв") return end
            hrp.CFrame = sv.CFrame + Vector3.new(0,4,0)
        end)
    end
end

-- aura
seclabel(paura,0,txt("ауры вокруг тебя","auras around you"))
checkbox(paura,26,txt("круги","rings"),s.aura_rings,function(v) s.aura_rings=v if not v and not s.aura_chains and not s.aura_spiral and not s.aura_orbit and not s.aura_pulse then auraclear() end end)
checkbox(paura,54,txt("цепи","chains"),s.aura_chains,function(v) s.aura_chains=v if not v and not s.aura_rings and not s.aura_spiral and not s.aura_orbit and not s.aura_pulse then auraclear() end end)
checkbox(paura,82,txt("спираль","spiral"),s.aura_spiral,function(v) s.aura_spiral=v end)
checkbox(paura,110,txt("орбита","orbit"),s.aura_orbit,function(v) s.aura_orbit=v end)
checkbox(paura,138,txt("пульс","pulse"),s.aura_pulse,function(v) s.aura_pulse=v end)
local aurahint = Instance.new("TextLabel") aurahint.Size = UDim2.new(1,-10,0,60) aurahint.Position = UDim2.new(0,0,0,168)
aurahint.BackgroundTransparency = 1 aurahint.Font = Enum.Font.Code aurahint.TextSize = 12 aurahint.TextXAlignment = Enum.TextXAlignment.Left
aurahint.TextColor3 = curtheme().dim aurahint.TextWrapped = true aurahint.Text = txt("все под цвет из settings","all use settings color") aurahint.Parent = paura aurahint:SetAttribute("kind","dim")

-- settings
seclabel(pset,0,"theme")
button(pset,26,txt("черная тема","black theme"),function() s.theme = "black" paint() selecttab("settings") paintbuttons() refreshfling() end)
button(pset,58,txt("белая тема","white theme"),function() s.theme = "white" paint() selecttab("settings") paintbuttons() refreshfling() end)
local menubind = button(pset,90,txt("бинд меню: [","menu bind: [")..string.lower(s.menukey).."]",function()
    listening_menu = true _G.lime_menubind.Text = txt("нажми любую клавишу...","press any key...")
end)
_G.lime_menubind = menubind
local langbtn = button(pset,122,txt("язык: русский (перезапусти)","language: english (re-execute)"),function()
    s.lang = (s.lang == "ru") and "en" or "ru"
    langbtn.Text = txt("язык: русский (перезапусти)","language: english (re-execute)")
    paintbuttons()
    setstatus(txt("перезапусти скрипт","re-execute script"))
end)
seclabel(pset,156,"accent color")
local colors = {
    {"лайм",190,255,70},{"красный",255,70,70},{"синий",80,140,255},
    {"фиолет",170,100,255},{"розовый",255,120,220},{"оранж",255,170,60},
    {"белый",255,255,255},{"циан",90,240,255},{"желтый",255,230,60}
}
for i,c in ipairs(colors) do
    local b = Instance.new("TextButton",pset)
    b.Size = UDim2.new(0,90,0,24) b.Position = UDim2.new(0,((i-1)%3)*98,0,182+math.floor((i-1)/3)*30)
    b.BackgroundColor3 = Color3.fromRGB(c[2],c[3],c[4])
    b.Text = c[1] b.Font = Enum.Font.GothamBold b.TextSize = 11
    b.TextColor3 = Color3.fromRGB(20,20,20) b.BorderSizePixel = 0
    corner(b,4)
    b.MouseButton1Click:Connect(function() s.accent_r,s.accent_g,s.accent_b = c[2],c[3],c[4] paint() selecttab("settings") paintbuttons() end)
end
button(pset,278,"re-apply esp",function() refreshesp() end)
button(pset,312,"unload menu",function()
    getgenv().lime_loaded = false
    for _,p in pairs(players:GetPlayers()) do clearesp(p) end
    gui:Destroy()
end)
local setscroll = Instance.new("ScrollingFrame") setscroll.Size = UDim2.new(1,-4,1,0) setscroll.Position = UDim2.new(0,0,0,0)
setscroll.BackgroundTransparency = 1 setscroll.ScrollBarThickness = 3 setscroll.CanvasSize = UDim2.new(0,0,0,350) setscroll.Parent = pset
for _,ch in pairs(pset:GetChildren()) do if ch ~= setscroll then ch.Parent = setscroll end end

-- кнопки: быстрые кнопки для функций
seclabel(pquick,0,txt("быстрые кнопки","quick buttons"))
local quickhint = Instance.new("TextLabel") quickhint.Size = UDim2.new(1,-10,0,40) quickhint.Position = UDim2.new(0,0,0,24)
quickhint.BackgroundTransparency = 1 quickhint.Font = Enum.Font.Code quickhint.TextSize = 11 quickhint.TextXAlignment = Enum.TextXAlignment.Left
quickhint.TextColor3 = curtheme().dim quickhint.TextWrapped = true quickhint.Text = txt("жми + и на экране появится кнопка, она двигается, крестик удаляет","press + and a button appears, drag it, x deletes") quickhint.Parent = pquick quickhint:SetAttribute("kind","dim")
local quickdefs = {
    {key="esp", label="esp", get=function() return s.esp end, set=function(v) s.esp=v if not v then for _,p in pairs(players:GetPlayers()) do clearesp(p) end else refreshesp() end end},
    {key="coinfarm", label="coin farm", get=function() return s.coinfarm end, set=function(v) s.coinfarm=v end},
    {key="gungrab", label="auto grab gun", get=function() return s.gungrab end, set=function(v) s.gungrab=v end},
    {key="silent", label="silent aim", get=function() return s.silentaim end, set=function(v) s.silentaim=v end},
    {key="killaura", label="kill aura", get=function() return s.killaura end, set=function(v) s.killaura=v end},
    {key="invis", label="invisible", get=function() return s.invisible end, set=function(v) setinvisible(v) end},
    {key="jerk", label="jerk", get=function() return s.jerk end, set=function(v) s.jerk=v end},
    {key="infjump", label="inf jump", get=function() return s.infjump end, set=function(v) s.infjump=v end},
    {key="speed", label="speed", get=function() return s.speedon end, set=function(v) s.speedon=v end},
    {key="bright", label="fullbright", get=function() return s.fullbright end, set=function(v) setfullbright(v) end},
    {key="anticoin", label="anti coin", get=function() return s.anticoin end, set=function(v) setanticoin(v) end},
    {key="antifling", label="anti fling", get=function() return s.antifling end, set=function(v) s.antifling=v end},
    {key="trigger", label="triggerbot", get=function() return s.triggerbot end, set=function(v) s.triggerbot=v end},
    {key="rings", label="aura rings", get=function() return s.aura_rings end, set=function(v) s.aura_rings=v end},
    {key="chains", label="aura chains", get=function() return s.aura_chains end, set=function(v) s.aura_chains=v end},
    {key="spiral", label="aura spiral", get=function() return s.aura_spiral end, set=function(v) s.aura_spiral=v end},
    {key="orbit", label="aura orbit", get=function() return s.aura_orbit end, set=function(v) s.aura_orbit=v end},
    {key="pulse", label="aura pulse", get=function() return s.aura_pulse end, set=function(v) s.aura_pulse=v end},
}
local function makequick(def)
    local f = Instance.new("Frame") f.Size = UDim2.new(0,170,0,32) f.Position = UDim2.new(0,20 + (#gui:GetChildren() % 5) * 180,0,60 + math.floor(#gui:GetChildren() / 5) * 40)
    f.BackgroundColor3 = curtheme().bg2 f.BorderSizePixel = 0 f.Active = true f.Parent = gui
    corner(f,4)
    local st = Instance.new("UIStroke") st.Color = getaccent() st.Thickness = 1 st.Transparency = 0.4 st.Parent = f st:SetAttribute("kind","accentstroke")
    local tg = Instance.new("TextButton") tg.Size = UDim2.new(1,-34,1,0) tg.BackgroundTransparency = 1
    tg.Font = Enum.Font.GothamBold tg.TextSize = 12 tg.TextColor3 = curtheme().txt tg.TextXAlignment = Enum.TextXAlignment.Left tg.Parent = f
    tg:SetAttribute("kind","txt")
    local function upd() tg.Text = "  "..def.label..": "..(def.get() and "вкл" or "выкл") end
    upd()
    tg.MouseButton1Click:Connect(function() def.set(not def.get()) upd() end)
    local x = Instance.new("TextButton") x.Size = UDim2.new(0,28,0,24) x.Position = UDim2.new(1,-30,0,4)
    x.BackgroundColor3 = Color3.fromRGB(255,80,80) x.Text = "x" x.Font = Enum.Font.GothamBold x.TextSize = 12 x.TextColor3 = Color3.new(1,1,1) x.BorderSizePixel = 0 x.Parent = f
    corner(x,4)
    x.MouseButton1Click:Connect(function() f:Destroy() end)
    drag(f, f)
    setstatus("кнопка добавлена: "..def.label)
end
local quickscroll = Instance.new("ScrollingFrame") quickscroll.Size = UDim2.new(1,-10,0,230) quickscroll.Position = UDim2.new(0,0,0,68)
quickscroll.BackgroundTransparency = 1 quickscroll.ScrollBarThickness = 3 quickscroll.CanvasSize = UDim2.new(0,0,0,0) quickscroll.AutomaticCanvasSize = Enum.AutomaticSize.Y quickscroll.Parent = pquick
local quicklayout = Instance.new("UIListLayout") quicklayout.Padding = UDim.new(0,4) quicklayout.Parent = quickscroll
for _,def in pairs(quickdefs) do
    local row = Instance.new("Frame") row.Size = UDim2.new(1,-6,0,30) row.BackgroundColor3 = curtheme().bg3 row.BorderSizePixel = 0 row.Parent = quickscroll
    corner(row,4)
    local l = Instance.new("TextLabel") l.Size = UDim2.new(1,-50,1,0) l.Position = UDim2.new(0,8,0,0)
    l.BackgroundTransparency = 1 l.Font = Enum.Font.GothamBold l.TextSize = 12 l.TextXAlignment = Enum.TextXAlignment.Left
    l.TextColor3 = curtheme().txt l.Text = def.label l.Parent = row
    local add = Instance.new("TextButton") add.Size = UDim2.new(0,36,0,22) add.Position = UDim2.new(1,-42,0,4)
    add.BackgroundColor3 = getaccent() add.Text = "+" add.Font = Enum.Font.GothamBold add.TextSize = 14 add.TextColor3 = Color3.fromRGB(20,20,20) add.BorderSizePixel = 0 add.Parent = row
    corner(add,4)
    local d = def
    add.MouseButton1Click:Connect(function() makequick(d) end)
end

-- cfg
seclabel(pcfg,0,"cfg - сохранения")
local cfgbox = mk("bg3", "TextBox", {Size = UDim2.new(1,-10,0,30), Position = UDim2.new(0,0,0,26), PlaceholderText = txt("впиши название cfg...","enter cfg name..."), Text = "", Font = Enum.Font.Gotham, TextSize = 13, BorderSizePixel = 0, ClearTextOnFocus = false}, pcfg)
corner(cfgbox,4) cfgbox.Name = "cfgbox"
local refreshcfglist
button(pcfg,60,txt("сохранить cfg","save cfg"),function()
    cfgsave(cfgbox.Text)
    pcall(function() refreshcfglist() end)
    paintbuttons()
end)
local cfgscroll = Instance.new("ScrollingFrame") cfgscroll.Size = UDim2.new(1,-10,0,150) cfgscroll.Position = UDim2.new(0,0,0,96)
cfgscroll.BackgroundTransparency = 1 cfgscroll.ScrollBarThickness = 3 cfgscroll.CanvasSize = UDim2.new(0,0,0,0) cfgscroll.AutomaticCanvasSize = Enum.AutomaticSize.Y cfgscroll.Parent = pcfg
local cfglayout = Instance.new("UIListLayout") cfglayout.Padding = UDim.new(0,4) cfglayout.Parent = cfgscroll
refreshcfglist = function()
    for _,c in pairs(cfgscroll:GetChildren()) do if c:IsA("Frame") then c:Destroy() end end
    for _,n in pairs(cfglist()) do
        local row = Instance.new("Frame") row.Size = UDim2.new(1,-6,0,30) row.BackgroundColor3 = curtheme().bg3 row.BorderSizePixel = 0 row.Parent = cfgscroll
        corner(row,4)
        local l = Instance.new("TextLabel") l.Size = UDim2.new(1,-110,1,0) l.Position = UDim2.new(0,8,0,0)
        l.BackgroundTransparency = 1 l.Font = Enum.Font.GothamBold l.TextSize = 12 l.TextXAlignment = Enum.TextXAlignment.Left
        l.TextColor3 = curtheme().txt l.Text = n l.Parent = row
        local load = Instance.new("TextButton") load.Size = UDim2.new(0,48,0,22) load.Position = UDim2.new(1,-102,0,4)
        load.BackgroundColor3 = getaccent() load.Text = "load" load.Font = Enum.Font.GothamBold load.TextSize = 11 load.TextColor3 = Color3.fromRGB(20,20,20) load.BorderSizePixel = 0 load.Parent = row
        corner(load,4)
        local del = Instance.new("TextButton") del.Size = UDim2.new(0,44,0,22) del.Position = UDim2.new(1,-50,0,4)
        del.BackgroundColor3 = Color3.fromRGB(255,80,80) del.Text = "del" del.Font = Enum.Font.GothamBold del.TextSize = 11 del.TextColor3 = Color3.new(1,1,1) del.BorderSizePixel = 0 del.Parent = row
        corner(del,4)
        local nn = n
        load.MouseButton1Click:Connect(function() cfgload(nn) paint() paintbuttons() selecttab("cfg") end)
        del.MouseButton1Click:Connect(function() pcall(function() delfile(cfgfolder.."/"..nn..".json") end) refreshcfglist() end)
    end
end
button(pcfg,252,txt("обновить список cfg","refresh cfg list"),function() refreshcfglist() end)
refreshcfglist()

local devl = Instance.new("TextLabel") devl.Size = UDim2.new(0,90,0,12) devl.Position = UDim2.new(1,-94,1,-13)
devl.BackgroundTransparency = 1 devl.Font = Enum.Font.Code devl.TextSize = 10 devl.TextXAlignment = Enum.TextXAlignment.Right
devl.TextColor3 = curtheme().dim devl.Text = "dev: tylenchik" devl.Parent = main devl:SetAttribute("kind","dim")

local status = mk("bg2", "Frame", {Size = UDim2.new(1,-156,0,28), Position = UDim2.new(0,148,1,-36), BorderSizePixel = 0}, main)
corner(status, 4)
local slabel = mk("dim", "TextLabel", {Size = UDim2.new(1,-10,1,0), Position = UDim2.new(0,10,0,0), BackgroundTransparency = 1, Font = Enum.Font.Code, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left, Text = "готов"}, status)
_G.lime_status = slabel
task.spawn(function()
    while getgenv().lime_loaded and slabel.Parent do slabel.Text = statusText task.wait(0.5) end
end)

local shootbtn = Instance.new("TextButton",gui)
shootbtn.Size = UDim2.new(0,84,0,38) shootbtn.Position = UDim2.new(1,-100,1,-200)
shootbtn.Text = "fire" shootbtn.Font = Enum.Font.GothamBold shootbtn.TextSize = 14
shootbtn.TextColor3 = Color3.fromRGB(20,20,20) shootbtn.BackgroundColor3 = getaccent()
shootbtn.BorderSizePixel = 0 shootbtn.Visible = false corner(shootbtn, 8)
shootbtn:SetAttribute("kind","accent")
shootbtn.MouseButton1Click:Connect(function() shootmurderer() end)
drag(shootbtn, shootbtn)

-- загрузка 3 сек на лаймовом фоне
local loadbg = Instance.new("Frame") loadbg.Size = UDim2.new(1,0,1,0) loadbg.BackgroundColor3 = getaccent() loadbg.BackgroundTransparency = 0.55 loadbg.BorderSizePixel = 0 loadbg.Parent = gui
local loadt = Instance.new("TextLabel") loadt.Size = UDim2.new(0,300,0,60) loadt.Position = UDim2.new(0.5,-150,0.5,-90)
loadt.BackgroundTransparency = 1 loadt.Font = Enum.Font.GothamBold loadt.TextSize = 48 loadt.Text = "lime.cs" loadt.TextColor3 = Color3.fromRGB(20,20,20) loadt.Parent = loadbg
local loadsub = Instance.new("TextLabel") loadsub.Size = UDim2.new(0,300,0,20) loadsub.Position = UDim2.new(0.5,-150,0.5,-28)
loadsub.BackgroundTransparency = 1 loadsub.Font = Enum.Font.Code loadsub.TextSize = 13 loadsub.Text = "v2 by tylenchik" loadsub.TextColor3 = Color3.fromRGB(40,40,40) loadsub.Parent = loadbg
local loadbarbg = Instance.new("Frame") loadbarbg.Size = UDim2.new(0,260,0,10) loadbarbg.Position = UDim2.new(0.5,-130,0.5,0)
loadbarbg.BackgroundColor3 = Color3.fromRGB(20,20,20) loadbarbg.BackgroundTransparency = 0.4 loadbarbg.BorderSizePixel = 0 loadbarbg.Parent = loadbg
corner(loadbarbg, 4)
local loadfill = Instance.new("Frame") loadfill.Size = UDim2.new(0,0,1,0) loadfill.BackgroundColor3 = Color3.fromRGB(255,255,255) loadfill.BorderSizePixel = 0 loadfill.Parent = loadbarbg
corner(loadfill, 4)
local loadpct = Instance.new("TextLabel") loadpct.Size = UDim2.new(0,260,0,20) loadpct.Position = UDim2.new(0.5,-130,0.5,14)
loadpct.BackgroundTransparency = 1 loadpct.Font = Enum.Font.GothamBold loadpct.TextSize = 14 loadpct.Text = "0%" loadpct.TextColor3 = Color3.fromRGB(20,20,20) loadpct.Parent = loadbg
local loadtip = Instance.new("TextLabel") loadtip.Size = UDim2.new(0,400,0,20) loadtip.Position = UDim2.new(0.5,-200,0.5,40)
loadtip.BackgroundTransparency = 1 loadtip.Font = Enum.Font.Code loadtip.TextSize = 12 loadtip.Text = "" loadtip.TextColor3 = Color3.fromRGB(40,40,40) loadtip.Parent = loadbg
local loadtips = {"совет: пкм по coin farm открывает настройки", "совет: бинд меню меняется в settings", "совет: fire стреляет в мардера", "совет: cfg сохраняет настройки"}
task.spawn(function()
    for i=1,30 do
        if not getgenv().lime_loaded then return end
        loadfill.Size = UDim2.new(i/30,0,1,0)
        loadpct.Text = math.floor(i/30*100).."%"
        if i % 8 == 1 then loadtip.Text = loadtips[(math.floor(i/8) % #loadtips) + 1] end
        task.wait(0.1)
    end
    for f=1,6 do
        if not loadbg.Parent then break end
        loadbg.BackgroundTransparency = 0.55 + f * 0.07
        task.wait(0.05)
    end
    if loadbg.Parent then loadbg:Destroy() end
    main.Visible = true wm.Visible = true shootbtn.Visible = true
end)

paint()
paintbuttons()
selecttab("visuals")
refreshesp()
print("[lime.cs] loaded")
