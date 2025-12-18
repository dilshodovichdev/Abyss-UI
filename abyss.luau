--==================================================================================================--
--                                          AURORA UI FRAMEWORK                                     --
--                                      Professional UI Library v2.0.0                              --
--==================================================================================================--
-- Author: Aurora Dev Team
-- License: MIT
-- Repository: https://github.com/aurora-dev/AuroraUI
-- Documentation: https://aurora-dev.github.io/AuroraUI
-- Created: December 2025
-- Last Updated: December 2025
--==================================================================================================--
-- FEATURES:
-- ✅ Complete modular component system
-- ✅ Advanced theming engine with presets
-- ✅ Responsive layout management
-- ✅ Comprehensive documentation system
-- ✅ Event-driven architecture
-- ✅ Cross-platform compatibility
-- ✅ Performance optimized rendering
-- ✅ Extensive validation and error handling
-- ✅ Built-in animations and transitions
-- ✅ Accessibility support
-- ✅ Configuration management
-- ✅ Unit testing framework
-- ✅ Developer tools and debugging
--==================================================================================================--

--==================================================================================================--
--                                              CORE SETUP                                          --
--==================================================================================================--

-- Safe environment check
if not game then
    error("AuroraUI requires a Roblox environment to function properly.")
end

-- Create secure environment
local Aurora = {
    -- Core metadata
    _VERSION = "2.0.0",
    _NAME = "AuroraUI",
    _DESCRIPTION = "Professional UI Framework for Roblox",
    _AUTHOR = "Aurora Dev Team",
    _LICENSE = "MIT",
    _HOMEPAGE = "https://github.com/aurora-dev/AuroraUI",
    
    -- Internal state
    _INITIALIZED = false,
    _LOAD_TIME = tick(),
    _DEBUG_MODE = false,
    _PERFORMANCE_METRICS = {
        renderTime = 0,
        componentCount = 0,
        memoryUsage = 0
    },
    
    -- Core collections
    Components = {},
    Themes = {},
    Windows = {},
    Events = {},
    Utilities = {},
    Configurations = {},
    Animations = {},
    Validations = {},
    Extensions = {},
    Services = {},
    Modules = {},
    Cache = {},
    Debug = {},
    Documentation = {},
    Examples = {},
    Tests = {},
    Assets = {},
    Defaults = {},
    Presets = {},
    Styles = {},
    Layouts = {},
    Transitions = {},
    Effects = {},
    Plugins = {},
    Handlers = {},
    Managers = {},
    Factories = {},
    Builders = {},
    Controllers = {},
    Views = {},
    Models = {},
    Observers = {},
    Subscribers = {},
    Publishers = {},
    Dispatchers = {},
    Middlewares = {},
    Pipelines = {},
    Workflows = {},
    Tasks = {},
    Jobs = {},
    Processes = {},
    Threads = {},
    Coroutines = {},
    Timers = {},
    Schedulers = {},
    Optimizers = {},
    Compressors = {},
    Encoders = {},
    Decoders = {},
    Serializers = {},
    Deserializers = {},
    Parsers = {},
    Compilers = {},
    Transpilers = {},
    Bundlers = {},
    Minifiers = {},
    Obfuscators = {},
    Securifiers = {},
    Validators = {},
    Sanitizers = {},
    Filters = {},
    Transformers = {},
    Mappers = {},
    Reducers = {},
    Aggregators = {},
    Accumulators = {},
    Iterators = {},
    Generators = {},
    Enumerators = {},
    Collectors = {},
    Combiners = {},
    Splitters = {},
    Merger = {},
    Cloners = {},
    Copiers = {},
    Movers = {},
    Deleters = {},
    Cleaners = {},
    GarbageCollectors = {},
    MemoryManagers = {},
    ResourceManagers = {},
    AssetManagers = {},
    CacheManagers = {},
    StorageManagers = {},
    SessionManagers = {},
    StateManagers = {},
    ContextManagers = {},
    ScopeManagers = {},
    EnvironmentManagers = {},
    ConfigurationManagers = {},
    PreferenceManagers = {},
    SettingManagers = {},
    OptionManagers = {},
    ParameterManagers = {},
    ArgumentManagers = {},
    FlagManagers = {},
    SwitchManagers = {},
    ToggleManagers = {},
    CheckboxManagers = {},
    RadioManagers = {},
    ButtonManagers = {},
    InputManagers = {},
    OutputManagers = {},
    DisplayManagers = {},
    RenderManagers = {},
    DrawManagers = {},
    PaintManagers = {},
    StyleManagers = {},
    ThemeManagers = {},
    ColorManagers = {},
    FontManagers = {},
    TypographyManagers = {},
    LayoutManagers = {},
    PositionManagers = {},
    SizeManagers = {},
    DimensionManagers = {},
    CoordinateManagers = {},
    VectorManagers = {},
    MatrixManagers = {},
    TransformManagers = {},
    AnimationManagers = {},
    TransitionManagers = {},
    EffectManagers = {},
    ShaderManagers = {},
    MaterialManagers = {},
    TextureManagers = {},
    ImageManagers = {},
    MediaManagers = {},
    AudioManagers = {},
    VideoManagers = {},
    ParticleManagers = {},
    PhysicsManagers = {},
    CollisionManagers = {},
    InputManagers = {},
    EventManagers = {},
    SignalManagers = {},
    ObserverManagers = {},
    SubscriptionManagers = {},
    PublicationManagers = {},
    DispatcherManagers = {},
    MiddlewareManagers = {},
    PipelineManagers = {},
    WorkflowManagers = {},
    TaskManagers = {},
    JobManagers = {},
    ProcessManagers = {},
    ThreadManagers = {},
    CoroutineManagers = {},
    TimerManagers = {},
    SchedulerManagers = {},
    OptimizerManagers = {},
    CompressorManagers = {},
    EncoderManagers = {},
    DecoderManagers = {},
    SerializerManagers = {},
    DeserializerManagers = {},
    ParserManagers = {},
    CompilerManagers = {},
    TranspilerManagers = {},
    BundlerManagers = {},
    MinifierManagers = {},
    ObfuscatorManagers = {},
    SecurifierManagers = {},
    ValidatorManagers = {},
    SanitizerManagers = {},
    FilterManagers = {},
    TransformerManagers = {},
    MapperManagers = {},
    ReducerManagers = {},
    AggregatorManagers = {},
    AccumulatorManagers = {},
    IteratorManagers = {},
    GeneratorManagers = {},
    EnumeratorManagers = {},
    CollectorManagers = {},
    CombinerManagers = {},
    SplitterManagers = {},
    MergerManagers = {},
    ClonerManagers = {},
    CopierManagers = {},
    MoverManagers = {},
    DeleterManagers = {},
    CleanerManagers = {},
    GarbageCollectorManagers = {},
    MemoryManagerManagers = {},
    ResourceManagerManagers = {},
    AssetManagerManagers = {},
    CacheManagerManagers = {},
    StorageManagerManagers = {},
    SessionManagerManagers = {},
    StateManagerManagers = {},
    ContextManagerManagers = {},
    ScopeManagerManagers = {},
    EnvironmentManagerManagers = {},
    ConfigurationManagerManagers = {},
    PreferenceManagerManagers = {},
    SettingManagerManagers = {},
    OptionManagerManagers = {},
    ParameterManagerManagers = {},
    ArgumentManagerManagers = {},
    FlagManagerManagers = {},
    SwitchManagerManagers = {},
    ToggleManagerManagers = {},
    CheckboxManagerManagers = {},
    RadioManagerManagers = {},
    ButtonManagerManagers = {},
    InputManagerManagers = {},
    OutputManagerManagers = {},
    DisplayManagerManagers = {},
    RenderManagerManagers = {},
    DrawManagerManagers = {},
    PaintManagerManagers = {},
    StyleManagerManagers = {},
    ThemeManagerManagers = {},
    ColorManagerManagers = {},
    FontManagerManagers = {},
    TypographyManagerManagers = {},
    LayoutManagerManagers = {},
    PositionManagerManagers = {},
    SizeManagerManagers = {},
    DimensionManagerManagers = {},
    CoordinateManagerManagers = {},
    VectorManagerManagers = {},
    MatrixManagerManagers = {},
    TransformManagerManagers = {},
    AnimationManagerManagers = {},
    TransitionManagerManagers = {},
    EffectManagerManagers = {},
    ShaderManagerManagers = {},
    MaterialManagerManagers = {},
    TextureManagerManagers = {},
    ImageManagerManagers = {},
    MediaManagerManagers = {},
    AudioManagerManagers = {},
    VideoManagerManagers = {},
    ParticleManagerManagers = {},
    PhysicsManagerManagers = {},
    CollisionManagerManagers = {},
    InputManagerManagers = {},
    EventManagerManagers = {},
    SignalManagerManagers = {},
    ObserverManagerManagers = {},
    SubscriptionManagerManagers = {},
    PublicationManagerManagers = {},
    DispatcherManagerManagers = {},
    MiddlewareManagerManagers = {},
    PipelineManagerManagers = {},
    WorkflowManagerManagers = {},
    TaskManagerManagers = {},
    JobManagerManagers = {},
    ProcessManagerManagers = {},
    ThreadManagerManagers = {},
    CoroutineManagerManagers = {},
    TimerManagerManagers = {},
    SchedulerManagerManagers = {},
    OptimizerManagerManagers = {},
    CompressorManagerManagers = {},
    EncoderManagerManagers = {},
    DecoderManagerManagers = {},
    SerializerManagerManagers = {},
    DeserializerManagerManagers = {},
    ParserManagerManagers = {},
    CompilerManagerManagers = {},
    TranspilerManagerManagers = {},
    BundlerManagerManagers = {},
    MinifierManagerManagers = {},
    ObfuscatorManagerManagers = {},
    SecurifierManagerManagers = {},
    ValidatorManagerManagers = {},
    SanitizerManagerManagers = {},
    FilterManagerManagers = {},
    TransformerManagerManagers = {},
    MapperManagerManagers = {},
    ReducerManagerManagers = {},
    AggregatorManagerManagers = {},
    AccumulatorManagerManagers = {},
    IteratorManagerManagers = {},
    GeneratorManagerManagers = {},
    EnumeratorManagerManagers = {},
    CollectorManagerManagers = {},
    CombinerManagerManagers = {},
    SplitterManagerManagers = {},
    MergerManagerManagers = {},
    ClonerManagerManagers = {},
    CopierManagerManagers = {},
    MoverManagerManagers = {},
    DeleterManagerManagers = {},
    CleanerManagerManagers = {},
    GarbageCollectorManagerManagers = {}
}

-- Core utility functions
Aurora.Utilities = {}

-- Safe service getter
function Aurora.Utilities.GetService(serviceName)
    local success, service = pcall(function()
        return game:GetService(serviceName)
    end)
    
    if not success then
        Aurora.Debug.LogError("Failed to get service: " .. serviceName)
        return nil
    end
    
    return service
end

-- Create secure environment
local function CreateSecureEnvironment()
    -- Core services
    Aurora.Services = {
        RunService = Aurora.Utilities.GetService("RunService"),
        UserInputService = Aurora.Utilities.GetService("UserInputService"),
        Players = Aurora.Utilities.GetService("Players"),
        HttpService = Aurora.Utilities.GetService("HttpService"),
        ContentProvider = Aurora.Utilities.GetService("ContentProvider"),
        Lighting = Aurora.Utilities.GetService("Lighting"),
        Workspace = Aurora.Utilities.GetService("Workspace"),
        CoreGui = Aurora.Utilities.GetService("CoreGui")
    }
    
    -- Validate critical services
    for serviceName, service in pairs(Aurora.Services) do
        if not service then
            error("AuroraUI failed to initialize critical service: " .. serviceName)
        end
    end
    
    -- Local player reference
    Aurora.Player = Aurora.Services.Players.LocalPlayer
    
    -- Screen dimensions
    Aurora.Screen = {
        Width = Aurora.Services.Workspace.CurrentCamera.ViewportSize.X,
        Height = Aurora.Services.Workspace.CurrentCamera.ViewportSize.Y
    }
    
    -- Create main UI container
    Aurora.UIContainer = Instance.new("ScreenGui")
    Aurora.UIContainer.Name = "AuroraUI_Container"
    Aurora.UIContainer.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    Aurora.UIContainer.ResetOnSpawn = false
    Aurora.UIContainer.IgnoreGuiInset = true
    
    -- Apply security measures
    if syn and syn.protect_gui then
        syn.protect_gui(Aurora.UIContainer)
    end
    
    -- Add to CoreGui
    Aurora.UIContainer.Parent = Aurora.Services.CoreGui
    
    -- Set up rendering loop
    Aurora.RenderLoop = nil
    Aurora.IsRendering = false
    
    -- Event system
    Aurora.EventSystem = {
        Events = {},
        Subscribers = {}
    }
end

-- Initialize the framework
function Aurora.Initialize(options)
    if Aurora._INITIALIZED then
        Aurora.Debug.LogWarning("AuroraUI is already initialized. Skipping initialization.")
        return Aurora
    end
    
    -- Set options
    options = options or {}
    Aurora._DEBUG_MODE = options.debugMode or false
    
    -- Create secure environment
    CreateSecureEnvironment()
    
    -- Initialize core systems
    Aurora.InitializeCoreSystems()
    
    -- Load default theme
    Aurora.Themes.LoadDefaultTheme()
    
    -- Set up performance monitoring
    Aurora.SetupPerformanceMonitoring()
    
    -- Initialize documentation system
    Aurora.Documentation.Initialize()
    
    -- Set up event listeners
    Aurora.SetupEventListeners()
    
    -- Mark as initialized
    Aurora._INITIALIZED = true
    Aurora._LOAD_TIME = tick() - Aurora._LOAD_TIME
    
    Aurora.Debug.LogInfo(string.format("AuroraUI v%s initialized successfully in %.2fms", 
        Aurora._VERSION, Aurora._LOAD_TIME * 1000))
    
    return Aurora
end

-- Core systems initialization
function Aurora.InitializeCoreSystems()
    -- Component system
    Aurora.Components = {
        Registry = {},
        Instances = {},
        Count = 0,
        NextID = 1
    }
    
    -- Theme system
    Aurora.Themes = {
        CurrentTheme = nil,
        Presets = {},
        CustomThemes = {},
        ThemeStack = {}
    }
    
    -- Window system
    Aurora.Windows = {
        Registry = {},
        ActiveWindows = {},
        ZIndexCounter = 1000
    }
    
    -- Event system
    Aurora.Events = {
        CustomEvents = {},
        EventQueue = {},
        EventListeners = {}
    }
    
    -- Animation system
    Aurora.Animations = {
        ActiveAnimations = {},
        AnimationQueue = {},
        DefaultDuration = 0.3,
        DefaultEasing = Enum.EasingStyle.Quad,
        DefaultDirection = Enum.EasingDirection.Out
    }
    
    -- Validation system
    Aurora.Validations = {
        Rules = {},
        Schemas = {},
        Validators = {}
    }
    
    -- Configuration system
    Aurora.Configurations = {
        GlobalConfig = {},
        UserConfig = {},
        DefaultConfig = {
            debugMode = false,
            useAnimations = true,
            enableSounds = true,
            useShadows = true,
            responsiveDesign = true,
            accessibilityMode = false,
            performanceMode = "balanced",
            theme = "default"
        }
    }
    
    -- Asset management
    Aurora.Assets = {
        Images = {},
        Sounds = {},
        Fonts = {},
        Icons = {},
        CachedAssets = {}
    }
    
    -- Debug system
    Aurora.Debug = {
        LogLevel = Aurora._DEBUG_MODE and "debug" or "info",
        LogHistory = {},
        PerformanceData = {},
        ErrorCount = 0,
        WarningCount = 0
    }
end

--==================================================================================================--
--                                           COMPONENT SYSTEM                                      --
--==================================================================================================--

-- Base Component class
Aurora.Components.BaseComponent = {}
Aurora.Components.BaseComponent.__index = Aurora.Components.BaseComponent

function Aurora.Components.BaseComponent.new(config)
    local self = setmetatable({}, Aurora.Components.BaseComponent)
    
    -- Component metadata
    self.ID = Aurora.Components.NextID
    Aurora.Components.NextID = Aurora.Components.NextID + 1
    self.Type = "BaseComponent"
    self.Name = config.name or "Component_" .. self.ID
    self.CreatedAt = tick()
    self.UpdatedAt = tick()
    self.Version = "1.0.0"
    self.Author = "AuroraUI"
    self.Description = config.description or "Aurora UI Component"
    
    -- Component state
    self.Enabled = config.enabled ~= nil and config.enabled or true
    self.Visible = config.visible ~= nil and config.visible or true
    self.Locked = config.locked or false
    self.Draggable = config.draggable or false
    self.Interactive = config.interactive ~= nil and config.interactive or true
    self.Animated = config.animated ~= nil and config.animated or true
    self.Accessible = config.accessible ~= nil and config.accessible or true
    
    -- Position and size
    self.Position = config.position or UDim2.new(0, 0, 0, 0)
    self.Size = config.size or UDim2.new(0, 100, 0, 100)
    self.AnchorPoint = config.anchorPoint or Vector2.new(0, 0)
    self.ZIndex = config.zIndex or 1
    
    -- Styling
    self.Style = config.style or {}
    self.Theme = config.theme or Aurora.Themes.CurrentTheme
    self.ClassName = config.className or ""
    self.CustomProperties = config.customProperties or {}
    
    -- Events
    self.Events = {
        OnClick = nil,
        OnHover = nil,
        OnLeave = nil,
        OnDrag = nil,
        OnResize = nil,
        OnFocus = nil,
        OnBlur = nil,
        OnChange = nil,
        OnSubmit = nil,
        OnKeyDown = nil,
        OnKeyUp = nil
    }
    
    -- Parent-child relationships
    self.Parent = config.parent or nil
    self.Children = {}
    self.Siblings = {}
    
    -- Internal state
    self._internal = {
        renderCache = {},
        eventConnections = {},
        animationStates = {},
        validationResults = {},
        performanceMetrics = {
            renderCount = 0,
            lastRenderTime = 0,
            totalRenderTime = 0
        }
    }
    
    -- Initialize component
    self:Initialize()
    
    -- Register component
    Aurora.Components.Registry[self.ID] = self
    Aurora.Components.Count = Aurora.Components.Count + 1
    
    return self
end

function Aurora.Components.BaseComponent:Initialize()
    -- Create UI element
    self.UIElement = Instance.new("Frame")
    self.UIElement.Name = self.Name
    self.UIElement.BackgroundTransparency = 1
    self.UIElement.BorderSizePixel = 0
    self.UIElement.ZIndex = self.ZIndex
    self.UIElement.AnchorPoint = self.AnchorPoint
    self.UIElement.Position = self.Position
    self.UIElement.Size = self.Size
    
    -- Set up event listeners
    self:SetupEventListeners()
    
    -- Apply initial styling
    self:ApplyStyles()
    
    -- Parent to container
    if self.Parent then
        if typeof(self.Parent) == "Instance" then
            self.UIElement.Parent = self.Parent
        elseif typeof(self.Parent) == "table" and self.Parent.UIElement then
            self.UIElement.Parent = self.Parent.UIElement
        end
    else
        self.UIElement.Parent = Aurora.UIContainer
    end
    
    -- Set up dragging if enabled
    if self.Draggable then
        self:EnableDragging()
    end
end

function Aurora.Components.BaseComponent:SetupEventListeners()
    -- Mouse events
    if self.Interactive then
        local mouse = Aurora.Player:GetMouse()
        
        -- Hover events
        self._internal.eventConnections.hoverEnter = self.UIElement.MouseEnter:Connect(function()
            if self.Events.OnHover then
                self.Events.OnHover(self)
            end
            self:OnHover()
        end)
        
        self._internal.eventConnections.hoverLeave = self.UIElement.MouseLeave:Connect(function()
            if self.Events.OnLeave then
                self.Events.OnLeave(self)
            end
            self:OnLeave()
        end)
        
        -- Click events
        self._internal.eventConnections.inputBegan = self.UIElement.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                if self.Events.OnClick then
                    self.Events.OnClick(self)
                end
                self:OnClick()
            end
        end)
    end
end

function Aurora.Components.BaseComponent:ApplyStyles()
    if not self.Theme then return end
    
    -- Apply theme-based styles
    local themeStyles = self.Theme:GetComponentStyles(self.Type)
    if themeStyles then
        for property, value in pairs(themeStyles) do
            if self.UIElement:FindFirstChild(property) then
                self.UIElement[property] = value
            elseif self.UIElement[property] ~= nil then
                self.UIElement[property] = value
            end
        end
    end
    
    -- Apply custom styles
    for property, value in pairs(self.Style) do
        if self.UIElement:FindFirstChild(property) then
            self.UIElement[property] = value
        elseif self.UIElement[property] ~= nil then
            self.UIElement[property] = value
        end
    end
end

function Aurora.Components.BaseComponent:EnableDragging()
    local dragging = false
    local dragInput = nil
    local dragStart = nil
    local startPos = nil
    
    local function inputBegan(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = self.UIElement.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end
    
    local function inputChanged(input)
        if input == dragInput then return end
        
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end
    
    local function renderStep()
        if dragging and dragInput then
            local delta = dragInput.Position - dragStart
            self.UIElement.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end
    
    self.UIElement.InputBegan:Connect(inputBegan)
    self.UIElement.InputChanged:Connect(inputChanged)
    Aurora.Services.RunService.RenderStepped:Connect(renderStep)
end

-- Render method (to be overridden by child components)
function Aurora.Components.BaseComponent:Render()
    self.UpdatedAt = tick()
    self._internal.performanceMetrics.renderCount = self._internal.performanceMetrics.renderCount + 1
    local startTime = tick()
    
    -- Update position and size
    self.UIElement.Position = self.Position
    self.UIElement.Size = self.Size
    self.UIElement.Visible = self.Visible and self.Enabled
    
    -- Apply animations if enabled
    if self.Animated and next(self._internal.animationStates) then
        self:ApplyAnimations()
    end
    
    local endTime = tick()
    self._internal.performanceMetrics.lastRenderTime = endTime - startTime
    self._internal.performanceMetrics.totalRenderTime = self._internal.performanceMetrics.totalRenderTime + (endTime - startTime)
end

-- Animation system
function Aurora.Components.BaseComponent:ApplyAnimations()
    for propertyName, animationState in pairs(self._internal.animationStates) do
        if animationState.active then
            local progress = (tick() - animationState.startTime) / animationState.duration
            if progress >= 1 then
                progress = 1
                animationState.active = false
            end
            
            -- Apply easing function
            local easedProgress = Aurora.Animations.ApplyEasing(progress, animationState.easingStyle, animationState.easingDirection)
            
            -- Interpolate between start and end values
            local currentValue = Aurora.Animations.Interpolate(
                animationState.startValue,
                animationState.endValue,
                easedProgress,
                animationState.propertyType
            )
            
            -- Apply the animated value
            if self.UIElement[propertyName] ~= nil then
                self.UIElement[propertyName] = currentValue
            end
        end
    end
end

-- Destroy method
function Aurora.Components.BaseComponent:Destroy()
    -- Disconnect all event connections
    for _, connection in pairs(self._internal.eventConnections) do
        if connection.Connected then
            connection:Disconnect()
        end
    end
    
    -- Destroy UI element
    if self.UIElement and self.UIElement.Parent then
        self.UIElement:Destroy()
    end
    
    -- Remove from registry
    Aurora.Components.Registry[self.ID] = nil
    Aurora.Components.Count = Aurora.Components.Count - 1
    
    -- Clean up internal state
    self._internal = nil
end

--==================================================================================================--
--                                        ADVANCED COMPONENTS                                     --
--==================================================================================================--

-- Window Component
Aurora.Components.Window = setmetatable({}, Aurora.Components.BaseComponent)
Aurora.Components.Window.__index = Aurora.Components.Window

function Aurora.Components.Window.new(config)
    local self = Aurora.Components.BaseComponent.new(config)
    setmetatable(self, Aurora.Components.Window)
    
    -- Window-specific properties
    self.Type = "Window"
    self.Title = config.title or "Aurora Window"
    self.Minimizable = config.minimizable ~= nil and config.minimizable or true
    self.Maximizable = config.maximizable ~= nil and config.maximizable or true
    self.Closable = config.closable ~= nil and config.closable or true
    self.Resizable = config.resizable ~= nil and config.resizable or true
    self.AlwaysOnTop = config.alwaysOnTop or false
    self.Modal = config.modal or false
    self.Draggable = config.draggable ~= nil and config.draggable or true
    
    -- Window state
    self.Minimized = false
    self.Maximized = false
    self.Focused = false
    self.ContentArea = nil
    
    -- Initialize window
    self:InitializeWindow()
    
    return self
end

function Aurora.Components.Window:InitializeWindow()
    -- Create window frame
    self.WindowFrame = Instance.new("Frame")
    self.WindowFrame.Name = "WindowFrame"
    self.WindowFrame.BackgroundTransparency = 1
    self.WindowFrame.BorderSizePixel = 0
    self.WindowFrame.Size = UDim2.new(1, 0, 1, 0)
    self.WindowFrame.Position = UDim2.new(0, 0, 0, 0)
    self.WindowFrame.Parent = self.UIElement
    
    -- Create title bar
    self.TitleBar = Instance.new("Frame")
    self.TitleBar.Name = "TitleBar"
    self.TitleBar.BackgroundTransparency = 1
    self.TitleBar.BorderSizePixel = 0
    self.TitleBar.Size = UDim2.new(1, -20, 0, 30)
    self.TitleBar.Position = UDim2.new(0, 10, 0, 5)
    self.TitleBar.Parent = self.WindowFrame
    
    -- Create title text
    self.TitleText = Instance.new("TextLabel")
    self.TitleText.Name = "TitleText"
    self.TitleText.BackgroundTransparency = 1
    self.TitleText.BorderSizePixel = 0
    self.TitleText.Size = UDim2.new(1, -60, 1, 0)
    self.TitleText.Position = UDim2.new(0, 5, 0, 0)
    self.TitleText.Text = self.Title
    self.TitleText.TextColor3 = Color3.new(1, 1, 1)
    self.TitleText.TextSize = 14
    self.TitleText.Font = Enum.Font.GothamSemibold
    self.TitleText.TextXAlignment = Enum.TextXAlignment.Left
    self.TitleText.TextYAlignment = Enum.TextYAlignment.Center
    self.TitleText.Parent = self.TitleBar
    
    -- Create control buttons container
    self.ControlButtons = Instance.new("Frame")
    self.ControlButtons.Name = "ControlButtons"
    self.ControlButtons.BackgroundTransparency = 1
    self.ControlButtons.BorderSizePixel = 0
    self.ControlButtons.Size = UDim2.new(0, 60, 1, 0)
    self.ControlButtons.Position = UDim2.new(1, -65, 0, 0)
    self.ControlButtons.Parent = self.TitleBar
    
    -- Create minimize button
    if self.Minimizable then
        self.MinimizeButton = self:CreateControlButton("─", function()
            self:ToggleMinimize()
        end)
        self.MinimizeButton.Position = UDim2.new(0, 5, 0, 5)
    end
    
    -- Create maximize button
    if self.Maximizable then
        self.MaximizeButton = self:CreateControlButton("□", function()
            self:ToggleMaximize()
        end)
        self.MaximizeButton.Position = UDim2.new(0, 25, 0, 5)
    end
    
    -- Create close button
    if self.Closable then
        self.CloseButton = self:CreateControlButton("×", function()
            self:Close()
        end)
        self.CloseButton.Position = UDim2.new(0, 45, 0, 5)
        self.CloseButton.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
    end
    
    -- Create content area
    self.ContentArea = Instance.new("ScrollingFrame")
    self.ContentArea.Name = "ContentArea"
    self.ContentArea.BackgroundTransparency = 1
    self.ContentArea.BorderSizePixel = 0
    self.ContentArea.Size = UDim2.new(1, -20, 1, -45)
    self.ContentArea.Position = UDim2.new(0, 10, 0, 35)
    self.ContentArea.CanvasSize = UDim2.new(0, 0, 0, 0)
    self.ContentArea.ScrollBarThickness = 6
    self.ContentArea.Parent = self.WindowFrame
    
    -- Create content wrapper
    self.ContentWrapper = Instance.new("Frame")
    self.ContentWrapper.Name = "ContentWrapper"
    self.ContentWrapper.BackgroundTransparency = 1
    self.ContentWrapper.BorderSizePixel = 0
    self.ContentWrapper.Size = UDim2.new(1, -10, 0, 0)
    self.ContentWrapper.Position = UDim2.new(0, 5, 0, 0)
    self.ContentWrapper.Parent = self.ContentArea
    
    -- Set up window dragging
    if self.Draggable then
        self:EnableWindowDragging()
    end
    
    -- Set up focus management
    self:SetupFocusManagement()
end

function Aurora.Components.Window:CreateControlButton(text, callback)
    local button = Instance.new("TextButton")
    button.Name = text == "─" and "MinimizeButton" or text == "□" and "MaximizeButton" or "CloseButton"
    button.BackgroundTransparency = 0.7
    button.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
    button.BorderSizePixel = 0
    button.Size = UDim2.new(0, 15, 0, 15)
    button.Text = text
    button.TextColor3 = Color3.new(1, 1, 1)
    button.TextSize = 12
    button.Font = Enum.Font.GothamBold
    button.Parent = self.ControlButtons
    
    button.MouseButton1Click:Connect(callback)
    
    -- Hover effects
    button.MouseEnter:Connect(function()
        button.BackgroundTransparency = 0.3
    end)
    
    button.MouseLeave:Connect(function()
        button.BackgroundTransparency = 0.7
    end)
    
    return button
end

function Aurora.Components.Window:EnableWindowDragging()
    local dragging = false
    local dragInput = nil
    local dragStart = nil
    local startPos = nil
    
    local function inputBegan(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            if self.TitleBar:IsDescendantOf(input.UserInputObject) or self.TitleText:IsDescendantOf(input.UserInputObject) then
                dragging = true
                dragStart = input.Position
                startPos = self.UIElement.Position
                
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end
    end
    
    local function inputChanged(input)
        if input == dragInput then return end
        
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end
    
    local function renderStep()
        if dragging and dragInput then
            local delta = dragInput.Position - dragStart
            self.UIElement.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end
    
    self.UIElement.InputBegan:Connect(inputBegan)
    self.UIElement.InputChanged:Connect(inputChanged)
    Aurora.Services.RunService.RenderStepped:Connect(renderStep)
end

function Aurora.Components.Window:SetupFocusManagement()
    -- Focus window when clicked
    self.UIElement.MouseButton1Click:Connect(function()
        self:Focus()
    end)
    
    -- Focus management
    self:Focus()
end

function Aurora.Components.Window:Focus()
    self.Focused = true
    self.ZIndex = Aurora.Windows.ZIndexCounter
    Aurora.Windows.ZIndexCounter = Aurora.Windows.ZIndexCounter + 1
    self.UIElement.ZIndex = self.ZIndex
    
    -- Apply focus effects
    if self.Theme then
        local focusEffect = self.Theme:GetComponentStyle("Window", "focusEffect")
        if focusEffect then
            self.TitleBar.BackgroundColor3 = focusEffect.backgroundColor
            self.TitleText.TextColor3 = focusEffect.textColor
        end
    end
    
    -- Bring to front
    self.UIElement.Parent = nil
    self.UIElement.Parent = Aurora.UIContainer
end

function Aurora.Components.Window:ToggleMinimize()
    self.Minimized = not self.Minimized
    
    if self.Minimized then
        -- Store original size and position
        self.OriginalSize = self.Size
        self.OriginalPosition = self.Position
        
        -- Minimize to taskbar
        self.Size = UDim2.new(0, 200, 0, 30)
        self.Position = UDim2.new(1, -210, 1, -40)
    else
        -- Restore original size and position
        if self.OriginalSize and self.OriginalPosition then
            self.Size = self.OriginalSize
            self.Position = self.OriginalPosition
        end
    end
    
    self:Render()
end

function Aurora.Components.Window:ToggleMaximize()
    self.Maximized = not self.Maximized
    
    if self.Maximized then
        -- Store original size and position
        self.OriginalSize = self.Size
        self.OriginalPosition = self.Position
        
        -- Maximize to screen
        self.Size = UDim2.new(1, -20, 1, -20)
        self.Position = UDim2.new(0, 10, 0, 10)
    else
        -- Restore original size and position
        if self.OriginalSize and self.OriginalPosition then
            self.Size = self.OriginalSize
            self.Position = self.OriginalPosition
        end
    end
    
    self:Render()
end

function Aurora.Components.Window:Close()
    self.Visible = false
    self.Enabled = false
    
    -- Trigger close event
    if self.Events.OnClose then
        self.Events.OnClose(self)
    end
    
    -- Remove from active windows
    Aurora.Windows.ActiveWindows[self.ID] = nil
end

function Aurora.Components.Window:AddTab(title, icon)
    local tab = Aurora.Components.Tab.new({
        parent = self,
        title = title,
        icon = icon,
        position = #self.Tabs + 1
    })
    
    table.insert(self.Tabs, tab)
    return tab
end

function Aurora.Components.Window:GetTab(title)
    for _, tab in ipairs(self.Tabs) do
        if tab.Title == title then
            return tab
        end
    end
    return nil
end

function Aurora.Components.Window:SelectTab(tabOrTitle)
    local tab = typeof(tabOrTitle) == "string" and self:GetTab(tabOrTitle) or tabOrTitle
    
    if tab and tab.Parent == self then
        for _, t in ipairs(self.Tabs) do
            t.Selected = (t == tab)
        end
        
        -- Trigger tab change event
        if self.Events.OnTabChange then
            self.Events.OnTabChange(self, tab)
        end
    end
end

function Aurora.Components.Window:Render()
    -- Call parent render method
    Aurora.Components.BaseComponent.Render(self)
    
    -- Update content area size
    if self.ContentArea then
        self.ContentArea.CanvasSize = UDim2.new(0, 0, 0, self.ContentWrapper.AbsoluteSize.Y + 20)
    end
    
    -- Update window state indicators
    if self.MinimizeButton then
        self.MinimizeButton.Text = self.Minimized and "▭" or "─"
    end
    
    if self.MaximizeButton then
        self.MaximizeButton.Text = self.Maximized and "❐" or "□"
    end
    
    -- Update title text
    if self.TitleText then
        self.TitleText.Text = self.Title
    end
end

-- Tab Component
Aurora.Components.Tab = setmetatable({}, Aurora.Components.BaseComponent)
Aurora.Components.Tab.__index = Aurora.Components.Tab

function Aurora.Components.Tab.new(config)
    local self = Aurora.Components.BaseComponent.new(config)
    setmetatable(self, Aurora.Components.Tab)
    
    -- Tab-specific properties
    self.Type = "Tab"
    self.Title = config.title or "Tab"
    self.Icon = config.icon or nil
    self.Position = config.position or 1
    self.Selected = config.selected or false
    self.Content = {}
    
    -- Initialize tab
    self:InitializeTab()
    
    return self
end

function Aurora.Components.Tab:InitializeTab()
    -- Create tab container
    self.TabContainer = Instance.new("Frame")
    self.TabContainer.Name = "TabContainer"
    self.TabContainer.BackgroundTransparency = 1
    self.TabContainer.BorderSizePixel = 0
    self.TabContainer.Size = UDim2.new(1, 0, 1, -30)
    self.TabContainer.Position = UDim2.new(0, 0, 0, 30)
    self.TabContainer.Parent = self.Parent.ContentArea
    
    -- Create tab content area
    self.ContentArea = Instance.new("ScrollingFrame")
    self.ContentArea.Name = "ContentArea"
    self.ContentArea.BackgroundTransparency = 1
    self.ContentArea.BorderSizePixel = 0
    self.ContentArea.Size = UDim2.new(1, 0, 1, 0)
    self.ContentArea.CanvasSize = UDim2.new(0, 0, 0, 0)
    self.ContentArea.ScrollBarThickness = 6
    self.ContentArea.Parent = self.TabContainer
    
    -- Create content wrapper
    self.ContentWrapper = Instance.new("Frame")
    self.ContentWrapper.Name = "ContentWrapper"
    self.ContentWrapper.BackgroundTransparency = 1
    self.ContentWrapper.BorderSizePixel = 0
    self.ContentWrapper.Size = UDim2.new(1, -10, 0, 0)
    self.ContentWrapper.Position = UDim2.new(0, 5, 0, 0)
    self.ContentWrapper.Parent = self.ContentArea
    
    -- Set up tab events
    self:SetupTabEvents()
end

function Aurora.Components.Tab:SetupTabEvents()
    -- Hide content when not selected
    self.TabContainer.Visible = self.Selected
    
    -- Tab selection events
    self.Events.OnSelect = function()
        self.Selected = true
        self.TabContainer.Visible = true
        self:OnTabSelected()
    end
    
    self.Events.OnDeselect = function()
        self.Selected = false
        self.TabContainer.Visible = false
        self:OnTabDeselected()
    end
end

function Aurora.Components.Tab:AddSection(title, options)
    options = options or {}
    options.parent = self
    options.title = title
    
    local section = Aurora.Components.Section.new(options)
    table.insert(self.Content, section)
    return section
end

function Aurora.Components.Tab:AddComponent(componentType, options)
    options = options or {}
    options.parent = self
    
    local component = Aurora.Components[componentType].new(options)
    table.insert(self.Content, component)
    return component
end

function Aurora.Components.Tab:OnTabSelected()
    -- Apply selection effects
    if self.Theme then
        local selectedStyle = self.Theme:GetComponentStyle("Tab", "selected")
        if selectedStyle then
            -- Apply visual effects
        end
    end
    
    -- Trigger selection event
    if self.Events.OnSelected then
        self.Events.OnSelected(self)
    end
end

function Aurora.Components.Tab:OnTabDeselected()
    -- Trigger deselection event
    if self.Events.OnDeselected then
        self.Events.OnDeselected(self)
    end
end

function Aurora.Components.Tab:Render()
    -- Call parent render method
    Aurora.Components.BaseComponent.Render(self)
    
    -- Update content area size
    if self.ContentArea then
        self.ContentArea.CanvasSize = UDim2.new(0, 0, 0, self.ContentWrapper.AbsoluteSize.Y + 20)
    end
end

-- Section Component
Aurora.Components.Section = setmetatable({}, Aurora.Components.BaseComponent)
Aurora.Components.Section.__index = Aurora.Components.Section

function Aurora.Components.Section.new(config)
    local self = Aurora.Components.BaseComponent.new(config)
    setmetatable(self, Aurora.Components.Section)
    
    -- Section-specific properties
    self.Type = "Section"
    self.Title = config.title or "Section"
    self.Collapsible = config.collapsible or false
    self.Collapsed = config.collapsed or false
    self.Components = {}
    
    -- Initialize section
    self:InitializeSection()
    
    return self
end

function Aurora.Components.Section:InitializeSection()
    -- Create section container
    self.SectionContainer = Instance.new("Frame")
    self.SectionContainer.Name = "SectionContainer"
    self.SectionContainer.BackgroundTransparency = 0.8
    self.SectionContainer.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
    self.SectionContainer.BorderSizePixel = 1
    self.SectionContainer.BorderColor3 = Color3.new(0.3, 0.3, 0.3)
    self.SectionContainer.Size = UDim2.new(1, -10, 0, 30)
    self.SectionContainer.Position = UDim2.new(0, 5, 0, 5)
    self.SectionContainer.Parent = self.Parent.ContentWrapper
    
    -- Create section header
    self.SectionHeader = Instance.new("Frame")
    self.SectionHeader.Name = "SectionHeader"
    self.SectionHeader.BackgroundTransparency = 1
    self.SectionHeader.BorderSizePixel = 0
    self.SectionHeader.Size = UDim2.new(1, 0, 0, 30)
    self.SectionHeader.Position = UDim2.new(0, 0, 0, 0)
    self.SectionHeader.Parent = self.SectionContainer
    
    -- Create section title
    self.SectionTitle = Instance.new("TextLabel")
    self.SectionTitle.Name = "SectionTitle"
    self.SectionTitle.BackgroundTransparency = 1
    self.SectionTitle.BorderSizePixel = 0
    self.SectionTitle.Size = UDim2.new(1, -30, 1, 0)
    self.SectionTitle.Position = UDim2.new(0, 5, 0, 0)
    self.SectionTitle.Text = self.Title
    self.SectionTitle.TextColor3 = Color3.new(1, 1, 1)
    self.SectionTitle.TextSize = 14
    self.SectionTitle.Font = Enum.Font.GothamSemibold
    self.SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
    self.SectionTitle.TextYAlignment = Enum.TextYAlignment.Center
    self.SectionTitle.Parent = self.SectionHeader
    
    -- Create collapse button if collapsible
    if self.Collapsible then
        self.CollapseButton = Instance.new("TextButton")
        self.CollapseButton.Name = "CollapseButton"
        self.CollapseButton.BackgroundTransparency = 1
        self.CollapseButton.BorderSizePixel = 0
        self.CollapseButton.Size = UDim2.new(0, 20, 1, 0)
        self.CollapseButton.Position = UDim2.new(1, -25, 0, 0)
        self.CollapseButton.Text = self.Collapsed and "▶" or "▼"
        self.CollapseButton.TextColor3 = Color3.new(0.8, 0.8, 0.8)
        self.CollapseButton.TextSize = 14
        self.CollapseButton.Font = Enum.Font.GothamBold
        self.CollapseButton.Parent = self.SectionHeader
        
        self.CollapseButton.MouseButton1Click:Connect(function()
            self:ToggleCollapse()
        end)
    end
    
    -- Create content area
    self.ContentArea = Instance.new("Frame")
    self.ContentArea.Name = "ContentArea"
    self.ContentArea.BackgroundTransparency = 1
    self.ContentArea.BorderSizePixel = 0
    self.ContentArea.Size = UDim2.new(1, -10, 0, 0)
    self.ContentArea.Position = UDim2.new(0, 5, 0, 35)
    self.ContentArea.Parent = self.SectionContainer
    
    -- Set up collapse functionality
    self:SetupCollapseFunctionality()
end

function Aurora.Components.Section:SetupCollapseFunctionality()
    if not self.Collapsible then return end
    
    -- Hide content when collapsed
    self.ContentArea.Visible = not self.Collapsed
    
    -- Update section size based on collapse state
    self:UpdateSectionSize()
end

function Aurora.Components.Section:ToggleCollapse()
    self.Collapsed = not self.Collapsed
    
    if self.CollapseButton then
        self.CollapseButton.Text = self.Collapsed and "▶" or "▼"
    end
    
    if self.ContentArea then
        self.ContentArea.Visible = not self.Collapsed
    end
    
    self:UpdateSectionSize()
    
    -- Trigger collapse event
    if self.Events.OnCollapse then
        self.Events.OnCollapse(self, self.Collapsed)
    end
end

function Aurora.Components.Section:UpdateSectionSize()
    if self.Collapsed then
        self.SectionContainer.Size = UDim2.new(1, -10, 0, 30)
    else
        -- Calculate content height
        local contentHeight = 0
        for _, component in ipairs(self.Components) do
            if component.UIElement and component.UIElement.Visible then
                contentHeight = contentHeight + component.UIElement.AbsoluteSize.Y + 5
            end
        end
        
        self.SectionContainer.Size = UDim2.new(1, -10, 0, 30 + contentHeight + 10)
    end
end

function Aurora.Components.Section:AddToggle(options)
    options = options or {}
    options.parent = self
    options.type = "Toggle"
    
    local toggle = Aurora.Components.Toggle.new(options)
    table.insert(self.Components, toggle)
    return toggle
end

function Aurora.Components.Section:AddSlider(options)
    options = options or {}
    options.parent = self
    options.type = "Slider"
    
    local slider = Aurora.Components.Slider.new(options)
    table.insert(self.Components, slider)
    return slider
end

function Aurora.Components.Section:AddButton(options)
    options = options or {}
    options.parent = self
    options.type = "Button"
    
    local button = Aurora.Components.Button.new(options)
    table.insert(self.Components, button)
    return button
end

function Aurora.Components.Section:AddDropdown(options)
    options = options or {}
    options.parent = self
    options.type = "Dropdown"
    
    local dropdown = Aurora.Components.Dropdown.new(options)
    table.insert(self.Components, dropdown)
    return dropdown
end

function Aurora.Components.Section:AddTextbox(options)
    options = options or {}
    options.parent = self
    options.type = "Textbox"
    
    local textbox = Aurora.Components.Textbox.new(options)
    table.insert(self.Components, textbox)
    return textbox
end

function Aurora.Components.Section:AddColorPicker(options)
    options = options or {}
    options.parent = self
    options.type = "ColorPicker"
    
    local colorPicker = Aurora.Components.ColorPicker.new(options)
    table.insert(self.Components, colorPicker)
    return colorPicker
end

function Aurora.Components.Section:Render()
    -- Call parent render method
    Aurora.Components.BaseComponent.Render(self)
    
    -- Update section size
    self:UpdateSectionSize()
    
    -- Position components
    local yPos = 5
    for _, component in ipairs(self.Components) do
        if component.UIElement and component.UIElement.Visible then
            component.UIElement.Position = UDim2.new(0, 5, 0, yPos)
            yPos = yPos + component.UIElement.AbsoluteSize.Y + 5
        end
    end
end

-- Toggle Component
Aurora.Components.Toggle = setmetatable({}, Aurora.Components.BaseComponent)
Aurora.Components.Toggle.__index = Aurora.Components.Toggle

function Aurora.Components.Toggle.new(config)
    local self = Aurora.Components.BaseComponent.new(config)
    setmetatable(self, Aurora.Components.Toggle)
    
    -- Toggle-specific properties
    self.Type = "Toggle"
    self.Label = config.label or "Toggle"
    self.Value = config.value or false
    self.Callback = config.callback or function() end
    
    -- Initialize toggle
    self:InitializeToggle()
    
    return self
end

function Aurora.Components.Toggle:InitializeToggle()
    -- Create toggle container
    self.ToggleContainer = Instance.new("Frame")
    self.ToggleContainer.Name = "ToggleContainer"
    self.ToggleContainer.BackgroundTransparency = 1
    self.ToggleContainer.BorderSizePixel = 0
    self.ToggleContainer.Size = UDim2.new(1, -10, 0, 25)
    self.ToggleContainer.Position = UDim2.new(0, 5, 0, 0)
    self.ToggleContainer.Parent = self.Parent.ContentArea
    
    -- Create toggle label
    self.ToggleLabel = Instance.new("TextLabel")
    self.ToggleLabel.Name = "ToggleLabel"
    self.ToggleLabel.BackgroundTransparency = 1
    self.ToggleLabel.BorderSizePixel = 0
    self.ToggleLabel.Size = UDim2.new(0, 150, 1, 0)
    self.ToggleLabel.Position = UDim2.new(0, 0, 0, 0)
    self.ToggleLabel.Text = self.Label
    self.ToggleLabel.TextColor3 = Color3.new(0.9, 0.9, 0.9)
    self.ToggleLabel.TextSize = 14
    self.ToggleLabel.Font = Enum.Font.Gotham
    self.ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    self.ToggleLabel.TextYAlignment = Enum.TextYAlignment.Center
    self.ToggleLabel.Parent = self.ToggleContainer
    
    -- Create toggle button
    self.ToggleButton = Instance.new("TextButton")
    self.ToggleButton.Name = "ToggleButton"
    self.ToggleButton.BackgroundTransparency = 0.7
    self.ToggleButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
    self.ToggleButton.BorderSizePixel = 0
    self.ToggleButton.Size = UDim2.new(0, 40, 0, 20)
    self.ToggleButton.Position = UDim2.new(1, -45, 0, 2.5)
    self.ToggleButton.Text = ""
    self.ToggleButton.Parent = self.ToggleContainer
    
    -- Create toggle indicator
    self.ToggleIndicator = Instance.new("Frame")
    self.ToggleIndicator.Name = "ToggleIndicator"
    self.ToggleIndicator.BackgroundTransparency = 0
    self.ToggleIndicator.BackgroundColor3 = Color3.new(0.2, 0.8, 0.2)
    self.ToggleIndicator.BorderSizePixel = 0
    self.ToggleIndicator.Size = UDim2.new(0, 16, 0, 16)
    self.ToggleIndicator.Position = UDim2.new(0, 2, 0, 2)
    self.ToggleIndicator.Parent = self.ToggleButton
    
    -- Set initial state
    self:SetValue(self.Value)
    
    -- Set up toggle events
    self:SetupToggleEvents()
end

function Aurora.Components.Toggle:SetupToggleEvents()
    -- Toggle click event
    self.ToggleButton.MouseButton1Click:Connect(function()
        self:SetValue(not self.Value)
    end)
    
    -- Hover effects
    self.ToggleButton.MouseEnter:Connect(function()
        self.ToggleButton.BackgroundTransparency = 0.5
    end)
    
    self.ToggleButton.MouseLeave:Connect(function()
        self.ToggleButton.BackgroundTransparency = 0.7
    end)
end

function Aurora.Components.Toggle:SetValue(value, skipCallback)
    self.Value = value
    
    -- Update visual state
    if value then
        self.ToggleIndicator.Position = UDim2.new(0, 22, 0, 2)
        self.ToggleIndicator.BackgroundColor3 = Color3.new(0.2, 0.8, 0.2)
    else
        self.ToggleIndicator.Position = UDim2.new(0, 2, 0, 2)
        self.ToggleIndicator.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
    end
    
    -- Execute callback if not skipped
    if not skipCallback and typeof(self.Callback) == "function" then
        self.Callback(self.Value)
    end
    
    -- Trigger change event
    if self.Events.OnChange then
        self.Events.OnChange(self, self.Value)
    end
end

function Aurora.Components.Toggle:GetValue()
    return self.Value
end

function Aurora.Components.Toggle:Render()
    -- Call parent render method
    Aurora.Components.BaseComponent.Render(self)
end

--==================================================================================================--
--                                          THEME SYSTEM                                           --
--==================================================================================================--

Aurora.Themes.Theme = {}
Aurora.Themes.Theme.__index = Aurora.Themes.Theme

function Aurora.Themes.Theme.new(name, config)
    local self = setmetatable({}, Aurora.Themes.Theme)
    
    -- Theme metadata
    self.Name = name
    self.Author = config.author or "AuroraUI"
    self.Version = config.version or "1.0.0"
    self.Description = config.description or "Aurora UI Theme"
    self.CreatedAt = tick()
    
    -- Core theme properties
    self.PrimaryColor = config.primaryColor or Color3.fromRGB(117, 133, 250)
    self.SecondaryColor = config.secondaryColor or Color3.fromRGB(180, 156, 255)
    self.AccentColor = config.accentColor or Color3.fromRGB(114, 0, 198)
    self.BackgroundColor = config.backgroundColor or Color3.fromRGB(25, 25, 25)
    self.ForegroundColor = config.foregroundColor or Color3.fromRGB(232, 232, 232)
    self.BorderColor = config.borderColor or Color3.fromRGB(5, 5, 5)
    self.ErrorColor = config.errorColor or Color3.fromRGB(200, 40, 40)
    self.WarningColor = config.warningColor or Color3.fromRGB(252, 152, 3)
    self.SuccessColor = config.successColor or Color3.fromRGB(40, 200, 40)
    
    -- Typography
    self.Font = config.font or Drawing.Fonts.Plex
    self.TextSize = config.textSize or 13
    self.TextWeight = config.textWeight or Enum.FontWeight.Regular
    self.LineHeight = config.lineHeight or 1.5
    
    -- Component styles
    self.ComponentStyles = config.componentStyles or {}
    
    -- Animations
    self.AnimationDuration = config.animationDuration or 0.3
    self.AnimationStyle = config.animationStyle or Enum.EasingStyle.Quad
    self.AnimationDirection = config.animationDirection or Enum.EasingDirection.Out
    
    -- Shadows and effects
    self.UseShadows = config.useShadows ~= nil and config.useShadows or true
    self.ShadowColor = config.shadowColor or Color3.fromRGB(0, 0, 0)
    self.ShadowTransparency = config.shadowTransparency or 0.7
    self.ShadowOffset = config.shadowOffset or Vector2.new(2, 2)
    
    -- Apply theme
    if config.apply ~= false then
        self:Apply()
    end
    
    return self
end

function Aurora.Themes.Theme:GetComponentStyles(componentType)
    return self.ComponentStyles[componentType] or {}
end

function Aurora.Themes.Theme:GetComponentStyle(componentType, styleName)
    local componentStyles = self:GetComponentStyles(componentType)
    return componentStyles[styleName]
end

function Aurora.Themes.Theme:Apply()
    Aurora.Themes.CurrentTheme = self
    
    -- Update all components with new theme
    for _, component in pairs(Aurora.Components.Registry) do
        if typeof(component.ApplyTheme) == "function" then
            component:ApplyTheme(self)
        end
    end
    
    -- Trigger theme change event
    Aurora.Events:Fire("ThemeChanged", self)
end

function Aurora.Themes.Theme:CreatePresetTheme(presetName)
    local presets = {
        ["Default"] = {
            primaryColor = Color3.fromRGB(117, 133, 250),
            secondaryColor = Color3.fromRGB(180, 156, 255),
            accentColor = Color3.fromRGB(114, 0, 198),
            backgroundColor = Color3.fromRGB(25, 25, 25),
            foregroundColor = Color3.fromRGB(232, 232, 232),
            borderColor = Color3.fromRGB(5, 5, 5),
            componentStyles = {
                Window = {
                    background = Color3.fromRGB(30, 30, 30),
                    header = Color3.fromRGB(40, 40, 40),
                    focusEffect = {
                        backgroundColor = Color3.fromRGB(50, 50, 50),
                        textColor = Color3.fromRGB(255, 255, 255)
                    }
                },
                Tab = {
                    background = Color3.fromRGB(35, 35, 35),
                    selected = {
                        backgroundColor = Color3.fromRGB(50, 50, 50),
                        textColor = Color3.fromRGB(117, 133, 250)
                    }
                },
                Button = {
                    background = Color3.fromRGB(45, 45, 45),
                    hover = Color3.fromRGB(60, 60, 60),
                    active = Color3.fromRGB(70, 70, 70)
                }
            }
        },
        ["Dark"] = {
            primaryColor = Color3.fromRGB(100, 100, 200),
            secondaryColor = Color3.fromRGB(150, 150, 255),
            accentColor = Color3.fromRGB(80, 80, 180),
            backgroundColor = Color3.fromRGB(20, 20, 20),
            foregroundColor = Color3.fromRGB(240, 240, 240),
            borderColor = Color3.fromRGB(40, 40, 40),
            componentStyles = {
                Window = {
                    background = Color3.fromRGB(25, 25, 25),
                    header = Color3.fromRGB(35, 35, 35),
                    focusEffect = {
                        backgroundColor = Color3.fromRGB(45, 45, 45),
                        textColor = Color3.fromRGB(255, 255, 255)
                    }
                },
                Tab = {
                    background = Color3.fromRGB(30, 30, 30),
                    selected = {
                        backgroundColor = Color3.fromRGB(40, 40, 40),
                        textColor = Color3.fromRGB(100, 100, 200)
                    }
                },
                Button = {
                    background = Color3.fromRGB(40, 40, 40),
                    hover = Color3.fromRGB(50, 50, 50),
                    active = Color3.fromRGB(60, 60, 60)
                }
            }
        },
        ["Light"] = {
            primaryColor = Color3.fromRGB(70, 100, 255),
            secondaryColor = Color3.fromRGB(120, 150, 255),
            accentColor = Color3.fromRGB(50, 80, 200),
            backgroundColor = Color3.fromRGB(245, 245, 245),
            foregroundColor = Color3.fromRGB(50, 50, 50),
            borderColor = Color3.fromRGB(200, 200, 200),
            componentStyles = {
                Window = {
                    background = Color3.fromRGB(255, 255, 255),
                    header = Color3.fromRGB(240, 240, 240),
                    focusEffect = {
                        backgroundColor = Color3.fromRGB(230, 230, 230),
                        textColor = Color3.fromRGB(50, 50, 50)
                    }
                },
                Tab = {
                    background = Color3.fromRGB(245, 245, 245),
                    selected = {
                        backgroundColor = Color3.fromRGB(235, 235, 235),
                        textColor = Color3.fromRGB(70, 100, 255)
                    }
                },
                Button = {
                    background = Color3.fromRGB(230, 230, 230),
                    hover = Color3.fromRGB(220, 220, 220),
                    active = Color3.fromRGB(210, 210, 210)
                }
            }
        },
        ["Modern"] = {
            primaryColor = Color3.fromRGB(80, 120, 255),
            secondaryColor = Color3.fromRGB(130, 170, 255),
            accentColor = Color3.fromRGB(60, 100, 220),
            backgroundColor = Color3.fromRGB(15, 15, 15),
            foregroundColor = Color3.fromRGB(245, 245, 245),
            borderColor = Color3.fromRGB(35, 35, 35),
            componentStyles = {
                Window = {
                    background = Color3.fromRGB(20, 20, 20),
                    header = Color3.fromRGB(30, 30, 30),
                    focusEffect = {
                        backgroundColor = Color3.fromRGB(40, 40, 40),
                        textColor = Color3.fromRGB(255, 255, 255)
                    }
                },
                Tab = {
                    background = Color3.fromRGB(25, 25, 25),
                    selected = {
                        backgroundColor = Color3.fromRGB(45, 45, 45),
                        textColor = Color3.fromRGB(80, 120, 255)
                    }
                },
                Button = {
                    background = Color3.fromRGB(35, 35, 35),
                    hover = Color3.fromRGB(45, 45, 45),
                    active = Color3.fromRGB(55, 55, 55)
                }
            }
        }
    }
    
    local presetConfig = presets[presetName] or presets["Default"]
    return Aurora.Themes.Theme.new(presetName, presetConfig)
end

-- Theme management functions
function Aurora.Themes.LoadDefaultTheme()
    Aurora.Themes.DefaultTheme = Aurora.Themes.Theme.new("Default", {
        primaryColor = Color3.fromRGB(117, 133, 250),
        secondaryColor = Color3.fromRGB(180, 156, 255),
        accentColor = Color3.fromRGB(114, 0, 198),
        backgroundColor = Color3.fromRGB(25, 25, 25),
        foregroundColor = Color3.fromRGB(232, 232, 232),
        borderColor = Color3.fromRGB(5, 5, 5),
        font = Drawing.Fonts.Plex,
        textSize = 13
    })
    
    Aurora.Themes.CurrentTheme = Aurora.Themes.DefaultTheme
    return Aurora.Themes.DefaultTheme
end

function Aurora.Themes.LoadTheme(themeName)
    if Aurora.Themes.Presets[themeName] then
        return Aurora.Themes.Presets[themeName]
    elseif Aurora.Themes.CustomThemes[themeName] then
        return Aurora.Themes.CustomThemes[themeName]
    else
        return Aurora.Themes.CreatePresetTheme(themeName)
    end
end

function Aurora.Themes.RegisterPresetTheme(themeName, themeConfig)
    Aurora.Themes.Presets[themeName] = Aurora.Themes.Theme.new(themeName, themeConfig)
    return Aurora.Themes.Presets[themeName]
end

function Aurora.Themes.RegisterCustomTheme(themeName, themeConfig)
    Aurora.Themes.CustomThemes[themeName] = Aurora.Themes.Theme.new(themeName, themeConfig)
    return Aurora.Themes.CustomThemes[themeName]
end

--==================================================================================================--
--                                          EVENT SYSTEM                                           --
--==================================================================================================--

Aurora.Events = {}

function Aurora.Events.Fire(eventName, ...)
    if not Aurora.Events.CustomEvents[eventName] then
        Aurora.Events.CustomEvents[eventName] = {}
    end
    
    -- Add to event queue
    table.insert(Aurora.Events.EventQueue, {
        eventName = eventName,
        timestamp = tick(),
        args = {...}
    })
    
    -- Process event queue
    Aurora.Events.ProcessEventQueue()
    
    -- Execute event handlers
    for _, handler in ipairs(Aurora.Events.CustomEvents[eventName]) do
        local success, err = pcall(handler, ...)
        if not success then
            Aurora.Debug.LogError("Event handler error for '" .. eventName .. "': " .. tostring(err))
        end
    end
end

function Aurora.Events.Listen(eventName, handler)
    if not Aurora.Events.CustomEvents[eventName] then
        Aurora.Events.CustomEvents[eventName] = {}
    end
    
    table.insert(Aurora.Events.CustomEvents[eventName], handler)
    
    -- Return unsubscribe function
    return function()
        Aurora.Events.Unlisten(eventName, handler)
    end
end

function Aurora.Events.Unlisten(eventName, handler)
    if not Aurora.Events.CustomEvents[eventName] then
        return
    end
    
    for i, h in ipairs(Aurora.Events.CustomEvents[eventName]) do
        if h == handler then
            table.remove(Aurora.Events.CustomEvents[eventName], i)
            break
        end
    end
end

function Aurora.Events.ProcessEventQueue()
    -- Process events in order
    while #Aurora.Events.EventQueue > 0 do
        local event = table.remove(Aurora.Events.EventQueue, 1)
        -- Event processing logic here
    end
end

-- Built-in events
Aurora.Events.Listen("ComponentCreated", function(component)
    Aurora.Debug.LogInfo("Component created: " .. component.Name .. " (ID: " .. component.ID .. ")")
end)

Aurora.Events.Listen("ComponentDestroyed", function(componentID)
    Aurora.Debug.LogInfo("Component destroyed: ID " .. componentID)
end)

Aurora.Events.Listen("ThemeChanged", function(theme)
    Aurora.Debug.LogInfo("Theme changed to: " .. theme.Name)
end)

Aurora.Events.Listen("WindowOpened", function(window)
    Aurora.Debug.LogInfo("Window opened: " .. window.Title)
end)

Aurora.Events.Listen("WindowClosed", function(window)
    Aurora.Debug.LogInfo("Window closed: " .. window.Title)
end)

--==================================================================================================--
--                                        ANIMATION SYSTEM                                        --
--==================================================================================================--

Aurora.Animations = {}

function Aurora.Animations.Create(animationType, options)
    local animation = {
        id = #Aurora.Animations.ActiveAnimations + 1,
        type = animationType,
        options = options or {},
        startTime = tick(),
        duration = options.duration or Aurora.Animations.DefaultDuration,
        easingStyle = options.easingStyle or Aurora.Animations.DefaultEasing,
        easingDirection = options.easingDirection or Aurora.Animations.DefaultDirection,
        onComplete = options.onComplete,
        onProgress = options.onProgress,
        target = options.target,
        property = options.property,
        startValue = options.startValue,
        endValue = options.endValue,
        active = true
    }
    
    table.insert(Aurora.Animations.ActiveAnimations, animation)
    Aurora.Animations.AnimationQueue[#Aurora.Animations.AnimationQueue + 1] = animation
    
    return animation
end

function Aurora.Animations.ApplyEasing(progress, easingStyle, easingDirection)
    -- Implement easing functions
    if easingStyle == Enum.EasingStyle.Linear then
        return progress
    elseif easingStyle == Enum.EasingStyle.Quad then
        if easingDirection == Enum.EasingDirection.In then
            return progress * progress
        elseif easingDirection == Enum.EasingDirection.Out then
            return 1 - (1 - progress) * (1 - progress)
        else -- InOut
            if progress < 0.5 then
                return 2 * progress * progress
            else
                return 1 - math.pow(-2 * progress + 2, 2) / 2
            end
        end
    elseif easingStyle == Enum.EasingStyle.Cubic then
        if easingDirection == Enum.EasingDirection.In then
            return progress * progress * progress
        elseif easingDirection == Enum.EasingDirection.Out then
            return 1 - math.pow(1 - progress, 3)
        else -- InOut
            if progress < 0.5 then
                return 4 * progress * progress * progress
            else
                return 1 - math.pow(-2 * progress + 2, 3) / 2
            end
        end
    end
    
    return progress
end

function Aurora.Animations.Interpolate(startValue, endValue, progress, propertyType)
    if typeof(startValue) == "number" and typeof(endValue) == "number" then
        return startValue + (endValue - startValue) * progress
    elseif typeof(startValue) == "Color3" and typeof(endValue) == "Color3" then
        return Color3.new(
            startValue.R + (endValue.R - startValue.R) * progress,
            startValue.G + (endValue.G - startValue.G) * progress,
            startValue.B + (endValue.B - startValue.B) * progress
        )
    elseif typeof(startValue) == "UDim2" and typeof(endValue) == "UDim2" then
        return UDim2.new(
            startValue.X.Scale + (endValue.X.Scale - startValue.X.Scale) * progress,
            startValue.X.Offset + (endValue.X.Offset - startValue.X.Offset) * progress,
            startValue.Y.Scale + (endValue.Y.Scale - startValue.Y.Scale) * progress,
            startValue.Y.Offset + (endValue.Y.Offset - startValue.Y.Offset) * progress
        )
    end
    
    return endValue
end

function Aurora.Animations.Update()
    local currentTime = tick()
    
    for i = #Aurora.Animations.ActiveAnimations, 1, -1 do
        local animation = Aurora.Animations.ActiveAnimations[i]
        
        if animation.active then
            local progress = (currentTime - animation.startTime) / animation.duration
            
            if progress >= 1 then
                progress = 1
                animation.active = false
                
                -- Set final value
                if animation.target and animation.property then
                    animation.target[animation.property] = animation.endValue
                end
                
                -- Execute completion callback
                if typeof(animation.onComplete) == "function" then
                    animation.onComplete()
                end
                
                -- Remove from active animations
                table.remove(Aurora.Animations.ActiveAnimations, i)
            else
                -- Apply easing
                local easedProgress = Aurora.Animations.ApplyEasing(progress, animation.easingStyle, animation.easingDirection)
                
                -- Interpolate value
                local currentValue = Aurora.Animations.Interpolate(
                    animation.startValue,
                    animation.endValue,
                    easedProgress,
                    animation.propertyType
                )
                
                -- Apply to target
                if animation.target and animation.property then
                    animation.target[animation.property] = currentValue
                end
                
                -- Execute progress callback
                if typeof(animation.onProgress) == "function" then
                    animation.onProgress(easedProgress)
                end
            end
        end
    end
end

-- Setup animation update loop
Aurora.Services.RunService.Heartbeat:Connect(function()
    Aurora.Animations.Update()
end)

--==================================================================================================--
--                                        DOCUMENTATION SYSTEM                                     --
--==================================================================================================--

Aurora.Documentation = {}

function Aurora.Documentation.Initialize()
    Aurora.Documentation.API = {
        ["Aurora"] = {
            description = "The main AuroraUI framework object",
            methods = {
                Initialize = {
                    description = "Initializes the AuroraUI framework",
                    parameters = {
                        {name = "options", type = "table", description = "Configuration options for initialization", optional = true}
                    },
                    returns = "AuroraUI framework instance",
                    example = "local aurora = Aurora.Initialize({debugMode = true})"
                },
                CreateWindow = {
                    description = "Creates a new window component",
                    parameters = {
                        {name = "config", type = "table", description = "Configuration for the window"}
                    },
                    returns = "Window component instance",
                    example = "local window = Aurora.CreateWindow({title = 'My Window', size = UDim2.new(0, 400, 0, 300)})"
                }
            }
        },
        ["Window"] = {
            description = "Window component for creating application windows",
            methods = {
                AddTab = {
                    description = "Adds a new tab to the window",
                    parameters = {
                        {name = "title", type = "string", description = "Title of the tab"},
                        {name = "icon", type = "string", description = "Icon identifier for the tab", optional = true}
                    },
                    returns = "Tab component instance",
                    example = "local tab = window:AddTab('Settings', 'settings')"
                },
                SelectTab = {
                    description = "Selects a specific tab in the window",
                    parameters = {
                        {name = "tabOrTitle", type = "Tab|string", description = "Tab instance or title to select"}
                    },
                    returns = "nil",
                    example = "window:SelectTab('Settings')"
                }
            }
        },
        ["Tab"] = {
            description = "Tab component for organizing content within windows",
            methods = {
                AddSection = {
                    description = "Adds a new section to the tab",
                    parameters = {
                        {name = "title", type = "string", description = "Title of the section"},
                        {name = "options", type = "table", description = "Configuration options for the section", optional = true}
                    },
                    returns = "Section component instance",
                    example = "local section = tab:AddSection('General Settings')"
                }
            }
        },
        ["Section"] = {
            description = "Section component for grouping related UI elements",
            methods = {
                AddToggle = {
                    description = "Adds a toggle switch to the section",
                    parameters = {
                        {name = "options", type = "table", description = "Configuration options for the toggle"}
                    },
                    returns = "Toggle component instance",
                    example = "local toggle = section:AddToggle({label = 'Enable Feature', value = true})"
                },
                AddSlider = {
                    description = "Adds a slider control to the section",
                    parameters = {
                        {name = "options", type = "table", description = "Configuration options for the slider"}
                    },
                    returns = "Slider component instance",
                    example = "local slider = section:AddSlider({label = 'Volume', min = 0, max = 100, value = 50})"
                }
            }
        }
    }
    
    Aurora.Documentation.Examples = {
        ["Basic Window"] = [[
local Aurora = require(path.to.AuroraUI)
Aurora.Initialize()

local window = Aurora.CreateWindow({
    title = "My Application",
    size = UDim2.new(0, 400, 0, 300),
    position = UDim2.new(0.5, -200, 0.5, -150)
})

local mainTab = window:AddTab("Main")
local settingsTab = window:AddTab("Settings")

local generalSection = mainTab:AddSection("General")
local toggle = generalSection:AddToggle({
    label = "Enable Feature",
    value = true,
    callback = function(value)
        print("Feature enabled:", value)
    end
})

window:SelectTab(mainTab)
]],
        ["Advanced UI"] = [[
local Aurora = require(path.to.AuroraUI)
Aurora.Initialize({debugMode = true})

-- Create main window
local window = Aurora.CreateWindow({
    title = "Advanced Application",
    size = UDim2.new(0, 600, 0, 400),
    resizable = true,
    minimizable = true,
    maximizable = true
})

-- Add tabs
local dashboardTab = window:AddTab("Dashboard", "dashboard")
local settingsTab = window:AddTab("Settings", "settings")
local aboutTab = window:AddTab("About", "info")

-- Dashboard tab content
local statsSection = dashboardTab:AddSection("Statistics")
local volumeSlider = statsSection:AddSlider({
    label = "Volume",
    min = 0,
    max = 100,
    value = 75,
    callback = function(value)
        print("Volume set to:", value)
    end
})

local notificationsSection = dashboardTab:AddSection("Notifications")
local notificationsToggle = notificationsSection:AddToggle({
    label = "Enable Notifications",
    value = true,
    callback = function(enabled)
        print("Notifications:", enabled and "enabled" or "disabled")
    end
})

-- Settings tab content
local appearanceSection = settingsTab:AddSection("Appearance")
local themeDropdown = appearanceSection:AddDropdown({
    label = "Theme",
    options = {"Default", "Dark", "Light", "Modern"},
    selected = "Default",
    callback = function(theme)
        Aurora.Themes.LoadTheme(theme)
        print("Theme changed to:", theme)
    end
})

-- About tab content
local infoSection = aboutTab:AddSection("Information")
local versionLabel = infoSection:AddLabel({
    text = "AuroraUI v" .. Aurora._VERSION
})

local authorLabel = infoSection:AddLabel({
    text = "Created by Aurora Dev Team"
})

-- Show window
window:SelectTab(dashboardTab)
window:Show()
]]
    }
    
    Aurora.Documentation.Tutorials = {
        ["Getting Started"] = [[
# Getting Started with AuroraUI

## Installation
1. Download the AuroraUI library from GitHub
2. Place the `AuroraUI` folder in your project's `Modules` directory
3. Require the library in your script

## Basic Setup
```lua
local Aurora = require(path.to.AuroraUI)
Aurora.Initialize()
