-- Abyss UI Library
-- Version: 1.0
-- Inspired by Rayfield Interface

local Abyss = {}
Abyss.__index = Abyss

-- Services
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")

-- Variables
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

function Abyss.new(Configuration)
    Configuration = Configuration or {}
    
    local self = setmetatable({
        Configuration = {
            Name = Configuration.Name or "Abyss UI",
            LoadingTitle = Configuration.LoadingTitle or "Abyss",
            LoadingSubtitle = Configuration.LoadingSubtitle or "Loading Interface",
            ConfigurationSaving = Configuration.ConfigurationSaving or {
                Enabled = true,
                FolderName = "Abyss",
                FileName = "Config.json"
            },
            Discord = Configuration.Discord or {
                Enabled = false,
                Invite = "discord.gg/example"
            },
            KeySystem = Configuration.KeySystem or {
                Enabled = false,
                Title = "Key System",
                Subtitle = "Enter Key",
                Note = "Join the Discord for the key",
                Key = "KEY123",
                SavedKey = ""
            },
            Theme = Configuration.Theme or {
                Accent = Color3.fromRGB(120, 133, 245),
                Darker = Color3.fromRGB(25, 25, 25),
                Dark = Color3.fromRGB(32, 32, 32),
                Light = Color3.fromRGB(50, 50, 50),
                Text = Color3.fromRGB(232, 232, 232),
                SubText = Color3.fromRGB(175, 175, 175)
            }
        },
        CurrentTab = nil,
        Tabs = {},
        Flags = {},
        Notifications = {},
        Connections = {},
        Drawings = {},
        ScreenGui = nil
    }, Abyss)
    
    return self
end

function Abyss:CreateWindow()
    -- Create ScreenGui
    self.ScreenGui = Instance.new("ScreenGui")
    self.ScreenGui.Name = "AbyssUI"
    self.ScreenGui.Parent = CoreGui
    self.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Create Main Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 550, 0, 400)
    MainFrame.Position = UDim2.new(0.5, -275, 0.5, -200)
    MainFrame.BackgroundColor3 = self.Configuration.Theme.Darker
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = self.ScreenGui
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = MainFrame
    
    -- Top Bar
    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Size = UDim2.new(1, 0, 0, 40)
    TopBar.BackgroundColor3 = self.Configuration.Theme.Dark
    TopBar.BorderSizePixel = 0
    TopBar.Parent = MainFrame
    
    local TopBarCorner = Instance.new("UICorner")
    TopBarCorner.CornerRadius = UDim.new(0, 8)
    TopBarCorner.Parent = TopBar
    
    -- Title
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(0, 200, 1, 0)
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = self.Configuration.Name
    Title.TextColor3 = self.Configuration.Theme.Text
    Title.TextSize = 18
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TopBar
    
    -- Close Button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -40, 0, 5)
    CloseButton.BackgroundColor3 = self.Configuration.Theme.Light
    CloseButton.Text = "X"
    CloseButton.TextColor3 = self.Configuration.Theme.Text
    CloseButton.TextSize = 16
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Parent = TopBar
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 6)
    CloseCorner.Parent = CloseButton
    
    -- Tab Container
    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Size = UDim2.new(0, 150, 1, -40)
    TabContainer.Position = UDim2.new(0, 0, 0, 40)
    TabContainer.BackgroundColor3 = self.Configuration.Theme.Dark
    TabContainer.BorderSizePixel = 0
    TabContainer.Parent = MainFrame
    
    local TabList = Instance.new("UIListLayout")
    TabList.Parent = TabContainer
    TabList.Padding = UDim.new(0, 5)
    
    -- Content Container
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Size = UDim2.new(1, -150, 1, -40)
    ContentContainer.Position = UDim2.new(0, 150, 0, 40)
    ContentContainer.BackgroundColor3 = self.Configuration.Theme.Darker
    ContentContainer.BorderSizePixel = 0
    ContentContainer.Parent = MainFrame
    
    -- Make window draggable
    local dragging
    local dragInput
    local dragStart
    local startPos

    local function update(input)
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    TopBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
    
    -- Close button functionality
    CloseButton.MouseButton1Click:Connect(function()
        self:Destroy()
    end)
    
    -- Hide initially
    self.ScreenGui.Enabled = false
    
    -- Create notification handler
    self:SetupNotifications()
    
    return self
end

function Abyss:SetupNotifications()
    -- Notification container
    local NotificationContainer = Instance.new("Frame")
    NotificationContainer.Name = "NotificationContainer"
    NotificationContainer.Size = UDim2.new(0, 300, 1, -20)
    NotificationContainer.Position = UDim2.new(1, -310, 0, 10)
    NotificationContainer.BackgroundTransparency = 1
    NotificationContainer.Parent = self.ScreenGui
    
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = NotificationContainer
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 10)
end

function Abyss:Notify(Title, Content, Duration)
    Duration = Duration or 5
    
    local Notification = Instance.new("Frame")
    Notification.Name = "Notification"
    Notification.Size = UDim2.new(1, 0, 0, 80)
    Notification.BackgroundColor3 = self.Configuration.Theme.Dark
    Notification.BorderSizePixel = 0
    Notification.Parent = self.ScreenGui:FindFirstChild("NotificationContainer")
    Notification.LayoutOrder = #self.Notifications + 1
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = Notification
    
    -- Accent line
    local Accent = Instance.new("Frame")
    Accent.Name = "Accent"
    Accent.Size = UDim2.new(0, 5, 1, 0)
    Accent.BackgroundColor3 = self.Configuration.Theme.Accent
    Accent.BorderSizePixel = 0
    Accent.Parent = Notification
    
    local AccentCorner = Instance.new("UICorner")
    AccentCorner.CornerRadius = UDim.new(0, 8)
    AccentCorner.Parent = Accent
    
    -- Title
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Name = "Title"
    TitleLabel.Size = UDim2.new(1, -20, 0, 25)
    TitleLabel.Position = UDim2.new(0, 15, 0, 10)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = Title
    TitleLabel.TextColor3 = self.Configuration.Theme.Text
    TitleLabel.TextSize = 16
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = Notification
    
    -- Content
    local ContentLabel = Instance.new("TextLabel")
    ContentLabel.Name = "Content"
    ContentLabel.Size = UDim2.new(1, -20, 1, -45)
    ContentLabel.Position = UDim2.new(0, 15, 0, 35)
    ContentLabel.BackgroundTransparency = 1
    ContentLabel.Text = Content
    ContentLabel.TextColor3 = self.Configuration.Theme.SubText
    ContentLabel.TextSize = 14
    ContentLabel.Font = Enum.Font.Gotham
    ContentLabel.TextXAlignment = Enum.TextXAlignment.Left
    ContentLabel.TextYAlignment = Enum.TextYAlignment.Top
    ContentLabel.TextWrapped = true
    ContentLabel.Parent = Notification
    
    -- Auto remove after duration
    task.delay(Duration, function()
        if Notification then
            local tween = TweenService:Create(
                Notification,
                TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {Position = UDim2.new(1, 0, Notification.Position.Y.Scale, Notification.Position.Y.Offset)}
            )
            tween:Play()
            tween.Completed:Wait()
            Notification:Destroy()
        end
    end)
    
    table.insert(self.Notifications, Notification)
end

function Abyss:CreateTab(Name, Icon)
    Icon = Icon or ""
    
    local Tab = {
        Name = Name,
        Icon = Icon,
        Sections = {}
    }
    
    -- Tab Button
    local TabButton = Instance.new("TextButton")
    TabButton.Name = Name .. "Tab"
    TabButton.Size = UDim2.new(1, -10, 0, 35)
    TabButton.Position = UDim2.new(0, 5, 0, 5 + (#self.Tabs * 40))
    TabButton.BackgroundColor3 = self.Configuration.Theme.Light
    TabButton.Text = (Icon ~= "" and Icon .. " " or "") .. Name
    TabButton.TextColor3 = self.Configuration.Theme.Text
    TabButton.TextSize = 14
    TabButton.Font = Enum.Font.Gotham
    TabButton.Parent = self.ScreenGui.MainFrame.TabContainer
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 6)
    TabCorner.Parent = TabButton
    
    -- Content Frame
    local ContentFrame = Instance.new("ScrollingFrame")
    ContentFrame.Name = Name .. "Content"
    ContentFrame.Size = UDim2.new(1, 0, 1, 0)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.BorderSizePixel = 0
    ContentFrame.ScrollBarThickness = 4
    ContentFrame.ScrollBarImageColor3 = self.Configuration.Theme.Light
    ContentFrame.Visible = false
    ContentFrame.Parent = self.ScreenGui.MainFrame.ContentContainer
    
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = ContentFrame
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 10)
    
    -- Tab selection
    TabButton.MouseButton1Click:Connect(function()
        for _, otherTab in pairs(self.Tabs) do
            self.ScreenGui.MainFrame.ContentContainer[otherTab.Name .. "Content"].Visible = false
            self.ScreenGui.MainFrame.TabContainer[otherTab.Name .. "Tab"].BackgroundColor3 = self.Configuration.Theme.Light
        end
        
        ContentFrame.Visible = true
        TabButton.BackgroundColor3 = self.Configuration.Theme.Accent
        
        self.CurrentTab = Tab
    end)
    
    -- Select first tab
    if #self.Tabs == 0 then
        ContentFrame.Visible = true
        TabButton.BackgroundColor3 = self.Configuration.Theme.Accent
        self.CurrentTab = Tab
    end
    
    table.insert(self.Tabs, Tab)
    
    function Tab:CreateSection(Title)
        local Section = {
            Title = Title,
            Elements = {}
        }
        
        -- Section Frame
        local SectionFrame = Instance.new("Frame")
        SectionFrame.Name = Title .. "Section"
        SectionFrame.Size = UDim2.new(1, -20, 0, 0)
        SectionFrame.BackgroundColor3 = self.Configuration.Theme.Dark
        SectionFrame.BorderSizePixel = 0
        SectionFrame.Parent = ContentFrame
        
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 8)
        UICorner.Parent = SectionFrame
        
        -- Section Title
        local TitleLabel = Instance.new("TextLabel")
        TitleLabel.Name = "Title"
        TitleLabel.Size = UDim2.new(1, 0, 0, 35)
        TitleLabel.BackgroundTransparency = 1
        TitleLabel.Text = Title
        TitleLabel.TextColor3 = self.Configuration.Theme.Text
        TitleLabel.TextSize = 16
        TitleLabel.Font = Enum.Font.GothamBold
        TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
        TitleLabel.Parent = SectionFrame
        
        local TitlePadding = Instance.new("UIPadding")
        TitlePadding.PaddingLeft = UDim.new(0, 15)
        TitlePadding.Parent = TitleLabel
        
        -- Elements Container
        local ElementsContainer = Instance.new("Frame")
        ElementsContainer.Name = "Elements"
        ElementsContainer.Size = UDim2.new(1, 0, 1, -35)
        ElementsContainer.Position = UDim2.new(0, 0, 0, 35)
        ElementsContainer.BackgroundTransparency = 1
        ElementsContainer.Parent = SectionFrame
        
        local ElementsLayout = Instance.new("UIListLayout")
        ElementsLayout.Parent = ElementsContainer
        ElementsLayout.SortOrder = Enum.SortOrder.LayoutOrder
        ElementsLayout.Padding = UDim.new(0, 5)
        
        RunService.Heartbeat:Connect(function()
            local elementCount = 0
            for _, element in pairs(ElementsContainer:GetChildren()) do
                if element:IsA("Frame") then
                    elementCount += element.Size.Y.Offset
                end
            end
            SectionFrame.Size = UDim2.new(1, -20, 0, 40 + elementCount)
        end)
        
        function Section:AddToggle(Config)
            Config = Config or {}
            local Toggle = {
                Value = Config.Default or false,
                Type = "Toggle"
            }
            
            -- Toggle Frame
            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Name = Config.Name or "Toggle"
            ToggleFrame.Size = UDim2.new(1, 0, 0, 30)
            ToggleFrame.BackgroundTransparency = 1
            ToggleFrame.Parent = ElementsContainer
            
            -- Toggle Button
            local ToggleButton = Instance.new("TextButton")
            ToggleButton.Name = "Button"
            ToggleButton.Size = UDim2.new(1, 0, 1, 0)
            ToggleButton.BackgroundTransparency = 1
            ToggleButton.Text = ""
            ToggleButton.Parent = ToggleFrame
            
            -- Toggle Background
            local ToggleBackground = Instance.new("Frame")
            ToggleBackground.Name = "Background"
            ToggleBackground.Size = UDim2.new(0, 50, 0, 25)
            ToggleBackground.Position = UDim2.new(1, -55, 0.5, -12.5)
            ToggleBackground.BackgroundColor3 = Toggle.Value and self.Configuration.Theme.Accent or self.Configuration.Theme.Light
            ToggleBackground.BorderSizePixel = 0
            ToggleBackground.Parent = ToggleFrame
            
            local ToggleCorner = Instance.new("UICorner")
            ToggleCorner.CornerRadius = UDim.new(0, 25)
            ToggleCorner.Parent = ToggleBackground
            
            -- Toggle Circle
            local ToggleCircle = Instance.new("Frame")
            ToggleCircle.Name = "Circle"
            ToggleCircle.Size = UDim2.new(0, 20, 0, 20)
            ToggleCircle.Position = Toggle.Value and UDim2.new(1, -25, 0.5, -10) or UDim2.new(0, 5, 0.5, -10)
            ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToggleCircle.BorderSizePixel = 0
            ToggleCircle.Parent = ToggleBackground
            
            local CircleCorner = Instance.new("UICorner")
            CircleCorner.CornerRadius = UDim.new(0, 10)
            CircleCorner.Parent = ToggleCircle
            
            -- Toggle Label
            local ToggleLabel = Instance.new("TextLabel")
            ToggleLabel.Name = "Label"
            ToggleLabel.Size = UDim2.new(1, -60, 1, 0)
            ToggleLabel.BackgroundTransparency = 1
            ToggleLabel.Text = Config.Name or "Toggle"
            ToggleLabel.TextColor3 = self.Configuration.Theme.Text
            ToggleLabel.TextSize = 14
            ToggleLabel.Font = Enum.Font.Gotham
            ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            ToggleLabel.Parent = ToggleFrame
            
            local LabelPadding = Instance.new("UIPadding")
            LabelPadding.PaddingLeft = UDim.new(0, 10)
            LabelPadding.Parent = ToggleLabel
            
            -- Toggle functionality
            ToggleButton.MouseButton1Click:Connect(function()
                Toggle.Value = not Toggle.Value
                
                local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                local bgTween = TweenService:Create(ToggleBackground, tweenInfo, {
                    BackgroundColor3 = Toggle.Value and self.Configuration.Theme.Accent or self.Configuration.Theme.Light
                })
                
                local circleTween = TweenService:Create(ToggleCircle, tweenInfo, {
                    Position = Toggle.Value and UDim2.new(1, -25, 0.5, -10) or UDim2.new(0, 5, 0.5, -10)
                })
                
                bgTween:Play()
                circleTween:Play()
                
                if Config.Callback then
                    Config.Callback(Toggle.Value)
                end
                
                if Config.Flag then
                    self.Flags[Config.Flag] = Toggle.Value
                end
            end)
            
            -- Add keybind if specified
            if Config.Keybind then
                local Keybind = self:AddKeybind({
                    Name = Config.Name .. "Keybind",
                    Default = Config.Keybind,
                    Callback = function()
                        ToggleButton:SetAttribute("Pressed", true)
                        task.wait(0.1)
                        ToggleButton:SetAttribute("Pressed", false)
                    end
                })
            end
            
            if Config.Flag then
                self.Flags[Config.Flag] = Toggle.Value
            end
            
            table.insert(Section.Elements, Toggle)
            return Toggle
        end
        
        function Section:AddButton(Config)
            Config = Config or {}
            
            -- Button Frame
            local ButtonFrame = Instance.new("Frame")
            ButtonFrame.Name = Config.Name or "Button"
            ButtonFrame.Size = UDim2.new(1, 0, 0, 35)
            ButtonFrame.BackgroundTransparency = 1
            ButtonFrame.Parent = ElementsContainer
            
            -- Button
            local Button = Instance.new("TextButton")
            Button.Name = "Button"
            Button.Size = UDim2.new(1, 0, 1, 0)
            Button.BackgroundColor3 = self.Configuration.Theme.Light
            Button.Text = Config.Name or "Button"
            Button.TextColor3 = self.Configuration.Theme.Text
            Button.TextSize = 14
            Button.Font = Enum.Font.Gotham
            Button.Parent = ButtonFrame
            
            local ButtonCorner = Instance.new("UICorner")
            ButtonCorner.CornerRadius = UDim.new(0, 6)
            ButtonCorner.Parent = Button
            
            -- Button hover effect
            Button.MouseEnter:Connect(function()
                TweenService:Create(Button, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(
                        math.floor(self.Configuration.Theme.Light.R * 255 * 1.2),
                        math.floor(self.Configuration.Theme.Light.G * 255 * 1.2),
                        math.floor(self.Configuration.Theme.Light.B * 255 * 1.2)
                    )
                }):Play()
            end)
            
            Button.MouseLeave:Connect(function()
                TweenService:Create(Button, TweenInfo.new(0.2), {
                    BackgroundColor3 = self.Configuration.Theme.Light
                }):Play()
            end)
            
            -- Button click
            Button.MouseButton1Click:Connect(function()
                if Config.Callback then
                    Config.Callback()
                end
            end)
        end
        
        function Section:AddSlider(Config)
            Config = Config or {}
            local Slider = {
                Value = Config.Default or Config.Min or 0,
                Type = "Slider"
            }
            
            -- Slider Frame
            local SliderFrame = Instance.new("Frame")
            SliderFrame.Name = Config.Name or "Slider"
            SliderFrame.Size = UDim2.new(1, 0, 0, 60)
            SliderFrame.BackgroundTransparency = 1
            SliderFrame.Parent = ElementsContainer
            
            -- Slider Label
            local SliderLabel = Instance.new("TextLabel")
            SliderLabel.Name = "Label"
            SliderLabel.Size = UDim2.new(1, 0, 0, 20)
            SliderLabel.BackgroundTransparency = 1
            SliderLabel.Text = Config.Name or "Slider"
            SliderLabel.TextColor3 = self.Configuration.Theme.Text
            SliderLabel.TextSize = 14
            SliderLabel.Font = Enum.Font.Gotham
            SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
            SliderLabel.Parent = SliderFrame
            
            local LabelPadding = Instance.new("UIPadding")
            LabelPadding.PaddingLeft = UDim.new(0, 10)
            LabelPadding.Parent = SliderLabel
            
            -- Slider Value
            local ValueLabel = Instance.new("TextLabel")
            ValueLabel.Name = "Value"
            ValueLabel.Size = UDim2.new(0, 50, 0, 20)
            ValueLabel.Position = UDim2.new(1, -60, 0, 0)
            ValueLabel.BackgroundTransparency = 1
            ValueLabel.Text = tostring(Config.Default or Config.Min or 0)
            ValueLabel.TextColor3 = self.Configuration.Theme.SubText
            ValueLabel.TextSize = 14
            ValueLabel.Font = Enum.Font.Gotham
            ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
            ValueLabel.Parent = SliderFrame
            
            -- Slider Background
            local SliderBackground = Instance.new("Frame")
            SliderBackground.Name = "Background"
            SliderBackground.Size = UDim2.new(1, -20, 0, 5)
            SliderBackground.Position = UDim2.new(0, 10, 1, -25)
            SliderBackground.BackgroundColor3 = self.Configuration.Theme.Light
            SliderBackground.BorderSizePixel = 0
            SliderBackground.Parent = SliderFrame
            
            local BackgroundCorner = Instance.new("UICorner")
            BackgroundCorner.CornerRadius = UDim.new(0, 5)
            BackgroundCorner.Parent = SliderBackground
            
            -- Slider Fill
            local SliderFill = Instance.new("Frame")
            SliderFill.Name = "Fill"
            local percent = ((Slider.Value - (Config.Min or 0)) / ((Config.Max or 100) - (Config.Min or 0)))
            SliderFill.Size = UDim2.new(percent, 0, 1, 0)
            SliderFill.BackgroundColor3 = self.Configuration.Theme.Accent
            SliderFill.BorderSizePixel = 0
            SliderFill.Parent = SliderBackground
            
            local FillCorner = Instance.new("UICorner")
            FillCorner.CornerRadius = UDim.new(0, 5)
            FillCorner.Parent = SliderFill
            
            -- Slider Button
            local SliderButton = Instance.new("TextButton")
            SliderButton.Name = "Button"
            SliderButton.Size = UDim2.new(0, 15, 0, 15)
            SliderButton.Position = UDim2.new(percent, -7.5, 0.5, -7.5)
            SliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderButton.Text = ""
            SliderButton.ZIndex = 2
            SliderButton.Parent = SliderBackground
            
            local ButtonCorner = Instance.new("UICorner")
            ButtonCorner.CornerRadius = UDim.new(0, 7.5)
            ButtonCorner.Parent = SliderButton
            
            -- Slider dragging
            local dragging = false
            
            local function updateSlider(input)
                local pos = UDim2.new(
                    math.clamp((input.Position.X - SliderBackground.AbsolutePosition.X) / SliderBackground.AbsoluteSize.X, 0, 1),
                    0,
                    0.5,
                    -7.5
                )
                SliderButton.Position = pos
                
                local value = math.floor(((pos.X.Scale * ((Config.Max or 100) - (Config.Min or 0))) + (Config.Min or 0)) * 100) / 100
                Slider.Value = value
                ValueLabel.Text = tostring(value)
                
                SliderFill.Size = UDim2.new(pos.X.Scale, 0, 1, 0)
                
                if Config.Callback then
                    Config.Callback(value)
                end
                
                if Config.Flag then
                    self.Flags[Config.Flag] = value
                end
            end
            
            SliderButton.MouseButton1Down:Connect(function()
                dragging = true
            end)
            
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)
            
            UserInputService.InputChanged:Connect(function(input)
                if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    updateSlider(input)
                end
            end)
            
            SliderBackground.MouseButton1Down:Connect(function(input)
                updateSlider(input)
                dragging = true
            end)
            
            if Config.Flag then
                self.Flags[Config.Flag] = Slider.Value
            end
            
            table.insert(Section.Elements, Slider)
            return Slider
        end
        
        function Section:AddDropdown(Config)
            Config = Config or {}
            local Dropdown = {
                Value = Config.Default or Config.Options[1],
                Type = "Dropdown",
                Open = false
            }
            
            -- Dropdown Frame
            local DropdownFrame = Instance.new("Frame")
            DropdownFrame.Name = Config.Name or "Dropdown"
            DropdownFrame.Size = UDim2.new(1, 0, 0, 30)
            DropdownFrame.BackgroundTransparency = 1
            DropdownFrame.ClipsDescendants = true
            DropdownFrame.Parent = ElementsContainer
            
            -- Dropdown Button
            local DropdownButton = Instance.new("TextButton")
            DropdownButton.Name = "Button"
            DropdownButton.Size = UDim2.new(1, 0, 0, 30)
            DropdownButton.BackgroundColor3 = self.Configuration.Theme.Light
            DropdownButton.Text = Config.Name or "Dropdown"
            DropdownButton.TextColor3 = self.Configuration.Theme.Text
            DropdownButton.TextSize = 14
            DropdownButton.Font = Enum.Font.Gotham
            DropdownButton.Parent = DropdownFrame
            
            local ButtonCorner = Instance.new("UICorner")
            ButtonCorner.CornerRadius = UDim.new(0, 6)
            ButtonCorner.Parent = DropdownButton
            
            -- Dropdown Arrow
            local Arrow = Instance.new("TextLabel")
            Arrow.Name = "Arrow"
            Arrow.Size = UDim2.new(0, 20, 0, 20)
            Arrow.Position = UDim2.new(1, -25, 0.5, -10)
            Arrow.BackgroundTransparency = 1
            Arrow.Text = "▼"
            Arrow.TextColor3 = self.Configuration.Theme.SubText
            Arrow.TextSize = 12
            Arrow.Font = Enum.Font.GothamBold
            Arrow.Parent = DropdownButton
            
            -- Options Frame
            local OptionsFrame = Instance.new("Frame")
            OptionsFrame.Name = "Options"
            OptionsFrame.Size = UDim2.new(1, 0, 0, 0)
            OptionsFrame.Position = UDim2.new(0, 0, 0, 35)
            OptionsFrame.BackgroundColor3 = self.Configuration.Theme.Dark
            OptionsFrame.BorderSizePixel = 0
            OptionsFrame.Visible = false
            OptionsFrame.Parent = DropdownFrame
            
            local OptionsCorner = Instance.new("UICorner")
            OptionsCorner.CornerRadius = UDim.new(0, 6)
            OptionsCorner.Parent = OptionsFrame
            
            local OptionsLayout = Instance.new("UIListLayout")
            OptionsLayout.Parent = OptionsFrame
            OptionsLayout.SortOrder = Enum.SortOrder.LayoutOrder
            
            -- Create options
            for i, option in pairs(Config.Options or {}) do
                local OptionButton = Instance.new("TextButton")
                OptionButton.Name = option
                OptionButton.Size = UDim2.new(1, 0, 0, 30)
                OptionButton.BackgroundColor3 = self.Configuration.Theme.Dark
                OptionButton.Text = option
                OptionButton.TextColor3 = self.Configuration.Theme.Text
                OptionButton.TextSize = 14
                OptionButton.Font = Enum.Font.Gotham
                OptionButton.Parent = OptionsFrame
                
                OptionButton.MouseButton1Click:Connect(function()
                    Dropdown.Value = option
                    DropdownButton.Text = option
                    Dropdown.Open = false
                    
                    TweenService:Create(OptionsFrame, TweenInfo.new(0.2), {
                        Size = UDim2.new(1, 0, 0, 0)
                    }):Play()
                    
                    TweenService:Create(Arrow, TweenInfo.new(0.2), {
                        Rotation = 0
                    }):Play()
                    
                    task.wait(0.2)
                    OptionsFrame.Visible = false
                    
                    if Config.Callback then
                        Config.Callback(option)
                    end
                    
                    if Config.Flag then
                        self.Flags[Config.Flag] = option
                    end
                end)
                
                OptionButton.MouseEnter:Connect(function()
                    TweenService:Create(OptionButton, TweenInfo.new(0.2), {
                        BackgroundColor3 = self.Configuration.Theme.Light
                    }):Play()
                end)
                
                OptionButton.MouseLeave:Connect(function()
                    TweenService:Create(OptionButton, TweenInfo.new(0.2), {
                        BackgroundColor3 = self.Configuration.Theme.Dark
                    }):Play()
                end)
            end
            
            -- Toggle dropdown
            DropdownButton.MouseButton1Click:Connect(function()
                Dropdown.Open = not Dropdown.Open
                
                if Dropdown.Open then
                    OptionsFrame.Visible = true
                    OptionsFrame.Size = UDim2.new(1, 0, 0, 0)
                    
                    TweenService:Create(OptionsFrame, TweenInfo.new(0.2), {
                        Size = UDim2.new(1, 0, 0, #Config.Options * 30)
                    }):Play()
                    
                    TweenService:Create(Arrow, TweenInfo.new(0.2), {
                        Rotation = 180
                    }):Play()
                else
                    TweenService:Create(OptionsFrame, TweenInfo.new(0.2), {
                        Size = UDim2.new(1, 0, 0, 0)
                    }):Play()
                    
                    TweenService:Create(Arrow, TweenInfo.new(0.2), {
                        Rotation = 0
                    }):Play()
                    
                    task.wait(0.2)
                    OptionsFrame.Visible = false
                end
            end)
            
            if Config.Flag then
                self.Flags[Config.Flag] = Dropdown.Value
            end
            
            table.insert(Section.Elements, Dropdown)
            return Dropdown
        end
        
        function Section:AddKeybind(Config)
            Config = Config or {}
            local Keybind = {
                Value = Config.Default or Enum.KeyCode.RightShift,
                Type = "Keybind",
                Listening = false
            }
            
            -- Keybind Frame
            local KeybindFrame = Instance.new("Frame")
            KeybindFrame.Name = Config.Name or "Keybind"
            KeybindFrame.Size = UDim2.new(1, 0, 0, 30)
            KeybindFrame.BackgroundTransparency = 1
            KeybindFrame.Parent = ElementsContainer
            
            -- Keybind Label
            local KeybindLabel = Instance.new("TextLabel")
            KeybindLabel.Name = "Label"
            KeybindLabel.Size = UDim2.new(0.5, 0, 1, 0)
            KeybindLabel.BackgroundTransparency = 1
            KeybindLabel.Text = Config.Name or "Keybind"
            KeybindLabel.TextColor3 = self.Configuration.Theme.Text
            KeybindLabel.TextSize = 14
            KeybindLabel.Font = Enum.Font.Gotham
            KeybindLabel.TextXAlignment = Enum.TextXAlignment.Left
            KeybindLabel.Parent = KeybindFrame
            
            local LabelPadding = Instance.new("UIPadding")
            LabelPadding.PaddingLeft = UDim.new(0, 10)
            LabelPadding.Parent = KeybindLabel
            
            -- Keybind Button
            local KeybindButton = Instance.new("TextButton")
            KeybindButton.Name = "Button"
            KeybindButton.Size = UDim2.new(0, 100, 0, 25)
            KeybindButton.Position = UDim2.new(1, -110, 0.5, -12.5)
            KeybindButton.BackgroundColor3 = self.Configuration.Theme.Light
            KeybindButton.Text = tostring(Keybind.Value.Name):gsub("Enum.KeyCode.", "")
            KeybindButton.TextColor3 = self.Configuration.Theme.Text
            KeybindButton.TextSize = 14
            KeybindButton.Font = Enum.Font.Gotham
            KeybindButton.Parent = KeybindFrame
            
            local ButtonCorner = Instance.new("UICorner")
            ButtonCorner.CornerRadius = UDim.new(0, 6)
            ButtonCorner.Parent = KeybindButton
            
            -- Keybind listening
            KeybindButton.MouseButton1Click:Connect(function()
                Keybind.Listening = true
                KeybindButton.Text = "..."
                KeybindButton.BackgroundColor3 = self.Configuration.Theme.Accent
            end)
            
            local connection
            connection = UserInputService.InputBegan:Connect(function(input)
                if Keybind.Listening then
                    if input.UserInputType == Enum.UserInputType.Keyboard then
                        Keybind.Value = input.KeyCode
                        KeybindButton.Text = tostring(input.KeyCode.Name)
                        Keybind.Listening = false
                        KeybindButton.BackgroundColor3 = self.Configuration.Theme.Light
                        
                        if Config.Callback then
                            Config.Callback(input.KeyCode)
                        end
                        
                        if Config.Flag then
                            self.Flags[Config.Flag] = input.KeyCode
                        end
                        
                        connection:Disconnect()
                    end
                end
            end)
            
            if Config.Flag then
                self.Flags[Config.Flag] = Keybind.Value
            end
            
            table.insert(Section.Elements, Keybind)
            return Keybind
        end
        
        function Section:AddLabel(Text)
            -- Label Frame
            local LabelFrame = Instance.new("Frame")
            LabelFrame.Name = "Label"
            LabelFrame.Size = UDim2.new(1, 0, 0, 25)
            LabelFrame.BackgroundTransparency = 1
            LabelFrame.Parent = ElementsContainer
            
            -- Label
            local Label = Instance.new("TextLabel")
            Label.Name = "Text"
            Label.Size = UDim2.new(1, 0, 1, 0)
            Label.BackgroundTransparency = 1
            Label.Text = Text
            Label.TextColor3 = self.Configuration.Theme.SubText
            Label.TextSize = 14
            Label.Font = Enum.Font.Gotham
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Parent = LabelFrame
            
            local LabelPadding = Instance.new("UIPadding")
            LabelPadding.PaddingLeft = UDim.new(0, 10)
            LabelPadding.Parent = Label
        end
        
        table.insert(self.Tabs[#self.Tabs].Sections, Section)
        return Section
    end
    
    return Tab
end

function Abyss:ToggleUI()
    if self.ScreenGui then
        self.ScreenGui.Enabled = not self.ScreenGui.Enabled
    end
end

function Abyss:Destroy()
    if self.ScreenGui then
        self.ScreenGui:Destroy()
    end
    
    for _, connection in pairs(self.Connections) do
        connection:Disconnect()
    end
    
    for _, drawing in pairs(self.Drawings) do
        drawing:Remove()
    end
end

-- Bind to RightShift
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        if Abyss.Instance then
            Abyss.Instance:ToggleUI()
        end
    end
end)

return Abyss
