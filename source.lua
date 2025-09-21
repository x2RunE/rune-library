local plr = game.Players.LocalPlayer

if (hookfunction and hookmetamethod and getconnections and cloneref and firetouchinterest and fireproximityprompt and collectgarbage and version and gethwid) then
    print("Supported Executor!")
else
    plr:Kick("Missing hookfunction/hookmetamethod...")
    local r = rawget(getrawmetatable(plr), "Kick") or plr.Kick
    r(plr, "")
    game:Shutdown()
end

local OldMemory = collectgarbage("count")
local ScriptStartTime = os.clock()
local sea1 = 2753915549
local sea2 = 4442272183
local sea3 = 7449423635
local GC = getconnections or get_signal_cons
local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
if GC then
    for _, v in pairs(GC(game.Players.LocalPlayer.Idled)) do
        if v.Disable then
            v:Disable()
        elseif v.Disconnect then
            v:Disconnect()
        end
    end
else
    local VirtualUser = cloneref(game:GetService("VirtualUser"))
    game.Players.LocalPlayer.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end
local checkRadiant = function()
    if getgenv()._G_RADIANT_LOADED then
        local servers = game:GetService("HttpService"):JSONDecode(game:HttpGet(
            "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
        for _, server in ipairs(servers.data) do
            if server.playing < server.maxPlayers then
                return cloneref(game:GetService("TeleportService")):TeleportToPlaceInstance(game.PlaceId, server.id, plr)
            end
        end
    else
        getgenv()._G_RADIANT_LOADED = true
    end
end
checkRadiant()
local function RequestAPI(u,m,d)
    if m == 'post' then
        return http_request({
            Url = u,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = cloneref(game:GetService('HttpService')):JSONEncode(d)
        })
    elseif m == 'get' then
        print('Nah')
    end
end
local localCheckRadiant, radiantCheck = pcall(function()
    return RequestAPI(
        'https://wl-9i8x.onrender.com/whitelist',
        'post',
    {
        key = getgenv().Key,
        hwid = gethwid()
    })
end)
if localCheckRadiant and radiantCheck.StatusCode ~= 200 and radiantCheck.StatusCode ~= 201 then
    plr:Kick("You're blacklisted \n reason : Try to crack Radiant Hub Script")
    local r = rawget(getrawmetatable(plr), "Kick") or plr.Kick
    r(plr, "You're blacklisted \n reason : Try to crack Radiant Hub Script")
    task.wait(3)
    game:Shutdown()
end
if getgenv()._G_RADIANT_LOADED then
    hookfunction(require(game.ReplicatedStorage.Effect.Container.Death), function()end)
    hookfunction(require(game.ReplicatedStorage.Effect.Container.Respawn), function()end)
    local cloneref = cloneref or function(o)
        return o
    end
    assert(getrawmetatable)
    grm = getrawmetatable(game)
    setreadonly(grm, false)
    old = grm.__namecall
    grm.__namecall = newcclosure(function(self, ...)
        local args = {...}
        if tostring(args[1]) == "TeleportDetect" then
            return
        elseif tostring(args[1]) == "CHECKER_1" then
            return
        elseif tostring(args[1]) == "CHECKER" then
            return
        elseif tostring(args[1]) == "GUI_CHECK" then
            return
        elseif tostring(args[1]) == "OneMoreTime" then
            return
        elseif tostring(args[1]) == "checkingSPEED" then
            return
        elseif tostring(args[1]) == "BANREMOTE" then
            return
        elseif tostring(args[1]) == "PERMAIDBAN" then
            return
        elseif tostring(args[1]) == "KICKREMOTE" then
            return
        elseif tostring(args[1]) == "BR_KICKPC" then
            return
        elseif tostring(args[1]) == "BR_KICKMOBILE" then
            return
        end
        return old(self, ...)
    end)
end
pcall(function()
    local ScreenGui = Instance.new("ScreenGui")
    if game.Players.LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("SCR") then
        game.Players.LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("SCR"):Destroy()
    end
    ScreenGui.Parent = game.Players.LocalPlayer:FindFirstChild("PlayerGui")
    ScreenGui.Name = "SCR"
    ScreenGui.ResetOnSpawn = false
    local ImageButton = Instance.new("ImageButton")
    ImageButton.Size = UDim2.fromOffset(50, 50)
    ImageButton.Position = UDim2.new(0.5, -25, 0.001, 0)
    ImageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ImageButton.ImageTransparency = 0.15 -- Có thể điều chỉnh từ 0.1 đến 0.5 tùy ý
    ImageButton.BorderSizePixel = 0
    ImageButton.AutoButtonColor = true
    ImageButton.Parent = ScreenGui
    ImageButton.Image = "rbxassetid://79671783080269"
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0.2, 0)
    UICorner.Parent = ImageButton
    local dragging, dragStart, startPos
    local UIS = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")
    ImageButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = ImageButton.Position
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            ImageButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale,
                startPos.Y.Offset + delta.Y)
        end
    end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    ImageButton.MouseButton1Click:Connect(function()
        game:GetService("VirtualInputManager"):SendKeyEvent(true, "RightControl", false, game)
        game:GetService("VirtualInputManager"):SendKeyEvent(false, "RightControl", false, game)
    end)
end)
repeat
    task.wait(1)
    if not game.Players.LocalPlayer.Team then
        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("SetTeam", "Pirates")
    end
until game.Players.LocalPlayer.Team
local size, twd
pcall(function()
    local UserInputService = game:GetService("UserInputService")
    if UserInputService.TouchEnabled then
        size = UDim2.fromOffset(265, 225)
        twd = 100
    else
        size = UDim2.fromOffset(550, 440)
        twd = 115
    end
end)
pcall(function() ---@diagnostic disable-next-line: undefined-global
    if Fluent then
        Fluent:Destroy()
    end
end)
task.wait(1)
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

repeat
    task.wait()
until Fluent

local Window = Fluent:CreateWindow({
    Title = "Radiant 2.0 - Premium",
    SubTitle = "- Blox Fruits",
    TabWidth = twd,
    Size = size,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl
})

local Options = Fluent.Options

local Tabs = {
    Settings = Window:AddTab({
        Title = 'Farm Settings',
        Icon = ''
    }),
    General = Window:AddTab({
        Title = "Auto Farm",
        Icon = ""
    }),
    Stack = Window:AddTab({
        Title = "Stack Farm",
        Icon = ""
    }),
    OtherFarm = Window:AddTab({
        Title = "Other Farm",
        Icon = ""
    }),
    Farm = Window:AddTab({
        Title = "Race / V4",
        Icon = ""
    }),
    Stats = Window:AddTab({
        Title = "Stats / PVP",
        Icon = ""
    }),
    Items = Window:AddTab({
        Title = "Items / Events",
        Icon = ""
    }),
    LocalPlayer = Window:AddTab({
        Title = "Local/Status",
        Icon = ""
    }),
    Travel = Window:AddTab({
        Title = "Travel",
        Icon = ""
    }),
    Visual = Window:AddTab({
        Title = "Visual",
        Icon = ""
    }),
    Webhook = Window:AddTab({
        Title = "Webhook",
        Icon = ""
    }),
    Plus = Window:AddTab({
        Title = "Plus",
        Icon = ""
    }),
    Misc = Window:AddTab({
        Title = "Misc",
        Icon = ""
    })
}
Window:SelectTab(2)
-- env

local plr = game.Players.LocalPlayer
local character = plr.Character or plr.CharacterAdded:Wait()
local runs = cloneref(game:GetService("RunService"))
local vu = cloneref(game:GetService("VirtualUser"))
local vim = cloneref(game:GetService("VirtualInputManager"))
local tps = cloneref(game:GetService("TeleportService"))
local repstorage = cloneref(game:GetService("ReplicatedStorage"))
local tweens = cloneref(game:GetService("TweenService"))
local uis = game:GetService("UserInputService")
local https = game:GetService("HttpService")
local req = request or syn.request or http_request
local queue_teleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)

-- Functions

if not isfile('RadiantHubData') then
    pcall(function()
        writefile('RadiantHubData', crypt.base64encode(getgenv().Key))
    end)
end

-- queue_teleport('getgenv().Key = "'..crypt.base64decode(readfile('RadiantEncryptedData'))..'"'..
-- '\nloadstring(game:HttpGet("https://raw.githubusercontent.com/x2RunE/QuynhLaSo1/refs/heads/main/evloader"))()')

plr.Idled:Connect(function()
    vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)

plr.CharacterAdded:Connect(function(v)
    character = v
end)

local function GetMaterial(name)
    for _, v in pairs(game.ReplicatedStorage.Remotes.CommF_:InvokeServer("getInventory")) do
        if v["Type"] == "Material" and v["Name"] == name then
            return v["Count"]
        end
    end
    return 0
end

local function getMastery(name)
    local b = 0
    local function a(x)
        for i, v in next, x do
            if typeof(v) == "table" then
                if i == name and v.Level then
                    b = v.Level
                end
                a(v)
            end
        end
    end
    a(game.ReplicatedStorage.Modules.Net["RF/ReadPlayerData"]:InvokeServer())
    return b
end

local function equipTool(v)
    character.Humanoid:EquipTool(plr.Backpack:FindFirstChild(v))
end

local Number = math.random(1, 1000000)

function MoveCamtoMoon()
    workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, game:GetService("Lighting"):GetMoonDirection() + workspace.CurrentCamera.CFrame.Position)
end

function getLowestServer()
    local servers = {}
    local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"

    local success, response = pcall(function()
        return https:GetAsync(url)
    end)
    if success then
        local data = https:JSONDecode(response)
        if data and data.data then
            for _, server in ipairs(data.data) do
                if server.playing < server.maxPlayers and server.id ~= game.JobId then
                    return server.id
                end
            end
        end
    end
    return nil
end

local race = plr.Data.Race
function getRaceGrade()
    if plr.Backpack:FindFirstChild("Awakening") or character:FindFirstChild("Awakening") then
        return "V4"
    elseif plr.Backpack:FindFirstChild("Last Resort") or character:FindFirstChild("Last Resort") or
        plr.Backpack:FindFirstChild("Agility") or plr.Character:FindFirstChild("Agility") or
        plr.Backpack:FindFirstChild("Water Body") or character:FindFirstChild("Water Body") or
        plr.Backpack:FindFirstChild("Heavenly Blood") or character:FindFirstChild("Heavenly Blood") or
        plr.Backpack:FindFirstChild("Heightened Senses") or character:FindFirstChild("Heightened Senses") or
        plr.Backpack:FindFirstChild("Energy Core") or character:FindFirstChild("Energy Core") or
        plr.Backpack:FindFirstChild("Primordial Reign") or character:FindFirstChild("Primordial Reign") then
        return "V3"
    elseif race:FindFirstChild("Evolved") then
        return "V2"
    else
        return "V1"
    end
end

function getMoonStatus()
    local MoonTextureId
    if game.PlaceId == sea1 then
        MoonTextureId = game:GetService("Lighting").Sky.MoonTextureId
    elseif game.PlaceId == sea2 then
        MoonTextureId = game:GetService("Lighting").FantasySky
    elseif game.PlaceId == sea3 then
        MoonTextureId = game:GetService("Lighting").Sky.MoonTextureId
    end
    if MoonTextureId == "http://www.roblox.com/asset/?id=9709149431" then
        return "8/8 - Full Moon"
    elseif MoonTextureId == "http://www.roblox.com/asset/?id=9709149052" then
        return "7/8"
    elseif MoonTextureId == "http://www.roblox.com/asset/?id=9709143733" then
        return "6/8"
    elseif MoonTextureId == "http://www.roblox.com/asset/?id=9709150401" then
        return "5/8"
    elseif MoonTextureId == "http://www.roblox.com/asset/?id=9709135895" then
        return "4/8"
    elseif MoonTextureId == "http://www.roblox.com/asset/?id=9709150086" then
        return "2/8"
    elseif MoonTextureId == "http://www.roblox.com/asset/?id=9709139597" then
        return "1/8"
    elseif MoonTextureId == "http://www.roblox.com/asset/?id=9709149680" then
        return "0/8"
    else
        return "nil"
    end
end

function getMirageStatus()
    local mirage = workspace.Map:FindFirstChild("MysticIsland")
    if mirage then
        return "🟢"
    else
        return "🔴"
    end
end

function getLeverStatus()
    local lever = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CheckTempleDoor")
    if lever then
        return "🟢"
    else
        return "🔴"
    end
end

function hopLowServer()
    local success, error = pcall(function()
        for _, v in ipairs(game:GetService("HttpService"):JSONDecode(game:HttpGet(
            "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")).data) do
            if v.playing < v.maxPlayers and v.playing <= 4 then
                game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, v.id, plr)
            else
                Fluent:Notify({
                    Title = "Notification",
                    Content = "Doesn't have any server",
                    SubContent = "Max players that you selected: " .. 4,
                    Duration = 3
                })
            end
        end
    end)
    if error then
        tps:Teleport(game.PlaceId)
    end
end
function FastAttackUnban()
    while true do end
end
function checkAllBoss()
    while true do end
end
function radiantloader()
    while true do end
end
getgenv().Radiant_FastAttackUnban = FastAttackUnban
getgenv().Radiant_checkAllBoss = checkAllBoss
getgenv().Radiant_Loader = radiantloader
getgenv().Radiant_KeysData = {
    ['SendDataRequest'] = function()
        cloneref(game:GetService('Players')).LocalPlayer:Kick('Làm trò hề gì vậy nhóc ?')
    end
}

local function hopServer()
    pcall(function()
        local servers = game:GetService("HttpService"):JSONDecode(game:HttpGet(
            "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
        for _, server in ipairs(servers.data) do
            if server.playing < server.maxPlayers then
                return tps:TeleportToPlaceInstance(game.PlaceId, server.id, plr)
            end
        end
        warn("Không tìm thấy server để hop!")
    end)
end

local function equipWeapon()
    for _, v in next,plr.Backpack:GetChildren() do
        if v.ToolTip == Options.SelectWeapon.Value then
            if not character:FindFirstChild("HasBuso") then
                if (function()
                    for i,v in next,game:GetService("ReplicatedStorage").Modules.Net["RF/ReadPlayerData"]:InvokeServer() do
                        if i == 'Abilities' then
                            return v.Buso
                        end
                    end end)() then
                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Buso")
                end
            end
            character.Humanoid:EquipTool(v)
        end
    end
end

local function checkItem(Name)
    for i, v in next,(game.ReplicatedStorage.Remotes.CommF_:InvokeServer("getInventory")) do
        if v.Name == Name then
            return true
        end
    end
end

local bringMob = newcclosure(function(v,s)
    pcall(function()
        if setscriptable then setscriptable(game.Players.LocalPlayer, "SimulationRadius", true) end
        if sethiddenproperty then sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge) end
        local p = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not p then return end
        local targets = {}
        for _, x in next, workspace.Enemies:GetChildren() do
            if x:FindFirstChild("HumanoidRootPart") and x:FindFirstChild("Humanoid") and x.Humanoid.Health > 0 and (not v or x.Name == v) and (p.Position - x.HumanoidRootPart.Position).Magnitude <= 180 then
                targets[#targets + 1] = x
                if #targets == 3 then break end
            end
        end
        if #targets == 0 then return end
        local t = targets[1].HumanoidRootPart.CFrame
        for _, x in next,targets do
            x.HumanoidRootPart.CFrame = t
        end
        for _, npc in next,workspace.Enemies:GetChildren() do
            local hrp = npc:FindFirstChild("HumanoidRootPart")
            local hum = npc:FindFirstChild("Humanoid")
            if hrp and hum and hum.Health == hum.MaxHealth and p and plr:DistanceFromCharacter(hrp.Position) <= 30 then
                task.spawn(function()
                    local oldPos = hrp.Position
                    task.wait(3)
                    local newPos = hrp.Position
                    if (oldPos - newPos).Magnitude < 0.5 and npc:FindFirstChild('Humanoid') and npc.Humanoid.Health == npc.Humanoid.MaxHealth then
                        if npc and npc.Parent then
                            npc:Destroy()
                        end
                    end
                end)
            end
        end
    end)
end)

local bringSG = newcclosure(function(v)
    pcall(function()
        if setscriptable then setscriptable(game.Players.LocalPlayer, "SimulationRadius", true) end
        if sethiddenproperty then sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge) end
        local p = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not p then return end
        local targets = {}
        for _, x in next, workspace.Enemies:GetChildren() do
            if x:FindFirstChild("HumanoidRootPart") and x:FindFirstChild("Humanoid") and x.Humanoid.Health > 0 and (not v or x.Name == v) and (p.Position - x.HumanoidRootPart.Position).Magnitude <= math.huge then
                targets[#targets + 1] = x
                if #targets == 6 then break end
            end
        end
        if #targets == 0 then return end
        local t = targets[1].HumanoidRootPart.CFrame
        for _, x in pairs(targets) do
            sethiddenproperty(x.HumanoidRootPart, "NetworkOwnershipRule", Enum.NetworkOwnership.Manual)
            x.HumanoidRootPart.CFrame = t
        end
        for _, npc in ipairs(workspace.Enemies:GetChildren()) do
            local hrp = npc:FindFirstChild("HumanoidRootPart")
            local hum = npc:FindFirstChild("Humanoid")
            if hrp and hum and hum.Health == hum.MaxHealth and p and plr:DistanceFromCharacter(hrp.Position) <= 30 then
                task.spawn(function()
                    local oldPos = hrp.Position
                    task.wait(3)
                    local newPos = hrp.Position
                    if (oldPos - newPos).Magnitude < 0.5 and npc:FindFirstChild('Humanoid') and npc.Humanoid.Health == npc.Humanoid.MaxHealth then
                        if npc and npc.Parent then
                            npc:Destroy()
                        end
                    end
                end)
            end
        end
    end)
end)

local function bringMobDistance(_D, _L)
    pcall(function()
        local player = plr
        local character = player.Character or player.CharacterAdded:Wait()
        local rootPart = character and character:FindFirstChild("HumanoidRootPart")
        local enemies = workspace:WaitForChild("Enemies")
        if not rootPart then
            return
        end
        local pos = _L
        for _, v in ipairs(enemies:GetChildren()) do
            local humanoid = v:FindFirstChildOfClass("Humanoid")
            local npcRoot = v:FindFirstChild("HumanoidRootPart")
            if v:IsA("Model") and (npcRoot.Position - rootPart.Position).Magnitude <= _D then
                npcRoot.CFrame = pos
                humanoid.JumpPower, humanoid.WalkSpeed = 0, 0
                if humanoid:FindFirstChild("Animator") then
                    humanoid.Animator:Destroy()
                end
                humanoid:ChangeState(11)
                humanoid:ChangeState(14)
                sethiddenproperty(player, "SimulationRadius", math.huge)
            end
        end
    end)
end

function getElite()
    local eliteNames = {"Diablo", "Deandre", "Urban", "Tyrant of the Skies"}
    for _, v in eliteNames do
        local e = game.ReplicatedStorage:FindFirstChild(v) or workspace.Enemies:FindFirstChild(v)
        if e and e:FindFirstChild('Humanoid') then
            if e.Humanoid.Health > 0 then
                return e
            end
        end
    end
    return false
end

local function Teleport(target)
    if typeof(target) == "CFrame" then
        game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = target
    elseif typeof(target) == "string" or typeof(target) == "number" then
        if game.PlaceId == sea1 then
            if string.find(target:lower(), "sky") then
                if string.find(target:lower(), "1") or string.find(target:lower(), "2") then
                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-4650, 872, -1775))--sky 2
                    return
                elseif string.find(target:lower(), "3") then
                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-7900, 5578, -520))--sky 3
                    return
                end
            elseif string.find(target:lower(), "fish") then
                if string.find(target:lower(), "entrance") then
                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(61200, 12, 1675))--entrance fish
                    return
                elseif string.find(target:lower(), "le") or string.find(target:lower(), "exit") then
                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(3900, 10, -1900))--leave fish
                    return
                end
            end
        elseif game.PlaceId == 2 then
            if string.find(target:lower(), "ship") then
                if string.find(target:lower(), "entrance") or string.find(target:lower(), "enter") then
                elseif string.find(target:lower(), "leave") or string.find(target:lower(), "exit") then
                end
                return
            end
        elseif game.PlaceId == 3 then
            if string.find(target:lower(), "mansion") then
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-12550, 340, -7500))--mansion
                return
            elseif string.find(target:lower(), "hydra") then
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(5700, 1015, -215)) -- hydraa
                return
            elseif string.find(target:lower(), "castle") then
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-5000, 350, -3035)) --sea castle
                return
            elseif string.find(target:lower(), "temple") then
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", workspace.Map["Temple of Time"].TeleportSpawn.Position)
                return
            end
        end
    end
end

local islands = {}
local function getIslands()
    islands = {}
    if game.PlaceId == sea1 then
        islands = {"WindMill", "Marine", "Middle Town", "Jungle", "Pirate Village", "Desert", "Snow Island",
                   "MarineFord", "Colosseum", "Sky Island 1", "Sky Island 2", "Sky Island 3", "Prison", "Magma Village",
                   "Under Water Island", "Fountain City", "Shank Room", "Mob Island"}
    elseif game.PlaceId == sea2 then
        islands = {"The Cafe", "Frist Spot", "Dark Area", "Flamingo Mansion", "Flamingo Room", "Green Zone", "Factory",
                   "Colossuim", "Zombie Island", "Two Snow Mountain", "Punk Hazard", "Cursed Ship", "Ice Castle",
                   "Forgotten Island", "Ussop Island", "Mini Sky Island"}
    else
        islands = {"Mansion", "Port Town", "Great Tree", "Castle On The Sea", "MiniSky", "Hydra Island",
                   "Floating Turtle", "Haunted Castle", "Ice Cream Island", "Peanut Island", "Cake Island",
                   "Cocoa Island", "Candy Island New", "CandyCane", "Tiki Island"}
    end
    return islands
end

local function getSea()
    if game.PlaceId == sea1 then
        return "First Sea"
    elseif game.PlaceId == sea2 then
        return "Second Sea"
    else
        return "Third Sea"
    end
end

task.spawn(function()
    while task.wait() do
        pcall(function()
            if not character:FindFirstChild("HighlightGreen") then
                local highlight = Instance.new("Highlight")
                highlight.Name = "HighlightGreen"
                highlight.FillColor = Color3.fromRGB(80, 245, 245)
                highlight.FillTransparency = 0.5
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.OutlineTransparency = 0
                highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                if character then
                    highlight.Adornee = character
                    highlight.Parent = character
                end
            end
        end)
    end
end)

local function waitUntilNoBusy()
    pcall(function()
        task.wait(0.1)
        if character.Busy.Value then
            repeat wait(0.1) until not character.Busy.Value
        end
    end)
end

local function useSkill()
    vim:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
    vim:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
    task.wait(2)
    vim:SendKeyEvent(true, Enum.KeyCode.X, false, game)
    vim:SendKeyEvent(false, Enum.KeyCode.X, false, game)
    task.wait(2)
    vim:SendKeyEvent(true, Enum.KeyCode.C, false, game)
    vim:SendKeyEvent(false, Enum.KeyCode.C, false, game)
    task.wait(2)
end

local function autoskill()
    for _, v in next,plr.Backpack:GetChildren() do
        if v.ToolTip == "Melee" or v.ToolTip == "Sword" or v.ToolTip == "Blox Fruit" or v.ToolTip == "Gun" then
            character.Humanoid:EquipTool(v)
            vim:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
            vim:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
            waitUntilNoBusy()
            vim:SendKeyEvent(true, Enum.KeyCode.X, false, game)
            vim:SendKeyEvent(false, Enum.KeyCode.X, false, game)
            waitUntilNoBusy()
            vim:SendKeyEvent(true, Enum.KeyCode.C, false, game)
            vim:SendKeyEvent(false, Enum.KeyCode.C, false, game)
        end
    end
end

local function getPlayers()
    local players = {}
    for _, player in ipairs(game.Players:GetPlayers()) do
        if player ~= plr and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            table.insert(players, player.Name)
        end
    end
    return players
end

local FruitList = {"Bomb-Bomb", "Spike-Spike", "Blade-Blade", "Spring-Spring", "Rocket-Rocket", "Spin-Spin",
                   "Bird: Falcon", "Smoke-Smoke", "Flame-Flame", "Ice-Ice", "Sand-Sand", "Dark-Dark", "Revive-Revive",
                   "Diamond-Diamond", "Light-Light", "Love-Love", "Rubber-Rubber", "Barrier-Barrier", "Magma-Magma",
                   "Door-Door", "Quake-Quake", "Human-Human: Buddha", "String-String", "Bird-Bird: Phoenix",
                   "Rumble-Rumble", "Paw-Paw", "Gravity-Gravity", "Sound-Sound", "Dough-Dough", "Venom-Venom",
                   "Yeti-Yeti", "Shadow-Shadow", "Control-Control", "Spirit-Spirit", "Kitsune-Kitsune",
                   "Leopard-Leopard", "Dragon-Dragon"}

-- script

-- Tab : Farm Settings

Tabs.Settings:AddParagraph({
    Title = "```",
    Content = "Auto Farm Settings"
})

local General_SelectWeapon = Tabs.Settings:AddDropdown("SelectWeapon", {
    Title = "Select Weapon",
    Description = "",
    Values = {"Melee", "Sword", "Blox Fruit"},
    Multi = false,
    Default = "Melee"
})
local General_NoFall = Tabs.Settings:AddToggle("NoFall", {
    Title = "Anti Fall [ For Tweens ]",
    Description = "",
    Default = true
})
local General_RedeemCodes = Tabs.Settings:AddToggle("RedeemCodes", {
    Title = "Redeem Codes",
    Description = "",
    Default = true
})
local General_Noclip = Tabs.Settings:AddToggle("Noclip", {
    Title = "Noclip",
    Description = "",
    Default = true
})
local General_EnableBringMob = Tabs.Settings:AddToggle("EnableBringMob", {
    Title = "Bring Mob",
    Description = "",
    Default = true
})

damageModule = require(game:GetService("ReplicatedStorage").Effect.Container.Misc.Damage)
runFunction = damageModule.Run
Tabs.Settings:AddToggle("DisableDamageText", {
    Title = "Disable Damage Text",
    Description = "",
    Default = true,
    Callback = function(state)
        task.spawn(function()
            if state then
                damageModule.Run = function(self, ...)
                    if Options.DisableDamageText.Value then
                        return
                    end
                    return runFunction(self, ...)
                end
            else
                damageModule.Run = runFunction
            end
        end)
    end
})

Tabs.Settings:AddParagraph({
    Title = "```",
    Content = "GUI Settings"
})

Tabs.Settings:AddColorpicker("WhiteScreenColor", {
    Title = "Screen Color",
    Description = "",
    Default = Color3.fromRGB(255, 255, 255)
})

Tabs.Settings:AddToggle("WhiteScreen", {
    Title = "Disable 3dRendering",
    Description = "",
    Default = false,
    Callback = function(value)
        pcall(function()
            if value then
                local gui = Instance.new("ScreenGui", plr:WaitForChild("PlayerGui"))
                gui["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling
                gui['IgnoreGuiInset'] = true
                gui['Name'] = 'RadiantHubScreen'
                local bg = Instance.new("Frame", gui)
                bg["Active"] = true
                bg["BorderSizePixel"] = 0;
                bg["BackgroundColor3"] = Options.WhiteScreenColor.Value
                bg["AnchorPoint"] = Vector2.new(0.5, 0.5)
                bg["Size"] = UDim2.new(1, 0, 1, 0)
                bg["Position"] = UDim2.new(0.5, 0, 0.5, 0)
                bg["BorderColor3"] = Color3.fromRGB(0, 0, 0)
                bg["Name"] = 'Radiant-BG'
            else
                local d = plr.PlayerGui and plr.PlayerGui.RadiantHubScreen
                if d then d:Destroy() end
            end
            runs:Set3dRenderingEnabled(not value)
        end)
    end
})

task.spawn(function()
    while task.wait() do
        pcall(function()
            local g = plr.PlayerGui and plr.PlayerGui.RadiantHubScreen
            if g and g:FindFirstChild('Radiant-BG') then
                g['Radiant-BG'].BackgroundColor3 = Options.WhiteScreenColor.Value
            end
        end)
    end
end)

-- Tab : General

Tabs.General:AddParagraph({
    Title = "```",
    Content = "Auto Farm"
})
local General_ShowCake = Tabs.General:AddParagraph({
    Title = "Dough Prince Progress",
    Content = ""
})

task.spawn(function()
    pcall(function()
        while task.wait(0.5) do
            General_ShowCake:SetDesc(game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CakePrinceSpawner", true):gsub("<Color=Yellow>", ""):gsub("<Color=/>", ""))
        end
    end)
end)

local selectedFarmMethod = "Level"
local General_SelectFarmMethod = Tabs.General:AddDropdown("AutoFarmMethod", {
    Title = "Select Farm Method",
    Description = "",
    Values = {"Level", "Katakuri [ Cake ]", "Bone"},
    Multi = false,
    Default = "Level",
    Callback = function(_e)
        selectedFarmMethod = _e
    end
})

local General_AutoFarm = Tabs.General:AddToggle("AutoFarm", {
    Title = "Auto Farm",
    Description = "",
    Default = false
})

local General_AutoRandomBone = Tabs.General:AddToggle("AutoRandomBone", {
    Title = "Random Bone",
    Description = "",
    Default = false
})

local General_TakeQuestCake = Tabs.General:AddToggle("TakeQuestCake", {
    Title = "Get Quest Cake Quest",
    Description = "",
    Default = true
})

local General_AttackKatakuri = Tabs.General:AddToggle("AttackKatakuri", {
    Title = "Attack Katakuri",
    Description = "",
    Default = true
})

local General_AutoSummonCakePrince = Tabs.General:AddToggle("AutoSummonCakePrince", {
    Title = "Summon Cake Prince",
    Description = "",
    Default = true
})

-- Tab : Stackble Farm

Tabs.Stack:AddParagraph({
    Title = "```",
    Content = "Stackble Get Items"
})

local Items_GetSaber = Tabs.Stack:AddToggle("GetSaber", {
    Title = "Auto Get Saber",
    Description = "",
    Default = false
})

local Items_GetPoleV1 = Tabs.Stack:AddToggle("GetPoleV1", {
    Title = "Auto Get Pole v1",
    Description = "",
    Default = false
})
local Items_GetTTK = Tabs.Stack:AddToggle("GetTTK", {
    Title = "Auto Get True Triple Katana",
    Description = "",
    Default = false
})

local Items_GetPoleV2 = Tabs.Stack:AddToggle("GetPoleV2", {
    Title = "Auto Get Pole v2",
    Description = "",
    Default = false
})
local Items_GetYama = Tabs.Stack:AddToggle("GetYama", {
    Title = "Auto Get Yama",
    Description = "",
    Default = false
})

local Items_GetTushita = Tabs.Stack:AddToggle("GetTushita", {
    Title = "Auto Get Tushita",
    Description = "",
    Default = false
})

local Stack_GetCDK = Tabs.Stack:AddToggle("GetCDK", {
    Title = "Auto Get Cursed Dual Katana",
    Description = "",
    Default = false
})

local Stack_GetSharkAnchor = Tabs.Stack:AddToggle("GetSharkAnchor", {
    Title = "Auto Get Shark Anchor [ Full ]",
    Description = "",
    Default = false
})

local Items_GetSG = Tabs.Stack:AddToggle("GetSG", {
    Title = "Auto Get Skull Guitar",
    Description = "",
    Default = false
})

Tabs.Stack:AddParagraph({
    Title = "```",
    Content = "Stackble Fruit Collect"
})

local Stack_TPFruit = Tabs.Stack:AddToggle("TPFruit", {
    Title = "Tween To Fruit",
    Description = "",
    Default = false
})
local Stack_InstantCollectFruit = Tabs.Stack:AddToggle("InstantCollectFruit", {
    Title = "Instant Collect Fruit",
    Description = "",
    Default = false
})
local Stack_TPFruitHop = Tabs.Stack:AddToggle("TPFruitHop", {
    Title = "Tween To Fruit [ Hop ]",
    Description = "",
    Default = false
})
Tabs.Stack:AddParagraph({
    Title = "```",
    Content = "Stackble Sea Unlock Quest"
})
local Stack_AutoSecondSea = Tabs.Stack:AddToggle("AutoSecondSea", {
    Title = "Auto Second Sea Quest",
    Description = "",
    Default = false
})
local Stack_AutoThirdSea = Tabs.Stack:AddToggle("AutoThirdSea", {
    Title = "Auto Third Sea Quest",
    Description = "",
    Default = false
})
Tabs.Stack:AddParagraph({
    Title = "```",
    Content = "Stackble Third Sea"
})

if game.PlaceId == sea3 then
    local Stack_ShowElite = Tabs.Stack:AddParagraph({
        Title = "Elite Hunter Status",
        Content = "Progress : ".. game.ReplicatedStorage.Remotes.CommF_:InvokeServer("EliteHunter", "Progress").. "\nElite : "..(function()
            return (getElite() and '🟢' or '🔴')
        end)()
    })
    task.spawn(function()
        pcall(function()
            while task.wait(0.5) do
                Stack_ShowElite:SetDesc("Progress : ".. game.ReplicatedStorage.Remotes.CommF_:InvokeServer("EliteHunter", "Progress").. "\nElite : "..(function()
                    return (getElite() and '🟢' or '🔴')
                end)())
            end
        end)
    end)
end

local Stack_AutoEliteHunter = Tabs.Stack:AddToggle("AutoEliteHunter", {
    Title = "Auto Elite Hunt",
    Description = "",
    Default = false
})
local Stack_AutoSpawnChalice = Tabs.Stack:AddToggle("AutoSpawnChalice", {
    Title = "Auto Dough King Or Indra [ Need Haki ]",
    Description = "",
    Default = false
})
local Stack_AutoEliteHunterHop = Tabs.Stack:AddToggle("AutoEliteHunterHop", {
    Title = "Enable Elite Hunt Hop",
    Description = "",
    Default = false
})
local Stack_CastleRaid = Tabs.Stack:AddToggle("CastleRaid", {
    Title = "Auto Castle Raid",
    Description = "",
    Default = false
})
Tabs.Stack:AddParagraph({
    Title = "```",
    Content = "Stack Second Sea"
})
local Stack_AutoFactory = Tabs.Stack:AddToggle("AutoFactory", {
    Title = "Auto Factory Raid",
    Description = "",
    Default = false
})

-- Tab : Other Farm

function getBosses()
    local _t = {}
    for _,v in {workspace.Enemies,game.ReplicatedStorage} do
        for _,v2 in next,v:GetChildren() do
            if not table.find(_t,v2.Name) and v2:GetAttribute('IsBoss') and v2:IsA('Model') and not v.Name:find('Terror') then
                table.insert(_t,v2.Name)
            end
        end
    end
    return _t
end

Tabs.OtherFarm:AddParagraph({
    Title = "```",
    Content = "Auto Summer Event [ Stackble ]"
})

local OtherFarm_AutoFarmSummer = Tabs.OtherFarm:AddToggle("AutoFarmSummer", {
    Title = "Auto Farm Token",
    Description = "",
    Default = false
})

Tabs.OtherFarm:AddButton({
    Title = "> Random Summer",
    Description = "",
    Callback = function()
        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Cousin", "BuySummer")
    end
})

Tabs.OtherFarm:AddParagraph({
    Title = "```",
    Content = "Auto Farm Boss"
})

local OtherFarm_SelectBoss = Tabs.OtherFarm:AddDropdown("SelectBoss", {
    Title = "Select Boss",
    Description = "",
    Values = getBosses(),
    Multi = false,
    Default = ""
})

Tabs.OtherFarm:AddButton({
    Title = "> Refresh Bosses",
    Description = "",
    Callback = function()
        OtherFarm_SelectBoss:SetValues(getBosses())
    end
})

local OtherFarm_AutoFarmBoss = Tabs.OtherFarm:AddToggle("AutoFarmBoss", {
    Title = "Start Auto Farm Boss",
    Description = "",
    Default = false
})

local OtherFarm_AutoQuestBoss = Tabs.OtherFarm:AddToggle("AutoQuestBoss", {
    Title = "Enable Auto Quest Boss",
    Description = "",
    Default = false
})

Tabs.OtherFarm:AddParagraph({
    Title = "```",
    Content = "Auto Farm Chest"
})

local OtherFarm_AutoChest = Tabs.OtherFarm:AddToggle("AutoChest", {
    Title = "Auto Farm Chest",
    Description = "",
    Default = false,
})

local OtherFarm_AutoChestReset = Tabs.OtherFarm:AddSlider("AutoChestReset", {
    Title = "Set Chest Reset",
    Description = "",
    Default = 5,
    Min = 1,
    Max = 10,
    Rounding = 0,
})

local OtherFarm_AutoChestStopItem = Tabs.OtherFarm:AddToggle("AutoChestStopItem", {
    Title = "Stop When Have Item",
    Description = "",
    Default = false
})

Tabs.OtherFarm:AddParagraph({
    Title = "```",
    Content = "Auto Farm Material"
})

function getMaterials()
    local _t = {}
    if game.PlaceId == sea1 then
        _t = {'Angel Wings', 'Leather + Scrap Metal', 'Magma Ore', 'Fish Tail'}
    elseif game.PlaceId == sea2 then
        _t = {"Leather + Scrap Metal", "Magma Ore", "Ectoplasm", "Mystic Droplet", "Radioactive Material",
              'Vampire Fang'}
    else
        _t = {'Leather + Scrap Metal', 'Fish Tail', 'Conjured Cocoa', 'Dragon Scale', 'Gunpowder', 'Mini Tusk'}
    end
    return _t
end

Tabs.OtherFarm:AddInput("MaterialLimit", {
    Title = "Set Material Limit",
    Description = "",
    Default = math.huge,
    Placeholder = "Default : inf",
    Numeric = true,
    Finished = true
})

local OtherFarm_SelectMaterial = Tabs.OtherFarm:AddDropdown("SelectMaterial", {
    Title = "Select Material",
    Description = "",
    Values = getMaterials(),
    Multi = false,
    Default = ""
})

local OtherFarm_AutoFarmMaterial = Tabs.OtherFarm:AddToggle("AutoFarmMaterial", {
    Title = "Auto Farm Material",
    Description = "",
    Default = false
})

Tabs.OtherFarm:AddParagraph({
    Title = "```",
    Content = "Auto Farm Sea Monsters"
})

local Farm_AutoSeaBeast = Tabs.OtherFarm:AddToggle("AutoSeaBeast", {
    Title = "Auto Sea Beasts [ Sea 2]",
    Description = "",
    Default = false
})

local Farm_AutoSeaEvents = Tabs.OtherFarm:AddToggle("AutoSeaEvents", {
    Title = "Auto Sea Events [ Sea 3 ]",
    Description = "",
    Default = false
})

local Farm_ProtectBoat = Tabs.OtherFarm:AddToggle("ProtectBoat", {
    Title = "Enable Protect Boat",
    Description = "",
    Default = false
})

local Farm_ProtectBoatRadius = Tabs.OtherFarm:AddSlider("ProtectBoatRadius", {
    Title = "Boat Radius",
    Description = "",
    Default = 120,
    Min = 100,
    Max = 500,
    Rounding = 1,
})

local Farm_AutoSeaEventsHighHealth = Tabs.OtherFarm:AddSlider("AutoSeaEventsHighHealth", {
    Title = "Set High Health %",
    Description = "",
    Default = 60,
    Min = 60,
    Max = 100,
    Rounding = 1,
})

local Farm_AutoSeaEventsLowHealth = Tabs.OtherFarm:AddSlider("AutoSeaEventsLowHealth", {
    Title = "Set Low Health %",
    Description = "",
    Default = 40,
    Min = 40,
    Max = 90,
    Rounding = 1,
})

-- Tab 2 : Stats

Tabs.Stats:AddParagraph({
    Title = "Account Info [ Premium ]",
    Content = "Username : " .. plr.Name .. "\nExpiration Date : Lifetime"..'\nLast ban reason : ' .. (function(x)
local function dit(dm)
	for i,v in next,dm do
		if i == 'LastBanReason' then 
			return v
		elseif typeof(v) == 'table' then
			dit(v)
		end
	end
end
return dit(x) or 'No'
end)(game.ReplicatedStorage.Modules.Net["RF/ReadPlayerData"]:InvokeServer())
})

local Stats_ShowLevel = Tabs.Stats:AddParagraph({
    Title = "Player Stats"
})
task.spawn(function()
    while wait(0.25) do
        Stats_ShowLevel:SetDesc("Level : " .. plr.Data.Level.Value)
    end
end)

Tabs.Stats:AddParagraph({
    Title = "```",
    Content = "Auto Upgrade Stats"
})

local Stats_SelectStats = Tabs.Stats:AddDropdown("SelectStats", {
    Title = "Select Stats",
    Description = "",
    Values = {"Melee", "Defense", "Sword", "Gun", "Fruit"},
    Multi = true,
    Default = {"Melee"}
})
local Stats_UpStats = Tabs.Stats:AddToggle("UpStats", {
    Title = "Auto Upgrade Stats",
    Description = "",
    Default = false
})

Tabs.Stats:AddParagraph({
    Title = "```",
    Content = "PVP and Aimbot"
})

local function getTargets()
    local targets = {}
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and
            v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
            table.insert(targets, v.Name)
        end
    end
    return targets
end
local target
local Stats_SelectTarget = Tabs.Stats:AddDropdown("SelectTarget", {
    Title = "Select Target",
    Description = "",
    Values = getTargets(),
    Multi = false,
    Default = "",
    Callback = function(_e)
        target = workspace.Characters:FindFirstChild(_e)
    end
})

Tabs.Stats:AddButton({
    Title = "> Refresh Players",
    Description = "",
    Callback = function()
        Stats_SelectTarget:SetValues(getTargets())
    end
})
local currentRemote
local old
local function hookTool()
    local mt = getrawmetatable(game)
    setreadonly(mt, false)
    old = mt.__namecall
    mt.__namecall = newcclosure(function(self, ...)
        local args = {...}
        if self == currentRemote and getnamecallmethod() == "FireServer" and typeof(args[1]) == "Vector3" then
            pcall(function()
                args[1] = target.HumanoidRootPart.Position
            end)
        end
        return old(self, unpack(args))
    end)
end
local Stats_AimBot = Tabs.Stats:AddToggle("AimBot", {
    Title = "Enable Aimbot",
    Description = "",
    Default = false
})
local function monitorTools()
    local function updateTool()
        local char = plr.Character
        if not char then
            return
        end
        local tool = char:FindFirstChildWhichIsA("Tool")
        if tool then
            local remote = tool:FindFirstChild("RemoteEvent")
            if remote then
                currentRemote = remote
            end
        end
    end
    plr.CharacterAdded:Connect(function(char)
        char.ChildAdded:Connect(function(c)
            if c:IsA("Tool") and Options.AimBot.Value then
                updateTool()
            end
        end)
        if Options.Aimbot.Value then
            updateTool()
        end
    end)
    if plr.Character and Options.AimBot.Value then
        plr.Character.ChildAdded:Connect(function(c)
            if c:IsA("Tool") then
                updateTool()
            end
        end)
        updateTool()
    end
end

local Stats_SpectatePlayer = Tabs.Stats:AddToggle("SpectatePlayer", {
    Title = "Spectate Player",
    Description = "",
    Default = false
})

-- Tab 3 : Items
Tabs.Items:AddParagraph({
    Title = "```",
    Content = "Auto Volcanic Event"
})

local Items_FindVolcanicIsland = Tabs.Items:AddToggle("FindVolcanicIsland", {
    Title = "Auto Find Volcanic Island",
    Description = "",
    Default = false
})

local Items_AutoDojo = Tabs.Items:AddToggle("AutoDojo", {
    Title = "Auto Dojo Trainer Quests",
    Description = "",
    Default = false
})

local Items_AutoDragonHunterHunt = Tabs.Items:AddToggle("AutoDragonHunterHunt", {
    Title = "Auto Dragon Hunter Hunt Quests",
    Description = "",
    Default = false
})

Tabs.Items:AddParagraph({
    Title = "```",
    Content = "Auto Kitsune Event"
})

local Items_FindKitsuneIsland = Tabs.Items:AddToggle("FindKitsuneIsland", {
    Title = "Auto Find Kitsune Island",
    Description = "",
    Default = false
})

local Items_CollectAzure = Tabs.Items:AddToggle("CollectAzure", {
    Title = "Auto Collect Azure Ember",
    Description = "",
    Default = false
})

Tabs.Items:AddParagraph({
    Title = "```",
    Content = "Auto get melee [ Stackable ]"
})

local Items_GetSuperhuman = Tabs.Items:AddToggle("GetSuperhuman", {
    Title = "Auto Get Superhuman",
    Description = "",
    Default = false
})

local Items_GetDeathStep = Tabs.Items:AddToggle("GetDeathStep", {
    Title = "Auto Get Death Step",
    Description = "",
    Default = false
})

local Items_GetSharkmanKarate = Tabs.Items:AddToggle("GetSharkmanKarate", {
    Title = "Auto Get Sharkman Karate",
    Description = "",
    Default = false
})
local Items_GetElectricClaw = Tabs.Items:AddToggle("GetElectricClaw", {
    Title = "Auto Get Electric Claw",
    Description = "",
    Default = false
})

local Items_GetDragonTalon = Tabs.Items:AddToggle("GetDragonTalon", {
    Title = "Auto Get Dragon Talon",
    Description = "",
    Default = false
})

local Items_GetGodhuman = Tabs.Items:AddToggle("GetGodhuman", {
    Title = "Auto Get Godhuman",
    Description = "",
    Default = false
})

local Items_SelectMelee = Tabs.Items:AddDropdown("SelectMeleeToBuy", {
    Title = "Select Melee",
    Description = "",
    Values = {"Dark Step", "Water Kung Fu", "Electric", "Dragon Claw", "Superhuman", "Death Step", "Sharkman Karate",
              "Electric Claw", "Dragon Talon", "Godhuman","Sanguine Art"},
    Multi = false,
    Default = ""
})

local Items_BuyMelee = Tabs.Items:AddToggle("BuyMelee", {
    Title = "Buy Selected Melee",
    Description = "",
    Default = false
})

Tabs.Items:AddParagraph({
    Title = "```",
    Content = "Auto buy abilites"
})

Tabs.Items:AddButton({
    Title = "Buy Abilities",
    Description = "",
    Callback = function()
        local t = {"Soru", "Buso", "Geppo"}
        for _, v in pairs(t) do
            game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyHaki", v)
        end
        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("KenTalk", "Buy")
    end
})

local Items_GetRainbowHaki = Tabs.Items:AddToggle('GetRainbowHaki',{
    Title = 'Auto Get Rainbow Haki',
    Description = '',
    Default = false
})

local Items_GetKenV2 = Tabs.Items:AddToggle("GetKenV2", {
    Title = "Auto Get Ken Haki V2",
    Description = "",
    Default = false
})

-- Tab 4 : Local Player

Tabs.LocalPlayer:AddParagraph({
    Title = "```",
    Content = "Player and server status"
})

local raceShow = Tabs.LocalPlayer:AddParagraph({
    Title = "Race Status ",
    Content = "Your race : " .. race.Value .. "\nRace grade : "
})
local moonShow = Tabs.LocalPlayer:AddParagraph({
    Title = "Moon Status ",
    Content = "Sea : " .. "\nMoon status : "
})
local eventShow = Tabs.LocalPlayer:AddParagraph({
    Title = "Event Status  ",
    Content = "Frozen Dimension : " .. "\nKitsune Shrine : "
})

task.spawn(function()
    while task.wait(0.5) do
        pcall(function()
            raceShow:SetDesc("Your race : " .. race.Value .. "\nRace grade : " .. getRaceGrade())
            moonShow:SetDesc("Sea : " .. getSea() .. " " .. "\nMoon status : " .. getMoonStatus())
            eventShow:SetDesc("Frozen Dimension : ".. (workspace.Map:FindFirstChild('FrozenDimension') and "🟢" or "🔴") .. "\nKitsune Shrine : " .. 
            (workspace.Map:FindFirstChild('KitsuneShrine') and "🟢" or "🔴"))
        end)
    end
end)

Tabs.LocalPlayer:AddParagraph({
    Title = "```",
    Content = "Auto race evo"
})

local LocalPlayer_AutoBartilo = Tabs.LocalPlayer:AddToggle("AutoBartilo", {
    Title = "Auto Bartilo Quest",
    Description = "",
    Default = false
})

local LocalPlayer_AutoRaceV2 = Tabs.LocalPlayer:AddToggle("AutoRaceV2", {
    Title = "Auto Race V2 Quest",
    Description = "",
    Default = false
})

local LocalPlayer_AutoRaceV3 = Tabs.LocalPlayer:AddToggle("AutoRaceV3", {
    Title = "Auto Race V3 Quest",
    Description = "",
    Default = false
})

-- Tab : Race / V4

Tabs.Farm:AddParagraph({
    Title = "```",
    Content = "Auto unlock race [ Full ]"
})

local Farm_AutoCyborg = Tabs.Farm:AddToggle("AutoCyborg", {
    Title = "Auto Unlock Cyborg Race",
    Description = "",
    Default = false
})

local Farm_AutoGhoul = Tabs.Farm:AddToggle("AutoGhoul", {
    Title = "Auto Unlock Ghoul Race",
    Description = "",
    Default = false
})

Tabs.Farm:AddParagraph({
    Title = "```",
    Content = "Auto race v4"
})

local Farm_SelectHost = Tabs.Farm:AddDropdown("SelectHost", {
    Title = "Select Host",
    Description = "",
    Values = getPlayers(),
    Multi = false,
    Default = ""
})
Tabs.Farm:AddButton({
    Title = "> Refresh Players",
    Description = "",
    Callback = function()
        Farm_SelectHost:SetValues(getPlayers())
    end
})

local Farm_ActiveHelp = Tabs.Farm:AddToggle("ActiveHelp", {
    Title = "Auto Active Race [ For Help Account ]",
    Description = "",
    Default = false
})

local Farm_AutoCompleteTrial = Tabs.Farm:AddToggle("AutoCompleteTrial", {
    Title = "Auto Complete Trial",
    Description = "",
    Default = false
})

local Farm_tweenToRacesDoor = Tabs.Farm:AddToggle("tweenToRacesDoor", {
    Title = "Enabled tween To Races Door",
    Description = "",
    Default = false
})

local Farm_ResetAfterTrial = Tabs.Farm:AddToggle("ResetAfterTrial", {
    Title = "Enabled Reset After Trial",
    Description = "",
    Default = false
})

local Farm_KillPlayersTrial = Tabs.Farm:AddToggle("KillPlayersTrial", {
    Title = "Enabled Kill Players Trial",
    Description = "",
    Default = false
})

local Farm_AutoBuyGears = Tabs.Farm:AddToggle("AutoBuyGears", {
    Title = "Enabled Auto Buy Gears",
    Description = "",
    Default = false
})

Tabs.Farm:AddParagraph({
    Title = "```",
    Content = "Auto pull lever and mirage"
})

local showLeverAndMirage = Tabs.Farm:AddParagraph({
    Title = "Lever and mirage status",
    Content = "Lever status : " .. getLeverStatus() .. "\nMirage status : " .. getMirageStatus()
})
task.spawn(function()
    while task.wait(0.5) do
        showLeverAndMirage:SetDesc("Lever status : " .. getLeverStatus() .. "\nMirage status : " .. getMirageStatus())
    end
end)

local Farm_LookAtMoon = Tabs.Farm:AddToggle("LookAtMoon", {
    Title = "Enabled Look At Moon",
    Description = "",
    Default = false
})

local Farm_AutoPullLever = Tabs.Farm:AddToggle("AutoPullLever", {
    Title = "Enabled Auto Pull Lever",
    Description = "",
    Default = false
})

local Farm_TweenToMirage = Tabs.Farm:AddToggle("TweenToMirage", {
    Title = "Enabled tween To Mirage",
    Description = "",
    Default = false
})

local Farm_TweenToAdvancedDealer = Tabs.Farm:AddToggle("TweenToAdvancedDealer", {
    Title = "Enabled tween To Advanced Dealer",
    Description = "",
    Default = false
})

local Farm_TweenToBlueGear = Tabs.Farm:AddToggle("TweenToBlueGear", {
    Title = "Enabled tween To Blue Gear",
    Description = "",
    Default = false
})

-- Tab 5 : Travel

Tabs.Travel:AddParagraph({
    Title = "```",
    Content = "World travel"
})

Tabs.Travel:AddButton({
    Title = "> Teleport to first sea",
    Description = "",
    Callback = function()
        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelMain")
    end
})
Tabs.Travel:AddButton({
    Title = "> Teleport to second sea",
    Description = "",
    Callback = function()
        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelDressrosa")
    end
})

Tabs.Travel:AddButton({
    Title = "> Teleport to third sea",
    Description = "",
    Callback = function()
        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelZou")
    end
})

Tabs.Travel:AddParagraph({
    Title = "```",
    Content = "Tween to islands"
})

getIslands()
local Travel_SelectIsland = Tabs.Travel:AddDropdown("SelectIsland", {
    Title = "Select Island",
    Description = "",
    Values = islands,
    Multi = false,
    Default = ""
})

local Travel_StartTravel = Tabs.Travel:AddToggle("StartTravel", {
    Title = "Start Travel [ Safe ]",
    Description = "",
    Default = false
})

-- Tab : Raid

Tabs.Visual:AddParagraph({
    Title = "```",
    Content = "Auto buy devil fruit"
})

local Visual_AutoRandomFruits = Tabs.Visual:AddToggle("AutoRandomFruits", {
    Title = "Auto Random Fruits",
    Description = "",
    Default = false
})

local Visual_AutoStoreFruits = Tabs.Visual:AddToggle("AutoStoreFruits", {
    Title = "Auto Store Fruits",
    Description = "",
    Default = false
})

Tabs.Visual:AddParagraph({
    Title = "```",
    Content = "Auto play dungeon"
})

local Visual_SelectChip = Tabs.Visual:AddDropdown("SelectChip", {
    Title = "Select Chip",
    Description = "Select chip to play dungeon",
    Values = {"Flame", "Ice", "Quake", "Light", "Dark", "String", "Rumble", "Magma", "Human: Buddha", "Sand",
              "Bird: Phoenix", "Dough"},
    Multi = false,
    Default = "Flame"
})

local Visual_AutoPlayDungeon = Tabs.Visual:AddToggle("AutoPlayDungeon", {
    Title = "Auto Play Dungeon",
    Description = "",
    Default = false
})

local Visual_AutoAwaken = Tabs.Visual:AddToggle("AutoAwaken", {
    Title = "Auto Awaken Skills",
    Description = "",
    Default = false
})

Tabs.Visual:AddParagraph({
    Title = "```",
    Content = "ESP"
})

local Visual_PlayerESP = Tabs.Visual:AddToggle("PlayerESP", {
    Title = "Player ESP",
    Description = "",
    Default = false
})

local Visual_ChestESP = Tabs.Visual:AddToggle("ChestESP", {
    Title = "Chest ESP",
    Description = "",
    Default = false
})

local Visual_IslandESP = Tabs.Visual:AddToggle("IslandESP", {
    Title = "Island ESP",
    Description = "",
    Default = false
})

local Visual_DevilFruitESP = Tabs.Visual:AddToggle("DevilFruitESP", {
    Title = "Devil Fruit ESP",
    Description = "",
    Default = false
})

local Visual_GearESP = Tabs.Visual:AddToggle("GearESP", {
    Title = "Gear ESP",
    Description = "",
    Default = false
})

-- Tab 6 : Webhook

Tabs.Webhook:AddSection("Webhook notify")

local Webhook_WebhookUrlInput = Tabs.Webhook:AddInput("WebhookUrlInput", {
    Title = "Webhook Url",
    Description = "",
    Default = "",
    Placeholder = "Enter webhook url",
    Numeric = false,
    Finished = true
})

local delayWebhook
local Webhook_SetTimeWebhook = Tabs.Webhook:AddSlider("SetTimeWebhook", {
    Title = "Set delay time",
    Description = "",
    Default = 600,
    Min = 10,
    Max = 1200,
    Rounding = 1,
    Callback = function(Value)
        delayWebhook = Value
    end
})

local Webhook_SendWebhook = Tabs.Webhook:AddToggle("SendWebhook", {
    Title = "Send Webhook",
    Description = "",
    Default = false
})

-- Tab 7 : Plus

Tabs.Plus:AddSection("🎧 Music Player")

local songUrl

local songList = {
    ["Ghe Qua"] = "https://files.catbox.moe/syjl5s.mp3"
}

local Plus_SelectSong = Tabs.Plus:AddDropdown("SelectSong", {
    Title = "Select Song",
    Description = "",
    Values = {"Ghe Qua", "Noi Nay Co Anh"},
    Multi = false,
    Default = "",
    Callback = function(Value)
        songUrl = songList[Value]
    end
})
local Plus_RepeatSong = Tabs.Plus:AddToggle("RepeatSong", {
    Title = "Enable Repeat Song",
    Description = "",
    Default = false
})
Tabs.Plus:AddButton({
    Title = "> Play song",
    Description = "",
    Callback = function()
        if not songUrl then
            warn("No song selected!")
            return
        end
        local res = req({
            Url = songUrl,
            Method = "GET"
        })
        writefile(Options.SelectSong.Value .. ".mp3", res.Body)
        local s = Instance.new("Sound")
        s.SoundId = getsynasset(Options.SelectSong.Value .. ".mp3")
        s.Parent = workspace
        s.Volume = 1
        s.Looped = Options.RepeatSong.Value
        s:Play()
    end
})

Tabs.Plus:AddSection("🤡 Troll Functions :)")

Tabs.Plus:AddButton({
    Title = "> Instant Ban",
    Description = "",
    Callback = function()
        local player = plr
        local banDuration = 7331
        local reason = "Cheating | ID 1337"
        local message = string.format(
            "You were kicked from this experience: \nYou are banned for [%d hours]\nReason: %s\nFuture bans will be PERMANENT. Do not break the rules.",
            banDuration, reason)
        player:Kick(message)
    end
})

Tabs.Plus:AddSection("📜 Useful Functions")

Tabs.Plus:AddButton({
    Title = "> Copy CFrame",
    Description = "",
    Callback = function()
        if character and character:FindFirstChild("HumanoidRootPart") then
            pcall(function()
                setclipboard(tostring(character.HumanoidRootPart.CFrame))
            end)
        end
    end
})

Tabs.Plus:AddButton({
    Title = "> Run Infinite Yield",
    Description = "",
    Callback = function()
        if character and character:FindFirstChild("HumanoidRootPart") then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
        end
    end
})

Tabs.Plus:AddInput("AgeCalculator", {
    Title = "Smart age calculator",
    Description = "Enter your age",
    Default = "Default",
    Placeholder = "Example: 69",
    Numeric = true, -- Only allows numbers
    Finished = true, -- Only calls callback when you press enter
    Callback = function(Value)
        Fluent:Notify({
            Title = "Radiant Hub Premium - Age Calculator",
            Content = "Your age is " .. Value .. " years old.",
            SubContent = "SubContent",
            Duration = 3
        })
    end
})

-- Tab 8 : Misc

Tabs.Misc:AddParagraph({
    Title = "```",
    Content = "Server Hop"
})

local Misc_AntiCheater = Tabs.Misc:AddToggle("AntiCheater", {
    Title = "Enable Anti Cheater",
    Description = "Auto Hop Server If Hacker Near",
    Default = false,
    Callback = function(Value)
        task.spawn(function()
            while Value and task.wait() do
                for _, v in pairs(workspace.Characters:GetChildren()) do
                    if v.Name ~= plr.Name and
                        (v.HumanoidRootPart.Position - character.HumanoidRootPart.Position).Magnitude < 150 then
                        hopLowServer()
                        break
                    end
                end
            end
        end)
    end
})

Tabs.Misc:AddToggle("AutoRejoin", {
    Title = "Auto Rejoin Disconnect",
    Description = "",
    Default = true,
    Callback = function(Value)
        game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
            if child.Name == "ErrorPrompt" and Value then
                tps:Teleport(game.PlaceId, plr)
            end
        end)
    end
})

local Misc_RAMInput = Tabs.Misc:AddInput("RAMInput", {
    Title = "Enter Limit RAM",
    Description = "",
    Default = math.huge,
    Placeholder = "Unit : MB",
    Numeric = true,
    Finished = true
})

local Misc_RAMLimit Tabs.Misc:AddToggle("RAMLimit", {
    Title = "Enable RAM Limit Rejoin",
    Description = "",
    Default = false,
    Callback = function(Value)
        task.spawn(function()
            while Value and task.wait(0.5) do
                if game:GetService('Stats'):GetTotalMemoryUsageMb() >= tonumber(Options.RAMInput.Value) then
                    pcall(function()
                        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,game.JobId, plr)
                    end)
                end
            end
        end)
    end
})

Tabs.Misc:AddInput("JobIdInput", {
    Title = "Input Job Id",
    Description = "",
    Default = "",
    Placeholder = "Enter JobId here...",
    Numeric = false,
    Finished = false
})

Tabs.Misc:AddToggle("SpamJoin", {
    Title = "Enable Spam Join",
    Description = "",
    Default = false,
    Callback = function(Value)
        task.spawn(function()
            while Value and task.wait(0.5) do
                if #Options.JobIdInput.Value > 5 then
                    pcall(function()
                        tps:TeleportToPlaceInstance(game.PlaceId,Options.JobIdInput.Value, plr)
                    end)
                end
            end
        end)
    end
})

Tabs.Misc:AddButton({
    Title = "> Copy JobId",
    Description = "",
    Callback = function()
        setclipboard(game.JobId)
    end
})

Tabs.Misc:AddButton({
    Title = "> Hop To Low Server",
    Description = "",
    Callback = function()
        hopLowServer()
    end
})

Tabs.Misc:AddButton({
    Title = "> Server Hop",
    Description = "",
    Callback = function()
        hopServer()
    end
})

Tabs.Misc:AddButton({
    Title = "> Rejoin Server",
    Description = "",
    Callback = function()
        tps:TeleportToPlaceInstance(game.PlaceId, game.JobId, plr)
    end
})

Tabs.Misc:AddParagraph({
    Title = "```",
    Content = "Open Guis"
})
Tabs.Misc:AddButton({
    Title = "Open Title Gui",
    Description = "",
    Callback = function()
        game:GetService("Players").LocalPlayer.PlayerGui.Main.Titles.Visible = true
    end
})

Tabs.Misc:AddButton({
    Title = "Open Fruit Shop Gui",
    Description = "",
    Callback = function()
        require(game:GetService("Players").LocalPlayer.PlayerGui.Main.FruitShopAndDealer.Controller):Open("FruitShop")
    end
})

-- Functions

function smartTween(t)
    pcall(function()
        if not character.HumanoidRootPart then return end
        local _is = {
            Vector3.new(5700, 1015, -215),
            Vector3.new(-12550, 340, -7500),
            Vector3.new(-5000, 350, -3035)
        }
        local min = nil
        local pos = nil
        if typeof(t) == 'CFrame' then t = t.Position end
        for i,v in ipairs(_is) do
            if min == nil then
                min = (t - v).Magnitude
            else
                if (t - v).Magnitude < min then
                    min = (t - v).Magnitude
                    pos = i
                end
            end
        end
        if min < plr:DistanceFromCharacter(t) then
            game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance",_is[pos])
            task.wait(0.5)
        end
    end)
end

local tw,conn
function StopTween()
    if tw then tw:Cancel() tw = nil end
    if conn then conn:Disconnect() conn = nil end
    local r = character and character:FindFirstChild('Root')
    if r then r:Destroy() end
end
-- local function tween(p, speed)
--     if tw then StopTween() end
--     if conn then conn:Disconnect() conn = nil end
--     if smartTween(p) then StopTween() end
--     local hrp = character and character:FindFirstChild('HumanoidRootPart')
--     if not (hrp and character:FindFirstChild('Humanoid')) then return end
--     if typeof(p) == "Vector3" then p = CFrame.new(p) end
--     local root = character:FindFirstChild("Root")
--     if not root then root = Instance.new("Part", character) root.Name, root.Size, root.Anchored, 
--         root.CanCollide, root.Transparency = "Root", Vector3.new(1,0.5,1), true, false, 1
--         root.CFrame = hrp.CFrame
--     end
--     local tween = tweens:Create(root, TweenInfo.new((root.Position-p.Position).Magnitude/(speed or 350), Enum.EasingStyle.Linear), {CFrame = p})
--     tween:Play()
--     conn = runs.Heartbeat:Connect(function() if tween.PlaybackState == Enum.PlaybackState.Playing then hrp.CFrame = root.CFrame else conn:Disconnect() end end)
--     tween.Completed:Connect(function() if conn then conn:Disconnect() end tween = nil end)
--     return tween
-- end

local function tween(v, speed, high)
    if not character then return end
    if not character.HumanoidRootPart then return end
    if not character.Humanoid then return end
    if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
        character.Humanoid.Sit = false
        smartTween(v)
        local rootPart = plr.Character:FindFirstChild("HumanoidRootPart")
        if typeof(v) == "Vector3" then v = CFrame.new(v) end
        local pos = v.Position + Vector3.new(0, high or 0, 0)
        local rot = rootPart.CFrame - rootPart.Position
        v = CFrame.new(pos) * rot
        local distance = (rootPart.Position - v.Position).Magnitude
        local time = distance / speed
        local tweeninfo = TweenInfo.new(time, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
        tw = tweens:Create(rootPart, tweeninfo, { CFrame = v })
        tw:Play()
        return tw
    end
end

-- functions : Quests

function Teleport(target)
    if typeof(target) == "CFrame" then
        game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = target
    elseif typeof(target) == "string" or typeof(target) == "number" then
        if game.PlaceId == sea1 then
            if string.find(target:lower(), "sky") then
                if string.find(target:lower(), "1") or string.find(target:lower(), "2") then
                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-4650, 872, -1775))--sky 2
                    return
                elseif string.find(target:lower(), "3") then
                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-7900, 5578, -520))--sky 3
                    return
                end
            elseif string.find(target:lower(), "fish") then
                if string.find(target:lower(), "entrance") then
                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(61200, 12, 1675))--entrance fish
                    return
                elseif string.find(target:lower(), "le") or string.find(target:lower(), "exit") then
                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(3900, 10, -1900))--leave fish
                    return
                end
            end
        elseif game.PlaceId == 2 then
            if string.find(target:lower(), "ship") then
                if string.find(target:lower(), "entrance") or string.find(target:lower(), "enter") then
                elseif string.find(target:lower(), "leave") or string.find(target:lower(), "exit") then
                end
                return
            end
        elseif game.PlaceId == 3 then
            if string.find(target:lower(), "mansion") then
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-12550, 340, -7500))--mansion
                return
            elseif string.find(target:lower(), "hydra") then
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(5700, 1015, -215)) -- hydraa
                return
            elseif string.find(target:lower(), "castle") then
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-5000, 350, -3035)) --sea castle
                return
            elseif string.find(target:lower(), "temple") then
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", workspace.Map["Temple of Time"].TeleportSpawn.Position)
                return
            end
        end
    end
end

function CheckQuestData()
    for i, _ in next, require(game.ReplicatedStorage.GuideModule).Data do if i == "QuestData" then return true end end
    return false
end

function CheckNameDoubleQuest()
    if CheckQuestData() then for i, _ in next, require(game.ReplicatedStorage.GuideModule).Data.QuestData.Task do return i end end
end
function CheckNameDoubleQuest2()
    local ndq = {}
    if CheckQuestData() then for i, _ in next, require(game.ReplicatedStorage.GuideModule).Data.QuestData.Task do table.insert(ndq, i) end end
    return ndq
end

function CheckDoubleQuest2()
        local Level = game.Players.LocalPlayer.Data.Level.Value
    local msn, nq, idq
    local min = 0
    if Level >= 275 and Level < 300 then
        nq, msn, idq = "ColosseumQuest", "Togga Warrior", 1
    elseif Level >= 1450 and game.PlaceId == 4442272183 then
		nq, msn, idq = "ForgottenQuest", "Water Fighter", 2
	elseif Level >= 700 and game.PlaceId == 2753915549 then
		nq, msn, idq ="FountainQuest", "Galley Captain", 2
	else
        for rnq, v in pairs(require(game.ReplicatedStorage.Quests)) do
			for ridq, ct in pairs(v) do
				for O, _ in pairs(ct.Task) do
					if Level >= ct.LevelReq and ct.LevelReq >= min and ct.Task[O] > 1 and not table.find({"BartiloQuest", "Trainees", "MarineQuest", "CitizenQuest"}, tostring(rnq)) then
						min, nq, msn, idq = ct.LevelReq, rnq, tostring(O), ridq
					end
				end
			end
		end
	end
    local q = {}
    if Level >= 20 then
        for rnq, v in pairs(require(game.ReplicatedStorage.Quests)) do
            for _, N in pairs(v) do
                for x, _ in pairs(N.Task) do
                    if tostring(x) == msn then
                        for iq, v2 in next, v do
                            for n, ct in next, v2.Task do
                                if n ~= msn and ct == 1 and (function()
                                    for _,v in {game.ReplicatedStorage,workspace.Enemies} do
                                        for _,v2 in next,v:GetChildren() do
                                            if v2.Name == tostring(n) and v2:FindFirstChild('Humanoid') and v2:FindFirstChild('HumanoidRootPart') then
                                                if v2.Humanoid.Health > 0 then
                                                    return true
                                                end
                                            end
                                        end
                                    end
                                    return false
                                end)() then
                                    q.NameMonster = v2.LevelReq <= Level and tostring(n) or msn
                                    q.NameQuest = v2.LevelReq <= Level and rnq or nq
                                    q.ID = v2.LevelReq <= Level and iq or idq
                                    return q -- Triple Quest or not
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    if Level >= 10 and CheckQuestData() and CheckNameDoubleQuest() == msn and #CheckNameDoubleQuest() > 2 then
        for rnq, v in pairs(require(game.ReplicatedStorage.Quests)) do
            for _, N in pairs(v) do
                for x, _ in pairs(N.Task) do
                    if tostring(x) == msn then
                        for iq, v2 in next, v do
                            for n, ct in next, v2.Task do
                                if n ~= msn and ct > 1 then
                                    q.NameMonster = v2.LevelReq <= Level and tostring(n) or msn
                                    q.NameQuest = v2.LevelReq <= Level and rnq or nq
                                    q.ID = v2.LevelReq <= Level and iq or idq
                                    return q -- Double Quest or not
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    q.NameMonster = msn
    q.NameQuest = nq
    q.ID = idq
    return q
end

function takeQuestCake(b)
    if not plr.PlayerGui.Main.Quest.Visible then
        local r = require(game.ReplicatedStorage.Quests)
        local t = {r.CakeQuest1,r.CakeQuest2}
        local qn,id,lvrq
        for c,v in t do
            if typeof(v) == 'table' then
                for i,v2 in v do
                    if v2.Name == b then
                        id = i
                        qn = 'CakeQuest'..c
                        lvrq = v2.LevelReq
                    end
                end
            end
        end
        local p
        for i,v in next,require(game.ReplicatedStorage.GuideModule).Data.NPCList do
            if typeof(v) == 'table' then
                for r,x in next,v do
                    if x == qn then
                        if plr.Data.Level.Value >= lvrq then
                            p = v.Position
                        else
                            return
                        end
                    end
                end
            end
        end
        -- print(p,qn,id,lvrq)
        tween(p,350).Completed:Wait()
        if plr:DistanceFromCharacter(p) < 5 then
            task.wait(1)
            game.ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", tostring(qn), id)
            task.wait(0.5)
        end
    end
end

function GetMonsterName()
    local _v = {}
    for _, v in pairs(workspace.Enemies:GetChildren()) do
        if not table.find(_v, v.Name) and v:IsA("Model") and v.Name ~= "PirateBasic"
        and not string.find(v.Name, "Brigade") and not string.find(v.Name,'FishBoat') and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then 
            table.insert(_v, v.Name)
        end
    end
    for _, v in pairs(_v) do
        if v:gsub(" %pLv. %d+%p", "") == CheckNameDoubleQuest() then return v:gsub(" %pLv. %d+%p", "") end
    end
    return false
end

function getQuestPosition()
    for i,v in next,require(game.ReplicatedStorage.GuideModule).Data.NPCList do
        if typeof(v) == 'table' then
            for r,x in next,v do
                if x == CheckDoubleQuest2()['NameQuest'] then
                    if CheckDoubleQuest2()['NameQuest'] == 'SkyExp1Quest' and plr.Data.Level.Value >= 450 then
                        return Vector3.new(-7859.09814453125, 5544.18994140625, -381.47601318359375)
                    end
                    return v.Position
                end
            end
        end
    end
end

function tweenMobSpawn(v)
    if game.ReplicatedStorage.FortBuilderReplicatedSpawnPositionsFolder:FindFirstChild(v) then
        return tween(game.ReplicatedStorage.FortBuilderReplicatedSpawnPositionsFolder:FindFirstChild(v),350)
    end
end

function takeQuest()
    local function escapePattern(cc)
        return cc:gsub("([^%w])", "%%%1")
    end
    local text = plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text
    if not plr.PlayerGui.Main.Quest.Visible or not string.find(text, escapePattern(CheckNameDoubleQuest2()[1])) and
        not string.find(text, CheckNameDoubleQuest2()[1]) then
        tween(getQuestPosition(),350).Completed:Wait()
        if plr:DistanceFromCharacter(getQuestPosition()) < 20 then
            task.wait(0.75)
            game.ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", tostring(CheckDoubleQuest2().NameQuest), CheckDoubleQuest2().ID)
            task.wait(0.25)
        end
    end
end

killAura = newcclosure(function(distance)
    for _, v in pairs(workspace.Enemies:GetChildren()) do
        if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") then
            if (v.HumanoidRootPart.Position - character.HumanoidRootPart.Position).Magnitude <= distance then
                warn("Kill Aura By Radiant Hub. NO SKID !!!")
                warn("            - From x2Rune")
                v.Humanoid:ChangeState(15)
            end
        end
    end
end)

local remote, idremote
for _, v in {game.ReplicatedStorage.Util, game.ReplicatedStorage.Common, game.ReplicatedStorage.Remotes, game.ReplicatedStorage.Assets, game.ReplicatedStorage.FX} do
    for _, n in next, v:GetChildren() do
        if n:IsA("RemoteEvent") and n:GetAttribute("Id") then
            remote, idremote = n, n:GetAttribute("Id")
        end
    end
    v.ChildAdded:Connect(function(n)
        if n:IsA("RemoteEvent") and n:GetAttribute("Id") then
            remote, idremote = n, n:GetAttribute("Id")
        end
    end)
end
local function FastAttack()
    local char = character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local parts = {}
    for _, v in ipairs(workspace.Enemies:GetChildren()) do
        local hrp = v:FindFirstChild("HumanoidRootPart")
        local hum = v:FindFirstChild("Humanoid")
        if v ~= char and hrp and hum and hum.Health > 0 and plr:DistanceFromCharacter(hrp.Position) <= 35 then
            for _, _v in ipairs(v:GetChildren()) do
                if _v:IsA("BasePart") and plr:DistanceFromCharacter(hrp.Position) <= 35 then
                    parts[#parts+1] = {v, _v}
                end
            end
        end
    end
    if #parts == 0 then return end
    local tool = char:FindFirstChildOfClass("Tool")
    if #parts > 0 and tool and (tool.ToolTip=="Melee" or tool.ToolTip=="Sword") then
        game.ReplicatedStorage.Remotes.Combo:FireServer()
        require(game.ReplicatedStorage.Modules.Net):RemoteEvent("RegisterHit", true)
        require(game.ReplicatedStorage.Modules.Net):RemoteEvent("ReceivedHit")
        game.ReplicatedStorage.Modules.Net["RE/RegisterAttack"]:FireServer()
        local head = parts[1][1]:FindFirstChild("Head")
        game.ReplicatedStorage.Modules.Net["RE/RegisterHit"]:FireServer(head, parts, {}, tostring(game.Players.LocalPlayer.UserId):sub(2, 4) .. tostring(coroutine.running()):sub(11, 15))
        cloneref(remote):FireServer(string.gsub("RE/RegisterHit", ".", function(c)
            return string.char(bit32.bxor(string.byte(c), math.floor(workspace:GetServerTimeNow() / 10 % 10) + 1))
        end),
        bit32.bxor(idremote + 909090, game.ReplicatedStorage.Modules.Net.seed:InvokeServer() * 2), head, parts)
    end
end

-- Event Handling

Stack_GetSharkAnchor:OnChanged(function()
    task.spawn(function()
        local stn = {['Mutant Tooth'] = 1,['Shark Tooth'] = 5}
        local tj = {['Terror Eyes'] = 1,['Mutant Tooth'] = 2,['Fool\'s Gold'] = 10,['Shark Tooth'] = 5}
        local mm = {['Terror Eyes'] = 2,['Electric Wing'] = 8,['Fool\'s Gold'] = 20,['Shark Tooth'] = 10}
        local function checkSharkAnchor(c)
            local b = 0
            for i,v in next,c do
                if GetMaterial(i) >= v then
                    b = b + 1
                end
            end
            if b == (function() 
                local l = 0 for i,v in next,c do l = l + 1 end return l 
            end)() then
                return true
            end
            return false
        end
        while task.wait() and Options.GetSharkAnchor.Value do
            if not checkItem('Shark Tooth Necklace') then
                if checkSharkAnchor(stn) then
                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer('CraftItem','Craft','ToothNecklace')
                else
                    repeat
                        if Options.AutoSeaEvents.Value == false then
                            Farm_AutoSeaEvents:SetValue(true)
                        end
                        task.wait(1.5)
                    until checkSharkAnchor(stn) or not Options.GetSharkAnchor.Value
                    Farm_AutoSeaEvents:SetValue(false)
                end
            elseif not checkItem('Terror Jaw') then
                if checkSharkAnchor(tj) then
                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer('CraftItem','Craft','TerrorJaw')
                else
                    repeat
                        if Options.AutoSeaEvents.Value == false then
                            Farm_AutoSeaEvents:SetValue(true)
                        end
                        task.wait(1.5)
                    until checkSharkAnchor(tj) or not Options.GetSharkAnchor.Value
                    Farm_AutoSeaEvents:SetValue(false)
                end
            elseif not checkItem('Monster Magnet') then
                if checkSharkAnchor(mm) then
                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer('CraftItem','Craft','SharkAnchor')
                else
                    repeat
                        if Options.AutoSeaEvents.Value == false then
                            Farm_AutoSeaEvents:SetValue(true)
                        end
                        task.wait(1.5)
                    until checkSharkAnchor(mm) or not Options.GetSharkAnchor.Value
                    Farm_AutoSeaEvents:SetValue(false)
                end
            elseif checkItem('Monster Magnet') and not checkItem('Shark Anchor') then
                repeat
                    if Options.AutoSeaEvents.Value == false then
                        Farm_AutoSeaEvents:SetValue(true)
                    end
                    task.wait(1.5)
                until checkItem('Shark Anchor') or not Options.GetSharkAnchor.Value
                Farm_AutoSeaEvents:SetValue(false)
            end
        end
    end)
end)

OtherFarm_AutoFarmBoss:OnChanged(function()
    task.spawn(function()
        while task.wait() do
            if Options.AutoFarmBoss.Value then
                for _, v2 in {workspace.Enemies, game.ReplicatedStorage} do
                    for _, v in pairs(v2:GetChildren()) do
                        if v.Name == Options.SelectBoss.Value and v.Humanoid.Health > 0 then
                            repeat
                                task.wait()
                                equipWeapon()
                                tween(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 10), 350)
                                FastAttack()
                            until not v or not Options.AutoFarmBoss.Value or v.Humanoid.Health <= 0
                        end
                    end
                end
            end
        end
    end)
end)

OtherFarm_AutoQuestBoss:OnChanged(function()
    task.spawn(function()
        while task.wait() do
            if Options.AutoQuestBoss.Value then
                if Options.AutoFarmBoss.Value then
                    if Options.SelectBoss.Value ~= "Longma" then
                        for i1, c2 in next, require(game.ReplicatedStorage.Quests) do
                            for id, d in next, c2 do
                                for i22, v22 in pairs(d) do
                                    if i22 == "Name" and v22 == Options.SelectBoss.Value then
                                        if game.ReplicatedStorage:FindFirstChild(Options.SelectBoss.Value) or
                                            workspace.Enemies:FindFirstChild(Options.SelectBoss.Value) then
                                            game.ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", i1, id)
                                            task.wait(1)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end)
end)

local materialMon, materialPos
local function getMaterialMon()
    if not character or not character.HumanoidRootPart then
        return
    end
    local function shouldRequestEntrance(targetPosition, distanceThreshold)
        local distance = (plr.Character.HumanoidRootPart.Position - targetPosition).Magnitude
        if distance >= distanceThreshold then
            game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", targetPosition)
        end
    end
    if game.PlaceId == sea1 then
        if Options.SelectMaterial.Value == "Angel Wings" then
            materialMon = {"Shanda", "Royal Squad", "Royal Soldier", "Wysper", "Thunder God"}
            materialPos = CFrame.new(-4698, 845, -1912)
            shouldRequestEntrance(Vector3.new(-4607.82275, 872.54248, -1667.55688), 10000)
        elseif Options.SelectMaterial.Value == "Leather + Scrap Metal" then
            materialMon = {"Brute", "Pirate"}
            materialPos = CFrame.new(-1145, 15, 4350)
        elseif Options.SelectMaterial.Value == "Magma Ore" then
            materialMon = {"Military Soldier", "Military Spy", "Magma Admiral"}
            materialPos = CFrame.new(-5815, 84, 8820)
        elseif Options.SelectMaterial.Value == "Fish Tail" then
            materialMon = {"Fishman Warrior", "Fishman Commando", "Fishman Lord"}
            materialPos = CFrame.new(61123, 19, 1569)
            shouldRequestEntrance(Vector3.new(61163, 5, 1819), 17000)
        end
    elseif game.PlaceId == sea2 then
        if Options.SelectMaterial.Value == "Leather + Scrap Metal" then
            materialMon = {"Marine Captain"}
            materialPos = CFrame.new(-2010.5059814453125, 73.00115966796875, -3326.620849609375)
        elseif Options.SelectMaterial.Value == "Magma Ore" then
            materialMon = {"Magma Ninja", "Lava Pirate"}
            materialPos = CFrame.new(-5428, 78, -5959)
        elseif Options.SelectMaterial.Value == "Ectoplasm" then
            materialMon = {"Ship Deckhand", "Ship Engineer", "Ship Steward", "Ship Officer"}
            materialPos = CFrame.new(911.35827636719, 125.95812988281, 33159.5390625)
            shouldRequestEntrance(Vector3.new(61163.8515625, 5.342342376708984, 1819.7841796875), 18000)
        elseif Options.SelectMaterial.Value == "Mystic Droplet" then
            materialMon = {"Water Fighter"}
            materialPos = CFrame.new(-3385, 239, -10542)
        elseif Options.SelectMaterial.Value == "Radioactive Material" then
            materialMon = {"Factory Staff"}
            materialPos = CFrame.new(295, 73, -56)
        elseif Options.SelectMaterial.Value == "Vampire Fang" then
            materialMon = {"Vampire"}
            materialPos = CFrame.new(-6033, 7, -1317)
        end
    elseif game.PlaceId == sea3 then
        if Options.SelectMaterial.Value == "Leather + Scrap Metal" then
            materialMon = {"Jungle Pirate", "Forest Pirate"}
            materialPos = CFrame.new(-11975.78515625, 331.7734069824219, -10620.0302734375)
        elseif Options.SelectMaterial.Value == "Fish Tail" then
            materialMon = {"Fishman Raider", "Fishman Captain"}
            materialPos = CFrame.new(-10993, 332, -8940)
        elseif Options.SelectMaterial.Value == "Conjured Cocoa" then
            materialMon = {"Chocolate Bar Battler", "Cocoa Warrior"}
            materialPos = CFrame.new(620, 78, -12581.369140625)
        elseif Options.SelectMaterial.Value == "Dragon Scale" then
            materialMon = {"Dragon Crew Warrior"}
            materialPos = CFrame.new(6594, 383, 139)
        elseif Options.SelectMaterial.Value == "Gunpowder" then
            materialMon = {"Pistol Billionaire"}
            materialPos = CFrame.new(-469, 74, 5904)
        elseif Options.SelectMaterial.Value == "Mini Tusk" then
            materialMon = {"Mythological Pirate"}
            materialPos = CFrame.new(-13545, 470, -6917)
        end
    end
end

OtherFarm_AutoFarmMaterial:OnChanged(function()
    task.spawn(function()
        if tw then StopTween() end
        while task.wait() and Options.AutoFarmMaterial.Value and (GetMaterial(Options.SelectMaterial.Value) < Options.MaterialLimit.Value) do
            pcall(function()
                getMaterialMon()
                local mob = nil
                local min = math.huge
                for _, v in next, workspace.Enemies:GetChildren() do
                    if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and table.find(materialMon,v.Name) then
                        local dist = plr:DistanceFromCharacter(v.HumanoidRootPart.Position)
                        if dist < min then
                            min = dist
                            mob = v
                        end
                    end
                end
                if mob and mob.HumanoidRootPart and mob.Humanoid and mob.Humanoid.Health > 0 then
                    repeat
                        task.wait()
                        equipWeapon()
                        tween(mob.HumanoidRootPart.CFrame * CFrame.new(0, 20, 10), 350)
                        if plr:DistanceFromCharacter(mob.HumanoidRootPart.CFrame.Position) <= 200 then
                            tween(mob.HumanoidRootPart.CFrame * CFrame.new(0, 20, 10), math.huge)
                            if plr:DistanceFromCharacter(mob.HumanoidRootPart.CFrame.Position) <= 45 then
                                bringMob(mob.Name)
                                FastAttack()
                            end
                        end
                    until not mob or not mob.Parent or mob.Humanoid.Health <= 0 or not Options.AutoFarmMaterial.Value
                else
                    tween(materialPos, 350).Completed:Wait()
                end
            end)
        end
    end)
end)

local function TeleportSeabeast(c5)
    local a = Vector3.new(0, c5:FindFirstChild("HumanoidRootPart").Position.Y, 0)
    local ab = Vector3.new(0, workspace.Map["WaterBase-Plane"].Position.Y, 0)
    if (a - ab).Magnitude <= 175 then
        tween(c5.HumanoidRootPart.CFrame * CFrame.new(0, 300, 50), 280).Completed:Wait()
    else
        tween(CFrame.new(c5.HumanoidRootPart.Position.X, workspace.Map["WaterBase-Plane"].Position.Y + 200,
            c5.HumanoidRootPart.Position.Z), 280).Completed:Wait()
    end
end

function CheckPirateBoat()
    local cl = {"PirateBasic", "PirateBrigade"}
    for r, v in next, workspace.Enemies:GetChildren() do
        if table.find(cl, v.Name) and v:FindFirstChild("Health") and v.Health.Value > 0 then
            return v
        end
    end
end

function checkseabeast()
    if not workspace:FindFirstChild('SeaBeasts') then return end
    for r, v in next, workspace.SeaBeasts:GetChildren() do
        if v.Name == "SeaBeast1" then
            if v.Health.Value >= 34500 then
                return v
            end
        end
    end
    return false
end

function checkboat()
    for r, v in next, workspace.Boats:GetChildren() do
        if v:IsA("Model") then
            if v:FindFirstChild("Owner") and tostring(v.Owner.Value) == plr.Name and v.Humanoid.Value > 0 and v:FindFirstChild('Engine') then
                if plr:DistanceFromCharacter(v.Engine.CFrame.Position) <= 1750 then
                    return v
                end
            end
        end
    end
    return false
end

function Seabeast()
    if not checkseabeast() and not CheckPirateBoat() then
        if not checkboat() then
            if (Vector3.new(-12.7291985, 10.3120461, 2955.1543) - character.HumanoidRootPart.Position).Magnitude > 8 then
                tween(CFrame.new(-12.7291985, 10.3120461, 2955.1543, -0.999506772, 3.31155747e-09, -0.0314048044,
                    2.85733082e-09, 1, 1.45084824e-08, 0.0314048044, 1.44115928e-08, -0.999506772), 280).Completed:Wait()
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyBoat", "PirateBrigade")
            else
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyBoat", "PirateBrigade")
            end
        else
            if (checkboat().VehicleSeat.Position - Vector3.new(28.4108, 1.2327, 3679.99)).Magnitude > 50 then
                checkboat().VehicleSeat.CFrame = CFrame.new(28.4108 + 20, 1.2327 + 10, 3679.99 + 20)
            else
                if not character.Humanoid.Sit then
                    if (checkboat().VehicleSeat.Position - character.HumanoidRootPart.Position).Magnitude > 50 then
                        General_Noclip:SetValue(false)
                        tween(checkboat().VehicleSeat.CFrame, 280).Completed:Wait()
                        General_Noclip:SetValue(false)
                    else
                        General_Noclip:SetValue(false)
                        character.HumanoidRootPart.CFrame = checkboat().VehicleSeat.CFrame
                    end
                end
            end
        end
    elseif CheckPirateBoat() then
        local v = CheckPirateBoat()
        repeat
            task.wait()
            tween(v.Engine.CFrame * CFrame.new(0, -20, 0), 250).Completed:Wait()
            autoskill()
        until not v or not v.Parent or v.Health.Value <= 0 or not CheckPirateBoat()
    elseif checkseabeast() then
        local v = checkseabeast()
        repeat
            task.wait()
            TeleportSeabeast(v)
            autoskill()
        until not v or not v.Parent or v.Health.Value <= 0 or not checkseabeast()
    end
end

local function KillMonster(_v)
    if character.Humanoid.Health > 0 then
        for _, v2 in {workspace.Enemies, game.ReplicatedStorage} do
            for _, v in next,v2:GetChildren() do
                if string.find(v.Name, _v) and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") then
                    repeat
                        task.wait()
                        tween(v.HumanoidRootPart.CFrame * CFrame.new(0, 15, 10), 350)
                        if plr:DistanceFromCharacter(v.HumanoidRootPart.CFrame.Position) <= 200 then
                            tween(v.HumanoidRootPart.CFrame * CFrame.new(0, 15, 10), math.huge)
                            if plr:DistanceFromCharacter(v.HumanoidRootPart.CFrame.Position) <= 50 then
                                equipWeapon()
                                FastAttack()
                            end
                        end
                    until not v or not v:FindFirstChild("Humanoid") or not v:FindFirstChild("HumanoidRootPart") or v.Humanoid.Health <= 0 or 
                    character.Humanoid.Health <= 0 or not character:FindFirstChild('Humanoid')
                    break
                end
            end
        end
    end
    return nil
end

task.spawn(function()
    while task.wait() do
        pcall(function()
            if Options.NoFall.Value then
                local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
                if Options.AutoFarm.Value or Options.GetCDK.Value or Options.AutoFarmBoss.Value or Options.StartTravel.Value or Options.GetDeathStep.Value
                or Options.GetDragonTalon.Value or Options.GetElectricClaw.Value or Options.GetGodhuman.Value or Options.GetKenV2.Value or Options.AutoFactory.Value or
                Options.GetTTK.Value or Options.GetYama.Value or Options.GetTushita.Value or Options.AutoEliteHunter.Value or 
                Options.AutoPlayDungeon.Value or Options.AutoFarmMaterial.Value or Options.GetSaber.Value or Options.TweenToMirage.Value or Options.TweenToAdvancedDealer.Value
                or Options.TweenToBlueGear.Value or Options.tweenToRacesDoor.Value or Options.AutoBartilo.Value or Options.AutoRaceV2.Value 
                or Options.AutoRaceV3.Value or Options.GetSG.Value or Options.GetSharkmanKarate.Value or Options.AutoPullLever.Value or Options.AutoSeaEvents.Value
                or Options.AutoSeaBeast.Value or Options.GetSharkAnchor.Value or Options.AutoDojo.Value or Options.AutoChest.Value or Options.GetRainbowHaki.Value or Options.AutoCyborg.Value
                or Options.AutoGhoul.Value or Options.AutoFarmSummer.Value then
                    if hrp and not hrp:FindFirstChild("NoFall") and not hrp:FindFirstChild('NoFall') then
                        local bv = Instance.new("BodyVelocity")
                        bv.Name = "NoFall"
                        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                        bv.Velocity = Vector3.new(0, 0, 0)
                        bv.P = 1000
                        bv.Parent = hrp
                    end
                elseif hrp:FindFirstChild('NoFall') then
                    hrp:FindFirstChild('NoFall'):Destroy()
                end
            end
        end)
    end
end)

task.spawn(function()
    while task.wait() do
        pcall(function()
            for _, v in pairs(character:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = not Options.Noclip.Value
                end
            end
        end)
    end
end)

local webhookURL
local function sendWebhook()
    if req then
        local itemList = {}
        for _, item in pairs(repstorage.Remotes['game.ReplicatedStorage.Remotes.CommF_']:InvokeServer("getInventory")) do
            table.insert(itemList, item.Name) -- Giả sử mỗi item có thuộc tính "Name"
        end
        local itemString = table.concat(itemList, ", ")
        local data = {
            ["username"] = "Radiant Hub 2.0 - Premium Expanded Version",
            ["embeds"] = {{
                ["title"] = "Blox Fruits | Webhook",
                ["description"] = "Character's name : ||" .. plr.Name .. "||",
                ["color"] = 16777215,
                ["fields"] = {{
                    ["name"] = "Player Data",
                    ["value"] = string.format("Level : %s\nBeli : %s\nFragments : %s\nRace : %s\nItems : %s",
                        plr.Data.Level.Value, plr.Data.Beli.Value, plr.Data.Fragments.Value,
                        plr.Data.Race.Value .. " " .. getRaceGrade(),
                        itemString
                    ),
                    ["inline"] = true
                }, {
                    ["name"] = "Server Data",
                    ["value"] = string.format(
                        "```JobId : %s\nNumber of players in server : %d\nCharacter's team : %s```", game.JobId,
                        #game.Players:GetPlayers(), plr.Team and plr.Team.Name or "None"),
                    ["inline"] = false
                }},
                ["footer"] = {
                    ["text"] = "- Radiant Hub 2.0 Premium - Expanded Version",
                    ["icon_url"] = "https://cdn.discordapp.com/attachments/1279072819749191805/1328406716605399091/standard_1.gif?ex=67b01de9&is=67aecc69&hm=b0c978d04f064354aa75e051f784d341f7b0f8a8d34d6fc7445bad073098be31&"
                }
            }}
        }
        req({
            Url = webhookURL,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = https:JSONEncode(data)
        })
    end
end

local function getFruits()
    for _, v in pairs(workspace:GetChildren()) do
        if string.find(v.Name, "Fruit") and (v:IsA('Tool') or v:IsA('Model')) and (v.Name ~= 'Fruit ') then
            return v
        end
    end
    return nil
end

local getCastleRaid = function()
    for _, v in {workspace.Enemies, game.ReplicatedStorage} do
        for _, v2 in next,(v:GetChildren()) do
            if  v2:GetAttribute('Level') and v2:GetAttribute('Level') <= 1500 and v2:IsA('Model') and
                (v2.WorldPivot.Position - Vector3.new(-5000, 350, -3035)).Magnitude <= 1000 then
                return true
            end
        end
    end
    return nil
end

local codes = {"NOOB2PRO", "Fudd10", "CONTROL", "UPDATE11", "XMASEXP", "1BILLION", "ShutDownFix2", "UPD14",
"STRAWHATMAINE", "TantaiGaming", "Colosseum", "Axiore", "Sub2Daigrock", "Sky Island 3",
"Sub2OfficialNoobie", "SUB2NOOBMASTER123", "THEGREATACE", "Fountain City", "BIGNEWS",
"SUB2GAMERROBOT_EXP1", "UPD15", "2BILLION", "UPD16", "3BVISITS", "fudd10_v2", "Starcodeheo", "Magicbus",
"JCWK", "Bluxxy", "Sub2Fer999", "Enyu_is_Pro", "CODE_SERVICIO", "DEVSCOOKING", "15B_BESTBROTHERS",
"NOOB_REFUND"}
General_RedeemCodes:OnChanged(function(Value)
    if Options.RedeemCodes.Value then
        task.spawn(function()
            for _, v in codes do
                game.ReplicatedStorage.Remotes.Redeem:InvokeServer(v)
            end
        end)
    end
end)

local MobsCakePrince = {"Cookie Crafter", "Cake Guard", "Baking Staff", "Head Baker"}
local CakePrinceBosses = {"Dough King", "Cake Prince"}
local function getCakePrince()
    for _, v in {workspace.Enemies,game.ReplicatedStorage} do
        for _,v2 in pairs(v:GetChildren()) do
            if table.find(CakePrinceBosses, v2.Name) and v2:FindFirstChild("Humanoid") and
                v2:FindFirstChild("HumanoidRootPart") and v2.Humanoid.Health > 0 then
                return v2
            end
        end
    end
end

General_AutoFarm:OnChanged(function()
    task.spawn(function()
        if tw then StopTween() end
        while task.wait() and Options.AutoFarm.Value do
            if Options.GetCDK.Value and (function()
                local b = 0
                local function a(x)
                    for i, v in next, x do
                        if typeof(v) == "table" then
                            if (i == "Yama" or i == "Tushita") and v.Level and v.Level >= 350 then
                                b = b + 1
                            end
                            a(v)
                        end
                    end
                end
                a(game:GetService("ReplicatedStorage").Modules.Net["RF/ReadPlayerData"]:InvokeServer())
                return b
            end)() == 2 and plr.Data.Level.Value >= 2200 then
                pcall(function()
                    if game.PlaceId ~= sea3 then
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelZou")
                        task.wait(10)
                    end
                    if game.ReplicatedStorage.Remotes.CommF_:InvokeServer('CDKQuest','OpenDoor') == 'can' then
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer('CDKQuest','OpenDoor',true)
                    end
                    local q = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CDKQuest","Progress")
                    if q.Evil == 0 or q.Evil == -3 then
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CDKQuest","StartTrial",'Evil')
                        if workspace.Enemies:FindFirstChild('Mythological Pirate') then
                            repeat
                                task.wait()
                                tween(workspace.Enemies:FindFirstChild('Mythological Pirate').HumanoidRootPart.CFrame * CFrame.new(5,0,0),350)
                            until not Options.GetCDK.Value or (game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CDKQuest","Progress").Evil ~= -3 and
                            GetMaterial('Alucard Fragment') == 1)
                        else
                            tween(Vector3.new(-13239, 520, -6813),350).Completed:Wait()
                        end
                    elseif q.Evil == 1 or q.Evil == -4 then
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CDKQuest","StartTrial",'Evil')
                        if plr:FindFirstChild('QuestHaze') then
                            for _,v in next, plr.QuestHaze:GetChildren() do
                                if v.Value > 0 then
                                    repeat task.wait()
                                        if plr:DistanceFromCharacter(game.ReplicatedStorage.FortBuilderReplicatedSpawnPositionsFolder[v.Name].CFrame.Position) >= 600 then
                                            tween(game.ReplicatedStorage.FortBuilderReplicatedSpawnPositionsFolder[v.Name].CFrame,350).Completed:Wait()
                                        end
                                        for _,v2 in next, workspace.Enemies:GetChildren() do
                                            if v2.Name == v.Name and v2:FindFirstChild('HumanoidRootPart') and v2:FindFirstChild('Humanoid') and v2.Humanoid.Health > 0 then
                                                repeat
                                                    task.wait()
                                                    tween(v2.HumanoidRootPart.Position + Vector3.new(0,25,10),350)
                                                    if plr:DistanceFromCharacter(v2.HumanoidRootPart.Position) <= 40 then
                                                        bringMob(v2.Name)
                                                        equipWeapon()
                                                        FastAttack()
                                                    end
                                                until not v2.Humanoid or not v2.HumanoidRootPart or v2.Humanoid.Health <= 0 or not v2
                                                break
                                            end
                                        end
                                    until not v or v.Value == 0 or not plr:FindFirstChild('QuestHaze')
                                end
                            end
                        end
                    elseif q.Evil == 2 or q.Evil == -5 then
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CDKQuest","StartTrial",'Evil')
                        if workspace.Enemies:FindFirstChild('Soul Reaper') or workspace.Map:FindFirstChild('HellDimension') then
                            if workspace.Enemies:FindFirstChild('Soul Reaper') and not workspace.Map:FindFirstChild('HellDimension') then
                                repeat
                                    tween(workspace.Enemies:FindFirstChild('Soul Reaper').HumanoidRootPart.CFrame,350).Completed:Wait()
                                    task.wait()
                                until workspace.Map:FindFirstChild('HellDimension')
                            end
                            if tw then tw:Cancel() end
                            task.wait(1)
                            for i = 1,3 do
                                tween(workspace.Map.HellDimension['Torch'..i].CFrame,350).Completed:Wait()
                                fireproximityprompt(workspace.Map.HellDimension['Torch'..i].ProximityPrompt)
                                repeat wait() until #workspace.Enemies:GetChildren() > 0
                                for _,v in next, workspace.Enemies:GetChildren() do
                                    if plr:DistanceFromCharacter(v.HumanoidRootPart.CFrame.Position) <= 300 and v.HumanoidRootPart and v.Humanoid and v.Humanoid.Health > 0 then
                                        repeat
                                            task.wait()
                                            tween(v.HumanoidRootPart.CFrame * CFrame.new(0, 25, 10), 350)
                                            if plr:DistanceFromCharacter(v.HumanoidRootPart.Position) <= 210 then
                                                tween(v.HumanoidRootPart.CFrame * CFrame.new(0, 25, 10), math.huge)
                                                if plr:DistanceFromCharacter(v.HumanoidRootPart.Position) <= 40 then
                                                    bringMob(v.Name)
                                                    equipWeapon()
                                                    FastAttack()
                                                end
                                            end
                                        until not v or not v:FindFirstChild("Humanoid")  or v.Humanoid.Health <= 0 or not v:FindFirstChild("HumanoidRootPart")
                                    end
                                end
                            end
                        else
                            local boneNPCs = {'Reborn Skeleton','Living Zombie','Demonic Soul','Posessed Mummy'}
                            repeat
                                task.wait()
                                local mob = nil
                                local min = math.huge
                                for _, v in next, workspace.Enemies:GetChildren() do
                                    if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and table.find(boneNPCs,v.Name) then
                                        local dist = plr:DistanceFromCharacter(v.HumanoidRootPart.Position)
                                        if dist < min then
                                            min = dist
                                            mob = v
                                        end
                                    end
                                end
                                if mob and mob.HumanoidRootPart and mob.Humanoid and mob.Humanoid.Health > 0 then
                                    repeat
                                        task.wait()
                                        tween(mob.HumanoidRootPart.CFrame * CFrame.new(0, 15, 5), 350)
                                        if plr:DistanceFromCharacter(mob.HumanoidRootPart.Position) <= 210 then
                                            tween(mob.HumanoidRootPart.CFrame * CFrame.new(0, 15, 5), math.huge)
                                            if plr:DistanceFromCharacter(mob.HumanoidRootPart.Position) <= 30 then
                                                bringMob(mob.Name)
                                                equipWeapon()
                                                FastAttack()
                                            end
                                        end
                                    until not mob or not mob:FindFirstChild("Humanoid")  or mob.Humanoid.Health <= 0 or not mob:FindFirstChild("HumanoidRootPart") or not
                                    Options.AutoFarm.Value or selectedFarmMethod ~= 'Bone'
                                else
                                    tween(CFrame.new(-9515, 164, 5786), 350).Completed:Wait()
                                end
                            until not Options.GetCDK.Value or plr.Backpack:FindFirstChild('Hallow Essence') or
                             (game.ReplicatedStorage:FindFirstChild('Soul Reaper') or workspace.Enemies:FindFirstChild('Soul Reaper'))
                            or not Options.AutoFarm.Value
                            if plr.Backpack:FindFirstChild('Hallow Essence') then
                                equipTool('Hallow Essence')
                                if character:FindFirstChild('Hallow Essence') then
                                    firetouchinterest(character.HumanoidRootPart,workspace.Map["Haunted Castle"].Summoner.Detection,1)
                                    firetouchinterest(character.HumanoidRootPart,workspace.Map["Haunted Castle"].Summoner.Detection,0)
                                end
                            end
                        end
                    elseif q.Good == 0 or q.Good == -3 then
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CDKQuest","StartTrial",'Good')
                        for _, x in next, {CFrame.new(-9550, 21, 4690), CFrame.new(-6120, 16, -2250), CFrame.new(-9530, 7, -8370)} do
                            repeat game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = x task.wait() until workspace.NPCs:FindFirstChildWhichIsA("Model") and workspace.NPCs:FindFirstChildWhichIsA("Model").Name:find("Boat")
                            for _, n in next, workspace.NPCs:GetChildren() do if n.Name:find("Boat") then game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CDKQuest", "BoatQuest", n) end end
                        end
                    elseif q.Good == 1 or q.Good == -4 then
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CDKQuest","StartTrial",'Good')
                        tween(CFrame.new(6148.4116210938, 294.38687133789, -6741.1166992188), 350)
                    elseif q.Good == 2 or q.Good == -5 then
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CDKQuest","StartTrial",'Good')
                        if workspace.Map:FindFirstChild("HeavenlyDimension") ~= nil and workspace.Map:FindFirstChild("Heavenly Dimension") then
                            if workspace.Map.HeavenlyDimension.Exit.Color ~= Color3.fromRGB(0, 0, 0) then 
                                firetouchinterest(workspace.Map.HeavenlyDimension.Exit.Touchinterest, game.Players.LocalPlayer.Character.HumanoidRootPart, 0)
                            else 
                                for i = 1, 3 do
                                    repeat 
                                        task.wait()
                                        local e = workspace.Enemies:FindFirstChildWhichIsA("Model", true)
                                        if e and (e.Name:find("Cursed Skeleton") or e.Name:find("Heaven")) then
                                            KillMonster(e.Name)
                                        else
                                            if workspace.Map.HeavenlyDimension["Torch"..i].ProximityPrompt.Enabled then
                                                tween(workspace.Map.HeavenlyDimension["Torch"..i].CFrame,350).Completed:Wait()
                                                fireproximityprompt(workspace.Map.HeavenlyDimension["Torch"..i].ProximityPrompt)
                                            end
                                        end
                                    until not Options.GetCDK.Value or not workspace.Map.HeavenlyDimension["Torch"..i].ProximityPrompt.Enabled or workspace.Map.HeavenlyDimension.Exit.Color ~= Color3.fromRGB(0, 0, 0) or character.Humanoid.Health <= 0
                                    if tw then tw:Cancel() end
                                end
                            end
                        else
                            if game.ReplicatedStorage:FindFirstChild('Cake Queen') or workspace.Enemies:FindFirstChild('Cake Queen') then
                                KillMonster("Cake Queen") 
                                if tw then tw:Cancel() end
                            else
                                hopLowServer()
                            end
                        end
                    end
                end)
            elseif Options.GetSaber.Value and plr.Data.Level.Value >= 200 and not checkItem("Saber") then
                if game.JobId ~= sea1 then game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelMain") task.wait(8) end
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("AbandonQuest")
                if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress").UsedRelic == false then
                    if workspace.Map.Jungle.QuestPlates.Door.Transparency == 0 then
                        for _, v in pairs(workspace.Map.Jungle.QuestPlates:GetChildren()) do
                            if v:IsA("Model") and string.find(v.Name, 'Plate') then
                                firetouchinterest(v.Button, character.HumanoidRootPart, 1)
                                firetouchinterest(v.Button, character.HumanoidRootPart, 0)
                            end
                        end
                    else
                        if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress").UsedTorch == false then
                            if plr.Backpack:FindFirstChild("Torch") or character:FindFirstChild("Torch") then
                                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress","DestroyTorch")
                            else
                                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress", "GetTorch")
                            end
                        else
                            if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress").UsedCup then
                                if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress").TalkedSon and 
                                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress").KilledMob then
                                    if not game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress").UsedRelic then
                                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon")
                                        if not character:FindFirstChild('Relic') then
                                            character.Humanoid:EquipTool(plr.Backpack:FindFirstChild('Relic'))
                                        end
                                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress", "PlaceRelic")
                                    end
                                elseif game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress").TalkedSon == false then
                                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon")
                                elseif game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress").KilledMob == false then
                                    if workspace.Enemies:FindFirstChild('Mob Leader') or game.ReplicatedStorage:FindFirstChild('Mob Leader') then
                                        KillMonster('Mob Leader')
                                    end
                                end
                            else
                                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress", "GetCup")
                                if not character:FindFirstChild('Cup') then
                                    character.Humanoid:EquipTool(plr.Backpack:FindFirstChild('Cup'))
                                end
                                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress", "FillCup", character.Cup)
                                game.ReplicatedStorage.Remotes.CommF_:InvokeServer('ProQuestProgress', "SickMan")
                            end
                        end
                    end
                else
                    if workspace.Enemies:FindFirstChild("Saber Expert") or game.ReplicatedStorage:FindFirstChild("Saber Expert") then
                        KillMonster('Saber Expert')
                    else
                        tween(game.ReplicatedStorage.FortBuilderReplicatedSpawnPositionsFolder["Saber Expert"].CFrame * CFrame.new(0,25,10),350)
                    end
                end
            elseif Options.GetSaber.Value and checkItem("Saber") then
                Items_GetSaber:SetValue(false)
            elseif Options.AutoSpawnChalice.Value and ((plr.Backpack:FindFirstChild('God\'s Chalice') or character:FindFirstChild('God\'s Chalice')) or (function()
                for _,v in {workspace.Enemies,game.ReplicatedStorage} do
                    for _,v2 in next,v:GetChildren() do
                        if v2.Name:find('indra') or v2.Name:find('Dough King') then
                            return true
                        end
                    end
                end
                return false
            end)()) then
                pcall(function()
                    if plr.Backpack:FindFirstChild('God\'s Chalice') or character:FindFirstChild('God\'s Chalice') then
                        if (function()
                            local b = 0
                            for _,v in next,workspace.Map["Boat Castle"].Summoner:GetChildren() do
                                if v:IsA('Part') and v.Name == 'Part' then
                                    if v.Color ~= Color3.fromRGB(99, 95, 98) then
                                        b = b + 1
                                    end
                                end
                            end
                            return b
                        end)() == 3 then
                            if not character:FindFirstChild('God\'s Chalice') then
                                equipTool('God\'s Chalice')
                            end
                            firetouchinterest(workspace.Map["Boat Castle"].Summoner.Detection,game.Players.LocalPlayer.Character.HumanoidRootPart,1)
                            firetouchinterest(workspace.Map["Boat Castle"].Summoner.Detection,game.Players.LocalPlayer.Character.HumanoidRootPart,0)
                        else
                            if GetMaterial('Conjured Cocoa') >= 10 then
                                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("SweetChaliceNpc")
                            else
                                repeat
                                    if Options.SelectMaterial.Value ~= 'Conjured Cocoa' then
                                        OtherFarm_SelectMaterial:SetValue('Conjured Cocoa')
                                    elseif not Options.AutoFarmMaterial.Value then
                                        OtherFarm_AutoFarmMaterial:SetValue(true)
                                    end
                                    task.wait(1)
                                until GetMaterial('Conjured Cocoa') >= 10 or not Options.AutoSpawnChalice.Value
                                OtherFarm_AutoFarmMaterial:SetValue(false)
                                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("SweetChaliceNpc")
                                selectedFarmMethod = 'Katakuri [ Cake ]'
                                if not Options.AutoFarm.Value then
                                    General_AutoFarm:SetValue(true)
                                end
                                if not Options.AttackKatakuri.Value then
                                    General_AttackKatakuri:SetValue(true)
                                end
                                if not Options.AutoSummonCakePrince.Value then
                                    General_AutoSummonCakePrince:SetValue(true)
                                end
                            end
                        end
                    elseif (function()
                        for _,v in {workspace.Enemies,game.ReplicatedStorage} do
                            for _,v2 in next,v:GetChildren() do
                                if v2.Name:find('indra') or v2.Name:find('Dough King') then
                                    return true
                                end
                            end
                        end
                        return false
                    end)() then
                        for _,v in {workspace.Enemies,game.ReplicatedStorage} do
                            for _,v2 in next,v:GetChildren() do
                                if (v2.Name:find('indra') or v2.Name:find('Dough King')) and v2.Humanoid and v2.Humanoid.Health > 0 then
                                    KillMonster(v2.Name)
                                end
                            end
                        end
                    end
                end)
            elseif Options.AutoEliteHunter.Value and getElite() and game.PlaceId == sea3 then
                pcall(function()
                    local elites = {'Tyrant of the Skies','Diablo','Urban','Deandre'}
                    for _, v2 in {workspace.Enemies, game.ReplicatedStorage} do
                        for _, v in next,(v2:GetChildren()) do
                            if v:IsA("Model") and v:GetAttribute("Level") and v:FindFirstChild("Humanoid") and
                                v.Humanoid.Health > 0 then
                                if table.find(elites,v.Name) then
                                    if plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Visible and
                                        string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, v.Name) then
                                        tween(v.HumanoidRootPart.CFrame * CFrame.new(0, 15, 10), 350).Completed:Wait()
                                        KillMonster(v.Name)
                                    else
                                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("EliteHunter")
                                    end
                                end
                            end
                        end
                    end
                end)
            elseif Options.TPFruit.Value and getFruits() then
                pcall(function()
                    tween(getFruits().Handle.CFrame, 350).Completed:Wait()
                    if not Options.AutoStoreFruits.Value then
                        Visual_AutoStoreFruits:SetValue(true)
                    end
                end)
            elseif Options.TPFruitHop.Value and Options.TPFruit.Value and not getFruits() then
                hopLowServer()
                task.wait(5)
            elseif Options.CastleRaid.Value and getCastleRaid() and game.PlaceId == sea3 then
                if plr:DistanceFromCharacter(Vector3.new(-5000, 350, -3035)) > 700 then
                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-5000, 350, -3035))
                end
                for _, v2 in next,workspace.Enemies:GetChildren() do
                    if v2:IsA('Model') and plr:DistanceFromCharacter(v2.WorldPivot.Position) <= 700 then
                        repeat
                            task.wait()
                            equipWeapon()
                            tween(v2.WorldPivot * CFrame.new(0, 20, 10), 350)
                            FastAttack()
                        until not v2 or not v2.Parent or not Options.CastleRaid.Value or not Options.AutoFarm.Value
                    end
                    break
                end
            elseif Options.AutoFactory.Value and workspace.Enemies:FindFirstChild("Factory") and game.PlaceId == sea2 then
                local enemies = workspace.Enemies
                local coreEnemy = enemies:FindFirstChild("Core")
                if coreEnemy and coreEnemy.Humanoid.Health > 0 then
                    repeat
                        task.wait()
                        equipWeapon()
                        tween(coreEnemy.HumanoidRootPart.CFrame, 350)
                        FastAttack()
                    until coreEnemy.Humanoid.Health <= 0 or not Options.AutoFactory.Value or not Options.AutoFarm.Value
                end
            elseif selectedFarmMethod == "Katakuri [ Cake ]" and game.PlaceId == sea3 then
                pcall(function()
                    repeat
                        task.wait()
                        -- if workspace.Map.CakeLoaf:FindFirstChild('RedDoor') then
                        --     if workspace.Map.CakeLoaf.RedDoor.Transparency == 0 then
                                
                        --     end
                        -- end
                        if plr:DistanceFromCharacter(Vector3.new(-2132, 70, -12319)) >= 1200 and not getCakePrince() then
                            tween(CFrame.new(-2251, 146, -12196), 350).Completed:Wait()
                        end
                        if getCakePrince() and Options.AttackKatakuri.Value then
                            local Target = getCakePrince()
                            repeat
                                if plr:DistanceFromCharacter(Target.HumanoidRootPart.CFrame.Position) >= 1200 and getCakePrince() then
                                    StopTween()
                                    tween(workspace.Map.CakeLoaf.BigMirror.Main.CFrame,350).Completed:Wait()
                                    task.wait(0.75)
                                end
                                tween(Target.HumanoidRootPart.CFrame * CFrame.new(0, 17.5, 10), 350)
                                if plr:DistanceFromCharacter(Target.HumanoidRootPart.CFrame.Position) <= 200 then
                                    tween(Target.HumanoidRootPart.CFrame * CFrame.new(0, 17.5, 10), math.huge)
                                    if plr:DistanceFromCharacter(Target.HumanoidRootPart.CFrame.Position) <= 40 then
                                        equipWeapon()
                                        FastAttack()
                                    end
                                end
                                task.wait()
                            until not Target or selectedFarmMethod ~= "Katakuri [ Cake ]" or not getCakePrince() or not Options.AutoFarm.Value or
                            character.Humanoid.Health <= 0 or not Options.AttackKatakuri.Value
                        else
                            local mob = nil
                            local min = math.huge
                            for _, v in next, workspace.Enemies:GetChildren() do
                                if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                                    local dist = plr:DistanceFromCharacter(v.HumanoidRootPart.Position)
                                    if dist < min then
                                        min = dist
                                        mob = v
                                    end
                                end
                            end
                            if mob and table.find(MobsCakePrince, mob.Name) and mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart")
                                and mob.Humanoid.Health > 0 then
                                    if Options.TakeQuestCake.Value then
                                        takeQuestCake(mob.Name)
                                    end
                                repeat
                                    task.wait()
                                    tween(mob.HumanoidRootPart.CFrame * CFrame.new(0, 15, 0), 350)
                                    if plr:DistanceFromCharacter(mob.HumanoidRootPart.Position) <= 200 then
                                        tween(mob.HumanoidRootPart.CFrame * CFrame.new(0, 15, 0), math.huge)
                                        if plr:DistanceFromCharacter(mob.HumanoidRootPart.Position) <= 40 then
                                            bringMob(mob.Name)
                                            equipWeapon()
                                            FastAttack()
                                        end
                                    end
                                until selectedFarmMethod ~= "Katakuri [ Cake ]" or not Options.AutoFarm.Value or not mob or not mob:FindFirstChild("Humanoid") 
                                or mob.Humanoid.Health <= 0 or not mob:FindFirstChild("HumanoidRootPart")
                            end
                        end
                    until selectedFarmMethod ~= 'Katakuri [ Cake ]' or not Options.AutoFarm.Value or getFruits() or getElite() or getCastleRaid()
                end)
            elseif selectedFarmMethod == "Level" then
                pcall(function()
                    if game.PlaceId == sea1 and (plr.Data.Level.Value >= 9 and plr.Data.Level.Value < 30) then
                        if plr:GetAttribute('CurrentLocation') ~= "Skylands" then
                            game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-7894, 5547, -380))
                            task.wait(1.5)
                            StopTween()
                        end
                        for _, v2 in {workspace.Enemies, game.ReplicatedStorage} do
                            for _, v in next,v2:GetChildren() do
                                if v.Name == "Shanda" and v.HumanoidRootPart and v.Humanoid.Health > 0 then
                                    repeat 
                                        task.wait()
                                        tween(v.HumanoidRootPart.CFrame * CFrame.new(0,15,10),350)
                                        if plr:DistanceFromCharacter(v.HumanoidRootPart.CFrame.Position) <= 210 then
                                            tween(v.HumanoidRootPart.CFrame * CFrame.new(0,15,10),math.huge)
                                            if plr:DistanceFromCharacter(v.HumanoidRootPart.CFrame.Position) <= 50 then
                                                bringMob(v.Name)
                                                equipWeapon()
                                                FastAttack()
                                            end
                                        end
                                    until not Options.AutoFarm.Value or not v or not v.Humanoid or not v.HumanoidRootPart or v.Humanoid.Health <= 0 or plr.Data.Level.Value >= 30
                                else
                                    if plr:DistanceFromCharacter(Vector3.new(-7683, 5567, -498)) >= 800 then
                                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-7894, 5547, -380))
                                        task.wait(1.5)
                                    end
                                end
                            end
                        end
                    else
                        if GetMonsterName() then
                            for _, v2 in {workspace.Enemies, game.ReplicatedStorage} do
                                for _, v in next, v2:GetChildren() do
                                    if v.Name == GetMonsterName() and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                                        repeat
                                            task.wait()
                                            takeQuest()
                                            tween(v.HumanoidRootPart.CFrame * CFrame.new(0,15,0),350)
                                            if plr:DistanceFromCharacter(v.HumanoidRootPart.CFrame.Position) <= 210 then
                                                tween(v.HumanoidRootPart.CFrame * CFrame.new(0,15,0),math.huge)
                                                if plr:DistanceFromCharacter(v.HumanoidRootPart.CFrame.Position) <= 40 then
                                                    bringMob(v.Name)
                                                    equipWeapon()
                                                    FastAttack()
                                                end
                                            end
                                        until not Options.AutoFarm.Value or not v or not v.Humanoid or not v.HumanoidRootPart or v.Humanoid.Health <= 0 or v.Name ~= GetMonsterName()
                                        break
                                    end
                                end
                            end
                        else
                            takeQuest()
                            for _,v in {game.ReplicatedStorage.FortBuilderReplicatedSpawnPositionsFolder,workspace._WorldOrigin.EnemySpawns} do
                                for __, v2 in ipairs(v:GetChildren()) do
                                    if not string.find(v2.Name, "Boss") and v2.Name == CheckNameDoubleQuest2()[1] then
                                        repeat task.wait()
                                            if game.PlaceId == sea1 and (string.find(CheckNameDoubleQuest(), "Fish") and plr:GetAttribute("CurrentLocation") ~= "Underwater City")then
                                                Teleport("Fish Entrance")
                                            elseif game.PlaceId == sea1 and (not string.find(CheckNameDoubleQuest(), "Fish") and plr:GetAttribute("CurrentLocation") == "Underwater City") then
                                                Teleport("Fish Leave")
                                            elseif game.PlaceId == sea1 and (string.find(CheckNameDoubleQuest(), "Sky Bandit") or string.find(CheckNameDoubleQuest(), "Dark Master") or string.find(CheckNameDoubleQuest(), "God's")) and game.Players.LocalPlayer:GetAttribute("CurrentLocation") ~= "Skylands" then
                                                Teleport("sky 1")
                                            elseif game.PlaceId == sea1 and (string.find(CheckNameDoubleQuest(), "Shanda") or string.find(CheckNameDoubleQuest(), "Sky") and game.Players.LocalPlayer:GetAttribute("CurrentLocation") ~= "Skylands") then
                                                Teleport("sky 3")
                                            elseif game.PlaceId == sea2 and (string.find(CheckNameDoubleQuest(), "Ship") and game.Players.LocalPlayer:GetAttribute("CurrentLocation") ~= "Cursed Ship" )then
                                                Teleport("Mansion")
                                            end
                                            tween(v2.CFrame * CFrame.new(0, 15, 0),350)
                                            task.wait(0.5)
                                        until GetMonsterName() or selectedFarmMethod ~= "Level" or not Options.AutoFarm.Value
                                        break
                                    end
                                end
                            end
                        end
                    end
                end)
            elseif selectedFarmMethod == "Bone" and game.PlaceId == sea3 then
                pcall(function()
                    local boneNPCs = {'Reborn Skeleton','Living Zombie','Demonic Soul','Posessed Mummy'}
                    repeat
                        task.wait()
                        local mob = nil
                        local min = math.huge
                        for _, v in next, workspace.Enemies:GetChildren() do
                            if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and table.find(boneNPCs,v.Name) then
                                local dist = plr:DistanceFromCharacter(v.HumanoidRootPart.Position)
                                if dist < min then
                                    min = dist
                                    mob = v
                                end
                            end
                        end
                        if mob and mob.HumanoidRootPart and mob.Humanoid and mob.Humanoid.Health > 0 then
                            repeat
                                task.wait()
                                tween(mob.HumanoidRootPart.CFrame * CFrame.new(0, 15, 5), 350)
                                if plr:DistanceFromCharacter(mob.HumanoidRootPart.Position) <= 210 then
                                    tween(mob.HumanoidRootPart.CFrame * CFrame.new(0, 15, 5), math.huge)
                                    if plr:DistanceFromCharacter(mob.HumanoidRootPart.Position) <= 30 then
                                        bringMob(mob.Name)
                                        equipWeapon()
                                        FastAttack()
                                    end
                                end
                            until not mob or not mob:FindFirstChild("Humanoid")  or mob.Humanoid.Health <= 0 or not mob:FindFirstChild("HumanoidRootPart") or not
                            Options.AutoFarm.Value or selectedFarmMethod ~= 'Bone'
                        else
                            tween(CFrame.new(-9515, 164, 5786), 350).Completed:Wait()
                        end
                    until selectedFarmMethod ~= 'Bone' or not Options.AutoFarm.Value or getFruits() or getElite() or getCastleRaid()
                end)
            end
        end
    end)
end)

Stats_UpStats:OnChanged(function()
    task.spawn(function()
        while task.wait() and Options.UpStats.Value do
            for _, v in next,Options.SelectStats.Value do
                if #Options.SelectStats.Value >= 1 then
                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", v, 1)
                end
            end
        end
    end)
end)

Webhook_SendWebhook:OnChanged(function()
    task.spawn(function()
        while Options.SendWebhook.Value and task.wait(tonumber(delayWebhook)) do
            sendWebhook()
        end
    end)
end)

Webhook_WebhookUrlInput:OnChanged(function()
    pcall(function()
        Fluent:Notify({
            Title = "Radiant Hub 2.0",
            Content = "✅ - Sent a test request to webhook",
            SubContent = "Thank you for using premium script",
            Duration = 2
        })
        webhookURL = Webhook_WebhookUrlInput.Value
        req({
            Url = webhookURL,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = https:JSONEncode({
                ["content"] = "Hello, premium user! - x2Rune",
                ["username"] = "Radiant Hub 2.0 - Premium Premium"
            })
        })
    end)
end)

local tweensea
function TPB(CFgo,s)
    local boat = checkboat()
    if not boat or not boat:FindFirstChild("VehicleSeat") then return end
    if tweensea then tweensea:Cancel() end
    local dist = (boat.VehicleSeat.Position - CFgo.Position).Magnitude
    local info = TweenInfo.new((dist / (s or 350)), Enum.EasingStyle.Linear)
    tweensea = tweens:Create(boat.VehicleSeat, info, {CFrame = CFgo})
    tweensea:Play()
    return tweensea
end

Items_FindVolcanicIsland:OnChanged(function()
    task.spawn(function()
        while task.wait() and Options.FindVolcanicIsland.Value and game.PlaceId == sea3 do
            pcall(function()
                local prehistoricIslandCore = workspace.Map:FindFirstChild("PrehistoricIsland")
                if prehistoricIslandCore then
                    if tweensea then tweensea:Cancel() end
                    character.Humanoid.Sit = false
                    local relic = prehistoricIslandCore:FindFirstChild("Core") and prehistoricIslandCore.Core:FindFirstChild("PrehistoricRelic")
                    local skull = relic and relic:FindFirstChild("Skull")
                    if skull then
                        tween(skull.Position, 350).Completed:Wait()
                    end
                else
                    if not checkboat() then 
                        tween(CFrame.new(-16927, 9, 433), 350).Completed:Wait()
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyBoat", "PirateBrigade")
                    end
                    if checkboat().VehicleSeat.Position.Y < 130 then 
                        local e = checkboat().VehicleSeat.Position
                        TPB(CFrame.new(e.X, 130, e.Z)).Completed:Wait() 
                    end
                    TPB(CFrame.new(-999999, 130, -1324),275)
                end
            end)
        end
    end)
end)

Items_FindKitsuneIsland:OnChanged(function()
    task.spawn(function()
        while task.wait() and Options.FindKitsuneIsland.Value and game.PlaceId == sea3 do
            pcall(function()
                if game:GetService("Lighting").Sky.MoonTextureId == 'http://www.roblox.com/asset/?id=9709149431' then
                    local island = workspace.Map:FindFirstChild("KitsuneIsland")
                    if island then
                        if tweensea then tweensea:Cancel() end
                        character.Humanoid.Sit = false
                        tween(island.CFrame * CFrame.new(0, 25, 0), 350).Completed:Wait()
                    else
                        if not checkboat() then 
                            tween(CFrame.new(-16927, 9, 433), 350).Completed:Wait()
                            game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyBoat", "PirateBrigade")
                        end
                        if checkboat().VehicleSeat.Position.Y < 130 then 
                            local e = checkboat().VehicleSeat.Position
                            TPB(CFrame.new(e.X, 130, e.Z)).Completed:Wait() 
                        end
                        TPB(CFrame.new(-999999, 130, -1324),275)
                    end
                end
            end)
        end
    end)
end)

Items_CollectAzure:OnChanged(function()
    task.spawn(function()
        while task.wait() and Options.CollectAzure.Value and game.PlaceId == sea3 do
            pcall(function()
                if workspace:FindFirstChild("AttachedAzureEmber") then
                    tween(game.Workspace.EmberTemplate.Part.CFrame,350)
                    if plr:DistanceFromCharacter(game.Workspace.EmberTemplate.Part.CFrame) <= 210 then
                        tween(game.Workspace.EmberTemplate.Part.CFrame,math.huge)
                    end
                end
            end)
        end
    end)
end)

Items_BuyMelee:OnChanged(function()
    task.spawn(function()
        while task.wait() and Options.BuyMelee.Value do
            local v = Options.SelectMeleeToBuy.Value
            if v == "Electric" then
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyElectro")
            elseif v == "Water Kung Fu" then
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyFishmanKarate")
            elseif v == "Dark Step" then
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyBlackLeg")
            elseif v == "Superhuman" then
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuySuperhuman")
            elseif v == "Death Step" then
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyDeathStep")
            elseif v == "Sharkman Karate" then
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuySharkmanKarate")
            elseif v == "Electric Claw" then
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyElectricClaw")
            elseif v == "Dragon Claw" then
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "2")
            elseif v == "Dragon Talon" then
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyDragonTalon")
            elseif v == "Godhuman" then
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyGodhuman")
            elseif v == "Sanguine Art" then
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuySanguineArt")
            end
        end
    end)
end)

Items_GetSaber:OnChanged(function()
    task.spawn(function()
        while task.wait() and Options.GetSaber.Value and game.PlaceId == sea1 and not Options.AutoFarm.Value do
            if Options.GetSaber.Value and plr.Data.Level.Value >= 200 and not checkItem("Saber") then
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("AbandonQuest")
                if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress").UsedRelic == false then
                    if workspace.Map.Jungle.QuestPlates.Door.Transparency == 0 then
                        for _, v in pairs(workspace.Map.Jungle.QuestPlates:GetChildren()) do
                            if v:IsA("Model") and string.find(v.Name, 'Plate') then
                                firetouchinterest(v.Button, character.HumanoidRootPart, 1)
                                firetouchinterest(v.Button, character.HumanoidRootPart, 0)
                            end
                        end
                    else
                        if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress").UsedTorch == false then
                            if plr.Backpack:FindFirstChild("Torch") or character:FindFirstChild("Torch") then
                                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress","DestroyTorch")
                            else
                                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress", "GetTorch")
                            end
                        else
                            if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress").UsedCup then
                                if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress").TalkedSon and 
                                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress").KilledMob then
                                    if not game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress").UsedRelic then
                                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon")
                                        if not character:FindFirstChild('Relic') then
                                            character.Humanoid:EquipTool(plr.Backpack:FindFirstChild('Relic'))
                                        end
                                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress", "PlaceRelic")
                                    end
                                elseif game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress").TalkedSon == false then
                                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon")
                                elseif game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress").KilledMob == false then
                                    if workspace.Enemies:FindFirstChild('Mob Leader') or game.ReplicatedStorage:FindFirstChild('Mob Leader') then
                                        KillMonster('Mob Leader')
                                    end
                                end
                            else
                                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress", "GetCup")
                                if not character:FindFirstChild('Cup') then
                                    character.Humanoid:EquipTool(plr.Backpack:FindFirstChild('Cup'))
                                end
                                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress", "FillCup", character.Cup)
                                game.ReplicatedStorage.Remotes.CommF_:InvokeServer('ProQuestProgress', "SickMan")
                            end
                        end
                    end
                else
                    if workspace.Enemies:FindFirstChild("Saber Expert") or game.ReplicatedStorage:FindFirstChild("Saber Expert") then
                        KillMonster('Saber Expert')
                    else
                        tween(game.ReplicatedStorage.FortBuilderReplicatedSpawnPositionsFolder["Saber Expert"].CFrame * CFrame.new(0,25,10),350)
                    end
                end
            elseif Options.GetSaber.Value and checkItem("Saber") then
                Items_GetSaber:SetValue(false)
            end
        end
    end)
end)

Items_GetPoleV1:OnChanged(function()
    task.spawn(function()
        while task.wait() and Options.GetPoleV1.Value and game.PlaceId == sea1 do
            if not checkItem('Pole') then
                if workspace.Enemies:FindFirstChild('Thunder God') or game.ReplicatedStorage:FindFirstChild('Thunder God') then
                    KillMonster('Thunder God')
                end
            end
        end
    end)
end)

Items_GetTTK:OnChanged(function()
    task.spawn(function()
        while task.wait() and Options.GetTTK.Value and game.PlaceId == sea3 do
            if plr.Data.Beli.Value >= 2500000 then
                pcall(function()
                    for index = 1, 3 do
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("LegendarySwordDealer", tostring(index))
                    end
                end)
            end
        end
    end)
end)

Items_GetSuperhuman:OnChanged(function()
    task.spawn(function()
        if tw then StopTween() end
        while task.wait() and (game.PlaceId == sea3 or game.PlaceId == sea2) and Options.GetSuperhuman.Value do
            pcall(function()
                local meleeMastery = {['BlackLeg'] = 0,['Electro'] = 0,['FishmanKarate'] = 0,['DragonClaw'] = 0}
                for i,v in next,meleeMastery do
                    if i == 'DragonClaw' then
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "2")
                    else
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Buy"..i)
                    end
                    if (function()
                        for _,v in {character,plr.Backpack} do
                            for _,v2 in next,v:GetChildren() do
                                if v2:IsA('Tool') and v2.ToolTip == 'Melee' then
                                    if v2.Level then return v2.Level.Value end
                                end
                            end
                        end
                    end)() >= 300 then
                        meleeMastery[i] = 300
                    else
                        repeat
                            selectedWeapon = 'Melee'
                            if not Options.AutoFarm.Value then
                                General_AutoFarm:SetValue(true)
                            end
                            task.wait(1.5)
                        until (function() for _,v in {character,plr.Backpack} do for _,v2 in next,v:GetChildren() do if v2:IsA('Tool') and v2.ToolTip == 'Melee' then
                        if v2.Level then return v2.Level.Value end end end end end)() >= 300
                    end
                end
                if (function()
                    local b = 0
                    for i,v in next,meleeMastery do
                        if v == 300 then
                            b = b + 1
                        end
                    end
                    return b
                end)() == 4 then
                    if plr.Data.Beli.Value >= 3000000 then
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuySuperhuman")
                        Items_GetSuperhuman:SetValue(false)
                    elseif not Options.AutoFarm.Value then
                        General_AutoFarm:SetValue(true)
                    end
                end
            end)
        end
    end)
end)

function checkBoss(v)
    if workspace.Enemies:FindFirstChild(v) or game.ReplicatedStorage:FindFirstChild(v) then
        return true
    end
    return false
end

Items_GetRainbowHaki:OnChanged(function()
    task.spawn(function()
        if tw then StopTween() end
        while task.wait(0.75) and Options.GetRainbowHaki.Value do
            pcall(function()
                local q = game.ReplicatedStorage.Remotes.CommF_:InvokeServer('HornedMan')
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("HornedMan","Bet")
                if q:find('Stone') and checkBoss('Stone') then
                    KillMonster('Stone')
                elseif q:find('Hydra Leader') and checkBoss('Hydra Leader') then
                    KillMonster('Hydra Leader')
                elseif q:find('Kilo Admiral') and checkBoss('Kilo Admiral') then
                    KillMonster('Kilo Admiral')
                elseif q:find('Captain Elephant') and checkBoss('Captain Elephant') then
                    KillMonster('Captain Elephant')
                elseif q:find('Beautiful Pirate') and checkBoss('Beautiful Pirate') then
                    KillMonster('Beautiful Pirate')
                end
            end)
        end
    end)
end)

Stack_InstantCollectFruit:OnChanged(function()
    task.spawn(function()
        if tw then StopTween() end
        while task.wait(1) and Options.InstantCollectFruit.Value and not Options.AutoFarm.Value do
            for _, v in pairs(workspace:GetChildren()) do
                if string.find(v.Name, 'Fruit') and v:FindFirstChild('Handle') then
                    firetouchinterest(v.Handle, character.HumanoidRootPart, 1)
                    firetouchinterest(v.Handle, character.HumanoidRootPart, 0)
                end
            end
        end
    end)
end)

Stack_TPFruit:OnChanged(function()
    task.spawn(function()
        if tw then StopTween() end
        while task.wait() and Options.TPFruit.Value and not Options.AutoFarm.Value do
            if getFruits() then
                pcall(function()
                    tween(getFruits().Handle.CFrame, 350).Completed:Wait()
                    if not Options.AutoStoreFruits.Value then
                        Visual_AutoStoreFruits:SetValue(true)
                    end
                end)
            elseif Options.TPFruitHop.Value then
                hopLowServer()
                task.wait(6)
            end
        end
    end)
end)

Stack_TPFruit:OnChanged(function()
    task.spawn(function()
        if tw then StopTween() end
        while task.wait() and Options.TPFruit.Value and not Options.AutoFarm.Value do
            pcall(function()
                tween(getFruits().WorldPivot, 300).Completed:Wait()
                if not Options.AutoStoreFruits.Value then
                    Visual_AutoStoreFruits:SetValue(true)
                end
            end)
        end
    end)
end)

Stack_AutoEliteHunter:OnChanged(function()
    task.spawn(function()
        if tw then StopTween() end
        while task.wait() and Options.AutoEliteHunter.Value and not Options.AutoFarm.Value do
            if game.PlaceId == sea3 then
                pcall(function()
                    for __, v2 in {workspace.Enemies, game.ReplicatedStorage} do
                        for __, v in next,v2:GetChildren() do
                            if v:IsA("Model") and v:GetAttribute("Level") and v:FindFirstChild("Humanoid") and
                                v.Humanoid.Health > 0 then
                                if string.find(v.Name, "Diablo") or string.find(v.Name, "Deandre") or
                                    string.find(v.Name, "Urban") or string.find(v.Name, "Tyrant of the Skies") then
                                    if plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Visible and
                                        string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, v.Name) then
                                        KillMonster(v.Name)
                                    else
                                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("EliteHunter")
                                    end
                                end
                            end
                        end
                    end
                end)
            end
        end
    end)
end)

Items_GetDeathStep:OnChanged(function()
    task.spawn(function()
        while task.wait() and Options.GetDeathStep.Value do
            pcall(function()
                if game.PlaceId ~= sea2 and Options.GetDeathStep.Value then game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelDressrosa") end
                local mastery = getMastery('Black Leg')
                if not plr.Backpack:FindFirstChild('Black Leg') and not character:FindFirstChild('Black Leg') then
                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyBlackLeg")
                elseif mastery >= 400 then
                    if not plr.Backpack:FindFirstChild('Library Key') and not character:FindFirstChild('Library Key') and 
                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer('OpenLibrary') == false then
                        if workspace.Enemies:FindFirstChild('Awakened Ice Admiral') or game.ReplicatedStorage:FindFirstChild('Awakened Ice Admiral') then
                            KillMonster('Awakened Ice Admiral')
                        else
                            hopLowServer()
                            task.wait(5)
                        end
                    elseif plr.Backpack:FindFirstChild('Library Key') or character:FindFirstChild('Library Key') then
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer('OpenLibrary')
                    elseif game.ReplicatedStorage.Remotes.CommF_:InvokeServer('OpenLibrary') == true then
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyDeathStep")
                    end
                elseif mastery < 400 then
                    repeat
                        selectedWeapon = 'Melee'
                        if not Options.AutoFarm.Value then
                            General_AutoFarm:SetValue(true)
                        end
                        task.wait(1)
                    until getMastery('Black Leg') >= 400 or not Options.GetDeathStep.Value
                    General_AutoFarm:SetValue(false)
                end
            end)
        end
    end)
end)

Items_GetSharkmanKarate:OnChanged(function()
    task.spawn(function()
        if tw then StopTween() end
        while task.wait() and Options.GetSharkmanKarate.Value do
            pcall(function()
                if game.PlaceId ~= sea2 and Options.GetSharkmanKarate.Value then game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelDressrosa") end
                local mastery = getMastery('Fishman Karate')
                if (game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuySharkmanKarate",true) ~= 0) and 
                (game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuySharkmanKarate",true) ~= 1) then
                    if not character:FindFirstChild('Fishman Karate') and not plr.Backpack:FindFirstChild('Fishman Karate') then
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyFishmanKarate")
                    elseif mastery >= 400 then
                        General_AutoFarm:SetValue(false)
                        if not plr.Backpack:FindFirstChild('Water Key') and not character:FindFirstChild('Water Key') then
                            if workspace.Enemies:FindFirstChild('Tide Keeper') or game.ReplicatedStorage:FindFirstChild('Tide Keeper') then
                                KillMonster('Tide Keeper')
                            else
                                hopLowServer()
                                task.wait(5)
                            end
                        else
                            game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuySharkmanKarate",true)
                            game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuySharkmanKarate")
                        end
                    elseif mastery < 400 then
                        repeat
                            selectedWeapon = 'Melee'
                            if not Options.AutoFarm.Value then
                                General_AutoFarm:SetValue(true)
                            end
                            task.wait(1)
                        until plr.Backpack:FindFirstChild("Fishman Karate").Level.Value >= 400 or character:FindFirstChild("Fishman Karate").Level.Value >= 400 
                        General_AutoFarm:SetValue(false)
                    end
                else
                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuySharkmanKarate")
                end
            end)
        end
    end)
end)

Items_GetElectricClaw:OnChanged(function()
    task.spawn(function()
        if game.PlaceId ~= sea3 and Options.GetElectricClaw.Value then game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelZou") end
        while task.wait() and Options.GetElectricClaw.Value and game.PlaceId == sea3 do
            pcall(function()
                local mastery = getMastery('Electro')
                if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyElectricClaw",true) ~= 0 and 
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyElectricClaw",true) ~= 1 then
                    if not character:FindFirstChild('Electro') and not plr.Backpack:FindFirstChild('Electro') then
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyElectro")
                    elseif mastery >= 400 then
                        General_AutoFarm:SetValue(false) 
                        if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyElectricClaw",true) ~= 'Nah.' then
                            local npc = workspace.NPCs:FindFirstChild('Previous Hero') or game.ReplicatedStorage.NPCs:FindFirstChild('Previous Hero')
                            if plr:DistanceFromCharacter(npc.HumanoidRootPart.CFrame.Position) >= 580 then
                                tween(npc.HumanoidRootPart.CFrame,350).Completed:Wait()
                            end
                            game.ReplicatedStorage.Remotes.CommF_:InvokeServer('BuyElectricClaw','Start')
                            tween(CFrame.new(-12550, 336, -7510),350).Completed:Wait()
                            task.wait(0.5)
                            game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyElectricClaw")
                        end
                    elseif mastery < 400 then
                        selectedWeapon = 'Melee'
                        General_AutoFarm:SetValue(true)
                    end
                else
                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyElectricClaw")
                end
            end)
        end
    end)
end)

Items_GetDragonTalon:OnChanged(function()
    task.spawn(function()
        if game.PlaceId ~= sea3 and Options.GetDragonTalon.Value then game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelZou") end
        while task.wait() and Options.GetDragonTalon.Value and game.PlaceId == sea3 do
            pcall(function()
                if (game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyDragonTalon") ~= 0) and 
                (game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyDragonTalon") ~= 1) then
                    if string.find(game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyDragonTalon",true),'your') then
                        repeat
                            task.wait()
                            selectedFarmMethod = "Bone"
                            General_AutoFarm:SetValue(true)
                            if GetMaterial('Bones') >= 50 then
                                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Bones", "Buy", 1, 1)
                            end
                        until not Options.GetDragonTalon.Value or plr.Backpack:FindFirstChild('Fire Essence') or character:FindFirstChild('Fire Essence')
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyDragonTalon",true)
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyDragonTalon")
                    end
                else
                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyDragonTalon")
                end
            end)
        end
    end)
end)

Items_GetGodhuman:OnChanged(function()
    task.spawn(function()
        if tw then StopTween() end
        while task.wait() and Options.GetGodhuman.Value do
            pcall(function()
                General_AutoFarm:SetValue(false)
                if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyGodhuman",true) ~= 0 and 
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyGodhuman",true) ~= 1 then
                    for _,v in {'DeathStep','Superhuman','ElectricClaw','DragonTalon','SharkmanKarate'} do
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Buy"..v)
                        local mastery = getMastery((function()
                            for _,v in {character,plr.Backpack} do
                                for _,v2 in next,v:GetChildren() do
                                    if v2:IsA('Tool') and v2.ToolTip == 'Melee' then
                                        return v2.Name
                                    end
                                end
                            end
                        end))
                        if mastery < 400 then
                            repeat
                                selectedWeapon = 'Melee'
                                General_AutoFarm:SetValue(true)
                                equipWeapon()
                                task.wait(2.5)
                            until getMastery(character:FindFirstChildOfClass('Tool').Name) >= 400 or not Options.GetGodhuman.Value
                            General_AutoFarm:SetValue(false)
                        end
                    end
                    for i,v in {'Dragon Scale','Fish Tail','Mystic Droplet','Magma Ore'} do
                        local max = 0
                        if (i % 2) > 0 then
                            max = 10
                        else
                            max = 20
                        end
                        if GetMaterial(v) < max then
                            if (i == 1 or i == 2) and game.PlaceId ~= sea3 then
                                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelZou")
                            elseif (i == 3 or i == 4) and game.PlaceId ~= sea2 then
                                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelDressrosa")
                            end
                            repeat
                                OtherFarm_SelectMaterial:SetValue(v)
                                OtherFarm_AutoFarmMaterial:SetValue(true)
                                task.wait(2.5)
                            until GetMaterial(v) >= max or not Options.GetGodhuman.Value
                            OtherFarm_AutoFarmMaterial:SetValue(false)
                        end
                    end
                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyGodhuman",true)
                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyGodhuman")
                else
                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyGodhuman")
                end
            end)
        end
    end)
end)

Stack_GetCDK:OnChanged(function()
    task.spawn(function()
        while task.wait() and not Options.AutoFarm.Value do
            if Options.GetCDK.Value and
                (function()
                local b = 0
                local function a(x)
                    for i, v in next, x do
                        if typeof(v) == "table" then
                            if (i == "Yama" or i == "Tushita") and v.Level and v.Level >= 350 then
                                b = b + 1
                            end
                            a(v)
                        end
                    end
                end
                a(game:GetService("ReplicatedStorage").Modules.Net["RF/ReadPlayerData"]:InvokeServer())
                return b
            end)() == 2 and plr.Data.Level.Value >= 2200 then
                pcall(function()
                    if game.PlaceId ~= sea3 then
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelZou")
                        task.wait(10)
                    end
                    if game.ReplicatedStorage.Remotes.CommF_:InvokeServer('CDKQuest','OpenDoor') == 'can' then
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer('CDKQuest','OpenDoor',true)
                    end
                    local q = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CDKQuest","Progress")
                    if q.Evil == 0 or q.Evil == -3 then
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CDKQuest","StartTrial",'Evil')
                        if workspace.Enemies:FindFirstChild('Mythological Pirate') then
                            repeat
                                task.wait()
                                tween(workspace.Enemies:FindFirstChild('Mythological Pirate').HumanoidRootPart.CFrame * CFrame.new(5,0,0),350)
                            until not Options.GetCDK.Value or (game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CDKQuest","Progress").Evil ~= -3 and
                            GetMaterial('Alucard Fragment') == 1)
                        else
                            tween(Vector3.new(-13239, 520, -6813),350).Completed:Wait()
                        end
                    elseif q.Evil == 1 or q.Evil == -4 then
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CDKQuest","StartTrial",'Evil')
                        if plr:FindFirstChild('QuestHaze') then
                            for _,v in next, plr.QuestHaze:GetChildren() do
                                if v.Value > 0 then
                                    repeat task.wait()
                                        if plr:DistanceFromCharacter(game.ReplicatedStorage.FortBuilderReplicatedSpawnPositionsFolder[v.Name].CFrame.Position) >= 600 then
                                            tween(game.ReplicatedStorage.FortBuilderReplicatedSpawnPositionsFolder[v.Name].CFrame,350).Completed:Wait()
                                        end
                                        for _,v2 in next, workspace.Enemies:GetChildren() do
                                            if v2.Name == v.Name and v2:FindFirstChild('HumanoidRootPart') and v2:FindFirstChild('Humanoid') and v2.Humanoid.Health > 0 then
                                                repeat
                                                    task.wait()
                                                    tween(v2.HumanoidRootPart.Position + Vector3.new(0,25,10),350)
                                                    if plr:DistanceFromCharacter(v2.HumanoidRootPart.Position) <= 40 then
                                                        bringMob(v2.Name)
                                                        equipWeapon()
                                                        FastAttack()
                                                    end
                                                until not v2.Humanoid or not v2.HumanoidRootPart or v2.Humanoid.Health <= 0 or not v2
                                                break
                                            end
                                        end
                                    until not v or v.Value == 0 or not plr:FindFirstChild('QuestHaze')
                                end
                            end
                        end
                    elseif q.Evil == 2 or q.Evil == -5 then
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CDKQuest","StartTrial",'Evil')
                        if workspace.Enemies:FindFirstChild('Soul Reaper') or workspace.Map:FindFirstChild('HellDimension') then
                            if workspace.Enemies:FindFirstChild('Soul Reaper') and not workspace.Map:FindFirstChild('HellDimension') then
                                repeat
                                    tween(workspace.Enemies:FindFirstChild('Soul Reaper').HumanoidRootPart.CFrame,350).Completed:Wait()
                                    task.wait()
                                until workspace.Map:FindFirstChild('HellDimension')
                            end
                            if tw then tw:Cancel() end
                            task.wait(1)
                            for i = 1,3 do
                                tween(workspace.Map.HellDimension['Torch'..i].CFrame,350).Completed:Wait()
                                fireproximityprompt(workspace.Map.HellDimension['Torch'..i].ProximityPrompt)
                                repeat wait() until #workspace.Enemies:GetChildren() > 0
                                for _,v in next, workspace.Enemies:GetChildren() do
                                    if plr:DistanceFromCharacter(v.HumanoidRootPart.CFrame.Position) <= 300 and v.HumanoidRootPart and v.Humanoid and v.Humanoid.Health > 0 then
                                        repeat
                                            task.wait()
                                            tween(v.HumanoidRootPart.CFrame * CFrame.new(0, 25, 10), 350)
                                            if plr:DistanceFromCharacter(v.HumanoidRootPart.Position) <= 210 then
                                                tween(v.HumanoidRootPart.CFrame * CFrame.new(0, 25, 10), math.huge)
                                                if plr:DistanceFromCharacter(v.HumanoidRootPart.Position) <= 40 then
                                                    bringMob(v.Name)
                                                    equipWeapon()
                                                    FastAttack()
                                                end
                                            end
                                        until not v or not v:FindFirstChild("Humanoid")  or v.Humanoid.Health <= 0 or not v:FindFirstChild("HumanoidRootPart")
                                    end
                                end
                            end
                        else
                            local boneNPCs = {'Reborn Skeleton','Living Zombie','Demonic Soul','Posessed Mummy'}
                            repeat
                                task.wait()
                                local mob = nil
                                local min = math.huge
                                for _, v in next, workspace.Enemies:GetChildren() do
                                    if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and table.find(boneNPCs,v.Name) then
                                        local dist = plr:DistanceFromCharacter(v.HumanoidRootPart.Position)
                                        if dist < min then
                                            min = dist
                                            mob = v
                                        end
                                    end
                                end
                                if mob and mob.HumanoidRootPart and mob.Humanoid and mob.Humanoid.Health > 0 then
                                    repeat
                                        task.wait()
                                        tween(mob.HumanoidRootPart.CFrame * CFrame.new(0, 15, 5), 350)
                                        if plr:DistanceFromCharacter(mob.HumanoidRootPart.Position) <= 210 then
                                            tween(mob.HumanoidRootPart.CFrame * CFrame.new(0, 15, 5), math.huge)
                                            if plr:DistanceFromCharacter(mob.HumanoidRootPart.Position) <= 30 then
                                                bringMob(mob.Name)
                                                equipWeapon()
                                                FastAttack()
                                            end
                                        end
                                    until not mob or not mob:FindFirstChild("Humanoid")  or mob.Humanoid.Health <= 0 or not mob:FindFirstChild("HumanoidRootPart") or not
                                    Options.AutoFarm.Value or selectedFarmMethod ~= 'Bone'
                                else
                                    tween(CFrame.new(-9515, 164, 5786), 350).Completed:Wait()
                                end
                            until not Options.GetCDK.Value or plr.Backpack:FindFirstChild('Hallow Essence') or
                             (game.ReplicatedStorage:FindFirstChild('Soul Reaper') or workspace.Enemies:FindFirstChild('Soul Reaper'))
                            or not Options.AutoFarm.Value
                            if plr.Backpack:FindFirstChild('Hallow Essence') then
                                equipTool('Hallow Essence')
                                if character:FindFirstChild('Hallow Essence') then
                                    firetouchinterest(character.HumanoidRootPart,workspace.Map["Haunted Castle"].Summoner.Detection,1)
                                    firetouchinterest(character.HumanoidRootPart,workspace.Map["Haunted Castle"].Summoner.Detection,0)
                                end
                            end
                        end
                    elseif q.Good == 0 or q.Good == -3 then
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CDKQuest","StartTrial",'Good')
                        for _, x in next, {CFrame.new(-9550, 21, 4690), CFrame.new(-6120, 16, -2250), CFrame.new(-9530, 7, -8370)} do
                            repeat game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = x task.wait() until workspace.NPCs:FindFirstChildWhichIsA("Model") and workspace.NPCs:FindFirstChildWhichIsA("Model").Name:find("Boat")
                            for _, n in next, workspace.NPCs:GetChildren() do if n.Name:find("Boat") then game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CDKQuest", "BoatQuest", n) end end
                        end
                    elseif q.Good == 1 or q.Good == -4 then
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CDKQuest","StartTrial",'Good')
                        if plr:DistanceFromCharacter(Vector3.new(-5074, 314, -2991)) >= 700 then
                            tween(CFrame.new(-5074, 314, -2991), 350).Completed:Wait()
                        end
                        for _,v in next,workspace.Enemies:GetChildren() do
                            if v:FindFirstChild('HumanoidRootPart') and v:FindFirstChild('Humanoid') then
                                if v.Humanoid.Health > 0 and plr:DistanceFromCharacter(v.HumanoidRootPart.CFrame.Position) <= 700 then
                                    tween(v.HumanoidRootPart.CFrame,350)
                                    if plr:DistanceFromCharacter(v.HumanoidRootPart.CFrame.Position) <= 50 then
                                        equipWeapon()
                                        FastAttack()
                                    end
                                end
                            end
                        end
                    elseif q.Good == 2 or q.Good == -5 then
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CDKQuest","StartTrial",'Good')
                        if workspace.Map:FindFirstChild("HeavenlyDimension") ~= nil and workspace.Map:FindFirstChild("Heavenly Dimension") then
                            if workspace.Map.HeavenlyDimension.Exit.Color ~= Color3.fromRGB(0, 0, 0) then 
                                firetouchinterest(workspace.Map.HeavenlyDimension.Exit.Touchinterest, game.Players.LocalPlayer.Character.HumanoidRootPart, 0)
                            else 
                                for i = 1, 3 do
                                    repeat 
                                        task.wait()
                                        local e = workspace.Enemies:FindFirstChildWhichIsA("Model", true)
                                        if e and (e.Name:find("Cursed Skeleton") or e.Name:find("Heaven")) then
                                            KillMonster(e.Name)
                                        else
                                            if workspace.Map.HeavenlyDimension["Torch"..i].ProximityPrompt.Enabled then
                                                tween(workspace.Map.HeavenlyDimension["Torch"..i].CFrame,350).Completed:Wait()
                                                fireproximityprompt(workspace.Map.HeavenlyDimension["Torch"..i].ProximityPrompt)
                                            end
                                        end
                                    until not Options.GetCDK.Value or not workspace.Map.HeavenlyDimension["Torch"..i].ProximityPrompt.Enabled or workspace.Map.HeavenlyDimension.Exit.Color ~= Color3.fromRGB(0, 0, 0) or character.Humanoid.Health <= 0
                                    if tw then tw:Cancel() end
                                end
                            end
                        else
                            if game.ReplicatedStorage:FindFirstChild('Cake Queen') or workspace.Enemies:FindFirstChild('Cake Queen') then
                                KillMonster("Cake Queen") 
                                if tw then tw:Cancel() end
                            else
                                hopLowServer()
                            end
                        end
                    end
                end)
            end
        end
    end)
end)

Plus_SelectSong:OnChanged(function(Value)
    selectedSong = Value
    songUrl = songList[selectedSong]
end)

LocalPlayer_AutoRaceV2:OnChanged(function()
    task.spawn(function()
        if tw then StopTween() end
        while task.wait() and Options.AutoRaceV2.Value and game.PlaceId == sea2 do
            pcall(function()
                if plr.Data.Level.Value >= 850 and plr.Data.Beli.Value >= 500000 and (function()
                    local b = 0
                    for i,v in next,game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BartiloQuestProgress") do
                        if v == true then
                            b = b + 1
                        end
                    end
                    return b
                end)() == 3 then
                    if not plr.Data.Race:FindFirstChild("Evolved") then
                        if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Alchemist", "1") == 0 then
                            game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Alchemist", "2")
                        elseif game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Alchemist", "1") == 1 then
                            if not plr.Backpack:FindFirstChild("Flower 1") and not character:FindFirstChild("Flower 1") then
                                tween(workspace.Flower1.CFrame, 350)
                            elseif not plr.Backpack:FindFirstChild("Flower 2") and not character:FindFirstChild("Flower 2") then
                                tween(workspace.Flower2.CFrame, 350)
                            elseif not plr.Backpack:FindFirstChild("Flower 3") and not character:FindFirstChild("Flower 3") then
                                if workspace.Enemies:FindFirstChild("Zombie") then
                                    for i, v in pairs(workspace.Enemies:GetChildren()) do
                                        if v.Name == "Zombie" then
                                            repeat
                                                task.wait()
                                                tween(v.HumanoidRootPart.CFrame * CFrame.new(0,15,10),350)
                                                if plr:DistanceFromCharacter(v.HumanoidRootPart.CFrame.Position)  <= 200 then
                                                    tween(v.HumanoidRootPart.CFrame * CFrame.new(0,15,10),math.huge)
                                                    equipWeapon()
                                                    bringMob(v.Name)
                                                    FastAttack()
                                                end
                                            until plr.Backpack:FindFirstChild("Flower 3") or not v.Parent or v.Humanoid.Health <= 0 or not Options.AutoRaceV2.Value
                                        end
                                    end
                                else
                                    tween(CFrame.new(-5685, 48, -853), 350).Completed:Wait()
                                end
                            end
                        elseif game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Alchemist", "1") == 2 then
                            game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Alchemist", "3")
                        end
                    end
                end
            end)
        end
    end)
end)

Items_GetKenV2:OnChanged(function()
    task.spawn(function()
        if tw then StopTween() end
        while task.wait() and Options.GetKenV2.Value and game.PlaceId == sea3 do
            pcall(function()
                if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CitizenQuestProgress","Citizen") == 3 then
                    if plr.Backpack:FindFirstChild("Banana") and plr.Backpack:FindFirstChild("Apple") and plr.Backpack:FindFirstChild("Pineapple") then
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CitizenQuestProgress","Citizen")
                    elseif plr.Backpack:FindFirstChild("Fruit Bowl") or character:FindFirstChild("Fruit Bowl") then
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("KenTalk2", "Start")
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("KenTalk2", "Buy")
                    end
                else
                    if not plr.PlayerGui.Main.Quest.Visible then
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CitizenQuestProgress","Citizen")
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest","CitizenQuest", 1)
                    else
                        if string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text,"Defeat 50 Forest Pirates") then
                            if workspace.Enemies:FindFirstChild('Forest Pirate') then
                                for _,v in next,workspace.Enemies:GetChildren() do
                                    if v.Name == 'Forest Pirate' and v.Humanoid and v.Humanoid.Health > 0 then
                                        repeat
                                            task.wait()
                                            tween(v.HumanoidRootPart.CFrame * CFrame.new(0,25,10),350)
                                            if plr:DistanceFromCharacter(v.HumanoidRootPart.CFrame.Position) <= 200 then
                                                tween(v.HumanoidRootPart.CFrame * CFrame.new(0,25,10),math.huge)
                                                if plr:DistanceFromCharacter(v.HumanoidRootPart.CFrame.Position) <= 50 then
                                                    bringMob(v.Name)
                                                    FastAttack()
                                                end
                                            end
                                        until not Options.GetKenV2.Value or not v.Humanoid or v.Humanoid.Health <= 0 or not v.HumanoidRootPart
                                    end
                                end
                            else
                                tweenMobSpawn('Forest Pirate').Completed:Wait()
                            end
                        elseif string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Captain Elephant") then
                            if game.ReplicatedStorage:FindFirstChild('Captain Elephant') or workspace.Enemies:FindFirstChild('Captain Elephant') then
                                KillMonster('Captain Elephant')
                            end
                        end
                    end
                end
            end)
        end
    end)
end)

game.ReplicatedStorage.FishReplicated.FishingRemote.OnClientEvent:Connect(function(p, en, fish)
    if en == 'SpawnFishOnBob' then
        print('Fish detected')
    end
end)

OtherFarm_AutoFarmSummer:OnChanged(function()
    task.spawn(function()
        while Options.AutoFarmSummer.Value and task.wait() do
            if not Options.AutoFarm.Value then
                if tonumber(os.date("%M")) >= 0 and tonumber(os.date("%M")) < 10 then
                    pcall(function()
                        local mob = nil
                        local min = math.huge
                        for _,v2 in {workspace.Enemies,game.ReplicatedStorage} do
                            for _,v in next,v2:GetChildren() do
                                if v:GetAttribute('IsBoss') and v:FindFirstChild('HumanoidRootPart') and v:FindFirstChild('Humanoid') and (function(n)
                                    for _,v in next,workspace:GetChildren() do
                                        if v.Name:find(n) then
                                            return true
                                        end
                                    end
                                    return false
                                end)(v.Name) then
                                    if v.Humanoid.Health > 0 and min > plr:DistanceFromCharacter(v.HumanoidRootPart.Position) then
                                        mob = v
                                        min = plr:DistanceFromCharacter(v.HumanoidRootPart.Position)
                                    end
                                end
                            end
                        end
                        repeat
                            task.wait()
                            tween(mob.HumanoidRootPart.CFrame * CFrame.new(0,15,0),350)
                            if plr:DistanceFromCharacter(mob.HumanoidRootPart.CFrame.Position) <= 170 then
                                tween(mob.HumanoidRootPart.CFrame  * CFrame.new(0,15,0) ,math.huge)
                                if plr:DistanceFromCharacter(mob.HumanoidRootPart.CFrame.Position) <= 50 then
                                    equipWeapon()
                                    FastAttack()
                                end
                            end
                        until not Options.AutoFarmSummer.Value or not mob or not mob:FindFirstChild('HumanoidRootPart') or mob.Humanoid.Health <= 0 or tonumber(os.date("%M")) >= 10
                        task.wait(1)
                        if tonumber(os.date("%M")) < 10 then
                            for _,v2 in {workspace.Enemies,game.ReplicatedStorage} do
                                for _,v in next,v2:GetChildren() do
                                    if v:GetAttribute('IsBoss') and v:GetAttribute('PainBoss') and v:FindFirstChild('HumanoidRootPart') and v:FindFirstChild('Humanoid') and v.Name == mob.Name then
                                       KillMonster(v.Name)
                                    end
                                end
                            end 
                        end
                    end)
                end
            end
        end
    end)
end)

-- OtherFarm_AutoRandomSummer:OnChanged(function()
--     task.spawn(function()
--         while Options.AutoRandomSummer.Value and wait() do
--             if GetMaterial('Summer Token') >= 500 then
--                 game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Cousin", "BuySummer")
--             end
--         end
--     end)
-- end)

OtherFarm_AutoChest:OnChanged(function()
    task.spawn(function()
        while Options.AutoChest.Value and task.wait() do
            pcall(function()
                local c = 0 
                local m = workspace.Map:GetDescendants()
                local plr = game.Players.LocalPlayer local chr = plr.Character or plr.CharacterAdded:Wait()
                local h = chr:FindFirstChild("Humanoid") or false
                for i = 1, #m do local v = m[i]
                    if not Options.AutoChest.Value then return end
                    if v:IsA("BasePart") and v.Name:find("Chest") and (v.Name:match("%d+") or v.Name:find("Frag")) and v.CanTouch then
                        if Options.AutoChestStopItem.Value and (function() 
                            for _,v in {character,plr.Backpack} do
                                for _,v2 in next,v:GetChildren() do
                                    if v2.Name == 'God\'s Chalice' or v2.Name == 'Fist of Darkness' or v2.Name == 'Sweet Chalice' then
                                        return true
                                    end
                                end
                            end
                            return false
                        end)() then
                            break
                        end
                        if c >= Options.AutoChestReset.Value then
                            c = 0
                            h.Health = 0
                        else
                            if character:FindFirstChild('HumanoidRootPart') and character:FindFirstChild('Humanoid') then
                                if character.Humanoid.Health > 0 then
                                    chr:SetPrimaryPartCFrame(v.CFrame * CFrame.new(0,2,0))
                                    c = c + 1
                                end
                            end
                        end
                        task.wait(0.2)
                    end
                end
            end)
        end
    end)
end)

LocalPlayer_AutoRaceV3:OnChanged(function()
    task.spawn(function()
        local HumanQuestStage = 0
        local MinkQuestStage = 0
        while task.wait() and Options.AutoRaceV3.Value and game.PlaceId == sea2 do
            pcall(function()
                if plr.Data.Level.Value >= 1000 and plr.Data.Beli.Value >= 2000000 and getRaceGrade() == "V2" then
                    local race = plr.Data.Race.Value
                    if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Wenlocktoad", "1") == 0 then
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Wenlocktoad", "2")
                    elseif game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Wenlocktoad", "1") == 1 then
                        if race == "Human" then
                            if HumanQuestStage == 0 then
                                if workspace.Enemies:FindFirstChild('Jeremy') or game.ReplicatedStorage:FindFirstChild('Jeremy') then
                                    KillMonster('Jeremy')
                                    HumanQuestStage = 1
                                end
                            elseif HumanQuestStage == 1 then
                                if workspace.Enemies:FindFirstChild("Diamond") or game.ReplicatedStorage:FindFirstChild('Diamond') then
                                    KillMonster('Diamond')
                                    HumanQuestStage = 2
                                end
                            elseif HumanQuestStage == 2 then
                                if workspace.Enemies:FindFirstChild("Orbitus") or game.ReplicatedStorage:FindFirstChild('Orbitus') then
                                    KillMonster('Orbitus')
                                    HumanQuestStage = 3
                                end
                            elseif HumanQuestStage == 3 then
                                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Wenlocktoad", "3")
                                LocalPlayer_AutoRaceV3:SetValue(false)
                            end
                        elseif race == "Rabbit" then
                            if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Wenlocktoad", "1") == 0 then
                                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Wenlocktoad", "2")
                            elseif game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Wenlocktoad", "1") == 1 then
                                for _, v in next,workspace.ChestModels:GetChildren() do
                                    if MinkQuestStage < 30 then
                                        tween(v.WorldPivot.Position, 350).Completed:Wait()
                                        MinkQuestStage = MinkQuestStage + 1
                                    elseif MinkQuestStage >= 30 then
                                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Wenlocktoad", "3")
                                        LocalPlayer_AutoRaceV3:SetValue(false)
                                    end
                                end
                            end
                        elseif race == "Fishman" then
                            repeat
                                Farm_AutoSeaBeast:SetValue(true)
                                task.wait(1)
                                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Wenlocktoad", "3")
                            until not Options.AutoRaceV3.Value or getRaceGrade() == "V3" or not string.find(race, "Fish")
                            Farm_AutoSeaBeast:SetValue(false)
                        end
                    end
                end
            end)
        end
    end)
end)

LocalPlayer_AutoBartilo:OnChanged(function()
    task.spawn(function()
        StopTween()
        while task.wait() and Options.AutoBartilo.Value and game.PlaceId == sea2 do
            pcall(function()
                if plr.Data.Level.Value >= 850 then
                    if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BartiloQuestProgress").KilledBandits == false then
                            repeat
                                if not plr.PlayerGui.Main.Quest.Visible then
                                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer('StartQuest','BartiloQuest',1)
                                end
                                if workspace.Enemies:FindFirstChild("Swan Pirate") then
                                    for _, v in pairs(workspace.Enemies:GetChildren()) do
                                        if v.Name == 'Swan Pirate' and v.Humanoid.Health > 0 and v.HumanoidRootPart then
                                            repeat
                                                task.wait()
                                                tween(v.HumanoidRootPart.CFrame * CFrame.new(0, 15, 10), 350)
                                                if plr:DistanceFromCharacter(v.HumanoidRootPart.CFrame.Position) <= 200 then
                                                    tween(v.HumanoidRootPart.CFrame * CFrame.new(0, 15, 10), math.huge)
                                                    equipWeapon()
                                                    bringMob(v.Name)
                                                    FastAttack()
                                                end
                                            until not v.Parent or not v or v.Humanoid.Health == 0 or not v.HumanoidRootPart
                                        end
                                    end
                                else
                                    tween(CFrame.new(932.624451, 156.106079, 1180.27466), 350).Completed:Wait()
                                end
                            until not Options.AutoBartilo.Value or game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BartiloQuestProgress").KilledBandits
                    elseif game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 1 then
                        if game.ReplicatedStorage:FindFirstChild('Jeremy') then
                            KillMonster('Jeremy')
                        end
                    elseif game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 2 then
                        for i = 1, 8 do
                            firetouchinterest(workspace.Map.Dressrosa.BartiloPlates['Plate' .. i],character.HumanoidRootPart, 0)
                            task.wait(0.1)
                            firetouchinterest(workspace.Map.Dressrosa.BartiloPlates['Plate' .. i],character.HumanoidRootPart, 1)
                        end
                    end
                end
            end)
        end
    end)
end)

Stack_AutoSecondSea:OnChanged(function()
    task.spawn(function()
        while task.wait() and Options.AutoSecondSea.Value and game.PlaceId == sea1 do
            pcall(function()
                if plr.Data.Level.Value >= 700 and
                    string.find(game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelDressrosa"), 'Cannot') then
                    General_AutoFarm:SetValue(false)
                    if not game.ReplicatedStorage.Remotes.CommF_:InvokeServer("DressrosaQuestProgress").UsedKey then
                        if not game.ReplicatedStorage.Remotes.CommF_:InvokeServer("DressrosaQuestProgress").TalkedDetective then
                            game.ReplicatedStorage.Remotes.CommF_:InvokeServer("DressrosaQuestProgress", "Detective")
                        elseif plr.Backpack:FindFirstChild('Key') then
                            character.Humanoid:EquipTool(plr.Backpack["Key"])
                        end
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer('DressrosaQuestProgress','UseKey')
                    elseif not game.ReplicatedStorage.Remotes.CommF_:InvokeServer("DressrosaQuestProgress").KilledIceBoss then
                        if workspace.Enemies:FindFirstChild("Ice Admiral") or game.ReplicatedStorage:FindFirstChild('Ice Admiral') then
                            KillMonster('Ice Admiral')
                        else
                            hopServer()
                        end
                    else
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelDressrosa")
                    end
                end
            end)
        end
    end)
end)

Stats_SpectatePlayer:OnChanged(function()
    task.spawn(function()
        pcall(function()
            repeat
                task.wait()
                local targetPlayer = game.Players:FindFirstChild(target.Name)
                if targetPlayer and targetPlayer.Character then
                    workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
                    workspace.CurrentCamera.CFrame = CFrame.new(targetPlayer.Character.HumanoidRootPart.Position+Vector3.new(0, 20, 0),
                    targetPlayer.Character.HumanoidRootPart.Position)
                else workspace.Camera.CameraSubject = game:GetService("Players").LocalPlayer.Character.Humanoid
                end
            until not Options.SpectatePlayer.Value or not targetPlayer or not targetPlayer.Character
            workspace.Camera.CameraSubject = game:GetService("Players").LocalPlayer.Character.Humanoid
        end)
    end)
end)

local function getFruitValue(_v)
    for i,v in next,game.ReplicatedStorage.Remotes.CommF_:InvokeServer("getInventory") do
        for i2,v2 in pairs(v) do
            if v2 == 'Blox Fruit' and v.Value >= _v then
                return v.Name
            end
        end
    end
    return nil
end

Items_AutoDojo:OnChanged(function()
    task.spawn(function()
        StopTween()
        while task.wait() and Options.AutoDojo.Value and not checkItem('Dojo Belt (Black)') do
            game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyDragonTalon")
            pcall(function()
                if (function() local b = false local function a(x) for i, v in next, x do if typeof(v) == "table" then if i == "Dragon Talon" 
                    and v.Level and v.Level >= 500 then b = true end a(v) end end end 
                    a(game.ReplicatedStorage.Modules.Net["RF/ReadPlayerData"]:InvokeServer()) return b end)() then 
                        local q = game.ReplicatedStorage.Modules.Net['RF/InteractDragonQuest']:InvokeServer({NPC = "Dojo Trainer",Command = "RequestQuest"})
                        if not q then
                            tween(Vector3.new(5849, 1208, 881),350).Completed:Wait()
                            local q2 = game.ReplicatedStorage.Modules.Net['RF/InteractDragonQuest']:InvokeServer({NPC = "Dojo Trainer",Command = "RequestQuest"})
                            task.wait(3)
                            if q2.Quest.Progress == q2.Quest.Goal then
                                game.ReplicatedStorage.Modules.Net['RF/InteractDragonQuest']:InvokeServer({NPC = "Dojo Trainer",Command = "ClaimQuest"})
                            end
                        elseif q.Timeout == false then
                            if q.Quest.BeltName == 'White' then
                                local t = tick()
                                repeat
                                    selectedFarmMethod = 'Level'
                                    if not Options.AutoFarm.Value then
                                        General_AutoFarm:SetValue(true)
                                    end
                                    task.wait(2)
                                until (tick() - t) >= 360 or not Options.AutoDojo.Value
                                General_AutoFarm:SetValue(false)
                            elseif q.Quest.BeltName == 'Yellow' then
                                local t = tick()
                                repeat
                                    if not Options.AutoSeaEvents.Value then
                                        Farm_AutoSeaEvents:SetValue(true)
                                    end
                                    task.wait(2)
                                until (tick() - t) >= 360 or not Options.AutoDojo.Value
                                Farm_AutoSeaEvents:SetValue(false)
                            elseif q.Quest.BeltName == 'Green' then
                                local t = tick()
                                repeat
                                    if not Options.AutoSeaEvents.Value then
                                        Farm_AutoSeaEvents:SetValue(true)
                                    end
                                    task.wait(2)
                                until (tick() - t) >= 600 or not Options.AutoDojo.Value
                                Farm_AutoSeaEvents:SetValue(false)
                            elseif q.Quest.BeltName == 'Purple' then
                                local e = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("EliteHunter", "Progress")
                                repeat
                                    if not Options.AutoEliteHunter.Value then
                                        Stack_AutoEliteHunter:SetValue(true)
                                    end
                                    task.wait(2)
                                until (game.ReplicatedStorage.Remotes.CommF_:InvokeServer("EliteHunter", "Progress") - e) >= 3 or not Options.AutoDojo.Value
                                Stack_AutoEliteHunter:SetValue(false)
                            elseif q.Quest.BeltName == 'Red' then
                                local ts = game.ReplicatedStorage.Modules.Net["RF/ReadPlayerData"]:InvokeServer().TerrorsharksKilled
                                repeat
                                    if not Options.AutoSeaEvents.Value then
                                        Farm_AutoSeaEvents:SetValue(true)
                                    end
                                    task.wait(2)
                                until (game.ReplicatedStorage.Modules.Net["RF/ReadPlayerData"]:InvokeServer().TerrorsharksKilled - ts) >= 1 or not Options.AutoDojo.Value
                                Farm_AutoSeaEvents:SetValue(false)
                            elseif q.Quest.BeltName == 'Black' then
                                print('Waittttt')
                            end
                        end
                else
                    repeat
                        selectedFarmMethod = 'Katakuri [ Cake ]'
                        selectedWeapon = 'Melee'
                        if not character:FindFirstChild('Dragon Talon') and not plr.Backpack:FindFirstChild('Dragon Talon') then
                            game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyDragonTalon")
                        end
                        if not Options.AutoFarm.Value then
                            General_AutoFarm:SetValue(true)
                        end
                        task.wait(1)
                    until character['Dragon Talon'].Level.Value >= 500 or not Options.AutoDojo.Value
                    General_AutoFarm:SetValue(false)
                end
            end)
        end
    end)
end)

Items_AutoDragonHunterHunt:OnChanged(function()
    task.spawn(function()
        StopTween()
        while task.wait() and Options.AutoDragonHunterHunt.Value and checkItem('Dojo Belt (Yellow)') do
            local q = game.ReplicatedStorage.Modules.Net['RF/DragonHunter']:InvokeServer({Context = 'Check'})
            if not q then
                tween(Vector3.new(5875, 1209, 818),350).Completed:Wait()
                task.wait(3)
            end
        end
    end)
end)

Stack_AutoThirdSea:OnChanged(function()
    task.spawn(function()
        while task.wait() and Options.AutoThirdSea.Value do
            if plr.Data.Level.Value >= 1500 and game.PlaceId == sea2 then
                General_AutoFarm:SetValue(false)
                if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("GetUnlockables").FlamingoAccess then
                    if game.ReplicatedStorage.Remotes["game.ReplicatedStorage.Remotes.CommF_"]:InvokeServer("ZQuestProgress", "Check") == 0 then
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelZou")
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ZQuestProgress", "Begin")
                        if workspace.Enemies:FindFirstChild("rip_indra") or game.ReplicatedStorage:FindFirstChild('rip_indra') then
                            KillMonster('rip_indra')
                        end
                    elseif game.ReplicatedStorage.Remotes["game.ReplicatedStorage.Remotes.CommF_"]:InvokeServer("ZQuestProgress", "Check") == 1 then
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelZou")
                    else
                        if workspace.Enemies:FindFirstChild("Don Swan") then
                            for i, v in pairs(workspace.Enemies:GetChildren()) do
                                if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and
                                    v.Humanoid.Health > 0 then
                                    if string.find(v.Name, "Don Swan") then
                                        KillMonster(v.Name)
                                    end
                                end
                            end
                            game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ZQuestProgress","Begin")
                        else
                            tween(CFrame.new(2288.802, 15.1870775, 863.034607), 350).Completed:Wait()
                        end
                    end
                else
                    if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TalkTrevor","1") == 1 then
                        if getFruitValue(1000000) then
                            game.ReplicatedStorage.Remotes.CommF_:InvokeServer("LoadFruit",getFruitValue(1000000))
                            game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TalkTrevor","3")
                        else
                            Stack_TPFruit:SetValue(true)
                            Stack_TPFruitHop:SetValue(true)
                            Visual_AutoRandomFruits:SetValue(true)
                            Visual_AutoStoreFruits:SetValue(true)
                            task.wait(2.5)
                        end
                    end
                end
            end
        end
    end)
    task.spawn(function()
        while task.wait(0.2) and Options.AutoThirdSea.Value do
            game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelZou")
        end
    end)
end)

Travel_StartTravel:OnChanged(function()
    task.spawn(function()
        StopTween()
        if Options.StartTravel.Value then
            if game.Players.LocalPlayer:GetAttribute('CurrentLocation') == "Underwater City" and Options.SelectIsland.Value ~= 'Under Water Island' then
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance",vector.create(3864, 6, -1926))
            end
            if game.Players.LocalPlayer:GetAttribute('CurrentLocation') == "Cursed Ship" and Options.SelectIsland.Value ~= 'Under Water Island' then
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance",vector.create(-6508, 89, -132))
            end
            if Options.SelectIsland.Value == "WindMill" then
                tween(CFrame.new(979, 16, 1429), 350)
            elseif Options.SelectIsland.Value == "Marine" then
                tween(CFrame.new(-2566.4296875, 6.8556680679321, 2045.2561035156), 350)
            elseif Options.SelectIsland.Value == "Middle Town" then
                tween(CFrame.new(-690.33081054688, 15.09425163269, 1582.2380371094), 350)
            elseif Options.SelectIsland.Value == "Jungle" then
                tween(CFrame.new(-1612.7957763672, 36.852081298828, 149.12843322754), 350)
            elseif Options.SelectIsland.Value == "Pirate Village" then
                tween(CFrame.new(-1181.3093261719, 4.7514905929565, 3803.5456542969), 350)
            elseif Options.SelectIsland.Value == "Desert" then
                tween(CFrame.new(944.15789794922, 20.919729232788, 4373.3002929688), 350)
            elseif Options.SelectIsland.Value == "Snow Island" then
                tween(CFrame.new(1347.8067626953, 104.66806030273, -1319.7370605469), 350)
            elseif Options.SelectIsland.Value == "MarineFord" then
                tween(CFrame.new(-4914.8212890625, 50.963626861572, 4281.0278320313), 350)
            elseif Options.SelectIsland.Value == "Colosseum" then
                tween(CFrame.new(-1427.6203613281, 7.2881078720093, -2792.7722167969), 350)
            elseif Options.SelectIsland.Value == "Sky Island 1" then
                tween(CFrame.new(-4869.1025390625, 733.46051025391, -2667.0180664063), 350)
            elseif Options.SelectIsland.Value == "Sky Island 2" then
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-4607.82275, 872.54248, -1667.55688))
            elseif Options.SelectIsland.Value == "Sky Island 3" then
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-7894, 5547, -380))
            elseif Options.SelectIsland.Value == "Prison" then
                tween(CFrame.new(4875.330078125, 5.6519818305969, 734.85021972656), 350)
            elseif Options.SelectIsland.Value == "Magma Village" then
                tween(CFrame.new(-5247.7163085938, 12.883934020996, 8504.96875), 350)
            elseif Options.SelectIsland.Value == "Under Water Island" then
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
            elseif Options.SelectIsland.Value == "Fountain City" then
                tween(CFrame.new(5127.1284179688, 59.501365661621, 4105.4458007813), 350)
            elseif Options.SelectIsland.Value == "Shank Room" then
                tween(CFrame.new(-1442.16553, 29.8788261, -28.3547478), 350)
            elseif Options.SelectIsland.Value == "Mob Island" then
                tween(CFrame.new(-2850.20068, 7.39224768, 5354.99268), 350)
            elseif Options.SelectIsland.Value == "The Cafe" then
                tween(CFrame.new(-380.47927856445, 77.220390319824, 255.82550048828), 350)
            elseif Options.SelectIsland.Value == "Frist Spot" then
                tween(CFrame.new(-11.311455726624, 29.276733398438, 2771.5224609375), 350)
            elseif Options.SelectIsland.Value == "Dark Area" then
                tween(CFrame.new(3780.0302734375, 22.652164459229, -3498.5859375), 350)
            elseif Options.SelectIsland.Value == "Flamingo Mansion" then
                tween(CFrame.new(-483.73370361328, 332.0383605957, 595.32708740234), 350)
            elseif Options.SelectIsland.Value == "Flamingo Room" then
                tween(CFrame.new(2284.4140625, 15.152037620544, 875.72534179688), 350)
            elseif Options.SelectIsland.Value == "Green Zone" then
                tween(CFrame.new(-2448.5300292969, 73.016105651855, -3210.6306152344), 350)
            elseif Options.SelectIsland.Value == "Factory" then
                tween(CFrame.new(424.12698364258, 211.16171264648, -427.54049682617), 350)
            elseif Options.SelectIsland.Value == "Colossuim" then
                tween(CFrame.new(-1503.6224365234, 219.7956237793, 1369.3101806641), 350)
            elseif Options.SelectIsland.Value == "Zombie Island" then
                tween(CFrame.new(-5622.033203125, 492.19604492188, -781.78552246094), 350)
            elseif Options.SelectIsland.Value == "Two Snow Mountain" then
                tween(CFrame.new(753.14288330078, 408.23559570313, -5274.6147460938), 350)
            elseif Options.SelectIsland.Value == "Punk Hazard" then
                tween(CFrame.new(-6127.654296875, 15.951762199402, -5040.2861328125), 350)
            elseif Options.SelectIsland.Value == "Cursed Ship" then
                if plr:DistanceFromCharacter(vector.create(923, 126, 32852)) >= 5000 then
                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance",vector.create(923, 126, 32852))
                end
            elseif Options.SelectIsland.Value == "Ice Castle" then
                tween(CFrame.new(6148.4116210938, 294.38687133789, -6741.1166992188), 350)
            elseif Options.SelectIsland.Value == "Forgotten Island" then
                tween(CFrame.new(-3032.7641601563, 317.89672851563, -10075.373046875), 350)
            elseif Options.SelectIsland.Value == "Ussop Island" then
                tween(CFrame.new(4816.8618164063, 8.4599885940552, 2863.8195800781), 350)
            elseif Options.SelectIsland.Value == "Mini Sky Island" then
                tween(CFrame.new(-288.74060058594, 49326.31640625, -35248.59375), 350)
            elseif Options.SelectIsland.Value == "Great Tree" then
                tween(CFrame.new(2681.2736816406, 1682.8092041016, -7190.9853515625), 350)
            elseif Options.SelectIsland.Value == "Castle On The Sea" then
                tween(CFrame.new(-5074.45556640625, 314.5155334472656, -2991.054443359375), 350)
            elseif Options.SelectIsland.Value == "MiniSky" then
                tween(CFrame.new(-260.65557861328, 49325.8046875, -35253.5703125), 350)
            elseif Options.SelectIsland.Value == "Port Town" then
                tween(CFrame.new(-290.7376708984375, 6.729952812194824, 5343.5537109375), 350)
            elseif Options.SelectIsland.Value == "Hydra Island" then
                tween(CFrame.new(5159.9707, 1004.0918, 471.099792), 350)
            elseif Options.SelectIsland.Value == "Floating Turtle" then
                tween(CFrame.new(-13274.528320313, 531.82073974609, -7579.22265625), 350)
            elseif Options.SelectIsland.Value == "Mansion" then
                tween(Vector3.new(-12471.169921875, 374.94024658203, -7551.677734375), 350)
            elseif Options.SelectIsland.Value == "Haunted Castle" then
                tween(CFrame.new(-9515.3720703125, 164.00624084473, 5786.0610351562), 350)
            elseif Options.SelectIsland.Value == "Ice Cream Island" then
                tween(CFrame.new(-902.56817626953, 79.93204498291, -10988.84765625), 350)
            elseif Options.SelectIsland.Value == "Peanut Island" then
                tween(CFrame.new(-2062.7475585938, 50.473892211914, -10232.568359375), 350)
            elseif Options.SelectIsland.Value == "Cake Island" then
                tween(CFrame.new(-1884.7747802734375, 19.327526092529297, -11666.8974609375), 350)
            elseif Options.SelectIsland.Value == "Cocoa Island" then
                tween(CFrame.new(87.94276428222656, 73.55451202392578, -12319.46484375), 350)
            elseif Options.SelectIsland.Value == "Candy Island New" then
                tween(CFrame.new(-1014.4241943359375, 149.11068725585938, -14555.962890625), 350)
            elseif Options.SelectIsland.Value == "CandyCane" then
                tween(CFrame.new(-1049.95068, 60.1938896, -14382.8105), 350).Completed:Wait()
            elseif Options.SelectIsland.Value == "Tiki Island" then
                tween(CFrame.new(-16926.5898, 9.09604263, 433.446442), 350).Completed:Wait()
            end
        else
            StopTween()
        end
    end)
end)

Visual_AutoRandomFruits:OnChanged(function()
    task.spawn(function()
        while task.wait() and Options.AutoRandomFruits.Value do
            pcall(function()
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Cousin", "Buy")
            end)
        end
    end)
end)

Farm_ActiveHelp:OnChanged(function()
    task.spawn(function()
        while Options.ActiveHelp.Value and task.wait() do
            pcall(function()
                local _s = game.Players[Options.SelectHost.Value].Character
                if _s and _s.HumanoidRootPart:FindFirstChildWhichIsA("ParticleEmitter") then
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommE"):FireServer("ActivateAbility")
                    task.wait(0.5)
                end
            end)
        end
    end)
end)

Farm_AutoCompleteTrial:OnChanged(function()
    task.spawn(function()
        local completed = nil
        while task.wait() and Options.AutoCompleteTrial.Value and game.PlaceId == sea3 do
            local race = plr.Data.Race.Value
            if getRaceGrade() == "V3" or getRaceGrade() == "V4" then
                if completed then
                    completed = nil
                    if Options.ResetAfterTrial.Value then
                        task.wait(5)
                        character.Humanoid.Health = 0
                    end
                    if Options.KillPlayersTrial.Value then
                        local plrs = {}
                        for _, v in pairs(game.Players:GetPlayers()) do
                            if v ~= plr and
                                plr:DistanceFromCharacter(v.Character.HumanoidRootPart.Position) <= 200 then
                                table.insert(plrs, v)
                            end
                        end
                        for i, v2 in pairs(plrs) do
                            if v2 ~= plr then
                                if #plrs >= 1 and plr:DistanceFromCharacter(v2.Character.HumanoidRootPart.Position) <= 100 then
                                    repeat
                                        task.wait()
                                        equipWeapon()
                                        tween(v2.Character.HumanoidRootPart.Position + Vector3.new(0, 25, 0), 200)
                                        FastAttack()
                                    until not v2 or not v2.Character or not Options.AutoCompleteTrial.Value
                                    table.remove(plrs, i)
                                end
                            end
                        end
                    end
                else
                    if race == "Rabbit" then
                        pcall(function()
                            local sp = workspace.StartPoint
                            if (sp.Position - character.HumanoidRootPart.Position).Magnitude <= 500 then
                                tween(sp.CFrame, 280).Completed:Wait()
                                for r, v in pairs(game:GetDescendants()) do
                                    if v:IsA("TouchInterest") or v.Name == "TouchInterest" then
                                        if (v.Position - character.HumanoidRootPart.Position).Magnitude <= 50 then
                                            firetouchinterest(v)
                                            completed = true
                                            break
                                        end
                                    end
                                end
                            end
                        end)
                    elseif race == "Human" then
                        if workspace.Map:FindFirstChild("HumanTrial") and
                            workspace["_WorldOrigin"].Locations:FindFirstChild("Trial of Strength") then
                            local StrengthPart = workspace["_WorldOrigin"].Locations["Trial of Strength"].CFrame
                            if (character.HumanoidRootPart.Position - StrengthPart.Position).Magnitude <= 1000 then
                                for r, v in pairs(workspace.Enemies:GetChildren()) do
                                    if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and
                                        (v.HumanoidRootPart.Position - StrengthPart.Position).Magnitude <= 200 then
                                        repeat
                                            task.wait()
                                            bringMob(v.Name)
                                            tween(v.HumanoidRootPart.CFrame * CFrame.new(0, 35, 0), 250)
                                            FastAttack()
                                            sethiddenproperty(plr, "SimulationRadius", math.huge)
                                        until not v or not v:FindFirstChild("Humanoid") or v.Humanoid.Health <= 0
                                        completed = true
                                        break
                                    end
                                end
                            end
                        end
                    elseif race == "Ghoul" then
                        if workspace.Map:FindFirstChild("GhoulTrial") and
                            workspace["_WorldOrigin"].Locations:FindFirstChild("Trial of Carnage") then
                            local GhoulhPart2 = CFrame.new(-11706, 10011, 11)
                            if GhoulhPart2 then
                                for r, v in pairs(workspace.Enemies:GetChildren()) do
                                    if GhoulhPart2 and v:FindFirstChild("Humanoid") and
                                        v:FindFirstChild("HumanoidRootPart") and
                                        (v.HumanoidRootPart.Position - GhoulhPart2.Position).magnitude <= 1500 then
                                        repeat
                                            task.wait()
                                            bringMob(v.Name)
                                            tween(v.HumanoidRootPart.CFrame * CFrame.new(0, 35, 0), 350)
                                            FastAttack()
                                            sethiddenproperty(plr, "SimulationRadius", math.huge)
                                        until not v or not v:FindFirstChild("Humanoid") or v.Humanoid.Health <= 0
                                        completed = true
                                        break
                                    end
                                end
                            end
                        end
                    elseif race == "Cyborg" then
                        pcall(function()
                            local CyborgTrial = workspace["_WorldOrigin"].Locations:FindFirstChild("Trial of The Machine") or nil
                            if CyborgTrial and plr:DistanceFromCharacter(CFrame.new(-20021, 10090, -16)) <= 2000 then
                                tween(CFrame.new(-20021, 10090, -16), 350).Completed:Wait()
                                if not plr.PlayerGui.Main.TopHUDList.RaidTimer.Visible then
                                    completed = true
                                end
                            end
                        end)
                    elseif race == "Fishman" then
                        local FishmanTrial = workspace["_WorldOrigin"].Locations:FindFirstChild("Trial of Water") or nil
                        if FishmanTrial then
                            for r, v in next, workspace.SeaBeasts:GetChildren() do
                                if string.find(v.Name, "SeaBeast") and v:FindFirstChild("HumanoidRootPart") and
                                    (v.HumanoidRootPart.Position - FishmanTrial.Position).Magnitude <= 1500 then
                                    if v.Health.Value > 0 then
                                        autoskill()
                                    elseif v.Health.Value <= 0 then
                                        completed = true
                                        break
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end)
end)

Farm_AutoBuyGears:OnChanged(function()
    while task.wait() and Options.AutoBuyGears.Value do
        pcall(function()
            game.ReplicatedStorage.Remotes.CommF_:InvokeServer("UpgradeRace", "Buy")
        end)
    end
end)

for _, v in ipairs(repstorage.MapStash:GetChildren()) do
    v.Parent = workspace.Map
end
Farm_tweenToRacesDoor:OnChanged(function()
    task.spawn(function()
        local tableRaceDoor = {}
        for r, v in pairs(workspace:GetDescendants()) do
            if string.find(v.Name, "Corridor") then
                tableRaceDoor[v.Name] = v.Door.Door.RightDoor.Union.CFrame
            end
        end
        while task.wait() and Options.tweenToRacesDoor.Value and game.PlaceId == sea3 do
            local a = tableRaceDoor[plr.Data.Race.Value .. "Corridor"]
            if plr:DistanceFromCharacter(Vector3.new(28734, 14888, -109)) > 2000 then
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance",workspace.Map["Temple of Time"].TeleportSpawn.Position)
            end
            tween(a.Position, 350).Completed:Wait()
        end
    end)
end)

Stats_AimBot:OnChanged(function()
    task.spawn(function()
        if Options.AimBot.Value then
            monitorTools()
            hookTool()
        else
            local mt = getrawmetatable(game)
            setreadonly(mt, false)
            if old then
                mt.__namecall = old
            end
        end
    end)
end)

Visual_AutoStoreFruits:OnChanged(function()
    task.spawn(function()
        while task.wait() and Options.AutoStoreFruits.Value do
            pcall(function()
                for _, _v in {plr.Backpack, character} do
                    for i, v in pairs(_v:GetChildren()) do
                        if string.find(v.Name, "Fruit") then
                            game.ReplicatedStorage.Remotes.CommF_:InvokeServer('StoreFruit',v:GetAttribute("OriginalName"), v)
                        end
                    end
                end
            end)
        end
    end)
end)

General_AutoSummonCakePrince:OnChanged(function()
    task.spawn(function()
        while task.wait(1) and Options.AutoSummonCakePrince.Value and game.PlaceId == sea3 do
            game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CakePrinceSpawner")
        end
    end)
end)

General_AutoRandomBone:OnChanged(function()
    task.spawn(function()
        while task.wait() and Options.AutoRandomBone.Value and game.PlaceId == sea3 do
            if GetMaterial('Bones') >= 50 then
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Bones", "Buy", 1, 1)
                task.wait(1)
            end
        end
    end)
end)

local function getUseableFruit()
    for i,v in pairs(game.ReplicatedStorage.Remotes.CommF_:InvokeServer("getInventory")) do
        for i2,v2 in pairs(v) do
            if v2 == 'Blox Fruit' and v.Value < 1000000 then
                return v.Name
            end
        end
    end
end
Visual_AutoPlayDungeon:OnChanged(function()
    task.spawn(function()
        while task.wait() and Options.AutoPlayDungeon.Value and (game.PlaceId == sea3 or game.PlaceId == sea2) do
            if not plr.PlayerGui.Main.TopHUDList.RaidTimer.Visible and not plr.Backpack:FindFirstChild("Special Microchip") and 
            not plr.Character:FindFirstChild("Special Microchip") then
                if plr.Data.Beli.Value >= 100000 and not game.ReplicatedStorage.Remotes.CommF_:InvokeServer("RaidsNpc", "Select", Options.SelectChip.Value):find('wait') then
                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("RaidsNpc", "Select", Options.SelectChip.Value)
                else
                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("LoadFruit",getUseableFruit())
                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("RaidsNpc", "Select", Options.SelectChip.Value)
                end
            end
            if not plr:GetAttribute('IslandRaiding') then
                if game.PlaceId == sea2 then
                    fireclickdetector(workspace.Map.CircleIsland.RaidSummon2.Button.Main.ClickDetector)
                elseif game.PlaceId == sea3 then
                    fireclickdetector(workspace.Map["Boat Castle"].RaidSummon2.Button.Main.ClickDetector)
                end
                repeat wait() until workspace["_WorldOrigin"].Locations:FindFirstChild("Island 1") and character:GetAttribute('IslandRaiding') and 
                plr:DistanceFromCharacter(workspace._WorldOrigin.Locations:FindFirstChild("Island 1").CFrame.Position) <= 2000
            end
            if plr:GetAttribute('IslandRaiding') and #workspace.Enemies:GetChildren() >= 0 then
                for _, v in next,(workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and
                        (v.HumanoidRootPart.CFrame.Position - character.HumanoidRootPart.Position).Magnitude <= 650 then
                        repeat
                            task.wait()
                            tween(v.HumanoidRootPart.CFrame * CFrame.new(0, 35, 15), 350)
                            if plr:DistanceFromCharacter(v.HumanoidRootPart.CFrame.Position) <= 200 then
                                tween(v.HumanoidRootPart.CFrame * CFrame.new(0, 35, 15), math.huge)
                                if plr:DistanceFromCharacter(v.HumanoidRootPart.CFrame.Position) <= 50 then
                                    equipWeapon()
                                    FastAttack()
                                end
                            end
                        until not Options.AutoPlayDungeon.Value or v.Humanoid.Health <= 0 or not v.Parent
                    else
                        for i = 5, 1, -1 do
                            if workspace["_WorldOrigin"].Locations:FindFirstChild("Island " .. i) and 
                            plr:DistanceFromCharacter(workspace["_WorldOrigin"].Locations:FindFirstChild("Island " .. i).CFrame.Position) <= 2000 then
                                tween(workspace["_WorldOrigin"].Locations:FindFirstChild("Island " .. i).CFrame * CFrame.new(100, 70, 100), 350)
                                break
                            end
                        end
                    end
                end
            end
        end
    end)
end)

Visual_AutoAwaken:OnChanged(function()
    task.spawn(function()
        pcall(function()
            while Options.AutoAwaken.Value and game.PlaceId ~= sea1 do
                if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Awakener", "Check") == 0 then
                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Awakener", "Teleport")
                else
                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Awakener", "Awaken")
                end
                task.wait(1.75)
            end
        end)
    end)
end)

function getBlueGear()
    if workspace.Map:FindFirstChild("MysticIsland") then
        for r, v in pairs(workspace.Map.MysticIsland:GetChildren()) do
            if v:IsA("MeshPart") and v.MeshId == "rbxassetid://10153114969" then
                return v
            end
        end
    end
end

function getHighestPoint()
    if not workspace.Map:FindFirstChild("MysticIsland") then
        return nil
    end
    for r, v in pairs(workspace.Map.MysticIsland:GetDescendants()) do
        if v:IsA("MeshPart") then
            if v.MeshId == "rbxassetid://6745037796" then
                return v
            end
        end
    end
end

function PullLever()
    local bn = CFrame.new(28576.4688, 14939.2832, 76.5164413)
    local bo = CFrame.new(28576.4688, 14935.9512, 75.469101)
    local bp = 0.2
    if workspace.Map["Temple of Time"].Lever.Lever.CFrame.Z > bo.Z + bp or
        workspace.Map["Temple of Time"].Lever.Lever.CFrame.Z < bo.Z - bp then
        CheckAndtweenTemple()
        tween(workspace.Map["Temple of Time"].Lever.Part.CFrame, 350).Completed:Wait()
        for r, v in pairs(workspace.Map["Temple of Time"].Lever:GetDescendants()) do
            if v.Name == "ProximityPrompt" then
                fireproximityprompt(v)
            end
        end
    end
end

Farm_AutoPullLever:OnChanged(function()
    task.spawn(function()
        while task.wait() and Options.AutoPullLever.Value and game.PlaceId == sea3 do
            pcall(function()
                if checkItem("Mirror Fractal") and checkItem("Valkyrie Helm") then
                    local cz = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("RaceV4Progress", "Check")
                    if cz == 1 then
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("RaceV4Progress", "Begin")
                    elseif cz == 2 then
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(28282,14896, 105))
                    elseif cz == 3 then
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("RaceV4Progress", "Continue")
                    elseif not getLeverStatus() and not game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CheckTempleDoor") and
                        workspace.Map:FindFirstChild("MysticIsland") then
                        if getBlueGear() then
                            local HighestPointRealCFrame = getHighestPoint().CFrame * CFrame.new(0, 211, 0)
                            if getBlueGear() and not getBlueGear().CanCollide and getBlueGear().Transparency ~= 1 then
                                repeat
                                    task.wait()
                                    tween(getBlueGear().WorldPivot, 350)
                                until not getBlueGear() or getBlueGear().Transparency == 1
                                if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CheckTempleDoor") then
                                    Farm_LookAtMoon:SetValue(false)
                                    Farm_AutoPullLever:SetValue(false)
                                end
                            elseif getBlueGear() and getBlueGear().Transparency == 1 then
                                if HighestPointRealCFrame and plr:DistanceFromCharacter(HighestPointRealCFrame.Position) > 10 then
                                    tween(HighestPointRealCFrame, 350).Completed:Wait()
                                elseif HighestPointRealCFrame and plr:DistanceFromCharacter(HighestPointRealCFrame.Position) <= 10 then
                                    Farm_LookAtMoon:SetValue(true)
                                    game.ReplicatedStorage.Remotes.CommE:FireServer("ActivateAbility")
                                    task.wait(1.5)
                                end
                            end
                        end
                    elseif game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CheckTempleDoor") then
                        PullLever()
                    end
                end
            end)
        end
    end)
end)

Farm_LookAtMoon:OnChanged(function()
    task.spawn(function()
        while task.wait() and Options.LookAtMoon.Value do
            MoveCamtoMoon()
        end
    end)
end)

Farm_AutoSeaBeast:OnChanged(function()
    task.spawn(function()
        while task.wait() and Options.AutoSeaBeast.Value and game.PlaceId == sea2 do
            repeat
                task.wait()
                Seabeast()
            until not Options.AutoSeaBeast.Value
        end
    end)
end)

Farm_AutoSeaEvents:OnChanged(function()
    task.spawn(function()
        if tweensea then tweensea:Cancel() end
        if workspace:FindFirstChild("Rocks") then workspace.Rocks:Destroy() end
        while task.wait() and Options.AutoSeaEvents.Value and game.PlaceId == sea3 do
            pcall(function()
                if character.HumanoidRootPart and character.Humanoid and character.Humanoid.Health > 0 then
                    if not checkboat() then tween(CFrame.new(-16927.451, 9.086, 433.864), 350).Completed:Wait()
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyBoat", "PirateBrigade")
                    end
                    if workspace.Enemies:FindFirstChild("Shark") or workspace.Enemies:FindFirstChild("Terrorshark") or
                        workspace.Enemies:FindFirstChild("Piranha") or workspace.Enemies:FindFirstChild("Fish Crew Member")
                        or workspace.Enemies:FindFirstChild('PirateBrigade') or workspace.Enemies:FindFirstChild('PirateGrandBrigade')
                        or workspace.Enemies:FindFirstChild('FishBoat') or workspace.Enemies:FindFirstChild('Anchored Terrorshark') then
                        for _, v in next,workspace.Enemies:GetChildren() do
                            if v.Name == "Piranha" or v.Name == "Shark" or v.Name == "Terrorshark" or v.Name == "Fish Crew Member" or 
                            v.Name == 'PirateBrigade' or v.Name == 'PirateGrandBrigade' or v.Name == 'FishBoat' or v.Name:find('shark') then
                                if tweensea then tweensea:Cancel() end
                                if plr:DistanceFromCharacter(v.WorldPivot.Position) < 2000 then
                                    repeat
                                        task.wait()
                                        character.Humanoid.Sit = false
                                        equipWeapon()
                                        local currenthp = character.Humanoid.Health / character.Humanoid.MaxHealth
                                        if v:FindFirstChild('Engine') then
                                            if currenthp > (Options.AutoSeaEventsHighHealth.Value/100) then
                                                tween(v.Engine.CFrame * CFrame.new(0,35,0),350)
                                            end
                                            if plr:DistanceFromCharacter(v.WorldPivot.Position) <= 260 then
                                                tween(v.Engine.CFrame * CFrame.new(0,35,0),math.huge)
                                                FastAttack()
                                                getgenv().killBoat = true
                                            end
                                        else
                                            getgenv().killBoat = false
                                            if v:FindFirstChild('HumanoidRootPart') and v:FindFirstChild('Humanoid') and v.Humanoid.Health > 0 then
                                                if currenthp > (Options.AutoSeaEventsHighHealth.Value/100) then
                                                    tween(v.HumanoidRootPart.CFrame * CFrame.new(0, 45, 0),350)
                                                end
                                                if plr:DistanceFromCharacter(v.HumanoidRootPart.Position) <= 260 then
                                                    if (v.Name == "Terrorshark" and
                                                        v.HumanoidRootPart.StunObjects:FindFirstChild("ACTIVE")) or currenthp <= (Options.AutoSeaEventsLowHealth.Value/100) then
                                                        character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 200, 0)
                                                    elseif currenthp > 0.6 then
                                                        character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 35, -10)
                                                    end
                                                    FastAttack()
                                                end
                                            end
                                        end
                                    until not Options.AutoSeaEvents.Value or not v or not v.Parent or (function()
                                        if v.Name ~= 'PirateBrigade' and v.Name ~= 'PirateGrandBrigade' and v.Name ~= 'FishBoat' then
                                            if not v:FindFirstChild('Humanoid') or v.Humanoid.Health <= 0 then
                                                return true
                                            end
                                        end
                                        return false
                                    end)()
                                    local boat = checkboat()
                                    if boat then
                                        if (boat.VehicleSeat.CFrame.Position - character.HumanoidRootPart.Position).Magnitude < 200 then
                                            character.HumanoidRootPart.CFrame = boat.VehicleSeat.CFrame * CFrame.new(0, 1, 0)
                                        else
                                            tween(boat.VehicleSeat.CFrame * CFrame.new(0, 1, 0), 350)
                                        end
                                    end
                                end
                            end
                        end
                    else
                        if not character:FindFirstChild("Humanoid") or not character.Humanoid.Sit then
                            if tweensea then tweensea:Cancel() end
                            local boat = checkboat()
                            if boat then
                                if plr:DistanceFromCharacter(boat.VehicleSeat.CFrame.Position) <= 210 then
                                    character.HumanoidRootPart.CFrame = boat.VehicleSeat.CFrame * CFrame.new(0, 1, 0)
                                else
                                    tween(boat.VehicleSeat.CFrame * CFrame.new(0, 1, 0), 350)
                                end
                            end
                        else character.Humanoid.Sit = true
                            if checkseabeast() and (plr:DistanceFromCharacter(checkseabeast().WorldPivot.Position) <= 1800) then
                                TPB(character.HumanoidRootPart.CFrame * CFrame.new(150, 0, 0)).Completed:Wait()
                            else if checkboat().VehicleSeat.Position.Y < 130 then local e = checkboat().VehicleSeat.Position
                                TPB(CFrame.new(e.X, 130, e.Z)).Completed:Wait() end
                                TPB(CFrame.new(-40952, 130, -1324))
                            end
                        end
                    end
                end
            end)
        end
    end)
end)

task.spawn(function()
    while task.wait() do
        pcall(function()
            if Options.AutoSeaEvents.Value and (function() 
                for _,v in next,workspace.Enemies:GetChildren() do 
                    if plr:DistanceFromCharacter(v.WorldPivot.Position) <= 700 then
                        return true
                    end
                end 
                return false
            end)() and Options.ProtectBoat.Value then
                if checkboat() then
                    local center = character.HumanoidRootPart.Position
                    local steps = 36
                    local totalTime = 5
                    for i = 0, steps do
                        local angle = math.rad((360 / steps) * i)
                        local x = math.cos(angle) * Options.ProtectBoatRadius.Value
                        local z = math.sin(angle) * Options.ProtectBoatRadius.Value
                        checkboat():PivotTo(CFrame.lookAt(Vector3.new(center.X + x, center.Y + 120, center.Z + z), center))
                        task.wait(totalTime / steps)
                    end
                end
            end
        end)
    end
end)

task.spawn(function()
    while task.wait() do
        if Options.AutoSeaEvents.Value and getgenv().killBoat then
            waitUntilNoBusy()
            vim:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
            vim:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
            waitUntilNoBusy()
            vim:SendKeyEvent(true, Enum.KeyCode.X, false, game)
            vim:SendKeyEvent(false, Enum.KeyCode.X, false, game)
            waitUntilNoBusy()
            vim:SendKeyEvent(true, Enum.KeyCode.C, false, game)
            vim:SendKeyEvent(false, Enum.KeyCode.C, false, game)
            waitUntilNoBusy()
        end
    end
end)

Items_GetYama:OnChanged(function()
    task.spawn(function()
        StopTween()
        while task.wait() do
            pcall(function()
                if Options.GetYama.Value then
                    if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("EliteHunter", "Progress") >= 30 then
                        if Options.AutoEliteHunter.Value then
                            General_AutoFarm:SetValue(false)
                            Stack_AutoEliteHunter:SetValue(false)
                        end
                        repeat
                            task.wait()
                            fireclickdetector(workspace.Map.Waterfall.SealedKatana.Hitbox.ClickDetector)
                        until plr.Backpack:FindFirstChild("Yama") or not Options.GetYama.Value
                    else
                        if not Options.AutoEliteHunter.Value then
                            Stack_AutoEliteHunter:SetValue(true)
                            General_AutoFarm:SetValue(true)
                        end
                    end
                end
            end)
        end
    end)
end)

Items_GetTushita:OnChanged(function()
    task.spawn(function()
        if tw then StopTween() end
        while task.wait() and Options.GetTushita.Value do
            pcall(function()
                if not workspace.Map.Turtle:FindFirstChild("TushitaGate") then
                    if game.ReplicatedStorage:FindFirstChild('Longma') or workspace.Enemies:FindFirstChild('Longma') then
                        KillMonster('Longma')
                    end
                elseif (function()
                    for _,v in {workspace.Enemies,game.ReplicatedStorage} do
                        for _,v2 in next,v:GetChildren() do
                            if v2:IsA('Model') and v2:FindFirstChild('Humanoid') and v2.Humanoid.Health > 0 and v2.Name:find('indra') then
                                return true
                            end
                        end
                    end
                end)() then
                    if not character:FindFirstChild("Holy Torch") and not plr.Backpack:FindFirstChild('Holy Torch') then
                        tween(workspace.Map.Waterfall.SecretRoom.Room.Door.Door.Hitbox.CFrame,350).Completed:Wait()
                        task.wait(1)
                    else
                        for i = 1,5,1 do
                            equipTool('Holy Torch')
                            tween(workspace.Map.Turtle.QuestTorches['Torch'..tostring(i)].Particles.Main.Enabled,350).Completed:Wait()
                        end
                    end
                else
                    print('Auto find indra soon...')
                end
            end)
        end
    end)
end)

Items_GetSG:OnChanged(function()
    task.spawn(function()
        if tw then StopTween() end
        while task.wait() and game.PlaceId == sea3 and Options.GetSG.Value do
            pcall(function()
                if not game.ReplicatedStorage.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check") then
                    if game.Lighting.Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709149431" and (game.Lighting.ClockTime > 16 or game.Lighting.ClockTime < 5) then
                        if plr:DistanceFromCharacter(Vector3.new(-8654, 140, 6167)) > 50 then
                            tween(CFrame.new(-8654, 140, 6167),350).Completed:Wait()
                        end
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("gravestoneEvent", 2)
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("gravestoneEvent", 2, true)
                    end
                elseif game.ReplicatedStorage.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check").Swamp == false then
                    if (function()
                        local b = 0
                        for _,v in next,workspace.Enemies:GetChildren() do
                            if v.Name == 'Living Zombie' and v.Humanoid and v.Humanoid.Health > 0 then
                                b = b + 1
                            end
                        end
                        return b
                    end)() == 6 then
                        repeat
                            for _,v in next,workspace.Enemies:GetChildren() do
                                if v.Name == 'Living Zombie' and v.Humanoid and v.Humanoid.Health > 0 then
                                    repeat
                                        task.wait()
                                        tween(v.HumanoidRootPart.CFrame * CFrame.new(0,15,10),350)
                                        if plr:DistanceFromCharacter(v.HumanoidRootPart.CFrame.Position) <= 220 then
                                            tween(v.HumanoidRootPart.CFrame * CFrame.new(0,15,10),math.huge)
                                            if plr:DistanceFromCharacter(v.HumanoidRootPart.CFrame.Position) <= 40 then
                                                bringSG(v.Name)
                                                equipWeapon()
                                                FastAttack()
                                            end
                                        end
                                    until v.Humanoid.Health <= 0 or not Options.GetSG.Value or not v.HumanoidRootPart
                                end
                            end
                        until game.ReplicatedStorage.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check").Swamp or not Options.GetSG.Value or (function() 
                        local b = 0
                            for _,v in next,workspace.Enemies:GetChildren() do
                                if v.Name == 'Living Zombie' and v.Humanoid and v.Humanoid.Health > 0 then
                                    b = b + 1
                                end
                            end
                            return b
                        end)() == 0
                    end
                elseif game.ReplicatedStorage.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check").Gravestones == false then
                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Gravestones")
                elseif game.ReplicatedStorage.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check").Ghost == false then
                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer('GuitarPuzzleProgress','Ghost')
                elseif game.ReplicatedStorage.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check").Trophies == false then
                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Trophies")
                elseif game.ReplicatedStorage.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check").Pipes == false then
                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Pipes")
                elseif game.ReplicatedStorage.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check").CraftedOnce == false then
                    if plr.Data.Fragments.Value >= 5000 and GetMaterial('Bones') >= 500 and GetMaterial('Ectoplasm') >= 250 then
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("soulGuitarBuy")
                    end
                end
            end)
        end
    end)
end)

Farm_TweenToMirage:OnChanged(function()
    task.spawn(function()
        if tw then StopTween() end
        while task.wait() and game.PlaceId == sea3 do
            pcall(function()
                if Options.TweenToMirage.Value and game.PlaceId == sea3 then
                    if workspace.Map.MysticIsland and workspace.Map.MysticIsland:FindFirstChild("Center") then
                        local targetPos = workspace.Map.MysticIsland.Center.Position
                        tween(CFrame.new(targetPos.X, 500, targetPos.Z), 350).Completed:Wait()
                    end
                end
            end)
        end
    end)
end)

Farm_TweenToAdvancedDealer:OnChanged(function()
    task.spawn(function()
        if tw then StopTween() end
        while Options.TweenToAdvancedDealer.Value and task.wait() and game.PlaceId == sea3 do
            if workspace.Map.MysticIsland and workspace.Map.MysticIsland:FindFirstChild("Center") then
                for _,v in {workspace.NPCs,game.ReplicatedStorage.NPCs} do
                    for _,v2 in next,v:GetChildren() do
                        if v2.Name == 'Advanced Fruit Dealer' then
                            tween(v2.HumanoidRootPart.CFrame,350).Completed:Wait()
                            break
                        end
                    end
                end
            end
        end
    end)
end)
Farm_TweenToBlueGear:OnChanged(function()
    task.spawn(function()
        if tw then StopTween() end
        while task.wait() and game.PlaceId == sea3 and Options.TweenToBlueGear.Value do
            pcall(function()
                local MysticIsland = workspace.Map:FindFirstChild("MysticIsland")
                for _, v in next,MysticIsland:GetChildren() do
                    if v:IsA("MeshPart") and v.Material == Enum.Material.Neon then
                        tween(v.CFrame, 350).Completed:Wait()
                    end
                end
            end)
        end
    end)
end)
Farm_ActiveHelp:OnChanged(function()
    task.spawn(function()
        while task.wait() and game.PlaceId == sea3 and Options.ActiveHelp.Value do
            pcall(function()
                if Options.SelectHost.Value.HumanoidRootPart:FindFirstChildOfClass("ParticleEmitter") then
                    game.ReplicatedStorage.Remotes.CommE:FireServer("ActivateAbility")
                end
            end)
        end
    end)
end)

Farm_AutoCyborg:OnChanged(function()
    task.spawn(function()
        while task.wait() and Options.AutoCyborg.Value and plr.Data.Race.Value ~= 'Cyborg' do
            pcall(function()
                local q = game.ReplicatedStorage.Remotes.CommF_:InvokeServer('CyborgTrainer','Check')
                if q then
                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer('CyborgTrainer','Buy')
                else
                    if game.ReplicatedStorage.Modules.Net["RF/ReadPlayerData"]:InvokeServer().CyborgPart1 then
                        if character.Humanoid.Health >= 6000 then
                            if (plr.Backpack:FindFirstChild('Microchip') or character:FindFirstChild('Microchip')) and not checkBoss('Order') then
                                fireclickdetector(workspace.Map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
                                task.wait(1.5)
                            elseif checkBoss('Order') then
                                KillMonster('Order')
                            else
                                if plr.Data.Fragments.Value >= 1000 then
                                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BlackbeardReward", "Microchip", "2")
                                else
                                    Fluent:Notify({Title = "Radiant Hub 2.0 - Premium",Content = "Don't have enough fragments...",SubContent = "",Duration = 1.5})
                                    task.wait(0.5)
                                end
                            end
                        else
                            Fluent:Notify({Title = "Radiant Hub 2.0 - Premium",Content = "Need more HP...",SubContent = "",Duration = 1.5})
                        end
                    else
                        if (not character:FindFirstChild('Fist of Darkness') and not plr.Backpack:FindFirstChild('Fist of Darkness')) then
                            local c = tick()
                            repeat
                                if not Options.AutoChest.Value then
                                    OtherFarm_AutoChestReset:SetValue(10)
                                    OtherFarm_AutoChest:SetValue(true)
                                    OtherFarm_AutoChestStopItem:SetValue(true)
                                end
                                task.wait(1)
                            until character:FindFirstChild('Fist of Darkness') or plr.Backpack:FindFirstChild('Fist of Darkness') or ((tick() - c) >= 30)
                            OtherFarm_AutoChest:SetValue(false)
                            if (tick() - c) >= 30 and not plr.Backpack:FindFirstChild('Fist of Darkness') then
                                hopServer()
                                task.wait(10)
                            end
                            fireclickdetector(workspace.Map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
                        end
                    end
                end
            end)
        end
    end)
end)

Farm_AutoGhoul:OnChanged(function()
    task.spawn(function()
        while task.wait() and Options.AutoGhoul.Value and plr.Data.Race.Value ~= 'Ghoul' do
            pcall(function()
                if GetMaterial('Ectoplasm') >= 100 and (plr.Backpack:FindFirstChild('Hellfire Torch') or character:FindFirstChild('Hellfire Torch')) then
                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Ectoplasm","BuyCheck",4)
                    Fluent:Notify({Title = "Radiant Hub 2.0 - Premium",Content = "Unlocked Ghoul Race :D",SubContent = "",Duration = 1.5})
                elseif GetMaterial('Ectoplasm') < 100 then
                    repeat
                        if not Options.AutoFarmMaterial.Value or Options.SelectMaterial.Value ~= 'Ectoplasm' then
                            OtherFarm_SelectMaterial:SetValue('Ectoplasm')
                            OtherFarm_AutoFarmMaterial:SetValue(true)
                        end
                        task.wait(1)
                    until GetMaterial('Ectoplasm') >= 100 or not Options.AutoFarmMaterial.Value
                elseif not plr.Backpack:FindFirstChild('Hellfire Torch') and not character:FindFirstChild('Hellfire Torch') then
                    if checkBoss('Cursed Captain') then
                        KillMonster('Cursed Captain')
                    else
                        Fluent:Notify({Title = "Radiant Hub 2.0 - Premium",Content = "Wait for boss or hop :D",SubContent = "",Duration = 1.5})
                        task.wait(2.5)
                    end
                end
            end)
        end
    end)
end)

warn([[
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                                 
                     @@@%=.            ..:-==++++++===--===++*#%%@@@@@@@@@@@@                       
                   @@@#..          .-*-....       ........:-==+++**++++--*%@@@@@@@                  
                  @@%-         .:==....::--=++*****++=-::..........::::--=--:..+#@@@@@              
                @@@*.       .:=-..----..............      ..:::::..         .:   ..=%@@@            
                @@=       .==..:+:..=*::::.......+-.          ..-**=-:.:=*=..       .-@@            
               @@+.    .:+...-=..+-               .=.          ..          .#..      .=@@           
              @@*.        .=-.-=:       ...       .-:         .-=            :-.      =@@           
             @@%.         .  ...*#%%@@@@@@@@%##+.....         .=:            .:.      :%@@          
            @@@.            .=@@%-+@@@@@@@@...=@@@@-..        .-:...+@@@@@@@:.         =@@@         
         @@@@*-:---:.. .:--.=@#...-@@@@@@@*..   ..*@%.        .:+@@@@@+...-%@%.:=--:..  :%@@@@      
       @@@#++-........ ..:-#:%@@@@@%*+++*%@@@@#+. -@#.     .+#%@@@@@@@@@@@@%+: ......:-==.:=%@@     
     @@@%:+.  .#@@@@@@@@=.     ..    .#%=.   .=@@@@#:      ...*@+===::..             .++.:+. %@@    
    @@@-.-. .+@%-.   ..+%@@%*=------*@%=.       ...           *@-             ..-=*%#+-:.+.=:+@@    
    @@-.--  =@+.   .=#: ..:-=+*%@@@%*:                        +@=        .%##%@@@*===++: :- ++@@    
   @@#. =.  +@-    :@@@%-                                     .*@@#:.    ..:::...        :=.:+@@    
   @@*. -.  +@- -*@@@+.#@@*:..            ..=::%@@%-            .:#@#...         #@=.   .-:.*-@@    
    @%: :=  +@- =+%@@%:..-*@@%*=:.   :-----:. #@=..:==-..         :%@@@=         @@#.  :=.:=.#@@    
    @@#..-: -@-   .%@@%.   ..*@@@@@#+.        :@#.-@%#@@-.       :%@+*-.:++..  .#@@@%. .==..%@@     
     @@%..=.       .*@@@@#-:.*@@-.:+%%@@@#+-:....           .+:*@@#:       ..:*@@@*#@=..  :%@@      
      @@@=.-=--     .+@@@@@@@@@@#=:..  .-=*#@@@@%#*+=--:....-#@#-    ..:-=+%@@@++@@@@#.  .*@@       
        @@#:         .:@@=.:=%@@@@@@@%#+:. -@@@::-=+#%@@@@@@@@@@@@@@@@@@@@%-:@@%.+@@@%.  -@@        
         @@@#..        .*@%.:%@@@@@@@@@@@@@@@@:.      :@@-    :@@#     :%@@-.:@@:=@@@%.  +@@        
           @@@-         .-%@#%@::+#@@@@@@@@@@@@%*=::..:@@+    .*@#      =@@*:=@@@@@@@%.  *@@        
            @@@:          .-%@@.   ..:=%@@@@@@@@@@@@@@@@@%##*+*%@%#####%@@@@@@@@@@@@@%.  #@@        
             @@@=            -@@#:.     :%@%*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%.  #@@        
               @@*.            :#@@=:. .*@@:  ..=*#%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*.  *@@        
                @@%:             .-%@%*+@@:         -@@@=--==+%@@@@@@@@@@@*=@@%@@%=%@.   %@@        
                 @@@*.      ..     ..-@@@@-.       .+@@*.     +@@%...-@#.  =@@#@@@@@:   .@@@        
                   @@@+..+-:.-=:..      .+#@@@*-:...#@@-     .@@@.  .@@= ..*@@@@@#-.     %@@        
                     @@@#:..-==.--+..      ..-=#@@@@@@@+=-:..:@@-.:-+@@#%@@@%+-..        *@@        
                       @@@@+. ..-*:.:+*..        ..:::+#@@@@@@@@@@@@@#=::...     .       -@@        
                          @@@@-..  .=+::.-#-::..      ..::::::::::::::.       .:*.   :.  :%@        
                            @@@@%+:.   .-=:=:..==:-=-..................   ..=-=..    =:  .+@@       
                                @@@@%*.    ..::=*-....::::-=*###****##*=:::..     .==.   .+@@       
                                    @@@@@#:...    ..:+#+:.......         ......:*+..     :%@        
                                        @@@@@@*=-.        ...:-==++====++==-:..         .#@@        
                                            @@@@@@@%#*-.                              .-@@@         
                                                   @@@@@@@@%*-.....              ....+@@@           
                                                         @@@@@@@@@@%#+=--:..:--=*%@@@@@             
                                                                 @@@@@@@@@@@@@@@@@@ 
                                                Hands Up Skid XD
]])
warn("┌───────────────────────────────────────────────────")
warn("├─[ RADIANT HUB ] Total execution time: " .. math.floor((os.clock() - ScriptStartTime) * 100 + 0.5) / 100 .. " seconds")
warn("├─[ RADIANT HUB ] Total memory used: " .. math.abs(((collectgarbage("count") - OldMemory) / 1024)) .. " MB")
warn("└───────────────────────────────────────────────────")
