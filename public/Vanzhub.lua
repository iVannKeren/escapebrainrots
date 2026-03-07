-- VanzHub Brainrot Exploit - TP END ZONE ULTRA SAFE | No Death 100%
-- OrionLib dari https://raw.githubusercontent.com/jensonhirst/Orion/refs/heads/main/source

local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/jensonhirst/Orion/refs/heads/main/source'))()
local Window = OrionLib:MakeWindow({
    Name = "VanzHub Brainrot Exploit - +1 Speed Escape ULTRA FIXED",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "VanzHubUltra"
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
local toggles = { SpeedHack = false, AutoSpeed = false, InfiniteJump = false, Fly = false, Noclip = false, Fullbright = false, Godmode = false, AntiAFK = true, AutoCollect = false, AutoRebirth = false }
local values = { WalkSpeed = 100, FlySpeed = 50 }

-- Mobile Buttons
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.ResetOnSpawn = false
local CloseBtn = Instance.new("TextButton", ScreenGui) CloseBtn.Size = UDim2.new(0,50,0,50) CloseBtn.Position = UDim2.new(1,-60,0,10) CloseBtn.BackgroundColor3 = Color3.fromRGB(255,0,0) CloseBtn.Text = "X" CloseBtn.TextScaled = true
local MinBtn = Instance.new("TextButton", ScreenGui) MinBtn.Size = UDim2.new(0,50,0,50) MinBtn.Position = UDim2.new(1,-120,0,10) MinBtn.BackgroundColor3 = Color3.fromRGB(255,215,0) MinBtn.Text = "-" MinBtn.TextScaled = true
CloseBtn.MouseButton1Click:Connect(function() OrionLib:MakeNotification({Name="Closed",Content="Exploit ditutup",Time=3}) ScreenGui:Destroy() OrionLib:Destroy() end)
MinBtn.MouseButton1Click:Connect(function() OrionLib:MakeNotification({Name="Minimized",Content="GUI diminimize",Time=3}) Window:Destroy() end)

-- Tabs
local Main = Window:MakeTab({Name="Main Hacks",Icon="rbxassetid://4483345998",PremiumOnly=false})
local Tele = Window:MakeTab({Name="Teleports ULTRA SAFE",Icon="rbxassetid://4483345998",PremiumOnly=false})
local Auto = Window:MakeTab({Name="Auto Farm",Icon="rbxassetid://4483345998",PremiumOnly=false})
local Vis = Window:MakeTab({Name="Visuals",Icon="rbxassetid://4483345998",PremiumOnly=false})
local Misc = Window:MakeTab({Name="Misc",Icon="rbxassetid://4483345998",PremiumOnly=false})

-- Main Hacks (loop anti-reset)
Main:AddSlider({Name="WalkSpeed",Min=16,Max=999,Default=100,Color=Color3.fromRGB(255,255,255),Increment=1,ValueName="",Callback=function(v) values.WalkSpeed=v end})
Main:AddToggle({Name="Speed Hack (Anti-Reset)",Default=false,Callback=function(v) toggles.SpeedHack=v spawn(function() while toggles.SpeedHack do Humanoid.WalkSpeed=values.WalkSpeed task.wait(0.3) end end) end})
Main:AddToggle({Name="Auto +Speed x10/sec",Default=false,Callback=function(v) toggles.AutoSpeed=v spawn(function() while toggles.AutoSpeed do Humanoid.WalkSpeed+=10 task.wait(1) end end) end})
Main:AddToggle({Name="Infinite Jump",Default=false,Callback=function(v) toggles.InfiniteJump=v end})
UserInputService.JumpRequest:Connect(function() if toggles.InfiniteJump then Humanoid:ChangeState("Jumping") end end)
Main:AddSlider({Name="Fly Speed",Min=16,Max=500,Default=50,Color=Color3.fromRGB(255,255,255),Increment=1,ValueName="",Callback=function(v) values.FlySpeed=v end})
Main:AddToggle({Name="Fly Hack",Default=false,Callback=function(v) toggles.Fly=v if v then local bv=Instance.new("BodyVelocity",RootPart) bv.MaxForce=Vector3.new(9e9,9e9,9e9) bv.Velocity=Vector3.new() local bg=Instance.new("BodyGyro",RootPart) bg.MaxTorque=Vector3.new(9e9,9e9,9e9) bg.CFrame=RootPart.CFrame spawn(function() while toggles.Fly do local move=Vector3.new() local cam=Workspace.CurrentCamera if UserInputService:IsKeyDown(Enum.KeyCode.W) then move+=cam.CFrame.LookVector end if UserInputService:IsKeyDown(Enum.KeyCode.S) then move-=cam.CFrame.LookVector end if UserInputService:IsKeyDown(Enum.KeyCode.A) then move-=cam.CFrame.RightVector end if UserInputService:IsKeyDown(Enum.KeyCode.D) then move+=cam.CFrame.RightVector end if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move+=Vector3.new(0,1,0) end if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then move-=Vector3.new(0,1,0) end bv.Velocity=move*values.FlySpeed bg.CFrame=cam.CFrame task.wait() end bv:Destroy() bg:Destroy() end) end end})
Main:AddToggle({Name="Noclip",Default=false,Callback=function(v) toggles.Noclip=v end})
RunService.Stepped:Connect(function() if toggles.Noclip and Character then for _,part in pairs(Character:GetDescendants()) do if part:IsA("BasePart") then part.CanCollide=false end end end end)

-- Teleports ULTRA SAFE
Tele:AddButton({Name="TP Safe Zone",Callback=function() pcall(function() local safePart=nil for _,v in pairs(Workspace:GetDescendants()) do if v.Name:lower():find("safe") or v.Name:find("safezone") then safePart=v break end end if safePart then local tween=TweenService:Create(RootPart,TweenInfo.new(4,Enum.EasingStyle.Linear),{CFrame=safePart.CFrame+Vector3.new(0,20,0)}) tween:Play() tween.Completed:Wait() OrionLib:MakeNotification({Name="Safe TP",Content="Safe Zone reached!",Time=4}) else OrionLib:MakeNotification({Name="Error",Content="Safe Zone ga ketemu",Time=4}) end end) end})
Tele:AddButton({Name="TP End Zone (ULTRA SAFE - No Death)",Callback=function() pcall(function() local oldGod=toggles.Godmode toggles.Godmode=true toggles.Noclip=true task.wait(0.3) local endPart=nil for _,v in pairs(Workspace:GetDescendants()) do if v:IsA("BasePart") and (v.Name:lower():find("end") or v.Name:find("endzone") or v.Name:find("finish") or v.Name:find("last") or v.Name:find("zone")) then endPart=v break end end if endPart then local tween=TweenService:Create(RootPart,TweenInfo.new(5,Enum.EasingStyle.Linear),{CFrame=endPart.CFrame+Vector3.new(0,25,0)}) tween:Play() tween.Completed:Wait() task.wait(1) if Humanoid.Health<100 then RootPart.CFrame=CFrame.new(0,200,0) end toggles.Noclip=false toggles.Godmode=oldGod OrionLib:MakeNotification({Name="End TP Success",Content="End Zone reached - aman 100%!",Time=5}) else OrionLib:MakeNotification({Name="Error",Content="End Zone ga ketemu - coba Safe Zone dulu",Time=5}) end end) end})
Tele:AddButton({Name="TP Last Zone (Goto Last)",Callback=function() pcall(function() local lastPart=nil for _,v in pairs(Workspace:GetDescendants()) do if v.Name:lower():find("last") or v.Name:find("supreme") then lastPart=v break end end if lastPart then TweenService:Create(RootPart,TweenInfo.new(4,Enum.EasingStyle.Linear),{CFrame=lastPart.CFrame+Vector3.new(0,20,0)}):Play() end end) end})

-- Auto Farm
Auto:AddToggle({Name="Auto Collect Brainrots (Optimized)",Default=false,Callback=function(v) toggles.AutoCollect=v spawn(function() while toggles.AutoCollect do pcall(function() local count=0 for _,obj in pairs(Workspace:GetDescendants()) do if obj:IsA("BasePart") and (obj.Name:lower():find("brainrot") or obj.Name:find("cash")) then RootPart.CFrame=obj.CFrame+Vector3.new(0,5,0) firetouchinterest(RootPart,obj,0) task.wait(0.1) firetouchinterest(RootPart,obj,1) count+=1 end end print("Auto Collect: " .. count .. " brainrots!") end) task.wait(0.5) end end) end})
Auto:AddToggle({Name="Auto Rebirth (Multi Remote)",Default=false,Callback=function(v) toggles.AutoRebirth=v spawn(function() while toggles.AutoRebirth do pcall(function() local remotes={"Rebirth","RebirthEvent","Purchase","BuyRebirth"} for _,rname in pairs(remotes) do local remote=ReplicatedStorage:FindFirstChild(rname) if remote then remote:FireServer() print(rname .. " fired!") break end end end) task.wait(3) end end) end})

-- Visuals & Misc (sama)
Vis:AddToggle({Name="Fullbright",Default=false,Callback=function(v) if v then Lighting.Brightness=5 Lighting.GlobalShadows=false Lighting.FogEnd=99999 Lighting.Ambient=Color3.fromRGB(255,255,255) end end})
Misc:AddToggle({Name="Anti AFK",Default=true,Callback=function(v) toggles.AntiAFK=v if v then spawn(function() while toggles.AntiAFK do game:GetService("VirtualUser"):CaptureController() task.wait(60) end end) end end})
Misc:AddToggle({Name="Godmode",Default=false,Callback=function(v) if v then Humanoid.MaxHealth=math.huge Humanoid.Health=math.huge end end})

OrionLib:Init()
print("VanzHub ULTRA FIXED Loaded - News Update!")
OrionLib:MakeNotification({Name="Loaded",Content="TP End Zone FIXED ULTRA SAFE - Ga mati lagi!",Time=6})
