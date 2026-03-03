-- VanzHub Brainrot Exploit - FIXED & OPTIMIZED | Work di Delta/Hydrogen 2026
-- OrionLib dari https://raw.githubusercontent.com/jensonhirst/Orion/refs/heads/main/source

local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/jensonhirst/Orion/refs/heads/main/source'))()
local Window = OrionLib:MakeWindow({
    Name = "VanzHub Brainrot Exploit - FIXED",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "VanzHubFixed"
})

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
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
    AutoCollect = false,
    AutoRebirth = false
}
local values = {
    WalkSpeed = 100,
    FlySpeed = 50
}

-- Mobile Buttons
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.ResetOnSpawn = false

local CloseBtn = Instance.new("TextButton", ScreenGui)
CloseBtn.Size = UDim2.new(0, 50, 0, 50)
CloseBtn.Position = UDim2.new(1, -60, 0, 10)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseBtn.Text = "X"
CloseBtn.TextScaled = true

local MinBtn = Instance.new("TextButton", ScreenGui)
MinBtn.Size = UDim2.new(0, 50, 0, 50)
MinBtn.Position = UDim2.new(1, -120, 0, 10)
MinBtn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
MinBtn.Text = "-"
MinBtn.TextScaled = true

CloseBtn.MouseButton1Click:Connect(function()
    OrionLib:MakeNotification({Name = "Closed", Content = "Exploit ditutup", Time = 3})
    ScreenGui:Destroy()
    OrionLib:Destroy()
end)

MinBtn.MouseButton1Click:Connect(function()
    OrionLib:MakeNotification({Name = "Minimized", Content = "GUI diminimize", Time = 3})
    Window:Destroy()
end)

-- Tabs
local Main = Window:MakeTab({Name = "Main Hacks", Icon = "rbxassetid://4483345998", PremiumOnly = false})
local Tele = Window:MakeTab({Name = "Teleports FIXED", Icon = "rbxassetid://4483345998", PremiumOnly = false})
local Auto = Window:MakeTab({Name = "Auto Farm FIXED", Icon = "rbxassetid://4483345998", PremiumOnly = false})
local Vis = Window:MakeTab({Name = "Visuals", Icon = "rbxassetid://4483345998", PremiumOnly = false})
local Misc = Window:MakeTab({Name = "Misc", Icon = "rbxassetid://4483345998", PremiumOnly = false})

-- Main Hacks (loop WalkSpeed biar ga di-reset server)
Main:AddSlider({Name = "WalkSpeed", Min = 16, Max = 999, Default = 100, Color = Color3.fromRGB(255,255,255), Increment = 1, ValueName = "", Callback = function(v) values.WalkSpeed = v end})
Main:AddToggle({Name = "Speed Hack (Loop Anti-Reset)", Default = false, Callback = function(v)
    toggles.SpeedHack = v
    spawn(function()
        while toggles.SpeedHack do
            if Humanoid.WalkSpeed < values.WalkSpeed then
                Humanoid.WalkSpeed = values.WalkSpeed
            end
            task.wait(0.5)
        end
    end)
end})
Main:AddToggle({Name = "Auto +Speed x10/sec", Default = false, Callback = function(v)
    toggles.AutoSpeed = v
    spawn(function()
        while toggles.AutoSpeed do
            Humanoid.WalkSpeed = Humanoid.WalkSpeed + 10
            task.wait(1)
        end
    end)
end})
Main:AddToggle({Name = "Infinite Jump", Default = false, Callback = function(v) toggles.InfiniteJump = v end})
UserInputService.JumpRequest:Connect(function() if toggles.InfiniteJump then Humanoid:ChangeState("Jumping") end end)
Main:AddSlider({Name = "Fly Speed", Min = 16, Max = 500, Default = 50, Color = Color3.fromRGB(255,255,255), Increment = 1, ValueName = "", Callback = function(v) values.FlySpeed = v end})
Main:AddToggle({Name = "Fly Hack", Default = false, Callback = function(v)
    toggles.Fly = v
    if v then
        local bv = Instance.new("BodyVelocity", RootPart) bv.MaxForce = Vector3.new(9e9,9e9,9e9) bv.Velocity = Vector3.new()
        local bg = Instance.new("BodyGyro", RootPart) bg.MaxTorque = Vector3.new(9e9,9e9,9e9) bg.CFrame = RootPart.CFrame
        spawn(function()
            while toggles.Fly do
                local move = Vector3.new()
                local cam = Workspace.CurrentCamera
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then move += cam.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then move -= cam.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then move -= cam.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then move += cam.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0,1,0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then move -= Vector3.new(0,1,0) end
                bv.Velocity = move * values.FlySpeed
                bg.CFrame = cam.CFrame
                task.wait()
            end
            bv:Destroy() bg:Destroy()
        end)
    end
end})
Main:AddToggle({Name = "Noclip", Default = false, Callback = function(v) toggles.Noclip = v end})
RunService.Stepped:Connect(function()
    if toggles.Noclip and Character then
        for _, part in pairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

-- Teleports FIXED (tween lambat + offset tinggi + noclip auto)
Tele:AddButton({Name = "TP to Spawn", Callback = function()
    pcall(function()
        local tween = TweenService:Create(RootPart, TweenInfo.new(1, Enum.EasingStyle.Linear), {CFrame = Workspace.SpawnLocation.CFrame + Vector3.new(0,5,0)})
        tween:Play()
    end)
end})

Tele:AddButton({Name = "TP to End Zone (FIXED - Safe)", Callback = function()
    pcall(function()
        toggles.Noclip = true
        task.wait(0.2)
        local endPart = nil
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("BasePart") and (v.Name:lower():find("end") or v.Name:find("finish") or v.Name:find("exit") or v.Name:find("zone") or v.Name:find("safe")) then
                endPart = v
                break
            end
        end
        if endPart then
            local tween = TweenService:Create(RootPart, TweenInfo.new(3, Enum.EasingStyle.Linear), {CFrame = endPart.CFrame + Vector3.new(0,15,0)})
            tween:Play()
            tween.Completed:Wait()
            toggles.Noclip = false
            OrionLib:MakeNotification({Name = "Success", Content = "TP to End Zone selesai - aman!", Time = 5})
        else
            OrionLib:MakeNotification({Name = "Error", Content = "End Zone ga ketemu, coba inspect Workspace", Time = 5})
        end
    end)
end})

-- Auto Farm (loop lebih ringan + debug)
Auto:AddToggle({Name = "Auto Collect Brainrots/Cash", Default = false, Callback = function(v)
    toggles.AutoCollect = v
    spawn(function()
        while toggles.AutoCollect do
            pcall(function()
                local count = 0
                for _, obj in pairs(Workspace:GetDescendants()) do
                    if obj:IsA("BasePart") and (obj.Name:lower():find("brainrot") or obj.Name:find("cash") or obj.Name:find("coin")) then
                        RootPart.CFrame = obj.CFrame + Vector3.new(0,3,0)
                        firetouchinterest(RootPart, obj, 0)
                        task.wait(0.1)
                        firetouchinterest(RootPart, obj, 1)
                        count += 1
                    end
                end
                if count > 0 then print("Collected " .. count .. " items!") end
            end)
            task.wait(0.4)
        end
    end)
end})

Auto:AddToggle({Name = "Auto Rebirth", Default = false, Callback = function(v)
    toggles.AutoRebirth = v
    spawn(function()
        while toggles.AutoRebirth do
            pcall(function()
                local rebirthRemote = ReplicatedStorage:FindFirstChild("Rebirth") or ReplicatedStorage:FindFirstChild("RebirthEvent") or ReplicatedStorage:FindFirstChild("Purchase") -- tambah variasi nama
                if rebirthRemote then
                    rebirthRemote:FireServer()
                    print("Rebirth fired!")
                else
                    print("Rebirth remote ga ketemu - inspect ReplicatedStorage")
                end
            end)
            task.wait(3)
        end
    end)
end})

-- Visuals
Vis:AddToggle({Name = "Fullbright", Default = false, Callback = function(v)
    if v then
        Lighting.Brightness = 5
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 99999
        Lighting.Ambient = Color3.fromRGB(255,255,255)
    end
end})

-- Misc
Misc:AddToggle({Name = "Anti AFK", Default = true, Callback = function(v)
    toggles.AntiAFK = v
    if v then
        spawn(function()
            while toggles.AntiAFK do
                game:GetService("VirtualUser"):CaptureController()
                task.wait(60)
            end
        end)
    end
end})

Misc:AddToggle({Name = "Godmode", Default = false, Callback = function(v)
    if v then
        Humanoid.MaxHealth = math.huge
        Humanoid.Health = math.huge
    end
end})

OrionLib:Init()
print("VanzHub FIXED Loaded - Cek console untuk debug (apa yang work/gagal)")
OrionLib:MakeNotification({Name = "Loaded", Content = "Fitur FIXED - Cek console untuk info remote/collect", Time = 5})
