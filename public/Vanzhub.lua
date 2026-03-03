-- Brainrot SC Loaded - Mobile Ready - Fuck the servers! by VanzHub
-- Semua HttpGet & loadstring di-wrap pcall biar tahan 404/error

local success, err = pcall(function()
    local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua", true))()
    if not Library then error("Kavo UI gagal load") end

    local Window = Library.CreateLib("VanzHub Brainrot Exploit - +1 Speed Escape", "DarkTheme")

    -- Services
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Workspace = game:GetService("Workspace")
    local LocalPlayer = Players.LocalPlayer
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local Humanoid = Character:WaitForChild("Humanoid")
    local RootPart = Character:WaitForChild("HumanoidRootPart")

    -- Vars & Toggles
    getgenv().Settings = getgenv().Settings or {}
    local toggles = {
        SpeedHack = false,
        AutoSpeed = false,
        InfiniteJump = false,
        Fly = false,
        Noclip = false,
        Fullbright = false,
        Godmode = false,
        AntiKick = true,
        AutoFarm = false,
        AutoRebirth = false,
        ESP = false
    }
    local values = {
        WalkSpeed = 100,
        FlySpeed = 50
    }

    -- Mobile Buttons (pojok kanan atas)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = game:GetService("CoreGui")
    ScreenGui.ResetOnSpawn = false

    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 60, 0, 60)
    CloseBtn.Position = UDim2.new(1, -70, 0, 10)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    CloseBtn.Text = "X"
    CloseBtn.TextColor3 = Color3.new(1,1,1)
    CloseBtn.TextScaled = true
    CloseBtn.Font = Enum.Font.SourceSansBold
    CloseBtn.Parent = ScreenGui
    CloseBtn.Visible = false

    local MinBtn = Instance.new("TextButton")
    MinBtn.Size = UDim2.new(0, 60, 0, 60)
    MinBtn.Position = UDim2.new(1, -140, 0, 10)
    MinBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 0)
    MinBtn.Text = "-"
    MinBtn.TextColor3 = Color3.new(0,0,0)
    MinBtn.TextScaled = true
    MinBtn.Font = Enum.Font.SourceSansBold
    MinBtn.Parent = ScreenGui
    MinBtn.Visible = false

    local FloatIcon = Instance.new("TextButton")
    FloatIcon.Size = UDim2.new(0, 50, 0, 50)
    FloatIcon.Position = UDim2.new(0.5, -25, 0.1, 0)
    FloatIcon.BackgroundTransparency = 0.4
    FloatIcon.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
    FloatIcon.Text = "BR"
    FloatIcon.TextScaled = true
    FloatIcon.Parent = ScreenGui
    FloatIcon.Visible = false
    FloatIcon.Draggable = true

    -- Toggle GUI
    local function toggleGUI(visible)
        pcall(function()
            if visible then
                Window:ToggleUI(true)
                CloseBtn.Visible = true
                MinBtn.Visible = true
                FloatIcon.Visible = false
            else
                Window:ToggleUI(false)
                CloseBtn.Visible = false
                MinBtn.Visible = false
                FloatIcon.Visible = true
            end
        end)
    end

    CloseBtn.MouseButton1Click:Connect(function()
        pcall(function()
            ScreenGui:Destroy()
            Library:ToggleUI(false)
        end)
    end)

    MinBtn.MouseButton1Click:Connect(function()
        toggleGUI(false)
    end)

    FloatIcon.MouseButton1Click:Connect(function()
        toggleGUI(true)
    end)

    -- Keybinds PC
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.Insert or input.KeyCode == Enum.KeyCode.E then
            toggleGUI(not Window.UI.Visible)
        end
    end)

    if UserInputService.TouchEnabled then
        toggleGUI(true)
    end

    -- Tabs
    local MainTab = Window:NewTab("Main Hacks")
    local TeleTab = Window:NewTab("Teleports")
    local AutoTab = Window:NewTab("Auto Farm")
    local VisTab = Window:NewTab("Visuals")
    local MiscTab = Window:NewTab("Misc")

    -- Main Hacks
    MainTab:NewSlider("WalkSpeed", "Set WalkSpeed", 999, 16, function(v)
        values.WalkSpeed = v
        if toggles.SpeedHack then
            pcall(function() Humanoid.WalkSpeed = v end)
        end
    end)

    MainTab:NewToggle("Speed Hack", "Enable custom speed", function(state)
        toggles.SpeedHack = state
        pcall(function() Humanoid.WalkSpeed = state and values.WalkSpeed or 16 end)
    end)

    MainTab:NewToggle("Auto +1 Speed x10/sec", "Spam speed gain", function(state)
        toggles.AutoSpeed = state
        spawn(function()
            while toggles.AutoSpeed do
                pcall(function()
                    Humanoid.WalkSpeed = Humanoid.WalkSpeed + 10
                end)
                task.wait(1)
            end
        end)
    end)

    MainTab:NewToggle("Infinite Jump", "Jump tanpa batas", function(state)
        toggles.InfiniteJump = state
    end)

    UserInputService.JumpRequest:Connect(function()
        if toggles.InfiniteJump then
            pcall(function() Humanoid:ChangeState("Jumping") end)
        end
    end)

    MainTab:NewSlider("Fly Speed", "Fly hack speed", 500, 16, function(v) values.FlySpeed = v end)

    MainTab:NewToggle("Fly Hack", "Terbang bebas", function(state)
        toggles.Fly = state
        if state then
            local bv = Instance.new("BodyVelocity", RootPart)
            bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
            bv.Velocity = Vector3.new()
            local bg = Instance.new("BodyGyro", RootPart)
            bg.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
            bg.CFrame = RootPart.CFrame

            spawn(function()
                while toggles.Fly and RootPart do
                    pcall(function()
                        local cam = Workspace.CurrentCamera
                        local move = Vector3.new()
                        if UserInputService:IsKeyDown(Enum.KeyCode.W) then move += cam.CFrame.LookVector end
                        if UserInputService:IsKeyDown(Enum.KeyCode.S) then move -= cam.CFrame.LookVector end
                        if UserInputService:IsKeyDown(Enum.KeyCode.A) then move -= cam.CFrame.RightVector end
                        if UserInputService:IsKeyDown(Enum.KeyCode.D) then move += cam.CFrame.RightVector end
                        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0,1,0) end
                        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then move -= Vector3.new(0,1,0) end
                        bv.Velocity = move * values.FlySpeed
                        bg.CFrame = cam.CFrame
                    end)
                    task.wait()
                end
                bv:Destroy()
                bg:Destroy()
            end)
        end
    end)

    MainTab:NewToggle("Noclip", "Lewat tembok", function(state)
        toggles.Noclip = state
    end)

    RunService.Stepped:Connect(function()
        if toggles.Noclip and Character then
            for _, part in pairs(Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    pcall(function() part.CanCollide = false end)
                end
            end
        end
    end)

    -- Teleports (contoh sederhana, tambah lebih banyak kalau tahu nama part)
    TeleTab:NewButton("TP to Spawn", "", function()
        pcall(function() RootPart.CFrame = Workspace.SpawnLocation.CFrame + Vector3.new(0,5,0) end)
    end)

    TeleTab:NewButton("TP to End Zone", "", function()
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("BasePart") and (v.Name:lower():find("end") or v.Name:find("finish")) then
                pcall(function() RootPart.CFrame = v.CFrame + Vector3.new(0,5,0) end)
                break
            end
        end
    end)

    -- Auto Farm
    AutoTab:NewToggle("Auto Collect Brainrots/Cash", "Ambil semua otomatis", function(state)
        toggles.AutoFarm = state
        spawn(function()
            while toggles.AutoFarm do
                pcall(function()
                    for _, obj in pairs(Workspace:GetDescendants()) do
                        if obj:IsA("BasePart") and (obj.Name:lower():find("brainrot") or obj.Name:find("cash") or obj.Name:find("coin")) then
                            RootPart.CFrame = obj.CFrame
                            firetouchinterest(RootPart, obj, 0)
                            task.wait(0.05)
                            firetouchinterest(RootPart, obj, 1)
                        end
                    end
                end)
                task.wait(0.3)
            end
        end)
    end)

    AutoTab:NewToggle("Auto Rebirth / Buy Upgrades", "Rebirth & upgrade otomatis", function(state)
        toggles.AutoRebirth = state
        spawn(function()
            while toggles.AutoRebirth do
                pcall(function()
                    if ReplicatedStorage:FindFirstChild("Rebirth") then
                        ReplicatedStorage.Rebirth:FireServer()
                    end
                    if ReplicatedStorage:FindFirstChild("Purchase") then
                        ReplicatedStorage.Purchase:FireServer("Speed")
                    end
                end)
                task.wait(2)
            end
        end)
    end)

    -- Visuals
    VisTab:NewToggle("Fullbright", "Terang maksimal", function(state)
        toggles.Fullbright = state
        if state then
            pcall(function()
                game.Lighting.Brightness = 5
                game.Lighting.GlobalShadows = false
                game.Lighting.FogEnd = 99999
                game.Lighting.Ambient = Color3.fromRGB(255,255,255)
            end)
        end
    end)

    -- Misc
    MiscTab:NewToggle("Anti Kick / Anti AFK", "", function(state)
        toggles.AntiKick = state
        if state then
            spawn(function()
                while toggles.AntiKick do
                    pcall(function()
                        game:GetService("VirtualUser"):Button2Down(Vector2.new())
                        task.wait(1)
                        game:GetService("VirtualUser"):Button2Up(Vector2.new())
                    end)
                    task.wait(60)
                end
            end)
        end
    end)

    MiscTab:NewToggle("Godmode", "No damage", function(state)
        toggles.Godmode = state
        if state then
            pcall(function()
                Humanoid.MaxHealth = math.huge
                Humanoid.Health = math.huge
            end)
        end
    end)

    print("Brainrot SC Loaded - Mobile Ready - Fuck the servers!")
end)

if not success then
    warn("Script gagal load total: " .. tostring(err))
    warn("Coba cek koneksi atau URL HttpGet (mungkin 404 atau Byfron block)")
end
