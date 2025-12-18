-- Rayfield-like UI Library (Client-side, Roblox)
-- Автор: сгенерировано ChatGPT
-- Описание: лёгкая, модульная UI-библиотека, вдохновлённая Rayfield.
-- Использование: поместите этот файл как ModuleScript в StarterPlayerScripts или в ReplicatedStorage и require() из LocalScript.

local Library = {}
Library.__index = Library

-- ======= Dependencies & Helpers =======
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer and LocalPlayer:WaitForChild("PlayerGui")

-- Simple theme defaults
Library.Theme = {
    Accent = Color3.fromRGB(120, 133, 245),
    Background = Color3.fromRGB(24, 24, 24),
    Window = Color3.fromRGB(20, 20, 20),
    Text = Color3.fromRGB(230, 230, 230),
    InactiveText = Color3.fromRGB(170, 170, 170),
}

local function Tween(obj, propTable, time)
    time = time or 0.18
    local info = TweenInfo.new(time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local t = TweenService:Create(obj, info, propTable)
    t:Play()
    return t
end

local function isWritefileAvailable()
    return type(writefile) == "function"
end

-- Unique id generator
local idCounter = 0
local function genId(prefix)
    idCounter = idCounter + 1
    return (prefix or "id") .. tostring(idCounter)
end

-- ======= Core: Screen GUI & Window =======
function Library.new(opts)
    opts = opts or {}
    local self = setmetatable({}, Library)
    self.ScreenGui = Instance.new("ScreenGui")
    self.ScreenGui.Name = opts.Name or "RayUI"
    self.ScreenGui.ResetOnSpawn = false
    self.ScreenGui.DisplayOrder = opts.DisplayOrder or 0

    -- parent safely
    if PlayerGui then
        self.ScreenGui.Parent = PlayerGui
    else
        self.ScreenGui.Parent = StarterGui -- fallback (Studio)
    end

    self.Windows = {}
    self.Flags = {}
    self.ConfigFolder = opts.ConfigFolder or ("RayUI_Configs")

    return self
end

-- Create main window
function Library:CreateWindow(title, opts)
    opts = opts or {}
    local Window = {}
    Window._id = genId("Window")
    Window.Title = title or "Window"
    Window.Tabs = {}
    Window.Sections = {}
    Window.Container = Instance.new("Frame")
    Window.Container.Name = Window._id
    Window.Container.Size = UDim2.new(0, 680, 0, 420)
    Window.Container.Position = UDim2.new(0.5, -340, 0.5, -210)
    Window.Container.AnchorPoint = Vector2.new(0.5, 0.5)
    Window.Container.BackgroundColor3 = Library.Theme.Window
    Window.Container.BorderSizePixel = 0
    Window.Container.Parent = self.ScreenGui

    -- Corner and shadow
    local Corner = Instance.new("UICorner", Window.Container)
    Corner.CornerRadius = UDim.new(0, 8)

    -- Header
    local Header = Instance.new("Frame")
    Header.Size = UDim2.new(1, 0, 0, 48)
    Header.BackgroundTransparency = 1
    Header.Parent = Window.Container

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(0, 400, 1, 0)
    TitleLabel.Position = UDim2.new(0, 14, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 18
    TitleLabel.Text = Window.Title
    TitleLabel.TextColor3 = Library.Theme.Text
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = Header

    -- Tab bar
    local TabBar = Instance.new("Frame")
    TabBar.Size = UDim2.new(1, -28, 0, 36)
    TabBar.Position = UDim2.new(0, 14, 0, 48)
    TabBar.BackgroundTransparency = 1
    TabBar.Parent = Window.Container

    local TabList = Instance.new("UIListLayout", TabBar)
    TabList.FillDirection = Enum.FillDirection.Horizontal
    TabList.HorizontalAlignment = Enum.HorizontalAlignment.Left
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.VerticalAlignment = Enum.VerticalAlignment.Center
    TabList.Padding = UDim.new(0, 8)

    -- Page area
    local PageArea = Instance.new("Frame")
    PageArea.Size = UDim2.new(1, -28, 1, -110)
    PageArea.Position = UDim2.new(0, 14, 0, 96)
    PageArea.BackgroundTransparency = 1
    PageArea.Parent = Window.Container

    -- Layout for pages
    local Pages = Instance.new("Folder", Window.Container)
    Pages.Name = "Pages"

    -- Save references
    Window.UI = {
        Container = Window.Container,
        Header = Header,
        TabBar = TabBar,
        TabList = TabList,
        PageArea = PageArea,
        Pages = Pages
    }

    -- Dragging (simple)
    do
        local dragging, dragStart, startPos
        Header.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                dragStart = input.Position
                startPos = Window.Container.Position
            end
        end)
        Header.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)
        Header.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
                local delta = input.Position - dragStart
                Window.Container.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)
    end

    -- Methods
    function Window:CreateTab(name)
        local Tab = {}
        Tab._id = genId("Tab")
        Tab.Name = name or "Tab"
        Tab.Sections = {}

        -- Tab button
        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(0, 120, 0, 32)
        Btn.BackgroundTransparency = 1
        Btn.Font = Enum.Font.Gotham
        Btn.TextSize = 14
        Btn.Text = Tab.Name
        Btn.TextColor3 = Library.Theme.InactiveText
        Btn.AutoButtonColor = false
        Btn.Parent = TabBar

        -- Page frame
        local Page = Instance.new("ScrollingFrame")
        Page.Name = Tab._id
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.CanvasSize = UDim2.new(0, 0, 1, 0)
        Page.ScrollBarThickness = 8
        Page.BorderSizePixel = 0
        Page.BackgroundTransparency = 1
        Page.Parent = Pages

        local List = Instance.new("UIListLayout", Page)
        List.SortOrder = Enum.SortOrder.LayoutOrder
        List.Padding = UDim.new(0, 8)

        -- Tab switching
        Btn.MouseButton1Click:Connect(function()
            for _, child in pairs(Pages:GetChildren()) do
                child.Visible = false
            end
            Page.Visible = true
            Btn.TextColor3 = Library.Theme.Text
            -- reset other buttons color
            for _, b in pairs(TabBar:GetChildren()) do
                if b:IsA("TextButton") and b ~= Btn then
                    b.TextColor3 = Library.Theme.InactiveText
                end
            end
        end)

        -- default: add first tab visible
        if #self.Tabs == 0 then
            Page.Visible = true
            Btn.TextColor3 = Library.Theme.Text
        else
            Page.Visible = false
        end

        function Tab:CreateSection(title)
            local Section = {}
            Section._id = genId("Section")
            Section.Title = title or "Section"

            local Frame = Instance.new("Frame")
            Frame.Size = UDim2.new(1, -20, 0, 90)
            Frame.BackgroundColor3 = Library.Theme.Background
            Frame.BorderSizePixel = 0
            Frame.Parent = Page
            Frame.LayoutOrder = #Page:GetChildren()

            local Corner = Instance.new("UICorner", Frame)
            Corner.CornerRadius = UDim.new(0, 6)

            local TitleLabel = Instance.new("TextLabel", Frame)
            TitleLabel.Size = UDim2.new(1, -16, 0, 28)
            TitleLabel.Position = UDim2.new(0, 8, 0, 8)
            TitleLabel.BackgroundTransparency = 1
            TitleLabel.Font = Enum.Font.GothamSemibold
            TitleLabel.TextSize = 14
            TitleLabel.Text = Section.Title
            TitleLabel.TextColor3 = Library.Theme.Text
            TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

            local Content = Instance.new("Frame", Frame)
            Content.Size = UDim2.new(1, -16, 1, -44)
            Content.Position = UDim2.new(0, 8, 0, 36)
            Content.BackgroundTransparency = 1

            local ContentList = Instance.new("UIListLayout", Content)
            ContentList.SortOrder = Enum.SortOrder.LayoutOrder
            ContentList.Padding = UDim.new(0, 8)

            Section.UI = {Frame = Frame, Content = Content}

            -- Controls creators
            function Section:Toggle(options)
                options = options or {}
                local Title = options.Name or "Toggle"
                local Default = options.Default == true
                local Callback = options.Callback or function() end
                local Flag = options.Flag
                if Flag then self.ParentLibrary = self.ParentLibrary or {} end

                local Item = Instance.new("Frame")
                Item.Size = UDim2.new(1, 0, 0, 28)
                Item.BackgroundTransparency = 1
                Item.Parent = Content

                local Label = Instance.new("TextLabel", Item)
                Label.Size = UDim2.new(1, -60, 1, 0)
                Label.Position = UDim2.new(0, 0, 0, 0)
                Label.BackgroundTransparency = 1
                Label.Font = Enum.Font.Gotham
                Label.TextSize = 14
                Label.Text = Title
                Label.TextColor3 = Library.Theme.Text
                Label.TextXAlignment = Enum.TextXAlignment.Left

                local ToggleBtn = Instance.new("TextButton", Item)
                ToggleBtn.Size = UDim2.new(0, 42, 0, 20)
                ToggleBtn.Position = UDim2.new(1, -46, 0, 4)
                ToggleBtn.BackgroundColor3 = Library.Theme.Background
                ToggleBtn.BorderSizePixel = 0
                ToggleBtn.Text = ""
                ToggleBtn.AutoButtonColor = false

                local ToggleUICorner = Instance.new("UICorner", ToggleBtn)
                ToggleUICorner.CornerRadius = UDim.new(0, 12)

                local Dot = Instance.new("Frame", ToggleBtn)
                Dot.Size = UDim2.new(0, 16, 0, 16)
                Dot.Position = UDim2.new(Default and 1 or 0, Default and -18 or 2, 0, 2)
                Dot.BackgroundColor3 = Default and Library.Theme.Accent or Library.Theme.InactiveText
                Dot.BorderSizePixel = 0
                Dot.AnchorPoint = Vector2.new(0, 0)

                local DotCorner = Instance.new("UICorner", Dot)
                DotCorner.CornerRadius = UDim.new(0, 8)

                local state = Default
                if options.Flag then
                    self.ParentLibrary.Flags = self.ParentLibrary.Flags or {}
                    self.ParentLibrary.Flags[options.Flag] = state
                end

                local function setState(v)
                    state = v
                    if state then
                        Tween(Dot, {Position = UDim2.new(1, -18, 0, 2)})
                        Dot.BackgroundColor3 = Library.Theme.Accent
                    else
                        Tween(Dot, {Position = UDim2.new(0, 2, 0, 2)})
                        Dot.BackgroundColor3 = Library.Theme.InactiveText
                    end
                    if options.Flag and self.ParentLibrary.Flags then
                        self.ParentLibrary.Flags[options.Flag] = state
                    end
                    Callback(state)
                end

                ToggleBtn.MouseButton1Click:Connect(function()
                    setState(not state)
                end)

                -- initial
                setState(Default)
                return setmetatable({Set = setState, Get = function() return state end}, {__index = Section})
            end

            function Section:Button(options)
                options = options or {}
                local text = options.Name or "Button"
                local cb = options.Callback or function() end

                local Item = Instance.new("Frame")
                Item.Size = UDim2.new(1, 0, 0, 36)
                Item.BackgroundTransparency = 1
                Item.Parent = Content

                local Btn = Instance.new("TextButton", Item)
                Btn.Size = UDim2.new(1, 0, 0, 36)
                Btn.BackgroundColor3 = Library.Theme.Accent
                Btn.Font = Enum.Font.GothamBold
                Btn.TextSize = 14
                Btn.TextColor3 = Color3.new(1,1,1)
                Btn.Text = text
                Btn.BorderSizePixel = 0

                local corner = Instance.new("UICorner", Btn)
                corner.CornerRadius = UDim.new(0, 6)

                Btn.MouseButton1Click:Connect(function()
                    cb()
                    -- small press tween
                    Tween(Btn, {BackgroundTransparency = 0.6}, 0.06):Play()
                    task.delay(0.06, function() Tween(Btn, {BackgroundTransparency = 0}, 0.06) end)
                end)

                return setmetatable({Instance = Btn}, {__index = Section})
            end

            function Section:Slider(options)
                options = options or {}
                local label = options.Name or "Slider"
                local min = options.Min or 0
                local max = options.Max or 100
                local init = options.Default or min
                local step = options.Step or 1
                local cb = options.Callback or function() end

                local Item = Instance.new("Frame")
                Item.Size = UDim2.new(1, 0, 0, 44)
                Item.BackgroundTransparency = 1
                Item.Parent = Content

                local Label = Instance.new("TextLabel", Item)
                Label.Size = UDim2.new(1, -8, 0, 18)
                Label.Position = UDim2.new(0, 0, 0, 0)
                Label.BackgroundTransparency = 1
                Label.Font = Enum.Font.Gotham
                Label.TextSize = 14
                Label.Text = label .. " — " .. tostring(init)
                Label.TextColor3 = Library.Theme.Text
                Label.TextXAlignment = Enum.TextXAlignment.Left

                local Track = Instance.new("Frame", Item)
                Track.Size = UDim2.new(1, -8, 0, 12)
                Track.Position = UDim2.new(0, 4, 0, 22)
                Track.BackgroundColor3 = Library.Theme.Background
                Track.BorderSizePixel = 0

                local TrackCorner = Instance.new("UICorner", Track)
                TrackCorner.CornerRadius = UDim.new(0, 6)

                local Fill = Instance.new("Frame", Track)
                Fill.Size = UDim2.new((init - min) / (max - min), 0, 1, 0)
                Fill.Position = UDim2.new(0, 0, 0, 0)
                Fill.BackgroundColor3 = Library.Theme.Accent
                Fill.BorderSizePixel = 0

                local FillCorner = Instance.new("UICorner", Fill)
                FillCorner.CornerRadius = UDim.new(0, 6)

                local handle = Instance.new("Frame", Track)
                handle.Size = UDim2.new(0, 12, 1, 0)
                handle.Position = UDim2.new(Fill.Size.X.Scale, -6, 0, 0)
                handle.BackgroundColor3 = Library.Theme.Accent
                handle.BorderSizePixel = 0
                local handleCorner = Instance.new("UICorner", handle) handleCorner.CornerRadius = UDim.new(0,6)

                local dragging = false
                local function updateFromX(x)
                    local relative = math.clamp((x - Track.AbsolutePosition.X) / Track.AbsoluteSize.X, 0, 1)
                    local raw = min + (relative * (max - min))
                    local stepped = math.floor(raw / step + 0.5) * step
                    Fill.Size = UDim2.new((stepped - min) / (max - min), 0, 1, 0)
                    handle.Position = UDim2.new(Fill.Size.X.Scale, -6, 0, 0)
                    Label.Text = label .. " — " .. tostring(stepped)
                    cb(stepped)
                end

                Track.InputBegan:Connect(function(inp)
                    if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                        updateFromX(inp.Position.X)
                    end
                end)
                Track.InputEnded:Connect(function(inp)
                    if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end)
                Track.InputChanged:Connect(function(inp)
                    if inp.UserInputType == Enum.UserInputType.MouseMovement and dragging then
                        updateFromX(inp.Position.X)
                    end
                end)

                -- initial
                updateFromX(Track.AbsolutePosition.X + Track.AbsoluteSize.X * ((init - min)/(max-min)))

                return setmetatable({Get = function()
                    return tonumber(Label.Text:match("%-%- (.*)$")) or init
                end}, {__index = Section})
            end

            function Section:Dropdown(options)
                options = options or {}
                local name = options.Name or "Dropdown"
                local items = options.Items or {}
                local multi = options.Multi or false
                local cb = options.Callback or function() end

                local Item = Instance.new("Frame")
                Item.Size = UDim2.new(1, 0, 0, 28)
                Item.BackgroundTransparency = 1
                Item.Parent = Content

                local Label = Instance.new("TextLabel", Item)
                Label.Size = UDim2.new(1, -24, 1, 0)
                Label.BackgroundTransparency = 1
                Label.Font = Enum.Font.Gotham
                Label.TextSize = 14
                Label.Text = name
                Label.TextColor3 = Library.Theme.Text
                Label.TextXAlignment = Enum.TextXAlignment.Left

                local Btn = Instance.new("TextButton", Item)
                Btn.Size = UDim2.new(0, 22, 0, 22)
                Btn.Position = UDim2.new(1, -24, 0, 3)
                Btn.BackgroundColor3 = Library.Theme.Background
                Btn.BorderSizePixel = 0
                Btn.Text = "+"
                Btn.Font = Enum.Font.GothamBold
                Btn.TextSize = 14
                Btn.TextColor3 = Library.Theme.Text

                local Open = false
                local DropdownFrame = Instance.new("Frame")
                DropdownFrame.Size = UDim2.new(1, 0, 0, 0)
                DropdownFrame.Position = UDim2.new(0, 0, 1, 6)
                DropdownFrame.BackgroundColor3 = Library.Theme.Background
                DropdownFrame.Parent = Item
                DropdownFrame.ClipsDescendants = true

                local List = Instance.new("UIListLayout", DropdownFrame)
                List.SortOrder = Enum.SortOrder.LayoutOrder
                List.Padding = UDim.new(0, 4)

                local selected = {}

                local function rebuild()
                    for _, ch in ipairs(DropdownFrame:GetChildren()) do
                        if ch:IsA("TextButton") then ch:Destroy() end
                    end
                    local height = 0
                    for i, opt in ipairs(items) do
                        local optBtn = Instance.new("TextButton")
                        optBtn.Size = UDim2.new(1, -8, 0, 28)
                        optBtn.Position = UDim2.new(0, 4, 0, 0)
                        optBtn.BackgroundColor3 = Library.Theme.Background
                        optBtn.BorderSizePixel = 0
                        optBtn.Text = tostring(opt)
                        optBtn.Font = Enum.Font.Gotham
                        optBtn.TextSize = 14
                        optBtn.TextColor3 = Library.Theme.Text
                        optBtn.Parent = DropdownFrame
                        height = height + 32

                        optBtn.MouseButton1Click:Connect(function()
                            if multi then
                                selected[opt] = not selected[opt]
                            else
                                selected = { [opt] = true }
                            end
                            cb(selected)
                        end)
                    end
                    DropdownFrame.Size = UDim2.new(1, 0, 0, math.clamp(height, 0, 200))
                end

                Btn.MouseButton1Click:Connect(function()
                    Open = not Open
                    if Open then
                        DropdownFrame.Visible = true
                        rebuild()
                    else
                        DropdownFrame.Visible = false
                    end
                end)

                return setmetatable({Get = function() return selected end, SetItems = function(t) items = t rebuild() end}, {__index = Section})
            end

            function Section:Colorpicker(options)
                options = options or {}
                local label = options.Name or "Color"
                local init = options.Default or Library.Theme.Accent
                local cb = options.Callback or function() end

                local Item = Instance.new("Frame")
                Item.Size = UDim2.new(1, 0, 0, 28)
                Item.BackgroundTransparency = 1
                Item.Parent = Content

                local Label = Instance.new("TextLabel", Item)
                Label.Size = UDim2.new(1, -40, 1, 0)
                Label.BackgroundTransparency = 1
                Label.Font = Enum.Font.Gotham
                Label.TextSize = 14
                Label.Text = label
                Label.TextColor3 = Library.Theme.Text
                Label.TextXAlignment = Enum.TextXAlignment.Left

                local Box = Instance.new("Frame", Item)
                Box.Size = UDim2.new(0, 28, 0, 20)
                Box.Position = UDim2.new(1, -36, 0, 4)
                Box.BackgroundColor3 = init
                Box.BorderSizePixel = 0
                Box.Visible = true

                local cpOpen = false
                local picker = Instance.new("Frame")
                picker.Size = UDim2.new(0, 240, 0, 160)
                picker.Position = UDim2.new(0, 0, 0, 36)
                picker.BackgroundColor3 = Library.Theme.Background
                picker.BorderSizePixel = 0
                picker.Parent = Item
                picker.Visible = false

                local sat = Instance.new("ImageLabel", picker)
                sat.Size = UDim2.new(0, 160, 0, 120)
                sat.Position = UDim2.new(0, 8, 0, 8)
                sat.BackgroundTransparency = 1
                sat.Image = "rbxassetid://415580125" -- placeholder gradient (studio-safe)

                local hue = Instance.new("ImageLabel", picker)
                hue.Size = UDim2.new(0, 16, 0, 120)
                hue.Position = UDim2.new(0, 176, 0, 8)
                hue.BackgroundTransparency = 1
                hue.Image = "rbxassetid://415580125"

                local ok = Instance.new("TextButton", picker)
                ok.Size = UDim2.new(0, 60, 0, 28)
                ok.Position = UDim2.new(1, -68, 1, -36)
                ok.Text = "OK"
                ok.Font = Enum.Font.Gotham
                ok.TextSize = 14
                ok.BackgroundColor3 = Library.Theme.Accent
                ok.TextColor3 = Color3.new(1,1,1)

                Box.InputBegan:Connect(function(inp)
                    if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                        cpOpen = not cpOpen
                        picker.Visible = cpOpen
                    end
                end)

                ok.MouseButton1Click:Connect(function()
                    picker.Visible = false
                    cpOpen = false
                    cb(Box.BackgroundColor3)
                end)

                return setmetatable({Set = function(c) Box.BackgroundColor3 = c end, Get = function() return Box.BackgroundColor3 end}, {__index = Section})
            end

            -- attach pointer to parent library for flags access
            Section.ParentLibrary = self

            -- finalize
            Tab.Sections[#Tab.Sections + 1] = Section
            return Section
        end

        -- store
        table.insert(self.Tabs, Tab)
        self.UI.Pages[Tab._id] = Page
        return Tab
    end

    -- Attach to window list
    table.insert(self.Windows, Window)

    -- convenience
    Window.ParentLibrary = self

    -- Methods for window-level actions
    function Window:SaveConfig(name)
        local data = {}
        if self.ParentLibrary and self.ParentLibrary.Flags then
            data.Flags = self.ParentLibrary.Flags
        end
        local encoded = HttpService:JSONEncode(data)
        if isWritefileAvailable() then
            pcall(function() writefile((self.ParentLibrary.ConfigFolder .. "/" .. name .. ".json"), encoded) end)
        else
            -- fallback: set core gui property as storage suggestion (no persistent storage in regular Roblox)
            warn("writefile not available: config not saved to disk. Provide writefile or use DataStore for persistent storage.")
        end
    end

    function Window:LoadConfig(name)
        if isWritefileAvailable() then
            local ok, content = pcall(function() return readfile((self.ParentLibrary.ConfigFolder .. "/" .. name .. ".json")) end)
            if ok and content then
                local data = HttpService:JSONDecode(content)
                if data.Flags and self.ParentLibrary then
                    for k, v in pairs(data.Flags) do
                        self.ParentLibrary.Flags[k] = v
                    end
                end
            end
        else
            warn("writefile not available: config not loaded from disk.")
        end
    end

    return Window
end

-- Notification helper (global)
function Library:Notify(text, duration)
    duration = duration or 4
    local notif = Instance.new("Frame")
    notif.Size = UDim2.new(0, 320, 0, 48)
    notif.Position = UDim2.new(1, -340, 0, 24 + (#self._notifications or 0) * 56)
    notif.AnchorPoint = Vector2.new(0, 0)
    notif.BackgroundColor3 = Library.Theme.Background
    notif.BorderSizePixel = 0
    notif.Parent = self.ScreenGui
    local corner = Instance.new("UICorner", notif) corner.CornerRadius = UDim.new(0,8)

    local label = Instance.new("TextLabel", notif)
    label.Size = UDim2.new(1, -16, 1, 0)
    label.Position = UDim2.new(0,8,0,0)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.Text = text
    label.TextColor3 = Library.Theme.Text
    label.TextXAlignment = Enum.TextXAlignment.Left

    -- animate in
    notif.Position = UDim2.new(1, 40, 0, notif.Position.Y.Offset)
    Tween(notif, {Position = UDim2.new(1, -340, 0, notif.Position.Y.Offset)}, 0.24)

    task.delay(duration, function()
        Tween(notif, {Position = UDim2.new(1, 40, 0, notif.Position.Y.Offset)}, 0.18)
        task.delay(0.18, function() notif:Destroy() end)
    end)

    self._notifications = self._notifications or {}
    table.insert(self._notifications, notif)
end

-- Utility: change theme
function Library:SetTheme(tbl)
    for k, v in pairs(tbl) do
        if Library.Theme[k] ~= nil then
            Library.Theme[k] = v
        end
    end
end

-- Return module
return Library
