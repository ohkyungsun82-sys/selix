local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

local Library = {}

function Library:CreateWindow(config)
    local titleText = config.Title or "UI Library"
    local themeColor = config.ThemeColor or Color3.fromRGB(255, 50, 50)
    local introText = config.IntroText or titleText
    local enableIntro = config.Intro
    if enableIntro == nil then enableIntro = true end
    
    local gui = Instance.new("ScreenGui")
    gui.Name = "CustomLibraryGui"
    gui.ResetOnSpawn = false
    gui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    
    local main = Instance.new("Frame")
    main.Size = UDim2.new(0, 480, 0, 320)
    main.Position = UDim2.new(0.5, -240, 0.5, -160)
    main.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
    main.BorderColor3 = Color3.fromRGB(0, 0, 0)
    main.BorderSizePixel = 1
    main.Active = true
    main.Draggable = true
    main.ClipsDescendants = true
    main.Visible = not enableIntro
    main.Parent = gui
    
    local outline = Instance.new("UIStroke")
    outline.Color = Color3.fromRGB(55, 55, 55)
    outline.Thickness = 1
    outline.Parent = main
    
    local topbar = Instance.new("Frame")
    topbar.Size = UDim2.new(1, 0, 0, 20)
    topbar.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    topbar.BorderSizePixel = 0
    topbar.Parent = main
    
    local accent = Instance.new("Frame")
    accent.Size = UDim2.new(1, 0, 0, 2)
    accent.Position = UDim2.new(0, 0, 1, -2)
    accent.BackgroundColor3 = themeColor
    accent.BorderSizePixel = 0
    accent.Parent = topbar
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -70, 1, -2)
    title.Position = UDim2.new(0, 8, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = titleText
    title.TextColor3 = Color3.fromRGB(200, 200, 200)
    title.TextSize = 11
    title.Font = Enum.Font.Code
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = topbar
    
    local controls = Instance.new("Frame")
    controls.Size = UDim2.new(0, 60, 1, -2)
    controls.Position = UDim2.new(1, -60, 0, 0)
    controls.BackgroundTransparency = 1
    controls.Parent = topbar
    
    local minBtn = Instance.new("TextButton")
    minBtn.Size = UDim2.new(0, 20, 1, 0)
    minBtn.Position = UDim2.new(0, 0, 0, 0)
    minBtn.BackgroundTransparency = 1
    minBtn.Text = "-"
    minBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
    minBtn.TextSize = 12
    minBtn.Font = Enum.Font.Code
    minBtn.Parent = controls
    
    local maxBtn = Instance.new("TextButton")
    maxBtn.Size = UDim2.new(0, 20, 1, 0)
    maxBtn.Position = UDim2.new(0, 20, 0, 0)
    maxBtn.BackgroundTransparency = 1
    maxBtn.Text = "□"
    maxBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
    maxBtn.TextSize = 10
    maxBtn.Font = Enum.Font.Code
    maxBtn.Parent = controls
    
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 20, 1, 0)
    closeBtn.Position = UDim2.new(0, 40, 0, 0)
    closeBtn.BackgroundTransparency = 1
    closeBtn.Text = "×"
    closeBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
    closeBtn.TextSize = 13
    closeBtn.Font = Enum.Font.Code
    closeBtn.Parent = controls

    local tabNav = Instance.new("Frame")
    tabNav.Size = UDim2.new(1, -16, 0, 20)
    tabNav.Position = UDim2.new(0, 8, 0, 24)
    tabNav.BackgroundTransparency = 1
    tabNav.Parent = main

    local tabNavList = Instance.new("UIListLayout")
    tabNavList.FillDirection = Enum.FillDirection.Horizontal
    tabNavList.SortOrder = Enum.SortOrder.LayoutOrder
    tabNavList.Padding = UDim.new(0, 4)
    tabNavList.Parent = tabNav
    
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -16, 1, -50)
    container.Position = UDim2.new(0, 8, 0, 46)
    container.BackgroundTransparency = 1
    container.Parent = main
    
    local isMinimized = false
    local isMaximized = false
    local normalSize = UDim2.new(0, 480, 0, 320)
    local normalPos = UDim2.new(0.5, -240, 0.5, -160)
    local tweenFast = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    
    minBtn.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        if isMinimized then
            container.Visible = false
            tabNav.Visible = false
            TweenService:Create(main, tweenFast, {Size = UDim2.new(main.Size.X.Scale, main.Size.X.Offset, 0, 20)}):Play()
        else
            local targetSize = isMaximized and UDim2.new(1, 0, 1, 0) or normalSize
            local tw = TweenService:Create(main, tweenFast, {Size = targetSize})
            tw:Play()
            tw.Completed:Connect(function()
                if not isMinimized then
                    container.Visible = true
                    tabNav.Visible = true
                end
            end)
        end
    end)
    
    maxBtn.MouseButton1Click:Connect(function()
        if isMinimized then return end
        isMaximized = not isMaximized
        if isMaximized then
            normalPos = main.Position
            normalSize = main.Size
            TweenService:Create(main, tweenFast, {Position = UDim2.new(0, 0, 0, 0), Size = UDim2.new(1, 0, 1, 0)}):Play()
        else
            TweenService:Create(main, tweenFast, {Position = normalPos, Size = normalSize}):Play()
        end
    end)
    
    closeBtn.MouseButton1Click:Connect(function()
        local tw = TweenService:Create(main, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(main.Position.X.Scale, main.Position.X.Offset + (main.AbsoluteSize.X / 2), main.Position.Y.Scale, main.Position.Y.Offset + (main.AbsoluteSize.Y / 2))
        })
        tw:Play()
        tw.Completed:Connect(function()
            gui:Destroy()
        end)
    end)
    
    if enableIntro then
        local introFrame = Instance.new("Frame")
        introFrame.Size = UDim2.new(0, 300, 0, 100)
        introFrame.Position = UDim2.new(0.5, -150, 0.5, -50)
        introFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
        introFrame.BorderColor3 = Color3.fromRGB(40, 40, 40)
        introFrame.BorderSizePixel = 1
        introFrame.BackgroundTransparency = 1
        introFrame.Parent = gui
        
        local introStroke = Instance.new("UIStroke")
        introStroke.Color = Color3.fromRGB(55, 55, 55)
        introStroke.Thickness = 1
        introStroke.Transparency = 1
        introStroke.Parent = introFrame
        
        local introBar = Instance.new("Frame")
        introBar.Size = UDim2.new(0, 0, 0, 2)
        introBar.Position = UDim2.new(0, 0, 1, -2)
        introBar.BackgroundColor3 = themeColor
        introBar.BorderSizePixel = 0
        introBar.Parent = introFrame
        
        local introLabel = Instance.new("TextLabel")
        introLabel.Size = UDim2.new(1, 0, 1, -2)
        introLabel.BackgroundTransparency = 1
        introLabel.Text = introText
        introLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
        introLabel.TextSize = 14
        introLabel.Font = Enum.Font.Code
        introLabel.TextTransparency = 1
        introLabel.Parent = introFrame

        task.spawn(function()
            TweenService:Create(introFrame, TweenInfo.new(0.4), {BackgroundTransparency = 0}):Play()
            TweenService:Create(introStroke, TweenInfo.new(0.4), {Transparency = 0}):Play()
            TweenService:Create(introLabel, TweenInfo.new(0.4), {TextTransparency = 0}):Play()
            task.wait(0.4)
            local barTween = TweenService:Create(introBar, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, 2)})
            barTween:Play()
            barTween.Completed:Wait()
            task.wait(0.3)
            TweenService:Create(introFrame, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
            TweenService:Create(introStroke, TweenInfo.new(0.3), {Transparency = 1}):Play()
            TweenService:Create(introBar, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
            local fadeOut = TweenService:Create(introLabel, TweenInfo.new(0.3), {TextTransparency = 1})
            fadeOut:Play()
            fadeOut.Completed:Wait()
            introFrame:Destroy()
            main.Visible = true
        end)
    end
    
    local Window = { Tabs = {}, FirstTab = nil }

    function Window:CreateTab(tabName)
        local tabBtn = Instance.new("TextButton")
        tabBtn.Size = UDim2.new(0, 70, 1, 0)
        tabBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
        tabBtn.BorderColor3 = Color3.fromRGB(40, 40, 40)
        tabBtn.BorderSizePixel = 1
        tabBtn.Text = tabName
        tabBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
        tabBtn.TextSize = 11
        tabBtn.Font = Enum.Font.Code
        tabBtn.Parent = tabNav

        local tabContent = Instance.new("Frame")
        tabContent.Size = UDim2.new(1, 0, 1, 0)
        tabContent.BackgroundTransparency = 1
        tabContent.Visible = false
        tabContent.Parent = container

        local Tab = {}

        local function activateTab()
            for _, t in pairs(Window.Tabs) do
                t.Button.TextColor3 = Color3.fromRGB(150, 150, 150)
                t.Button.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
                t.Content.Visible = false
            end
            tabBtn.TextColor3 = Color3.fromRGB(240, 240, 240)
            tabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            tabContent.Visible = true
        end

        tabBtn.MouseButton1Click:Connect(activateTab)

        table.insert(Window.Tabs, { Button = tabBtn, Content = tabContent })

        if not Window.FirstTab then
            Window.FirstTab = Tab
            activateTab()
        end

        function Tab:CreateSection(name, pos, size)
            local box = Instance.new("Frame")
            box.Size = size or UDim2.new(0.5, -5, 1, 0)
            box.Position = pos or UDim2.new(0, 0, 0, 0)
            box.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            box.BorderColor3 = Color3.fromRGB(40, 40, 40)
            box.BorderSizePixel = 1
            box.Parent = tabContent
            
            local lbl = Instance.new("TextLabel")
            lbl.Size = UDim2.new(0, 0, 0, 12)
            lbl.Position = UDim2.new(0, 8, 0, -6)
            lbl.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            lbl.BorderSizePixel = 0
            lbl.Text = " " .. name .. " "
            lbl.TextColor3 = Color3.fromRGB(180, 180, 180)
            lbl.TextSize = 11
            lbl.Font = Enum.Font.Code
            lbl.AutomaticSize = Enum.AutomaticSize.X
            lbl.Parent = box
            
            local list = Instance.new("UIListLayout")
            list.SortOrder = Enum.SortOrder.LayoutOrder
            list.Padding = UDim.new(0, 6)
            list.Parent = box
            
            local pad = Instance.new("UIPadding")
            pad.PaddingTop = UDim.new(0, 14)
            pad.PaddingLeft = UDim.new(0, 8)
            pad.PaddingRight = UDim.new(0, 8)
            pad.Parent = box
            
            local Section = {}
            
            function Section:AddToggle(text, callback)
                local f = Instance.new("Frame")
                f.Size = UDim2.new(1, 0, 0, 16)
                f.BackgroundTransparency = 1
                f.Parent = box
                
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(0, 10, 0, 10)
                btn.Position = UDim2.new(0, 0, 0.5, -5)
                btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                btn.BorderColor3 = Color3.fromRGB(55, 55, 55)
                btn.BorderSizePixel = 1
                btn.Text = ""
                btn.Parent = f
                
                local tLbl = Instance.new("TextLabel")
                tLbl.Size = UDim2.new(1, -16, 1, 0)
                tLbl.Position = UDim2.new(0, 16, 0, 0)
                tLbl.BackgroundTransparency = 1
                tLbl.Text = text
                tLbl.TextColor3 = Color3.fromRGB(160, 160, 160)
                tLbl.TextSize = 11
                tLbl.Font = Enum.Font.Code
                tLbl.TextXAlignment = Enum.TextXAlignment.Left
                tLbl.Parent = f
                
                local state = false
                btn.MouseButton1Click:Connect(function()
                    state = not state
                    btn.BackgroundColor3 = state and themeColor or Color3.fromRGB(30, 30, 30)
                    tLbl.TextColor3 = state and Color3.fromRGB(240, 240, 240) or Color3.fromRGB(160, 160, 160)
                    if callback then callback(state) end
                end)
            end
            
            function Section:AddButton(text, callback)
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1, 0, 0, 20)
                btn.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
                btn.BorderColor3 = Color3.fromRGB(45, 45, 45)
                btn.BorderSizePixel = 1
                btn.Text = text
                btn.TextColor3 = Color3.fromRGB(180, 180, 180)
                btn.TextSize = 11
                btn.Font = Enum.Font.Code
                btn.Parent = box
                
                btn.MouseButton1Click:Connect(function()
                    if callback then callback() end
                end)
            end
            
            return Section
        end

        return Tab
    end
    
    function Window:Destroy()
        gui:Destroy()
    end
    
    return Window
end

return Library
