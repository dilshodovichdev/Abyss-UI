--[[
    Abyss Library Remastered
    Optimized for GitHub hosting
    Version: 2.0.0
]]

local Library = {
    Name = "Abyss UI",
    Version = "2.0.0",
    WindowVisible = true,
    Flags = {},
    Config = {},
    Drawings = {},
    Connections = {},
    Theme = {
        Accent = Color3.fromRGB(120, 133, 245),
        Outline = Color3.fromRGB(0, 0, 5),
        Inline = Color3.fromRGB(50, 50, 50),
        LightContrast = Color3.fromRGB(32, 32, 32),
        DarkContrast = Color3.fromRGB(25, 25, 25),
        Text = Color3.fromRGB(232, 232, 232),
        TextInactive = Color3.fromRGB(170, 170, 170),
        Font = Drawing.Fonts.Plex,
        TextSize = 13
    }
}

-- // Services
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

-- // Utility Functions
local Utility = {}

function Utility:CreateDrawing(Type, Properties)
    local DrawingObj = Drawing.new(Type)
    for Property, Value in pairs(Properties) do
        DrawingObj[Property] = Value
    end
    table.insert(Library.Drawings, DrawingObj)
    return DrawingObj
end

function Utility:RemoveDrawing(DrawingObj)
    if DrawingObj then
        DrawingObj.Visible = false
        DrawingObj:Remove()
        local idx = table.find(Library.Drawings, DrawingObj)
        if idx then table.remove(Library.Drawings, idx) end
    end
end

function Utility:Connection(Signal, Callback)
    local Con = Signal:Connect(Callback)
    table.insert(Library.Connections, Con)
    return Con
end

function Utility:IsMouseOver(Obj)
    if not Library.WindowVisible then return false end
    local MouseLoc = UserInputService:GetMouseLocation()
    local Pos = Obj.Position
    local Size = Obj.Size
    return (MouseLoc.X >= Pos.X and MouseLoc.X <= Pos.X + Size.X) and (MouseLoc.Y >= Pos.Y and MouseLoc.Y <= Pos.Y + Size.Y)
end

function Utility:GetTextBounds(Text, Size, Font)
    local bounds = Vector2.new(0, 0)
    -- Mockup functionality since Drawing API doesn't have native TextBounds instant calculation without rendering
    -- Usually handled by creating a temporary object or estimating. 
    -- For this version, we use estimation or strict sizing.
    return Vector2.new(#Text * (Size * 0.5), Size) 
end

-- // Library Functions
function Library:ToggleUI()
    self.WindowVisible = not self.WindowVisible
    for _, DrawingObj in pairs(self.Drawings) do
        if DrawingObj.Transparency then -- Check if property exists
             -- Simple toggle visibility logic, can be enhanced with fading
             DrawingObj.Visible = self.WindowVisible
        end
    end
end

function Library:Unload()
    for _, Con in pairs(self.Connections) do Con:Disconnect() end
    for _, Draw in pairs(self.Drawings) do pcall(function() Draw:Remove() end) end
    Library.Drawings = {}
    Library.Connections = {}
    Library.Flags = {}
end

-- // Window Creation
function Library:CreateWindow(Title, Size)
    local Window = {
        Tabs = {},
        ActiveTab = nil
    }
    
    -- Main Window Structure
    local MainFrame = Utility:CreateDrawing("Square", {
        Size = Size,
        Position = Vector2.new(Camera.ViewportSize.X / 2 - Size.X / 2, Camera.ViewportSize.Y / 2 - Size.Y / 2),
        Color = Library.Theme.Outline,
        Filled = true,
        Thickness = 1,
        Visible = true,
        ZIndex = 1
    })

    local MainBorder = Utility:CreateDrawing("Square", {
        Size = Vector2.new(Size.X - 2, Size.Y - 2),
        Position = MainFrame.Position + Vector2.new(1, 1),
        Color = Library.Theme.Accent,
        Filled = true,
        Visible = true,
        ZIndex = 2
    })

    local MainBackground = Utility:CreateDrawing("Square", {
        Size = Vector2.new(Size.X - 4, Size.Y - 4),
        Position = MainFrame.Position + Vector2.new(2, 2),
        Color = Library.Theme.DarkContrast,
        Filled = true,
        Visible = true,
        ZIndex = 3
    })

    local TopBarTitle = Utility:CreateDrawing("Text", {
        Text = Title,
        Font = Library.Theme.Font,
        Size = Library.Theme.TextSize,
        Color = Library.Theme.Text,
        Position = MainBackground.Position + Vector2.new(8, 6),
        Visible = true,
        ZIndex = 4
    })
    
    -- Dragging Logic
    local Dragging, DragInput, DragStart, StartPos
    Utility:Connection(MainFrame.InputBegan, function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 then
            Dragging = true
            DragStart = Input.Position
            StartPos = MainFrame.Position
        end
    end) -- Note: Drawing API doesn't have InputBegan directly on objects usually, needs global check.
    
    -- Global Drag Fix
    Utility:Connection(UserInputService.InputBegan, function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 and Utility:IsMouseOver(MainFrame) then
            Dragging = true
            DragStart = Input.Position
            StartPos = MainFrame.Position
        end
    end)
    
    Utility:Connection(UserInputService.InputChanged, function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseMovement and Dragging then
            local Delta = Input.Position - DragStart
            local NewPos = StartPos + Vector2.new(Delta.X, Delta.Y)
            
            MainFrame.Position = NewPos
            MainBorder.Position = NewPos + Vector2.new(1, 1)
            MainBackground.Position = NewPos + Vector2.new(2, 2)
            TopBarTitle.Position = NewPos + Vector2.new(8, 6)
            
            -- Refresh Tabs
            if Window.ActiveTab then
                Window.ActiveTab:Update()
            end
        end
    end)

    Utility:Connection(UserInputService.InputEnded, function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 then Dragging = false end
    end)

    -- // Tab System
    local TabAreaStart = MainBackground.Position + Vector2.new(10, 30)
    local CurrentTabOffset = 0

    function Window:AddTab(Name)
        local Tab = {
            Name = Name,
            Sections = {Left = {}, Right = {}},
            Visible = false
        }
        
        local TabButton = Utility:CreateDrawing("Text", {
            Text = Name,
            Font = Library.Theme.Font,
            Size = Library.Theme.TextSize,
            Color = Library.Theme.TextInactive,
            Position = TabAreaStart + Vector2.new(CurrentTabOffset, 0),
            Visible = true,
            ZIndex = 4
        })
        
        local TextWidth = Utility:GetTextBounds(Name, Library.Theme.TextSize).X + 15
        CurrentTabOffset = CurrentTabOffset + TextWidth

        -- Tab Click Logic
        Utility:Connection(UserInputService.InputBegan, function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                -- Checking strict bounds for text button is tricky in Drawing API without background
                -- Assuming a clickable area around the text
                local MouseLoc = UserInputService:GetMouseLocation()
                local TP = TabButton.Position
                if MouseLoc.X >= TP.X and MouseLoc.X <= TP.X + TextWidth and MouseLoc.Y >= TP.Y and MouseLoc.Y <= TP.Y + 15 then
                   Window:SelectTab(Tab)
                end
            end
        end)
        
        function Tab:Update()
            -- Placeholder for updating positions of elements inside the tab when window moves
            for side, sections in pairs(Tab.Sections) do
                for _, section in pairs(sections) do
                    section:UpdatePosition()
                end
            end
        end

        function Tab:Show(bool)
            Tab.Visible = bool
            TabButton.Color = bool and Library.Theme.Accent or Library.Theme.TextInactive
            for side, sections in pairs(Tab.Sections) do
                for _, section in pairs(sections) do
                    section:SetVisible(bool)
                end
            end
        end

        function Tab:AddSection(Title, Side)
            local Section = {
                Elements = {},
                Offset = 0
            }
            
            -- Calculate Position based on Side (Left/Right)
            local BaseX = (Side == "Left") and (MainBackground.Position.X + 15) or (MainBackground.Position.X + Size.X / 2 + 5)
            local BaseY = MainBackground.Position.Y + 60
            
            -- Accumulate Y offset based on previous sections would go here
            -- For simplicity in this optimized version, we assume one column flow per side
            local SectionIndex = #Tab.Sections[Side]
            local PrevHeight = 0 
            for _, s in pairs(Tab.Sections[Side]) do PrevHeight = PrevHeight + s:GetHeight() + 10 end

            local SectionPos = Vector2.new(BaseX, BaseY + PrevHeight)
            local SectionSize = Vector2.new((Size.X / 2) - 20, 25) -- Starts small, grows

            local SectionBox = Utility:CreateDrawing("Square", {
                Size = SectionSize,
                Position = SectionPos,
                Color = Library.Theme.Inline,
                Filled = true,
                Visible = false,
                ZIndex = 4
            })
            
            local SectionTitle = Utility:CreateDrawing("Text", {
                Text = Title,
                Font = Library.Theme.Font,
                Size = Library.Theme.TextSize,
                Color = Library.Theme.Text,
                Position = SectionPos + Vector2.new(5, 5),
                Visible = false,
                ZIndex = 5
            })

            function Section:GetHeight()
                return Section.Offset + 30
            end

            function Section:UpdatePosition()
                -- Dynamic Position Update Logic would go here
                SectionBox.Position = MainFrame.Position + (SectionPos - StartPos) -- offset logic needed
            end

            function Section:SetVisible(bool)
                SectionBox.Visible = bool
                SectionTitle.Visible = bool
                for _, elem in pairs(Section.Elements) do
                    elem:SetVisible(bool)
                end
            end
            
            -- // Element: Toggle
            function Section:AddToggle(Config)
                local Toggle = {
                    State = Config.Default or false,
                    Callback = Config.Callback or function() end,
                    Flag = Config.Flag or Utility:GenerateRandomString()
                }
                Library.Flags[Toggle.Flag] = Toggle.State

                local ToggleY = SectionPos.Y + 25 + Section.Offset
                local ToggleBox = Utility:CreateDrawing("Square", {
                    Size = Vector2.new(12, 12),
                    Position = Vector2.new(SectionPos.X + 10, ToggleY),
                    Color = Toggle.State and Library.Theme.Accent or Library.Theme.LightContrast,
                    Filled = true,
                    Visible = false,
                    ZIndex = 5
                })
                
                local ToggleText = Utility:CreateDrawing("Text", {
                    Text = Config.Title,
                    Font = Library.Theme.Font,
                    Size = Library.Theme.TextSize,
                    Color = Library.Theme.Text,
                    Position = Vector2.new(SectionPos.X + 30, ToggleY - 2),
                    Visible = false,
                    ZIndex = 5
                })

                Utility:Connection(UserInputService.InputBegan, function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 and Tab.Visible then
                        if Utility:IsMouseOver(ToggleBox) or Utility:IsMouseOver(ToggleText) then
                            Toggle.State = not Toggle.State
                            Library.Flags[Toggle.Flag] = Toggle.State
                            ToggleBox.Color = Toggle.State and Library.Theme.Accent or Library.Theme.LightContrast
                            Toggle.Callback(Toggle.State)
                        end
                    end
                end)

                function Toggle:SetVisible(bool)
                    ToggleBox.Visible = bool
                    ToggleText.Visible = bool
                end

                table.insert(Section.Elements, Toggle)
                Section.Offset = Section.Offset + 20
                -- Update Section Box Height
                SectionBox.Size = Vector2.new(SectionBox.Size.X, Section.Offset + 30)
                return Toggle
            end
            
            -- // Element: Button
            function Section:AddButton(Config)
                 local ButtonY = SectionPos.Y + 25 + Section.Offset
                 local ButtonBox = Utility:CreateDrawing("Square", {
                    Size = Vector2.new(SectionBox.Size.X - 20, 20),
                    Position = Vector2.new(SectionPos.X + 10, ButtonY),
                    Color = Library.Theme.LightContrast,
                    Filled = true,
                    Visible = false,
                    ZIndex = 5
                 })

                 local ButtonText = Utility:CreateDrawing("Text", {
                     Text = Config.Title,
                     Font = Library.Theme.Font,
                     Size = Library.Theme.TextSize,
                     Color = Library.Theme.Text,
                     Center = true,
                     Position = Vector2.new(ButtonBox.Position.X + ButtonBox.Size.X/2, ButtonY + 3),
                     Visible = false,
                     ZIndex = 6
                 })

                 Utility:Connection(UserInputService.InputBegan, function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 and Tab.Visible then
                        if Utility:IsMouseOver(ButtonBox) then
                            Config.Callback()
                            -- Simple click animation effect
                            ButtonBox.Color = Library.Theme.Accent
                            task.delay(0.1, function() ButtonBox.Color = Library.Theme.LightContrast end)
                        end
                    end
                 end)

                 function ButtonBox:SetVisible(bool)
                     ButtonBox.Visible = bool
                     ButtonText.Visible = bool
                 end

                 table.insert(Section.Elements, ButtonBox)
                 Section.Offset = Section.Offset + 25
                 SectionBox.Size = Vector2.new(SectionBox.Size.X, Section.Offset + 30)
            end

            -- // Element: Slider
            function Section:AddSlider(Config)
                local Slider = {
                    Value = Config.Default or Config.Min,
                    Min = Config.Min or 0,
                    Max = Config.Max or 100,
                    Callback = Config.Callback or function() end,
                    Flag = Config.Flag or "Slider"
                }

                local SliderY = SectionPos.Y + 25 + Section.Offset
                local SliderBg = Utility:CreateDrawing("Square", {
                    Size = Vector2.new(SectionBox.Size.X - 20, 10),
                    Position = Vector2.new(SectionPos.X + 10, SliderY + 15),
                    Color = Library.Theme.LightContrast,
                    Filled = true,
                    Visible = false,
                    ZIndex = 5
                })

                local SliderFill = Utility:CreateDrawing("Square", {
                    Size = Vector2.new(0, 10),
                    Position = SliderBg.Position,
                    Color = Library.Theme.Accent,
                    Filled = true,
                    Visible = false,
                    ZIndex = 6
                })

                local SliderTitle = Utility:CreateDrawing("Text", {
                    Text = Config.Title .. ": " .. tostring(Slider.Value),
                    Font = Library.Theme.Font,
                    Size = Library.Theme.TextSize,
                    Color = Library.Theme.Text,
                    Position = Vector2.new(SectionPos.X + 10, SliderY),
                    Visible = false,
                    ZIndex = 5
                })

                local DraggingSlider = false

                local function UpdateSlider(Input)
                    local SizeX = SliderBg.Size.X
                    local Percent = math.clamp((Input.Position.X - SliderBg.Position.X) / SizeX, 0, 1)
                    local NewValue = math.floor(Slider.Min + (Slider.Max - Slider.Min) * Percent)
                    
                    Slider.Value = NewValue
                    SliderFill.Size = Vector2.new(SizeX * Percent, 10)
                    SliderTitle.Text = Config.Title .. ": " .. tostring(NewValue)
                    
                    Library.Flags[Slider.Flag] = NewValue
                    Slider.Callback(NewValue)
                end

                Utility:Connection(UserInputService.InputBegan, function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 and Tab.Visible and Utility:IsMouseOver(SliderBg) then
                        DraggingSlider = true
                        UpdateSlider(Input)
                    end
                end)

                Utility:Connection(UserInputService.InputEnded, function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 then DraggingSlider = false end
                end)

                Utility:Connection(UserInputService.InputChanged, function(Input)
                    if DraggingSlider and Input.UserInputType == Enum.UserInputType.MouseMovement then
                        UpdateSlider(Input)
                    end
                end)

                -- Initialize
                local StartPercent = (Slider.Value - Slider.Min) / (Slider.Max - Slider.Min)
                SliderFill.Size = Vector2.new(SliderBg.Size.X * StartPercent, 10)

                function Slider:SetVisible(bool)
                    SliderBg.Visible = bool
                    SliderFill.Visible = bool
                    SliderTitle.Visible = bool
                end

                table.insert(Section.Elements, Slider)
                Section.Offset = Section.Offset + 35
                SectionBox.Size = Vector2.new(SectionBox.Size.X, Section.Offset + 30)
            end

            table.insert(Tab.Sections[Side], Section)
            return Section
        end

        table.insert(Window.Tabs, Tab)
        if #Window.Tabs == 1 then Window:SelectTab(Tab) end -- Select first tab
        return Tab
    end

    function Window:SelectTab(Tab)
        Window.ActiveTab = Tab
        for _, t in pairs(Window.Tabs) do
            t:Show(false)
        end
        Tab:Show(true)
    end

    return Window
end

return Library
