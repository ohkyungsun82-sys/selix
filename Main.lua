local Library = {}

function Library:CreateWindow(config)
    local titleText = config.Title or "UI Library"
    local themeColor = config.ThemeColor or Color3.fromRGB(255, 50, 50)
    
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    
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
    
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -20, 1, -35)
    container.Position = UDim2.new(0, 10, 0, 28)
    container.BackgroundTransparency = 1
    container.Parent = main
    
    local isMinimized = false
    local isMaximized = false
    local normalSize = UDim2.new(0, 480, 0, 320)
    local normalPos = UDim2.new(0.5, -240, 0.5, -160)
    
    minBtn.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        container.Visible = not isMinimized
        if isMinimized then
            main.Size = UDim2.new(main.Size.X.Scale, main.Size.X.Offset, 0, 20)
        else
            main.Size = isMaximized and UDim2.new(1, 0, 1, 0) or normalSize
        end
    end)
    
    maxBtn.MouseButton1Click:Connect(function()
        if isMinimized then return end
        isMaximized = not isMaximized
        if isMaximized then
            normalPos = main.Position
            normalSize = main.Size
            main.Position = UDim2.new(0, 0, 0, 0)
            main.Size = UDim2.new(1, 0, 1, 0)
        else
            main.Position = normalPos
            main.Size = normalSize
        end
    end)
    
    closeBtn.MouseButton1Click:Connect(function()
        gui:Destroy()
    end)
    
    local Window = {}
    
    function Window:CreateSection(name, pos, size)
        local box = Instance.new("Frame")
        box.Size = size or UDim2.new(0.5, -5, 1, 0)
        box.Position = pos or UDim2.new(0, 0, 0, 0)
        box.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        box.BorderColor3 = Color3.fromRGB(40, 40, 40)
        box.BorderSizePixel = 1
        box.Parent = container
        
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
    
    function Window:Destroy()
        gui:Destroy()
    end
    
    return Window
end

return Library
