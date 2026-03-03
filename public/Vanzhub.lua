-- VanzHub Brainrot Exploit - +1 Speed Escape | Mobile Ready - Fuck the servers!
-- OrionLib dari https://raw.githubusercontent.com/jensonhirst/Orion/refs/heads/main/source

local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/jensonhirst/Orion/refs/heads/main/source'))()
local Window = OrionLib:MakeWindow({
    Name = "VanzHub Brainrot Exploit - +1 Speed Escape",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "VanzHubBrainrot"
})

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- Toggles & Values
local toggles = {
    SpeedHack = false,
    AutoSpeed = false,
    InfiniteJump = false,
    Fly = false,
    Noclip = false,
    Fullbright = false,
    Godmode = false,
    AntiAFK = true,
    AutoFarm = false,
    AutoRebirth = false
}
local values = {
    WalkSpeed = 100,
    FlySpeed = 50
}

-- Mobile Close/Minimize Buttons (pojok kanan atas)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 50, 0, 50)
CloseBtn.Position = UDim2.new(1, -60, 0, 10)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseBtn.Text = "X"
CloseBtn.TextScaled = true
CloseBtn.Parent = ScreenGui

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 50, 0, 50)
MinBtn.Position = UDim2.new(1, -120, 0, 10)
MinBtn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
MinBtn.Text = "-"
MinBtn.TextScaled = true
MinBtn.Parent = ScreenGui

CloseBtn.MouseButton1Click:Connect(function()
    OrionLib:MakeNotification({Name = "Closed", Content = "Exploit ditutup", Time = 3})
    ScreenGui:Destroy()
    OrionLib:Destroy()
end)

MinBtn.MouseButton1Click:Connect(function()
    OrionLib:MakeNotification({Name = "Minimized", Content = "GUI diminimize, execute ulang kalau mau buka lagi", Time = 3})
    Window:Destroy()
end)

-- Tabs
local Main = Window:MakeTab({Name = "Main Hacks", Icon = "rbxassetid://4483345998", PremiumOnly = false})
local Tele = Window:MakeTab({Name = "Teleports", Icon = "rbxassetid://4483345998", PremiumOnly = false})
local Auto = Window:MakeTab({Name = "Auto Farm", Icon = "rbxassetid://4483345998", PremiumOnly = false})
local Vis = Window:MakeTab({Name = "Visuals", Icon = "rbxassetid://4483345998", PremiumOnly = false})
local Misc = Window:MakeTab({Name = "Misc", Icon = "rbxassetid://4483345998", PremiumOnly = false})

-- Main Hacks
Main:AddSlider({Name = "WalkSpeed", Min = 16, Max = 999, Default = 100, Color = Color3.fromRGB(255,255,255), Increment = 1, ValueName = "", Callback = function(Value) values.WalkSpeed = Value if toggles.SpeedHack then Humanoid.WalkSpeed = Value end end})
Main:AddToggle({Name = "Speed Hack", Default = false, Callback = function(Value) toggles.SpeedHack = Value Humanoid.WalkSpeed = Value and values.WalkSpeed or 16 end})
Main:AddToggle({Name = "Auto +Speed x10/sec", Default = false, Callback = function(Value) toggles.AutoSpeed = Value spawn(function() while toggles.AutoSpeed do Humanoid.WalkSpeed = Humanoid.WalkSpeed + 10 task.wait(1) end end) end})
Main:AddToggle({Name = "Infinite Jump", Default = false, Callback = function(Value) toggles.InfiniteJump = Value end})
UserInputService.JumpRequest:Connect(function() if toggles.InfiniteJump then Humanoid:ChangeState("Jumping") end end)
Main:AddSlider({Name = "Fly Speed", Min = 16, Max = 500, Default = 50, Color = Color3.fromRGB(255,255,255), Increment = 1, ValueName = "", Callback = function(Value) values.FlySpeed = Value end})
Main:AddToggle({Name = "Fly Hack", Default = false, Callback = function(Value)
    toggles.Fly = Value
    if Value then
        local bv = Instance.new("BodyVelocity", RootPart) bv.MaxForce = Vector3.new(9e9,9e9,9e9) bv.Velocity = Vector3.new()
        local bg = Instance.new("BodyGyro", RootPart) bg.MaxTorque = Vector3.new(9e9,9e9,9e9) bg.CFrame = RootPart.CFrame
        spawn(function()
            while toggles.Fly do
                local move = Vector3.new()
                local cam = Workspace.CurrentCamera
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + cam.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - cam.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - cam.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + cam.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0,1,0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then move = move - Vector3.new(0,1,0) end
                bv.Velocity = move * values.FlySpeed
                bg.CFrame = cam.CFrame
                task.wait()
            end
            bv:Destroy() bg:Destroy()
        end)
    end
end})
Main:AddToggle({Name = "Noclip", Default = false, Callback = function(Value) toggles.Noclip = Value end})
RunService.Stepped:Connect(function()
    if toggles.Noclip and Character then
        for _, part in pairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

-- Teleports
Tele:AddButton({Name = "TP to Spawn", Callback = function() RootPart.CFrame = Workspace.SpawnLocation.CFrame + Vector3.new(0,5,0) end})
Tele:AddButton({Name = "TP to End Zone", Callback = function()
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("BasePart") and (v.Name:lower():find("end") or v.Name:find("finish") or v.Name:find("exit")) then
            RootPart.CFrame = v.CFrame + Vector3.new(0,5,0)
            break
        end
    end
end})

-- Auto Farm
Auto:AddToggle({Name = "Auto Collect Brainrots/Cash", Default = false, Callback = function(Value)
    toggles.AutoFarm = Value
    spawn(function()
        while toggles.AutoFarm do
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj:IsA("BasePart") and (obj.Name:lower():find("brainrot") or obj.Name:find("cash") or obj.Name:find("coin")) then
                    RootPart.CFrame = obj.CFrame
                    firetouchinterest(RootPart, obj, 0) task.wait(0.05) firetouchinterest(RootPart, obj, 1)
                end
            end
            task.wait(0.3)
        end
    end)
end})
Auto:AddToggle({Name = "Auto Rebirth", Default = false, Callback = function(Value)
    toggles.AutoRebirth = Value
    spawn(function()
        while toggles.AutoRebirth do
            pcall(function()
                if ReplicatedStorage:FindFirstChild("Rebirth") then ReplicatedStorage.Rebirth:FireServer() end
            end)
            task.wait(2)
        end
    end)
end})

-- Visuals
Vis:AddToggle({Name = "Fullbright", Default = false, Callback = function(Value)
    if Value then
        Lighting.Brightness = 5
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 99999
        Lighting.Ambient = Color3.fromRGB(255,255,255)
    end
end})

-- Misc
Misc:AddToggle({Name = "Anti AFK", Default = true, Callback = function(Value)
    toggles.AntiAFK = Value
    if Value then
        spawn(function()
            while toggles.AntiAFK do
                game:GetService("VirtualUser"):CaptureController()
                task.wait(60)
            end
        end)
    end
end})
Misc:AddToggle({Name = "Godmode", Default = false, Callback = function(Value)
    if Value then
        Humanoid.MaxHealth = math.huge
        Humanoid.Health = math.huge
    end
end})

OrionLib:Init()
print("VanzHub Brainrot Exploit Loaded - Orion jensonhirst fork work!")
