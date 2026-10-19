
--==================================================
-- PHANTOM V3 | MOBILE UI
-- Interface visual completa
-- Tema: Dark / Purple Cyber
--==================================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- LIMPAR VERSAO ANTERIOR
local previous = playerGui:FindFirstChild("PhantomUI")
if previous then
previous:Destroy()
end

-- CORES
local COLORS = {
Background = Color3.fromRGB(13, 12, 20),
Panel = Color3.fromRGB(22, 20, 33),
Element = Color3.fromRGB(32, 29, 46),
ElementHover = Color3.fromRGB(44, 36, 62),
Purple = Color3.fromRGB(105, 35, 170),
PurpleLight = Color3.fromRGB(145, 90, 205),
White = Color3.fromRGB(242, 239, 250),
Gray = Color3.fromRGB(155, 151, 176),
Green = Color3.fromRGB(103, 230, 166),
Red = Color3.fromRGB(255, 105, 125)
}

--==================================================
-- PHANTOM V3 | CORES PERSONALIZAVEIS 
-- Persistencia local
--==================================================

local THEME_FILE = "PhantomV3_Main_Colors.json"

local THEME_PALETTE = {
    Vermelho = Color3.fromRGB(239, 68, 68),
    Preto = Color3.fromRGB(8, 8, 8),
    Roxo = Color3.fromRGB(105, 35, 170),
    Branco = Color3.fromRGB(245, 245, 245)
}

-- Padroes do sistema de personalizacao
local THEME_DEFAULTS = {
    Barra = "Roxo",
    Area = "Preto",
    Neon = "Roxo",
    Linha = "Roxo"
}

local themeSelected = {}
for key, value in pairs(THEME_DEFAULTS) do
    themeSelected[key] = value
end
local function validTheme(data)
    if type(data) ~= "table" then
        return false
    end

    for key in pairs(THEME_DEFAULTS) do
        if type(data[key]) ~= "string"
            or THEME_PALETTE[data[key]] == nil then
            return false
        end
    end

    return true
end

local function loadTheme()
    if type(isfile) ~= "function"
        or type(readfile) ~= "function" then
        return false
    end

    local existsOK, exists = pcall(isfile, THEME_FILE)
    if not existsOK or not exists then
        return false
    end

    local readOK, contents = pcall(readfile, THEME_FILE)
    if not readOK or type(contents) ~= "string" then
        return false
    end

    local decodeOK, data = pcall(function()
        return HttpService:JSONDecode(contents)
    end)

    if not decodeOK or not validTheme(data) then
        return false
    end

    for key in pairs(THEME_DEFAULTS) do
        themeSelected[key] = data[key]
    end

    return true
end

local function saveTheme()
    if type(writefile) ~= "function" then
        return false, "Gravacao indisponivel"
    end

    local encodedOK, contents = pcall(function()
        return HttpService:JSONEncode(themeSelected)
    end)

    if not encodedOK then
        return false, "Erro ao preparar as cores"
    end

    local writeOK = pcall(writefile, THEME_FILE, contents)
    if not writeOK then
        return false, "Erro ao salvar o arquivo"
    end

    return true, "Cores salvas!"
end

local themeWasLoaded = loadTheme()


-- FUNCOES DE CONSTRUCAO
local function create(className, properties, parent)
local object = Instance.new(className)

for property, value in pairs(properties or {}) do  
    object[property] = value  
end  

object.Parent = parent  
return object

end

local function round(object, radius)
create("UICorner", {
CornerRadius = UDim.new(0, radius or 10)
}, object)
end

local function outline(object, color, thickness)
    return create("UIStroke", {
Color = color or COLORS.Purple,
Thickness = thickness or 1,
Transparency = 0.18
}, object)
end

local function label(parent, text, position, size, color, textSize, bold)
return create("TextLabel", {
BackgroundTransparency = 1,
Position = position,
Size = size,
Font = bold and Enum.Font.GothamBold
or Enum.Font.Gotham,
Text = text,
TextColor3 = color or COLORS.White,
TextSize = textSize or 12,
TextXAlignment = Enum.TextXAlignment.Left,
TextYAlignment = Enum.TextYAlignment.Center,
TextWrapped = false
}, parent)
end

local function card(parent, name, position, size)
    local frame = create("Frame", {
        Name = name,
        Position = position,
        Size = size,
        BackgroundColor3 = COLORS.Panel,
        BorderSizePixel = 0
    }, parent)

    
round(frame, 10)

local stroke = outline(
    frame,
    Color3.fromRGB(91, 65, 133),
    1
)
stroke.Transparency = 0.38

-- MARCADOR CYBER
local accent = create("Frame", {
    Name = "CyberAccent",
    Position = UDim2.fromOffset(0, 10),
    Size = UDim2.fromOffset(3, 20),
    BackgroundColor3 = COLORS.PurpleLight,
    BorderSizePixel = 0,
    ZIndex = 3
}, frame)

round(accent, 2)

return frame

end


-- GUI
local gui = create("ScreenGui", {
Name = "PhantomUI",
ResetOnSpawn = false,
IgnoreGuiInset = true,
ZIndexBehavior = Enum.ZIndexBehavior.Sibling
}, playerGui)


--==================================================
-- BOTAO FLUTUANTE ORBITAL BLACK HOLE V4
--==================================================

local openButton = create("ImageButton", {
    Name = "OpenButton",
    AnchorPoint = Vector2.new(0, 0.5),
    Size = UDim2.fromOffset(35, 35),
    Position = UDim2.new(0, 18, 0.5, 0),
    BackgroundColor3 = Color3.fromRGB(5, 4, 10),
    Image = "",
    AutoButtonColor = false,
    Visible = false,
    Active = true,
    ClipsDescendants = false,
    ZIndex = 10
}, gui)

round(openButton, 50)
outline(openButton, COLORS.Purple, 1.5)

-- HALO ROXO
local halo = create("Frame", {
    Name = "PurpleHalo",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(39, 39),
    BackgroundColor3 = COLORS.Purple,
    BackgroundTransparency = 0.7,
    BorderSizePixel = 0,
    ZIndex = 10
}, openButton)

round(halo, 50)

-- ORBITA EXTERNA
local orbit = create("Frame", {
    Name = "OrbitalRing",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(43, 17),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Rotation = -25,
    ZIndex = 12
}, openButton)

round(orbit, 50)
outline(orbit, COLORS.PurpleLight, 1.7)

-- ORBITA INTERNA
local orbit2 = create("Frame", {
            Name = "SecondaryOrbit",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(39, 13),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Rotation = 55,
    ZIndex = 11
}, openButton)

round(orbit2, 50)
outline(orbit2, COLORS.Purple, 1.2)

-- NUCLEO DO BURACO NEGRO
local core = create("Frame", {
    Name = "BlackHoleCore",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(23, 23),
    BackgroundColor3 = Color3.fromRGB(3, 2, 7),
    BorderSizePixel = 0,
    ZIndex = 13
}, openButton)

round(core, 50)
outline(core, Color3.fromRGB(115, 53, 220), 1)

-- PONTO CENTRAL
local energy = create("Frame", {
    Name = "EnergyPoint",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(4, 4),
    BackgroundColor3 = COLORS.White,
    BorderSizePixel = 0,
    ZIndex = 14
}, openButton)

round(energy, 50)

-- ANIMACAO DAS ORBITAS
TweenService:Create(
    orbit,
    TweenInfo.new(7, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1),
    {Rotation = 335}
):Play()

TweenService:Create(
    orbit2,
    TweenInfo.new(9, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1),
    {Rotation = 415}
):Play()

-- PULSO DO HALO
TweenService:Create(
    halo,
    TweenInfo.new(
        1.4,
        Enum.EasingStyle.Sine,
        Enum.EasingDirection.InOut,
                -1,
        true
    ),
    {
        BackgroundTransparency = 0.48,
        Size = UDim2.fromOffset(44, 44)
    }
):Play()


--==================================================
-- JANELA PRINCIPAL
--==================================================

local window = create("Frame", {
Name = "MainWindow",
AnchorPoint = Vector2.new(0.5, 0.5),
Position = UDim2.fromScale(0.5, 0.5),
Size = UDim2.fromOffset(320, 310),
BackgroundColor3 = COLORS.Background,
BorderSizePixel = 0,
Visible = true,
ClipsDescendants = true,
ZIndex = 1
}, gui)

local windowScale = create("UIScale", { 
    Name = "WindowScale",
    Scale = 1
}, window)
--==================================================
-- PHANTOM V3 | CONFIGURACAO DE TAMANHO
--==================================================

local SIZE_FILE = "PhantomV3_WindowSize.json"

local MIN_WINDOW_SCALE = 0.75
local MAX_WINDOW_SCALE = 1.25
local DEFAULT_WINDOW_SCALE = 1

local function loadWindowScale()
    if not (isfile and readfile) then
        return DEFAULT_WINDOW_SCALE
    end

    local success, result = pcall(function()
        if not isfile(SIZE_FILE) then
            return DEFAULT_WINDOW_SCALE
        end

        local data = game:GetService("HttpService"):JSONDecode(
            readfile(SIZE_FILE)
        )

        local scale = tonumber(data.Scale)

        if scale then
            return math.clamp(
                scale,
                MIN_WINDOW_SCALE,
                                    MAX_WINDOW_SCALE
            )
        end

        return DEFAULT_WINDOW_SCALE
    end)

    if success then
        return result
    end

    return DEFAULT_WINDOW_SCALE
end

local function saveWindowScale(scale)
    if not (writefile and isfile) then
        return false
    end

    local success = pcall(function()
        local data = {
            Scale = scale
        }

        writefile(
            SIZE_FILE,
            game:GetService("HttpService"):JSONEncode(data)
        )
    end)

    return success
end
windowScale.Scale = loadWindowScale()

round(window, 14)

-- CONTORNO NEON ANIMADO
local windowStroke = outline(
    window,
    Color3.fromRGB(190, 110, 255),
    3.5
)

windowStroke.Transparency = 0

local borderGradient = create("UIGradient", {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(
            0,
            Color3.fromRGB(65, 30, 110)
        ),
        ColorSequenceKeypoint.new(
            0.42,
            Color3.fromRGB(157, 91, 255)
        ),
        ColorSequenceKeypoint.new(
            0.5,
            Color3.fromRGB(245, 225, 255)
        ),
        ColorSequenceKeypoint.new(
                                0.58,
            Color3.fromRGB(157, 91, 255)
        ),
        ColorSequenceKeypoint.new(
            1,
            Color3.fromRGB(65, 30, 110)
        )
    }),
    Rotation = 0
}, windowStroke)

local borderAnimation = TweenService:Create(
    borderGradient,
    TweenInfo.new(
        10,
        Enum.EasingStyle.Linear,
        Enum.EasingDirection.InOut,
        -1,
        false
    ),
    {
        Rotation = 360
    }
)

borderAnimation:Play()

-- ACENTO CYBER SUPERIOR
local topAccent = create("Frame", {
    Name = "TopAccent",
    Position = UDim2.fromOffset(16, 0),
    Size = UDim2.new(0, 76, 0, 3),
    BackgroundColor3 = COLORS.PurpleLight,
    BorderSizePixel = 0,
    ZIndex = 5
}, window)

round(topAccent, 2)


-- CABECALHO
local header = create("Frame", {
Name = "Header",
Size = UDim2.new(1, 0, 0, 46),
BackgroundColor3 = Color3.fromRGB(48, 32, 70),
BorderSizePixel = 0,
ZIndex = 2
}, window)
round(header, 14)
create("Frame", {
    Name = "HeaderBottomFill",
    Position = UDim2.new(0, 0, 0, 14),
    Size = UDim2.new(1, 0, 0, 32),
    BackgroundColor3 = Color3.fromRGB(48, 32, 70),
    BorderSizePixel = 0,
    ZIndex = 2
}, header)


local titleLabel = label(
    header,
    "鈼�  PHANTOM",
    UDim2.fromOffset(13, 2),
    UDim2.new(1, -65, 0, 25),
    COLORS.White,
    16,
    true
)

titleLabel.ZIndex = 3
titleLabel.TextStrokeColor3 = COLORS.Purple
titleLabel.TextStrokeTransparency = 0.82

label(
header,
"V3  /  MOBILE INTERFACE",
UDim2.fromOffset(15, 25),
UDim2.new(1, -65, 0, 13),
COLORS.PurpleLight,
8,
false
).ZIndex = 3

local headerLine = create("Frame", {
Name = "NeonLine",
Position = UDim2.new(0, 12, 1, -1),
Size = UDim2.new(1, -24, 0, 1),
BackgroundColor3 = COLORS.Purple,
BorderSizePixel = 0,
ZIndex = 3
}, header)

local closeButton = create("TextButton", {
Name = "CloseButton",
Position = UDim2.new(1, -38, 0, 9),
Size = UDim2.fromOffset(27, 27),
BackgroundColor3 = Color3.fromRGB(57, 32, 73),
TextColor3 = COLORS.PurpleLight,
TextSize = 21,
Text = "脳",
Font = Enum.Font.GothamBold,
AutoButtonColor = true,
ZIndex = 4
}, header)

round(closeButton, 8)
outline(closeButton, COLORS.Purple, 1)

-- BARRA LATERAL
local sidebar = create("Frame", {
Name = "Sidebar",
Position = UDim2.fromOffset(0, 46),
Size = UDim2.new(0, 94, 1, -46),
BackgroundColor3 = COLORS.Panel,
BorderSizePixel = 0,
ZIndex = 2
}, window)
round(sidebar, 14)
create("Frame", {
    Name = "SidebarTopFill",
        Position = UDim2.new(0, 0, 0, 0),
    Size = UDim2.new(1, 0, 0, 14),
    BackgroundColor3 = COLORS.Panel,
    BorderSizePixel = 0,
    ZIndex = 2
}, sidebar)

create("Frame", {
    Name = "SidebarRightFill",
    Position = UDim2.new(1, -14, 0, 0),
    Size = UDim2.new(0, 14, 1, 0),
    BackgroundColor3 = COLORS.Panel,
    BorderSizePixel = 0,
    ZIndex = 2
}, sidebar)

-- DIVISORIA CYBER
local sidebarDivider = create("Frame", {
    Name = "SidebarDivider",
    Position = UDim2.new(1, -1, 0, 8),
    Size = UDim2.new(0, 1, 1, -16),
    BackgroundColor3 = Color3.fromRGB(76, 54, 103),
    BackgroundTransparency = 0.25,
    BorderSizePixel = 0,
    ZIndex = 3
}, sidebar)

label(
sidebar,
"MENU",
UDim2.fromOffset(12, 8),
UDim2.new(1, -20, 0, 18),
COLORS.Gray,
9,
true
).ZIndex = 3

-- AREA DAS PAGINAS
local pageHost = create("Frame", {
Name = "PageHost",
Position = UDim2.fromOffset(104, 56),
Size = UDim2.new(1, -114, 1, -66),
BackgroundColor3 = COLORS.Background,
BackgroundTransparency = 0,
ClipsDescendants = true,
ZIndex = 2
}, window)

local function createTab(name, text, y)
    local button = create("TextButton", {
        Name = name .. "Tab",
        Position = UDim2.fromOffset(7, y),
        Size = UDim2.new(1, -14, 0, 37),
        BackgroundColor3 = COLORS.Element,
        Text = text,
        TextColor3 = COLORS.Gray,
        TextSize = 11,
        Font = Enum.Font.GothamMedium,
        AutoButtonColor = true,
        ZIndex = 3
    }, sidebar)

    round(button, 8)

    local indicator = create("Frame", {
        Name = "Indicator",
        Position = UDim2.fromOffset(0, 9),
        Size = UDim2.fromOffset(3, 19),
        BackgroundColor3 = COLORS.PurpleLight,
        BorderSizePixel = 0,
        Visible = false,
        ZIndex = 4
    }, button)

    round(indicator, 2)

    tabs[name] = {
        Button = button,
        Indicator = indicator
    }

    return button
end

createTab("Principal", "鈱�  Principal", 34)
createTab("Ajustes", "鈿�  Ajustes", 77)
createTab("ESPVisual", "鈼�  ESP / VISUAL", 120)


--==================================================
-- PAGINA PRINCIPAL
--==================================================

local home = createPage("Principal")

local homeScroll = create("ScrollingFrame", {
Name = "HomeScroll",
    Position = UDim2.fromOffset(0, 28),
    Size = UDim2.new(1, 0, 1, -28),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = COLORS.Purple,
    ScrollingDirection = Enum.ScrollingDirection.Y,
    AutomaticCanvasSize = Enum.AutomaticSize.None,
    CanvasSize = UDim2.new(0, 0, 0, 320),
    Active = true,
    ZIndex = 3
}, home)

label(
home,
"PAINEL PRINCIPAL",
UDim2.fromOffset(0, 2),
UDim2.new(1, 0, 0, 22),
COLORS.PurpleLight,
12,
true
)

-- CONTADORES: FPS / PING / JOGADORES
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Stats = game:GetService("Stats")

local counters = create("Frame", {
    Name = "PerformanceCounters",
    Position = UDim2.fromOffset(0, 0),
    Size = UDim2.new(1, 0, 0, 42),
    BackgroundTransparency = 1,
    BorderSizePixel = 0
}, homeScroll)

local function createCounter(name, color, position, width)
    local item = create("Frame", {
        Name = name .. "Card",
        Position = UDim2.new(0, position, 0, 0),
        Size = UDim2.new(0, width, 1, 0),
        BackgroundColor3 = Color3.fromRGB(30, 25, 42),
        BorderSizePixel = 0
    }, counters)

    create("UICorner", {
        CornerRadius = UDim.new(0, 6)
    }, item)

    local text = create("TextLabel", {
        Name = name .. "Text",
        Size = UDim2.new(1, -4, 1, 0),
        Position = UDim2.fromOffset(2, 0),
        BackgroundTransparency = 1,
        Text = name .. ": --",
        TextColor3 = color,
        Font = Enum.Font.GothamSemibold,
        TextSize = 10,
        TextScaled = false,
        BorderSizePixel = 0
    }, item)

    return text
end

local fpsLabel = createCounter(
    "FPS", COLORS.PurpleLight, 0, 52
)

local pingLabel = createCounter(
    "PING", Color3.fromRGB(85, 216, 255), 56, 58
)

local playersLabel = createCounter(
    "JOGADORES", Color3.fromRGB(107, 231, 160), 118, 82
)

-- Atualiza莽茫o peri贸dica dos valores
local elapsed = 0
local frames = 0
local currentFPS = 0

local function readPing()
    local success, value = pcall(function()
        return Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
    end)

    if success and type(value) == "number" then
        return math.floor(value + 0.5)
    end

    return nil
end

RunService.RenderStepped:Connect(function(dt)
    frames = frames + 1
    elapsed = elapsed + dt

    if elapsed >= 1 then
        currentFPS = math.floor(frames / elapsed + 0.5)
        frames = 0
        elapsed = 0

        fpsLabel.Text = "FPS: " .. currentFPS

        local ping = readPing()
        pingLabel.Text = ping
            and ("PING: " .. ping .. "ms")
            or "PING: --"

        playersLabel.Text = "JOGADORES: "
            .. #Players:GetPlayers()
    end
end)

local welcome = card(
    homeScroll,
    "WelcomeCard",
    UDim2.fromOffset(0, 76),
    UDim2.new(1, 0, 0, 65)
)

local welcomeDivider = create("Frame", {
    Name = "WelcomeDivider",
    Position = UDim2.new(0, 10, 0, 31),
    Size = UDim2.new(1, -20, 0, 1),
    BackgroundColor3 = Color3.fromRGB(76, 54, 103),
    BackgroundTransparency = 0.25,
    BorderSizePixel = 0,
    ZIndex = 3
}, welcome)

label(
    welcome,
    "Bem-vindo ao PHANTOM",
    UDim2.fromOffset(10, 8),
    UDim2.new(1, -20, 0, 22),
    COLORS.White,
    11,
    true
)

label(
    welcome,
    "Seu espaco de configuracao",
    UDim2.fromOffset(10, 33),
    UDim2.new(1, -20, 0, 19),
    COLORS.Gray,
    9,
    false
)

local statusCard = card(
    homeScroll,
    "StatusCard",
    UDim2.fromOffset(0, 150),
    UDim2.new(1, 0, 0, 59)
)

label(
statusCard,
"STATUS DA INTERFACE",
UDim2.fromOffset(10, 5),
UDim2.new(1, -20, 0, 17),
COLORS.Gray,
9,
true
)

local statusLabel = label(
statusCard,
"鈼�  Interface carregada",
UDim2.fromOffset(10, 27),
UDim2.new(1, -20, 0, 22),
COLORS.Green,
11,
true
)

local infoCard = card(
    homeScroll,
    "InfoCard",
UDim2.fromOffset(0, 218),
UDim2.new(1, 0, 0, 57)
)

label(
infoCard,
"VERSAO",
UDim2.fromOffset(10, 5),
UDim2.new(1, -20, 0, 17),
COLORS.Gray,
9,
true
)

label(
infoCard,
"PHANTOM V3.0",
UDim2.fromOffset(10, 26),
UDim2.new(1, -20, 0, 22),
COLORS.White,
12,
true
)

label(
    homeScroll,
    "Novas opcoes poderao ser adicionadas aqui.",
    UDim2.fromOffset(0, 284),
    UDim2.new(1, 0, 0, 30),
    COLORS.Gray,
    9,
    false
)
--==================================================
-- PAGINA AJUSTES
--==================================================

local settings = createPage("Ajustes")

label(
settings,
"AJUSTES",
UDim2.fromOffset(0, 2),
UDim2.new(1, 0, 0, 22),
COLORS.PurpleLight,
12,
true
)


--==================================================
-- PHANTOM V3 | PERSONALIZACAO DO TEMA
-- Dentro da pagina AJUSTES
--==================================================

local themeScroll = create("ScrollingFrame", {
    Name = "ThemeColorScroll",
    Position = UDim2.fromOffset(0, 28),
    Size = UDim2.new(1, 0, 1, -50),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = COLORS.Purple,
    ScrollingDirection = Enum.ScrollingDirection.Y,
    AutomaticCanvasSize = Enum.AutomaticSize.None,
    CanvasSize = UDim2.fromOffset(0, 0),
    Active = true,
    ZIndex = 3
}, settings)

local themeStatus = label(
    settings,
    "",
    UDim2.new(0, 0, 1, -22),
    UDim2.new(1, 0, 0, 14),
    COLORS.Gray,
    8,
    false
)
themeStatus.TextXAlignment = Enum.TextXAlignment.Center

local themeSections = {}
local expandedThemeKey = nil

local themeDefinitions = {
    {key = "Barra", title = "BARRA LATERAL"},
    {key = "Area", title = "AREA DAS PAGINAS"},
    {key = "Neon", title = "ILUMINACAO NEON"},
    {key = "Linha", title = "COR DA LINHA"}
}

-- Aplicar uma cor em cada parte do menu
local function applyThemeColor(key, color)
    if key == "Barra" then
        sidebar.BackgroundColor3 = color

        local topFill = sidebar:FindFirstChild("SidebarTopFill")
        local rightFill = sidebar:FindFirstChild("SidebarRightFill")

        if topFill then
            topFill.BackgroundColor3 = color
        end

        if rightFill then
            rightFill.BackgroundColor3 = color
        end

    elseif key == "Area" then
        pageHost.BackgroundColor3 = color
        pageHost.BackgroundTransparency = 0

    elseif key == "Neon" then
    local dark = color:Lerp(Color3.new(0, 0, 0), 0.35)
local bright = color:Lerp(Color3.new(1, 1, 1), 0.15)

    windowStroke.Color = color

    borderGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, dark),
        ColorSequenceKeypoint.new(0.42, color),
        ColorSequenceKeypoint.new(0.5, bright),
        ColorSequenceKeypoint.new(0.58, color),
        ColorSequenceKeypoint.new(1, dark)
    })

    topAccent.BackgroundColor3 = color
    themeScroll.ScrollBarImageColor3 = color

    for _, tab in pairs(tabs) do
    tab.Indicator.BackgroundColor3 = color
        end

    elseif key == "Linha" then
        headerLine.BackgroundColor3 = color
        sidebarDivider.BackgroundColor3 = color
    end
end

local function applyAllThemeColors()
    for key, colorName in pairs(themeSelected) do
        applyThemeColor(key, THEME_PALETTE[colorName])

        local section = themeSections[key]
        if section then
            section.refresh()
        end
    end
end
local saveThemeButton
local resetThemeButton
local sizePanel

local function updateThemeLayout()
    local y = 0

    for _, def in ipairs(themeDefinitions) do
        local section = themeSections[def.key]
        local isOpen = expandedThemeKey == def.key

        section.holder.Position = UDim2.fromOffset(0, y)

        local height = isOpen and 145 or 39
        section.holder.Size = UDim2.new(1, -2, 0, height)
        section.options.Visible = isOpen
        section.arrow.Text = isOpen and "-" or "+"

        y = y + height + 5
    end


    if saveThemeButton and resetThemeButton then
        saveThemeButton.Position = UDim2.new(0, 0, 0, y + 2)
        resetThemeButton.Position = UDim2.new(0.5, 3, 0, y + 2)
      y = y + 29
    end

    if sizePanel then
        sizePanel.Position = UDim2.fromOffset(0, y + 8)
        y = y + 116
    end

    themeScroll.CanvasSize = UDim2.fromOffset(0, y + 250)
end

local function makeThemeSection(def)
    local holder = create("Frame", {
        Name = def.key .. "ColorSection",
        Position = UDim2.fromOffset(0, 0),
        Size = UDim2.new(1, -2, 0, 39),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 3
    }, themeScroll)

    local head = create("TextButton", {
        Name = "SectionHeader",
        Size = UDim2.new(1, 0, 0, 35),
        BackgroundColor3 = COLORS.Element,
        Text = "",
        BorderSizePixel = 0,
        AutoButtonColor = false,
        ZIndex = 3
    }, holder)

    round(head, 7)
    outline(head, COLORS.Purple, 1)

    label(
        head,
        def.title,
        UDim2.fromOffset(8, 1),
        UDim2.new(1, -63, 0, 16),
        COLORS.White,
        9,
        true
    ).ZIndex = 4

    local current = label(
        head,
        "Atual: " .. themeSelected[def.key],
        UDim2.fromOffset(8, 17),
        UDim2.new(1, -63, 0, 14),
        COLORS.Gray,
        8,
        false
    )
    current.ZIndex = 4

    local swatch = create("Frame", {
        Name = "CurrentSwatch",
        Position = UDim2.new(1, -43, 0, 9),
        Size = UDim2.fromOffset(16, 16),
        BackgroundColor3 = THEME_PALETTE[themeSelected[def.key]],
        BorderSizePixel = 0,
        ZIndex = 4
    }, head)

    round(swatch, 4)
    outline(swatch, COLORS.PurpleLight, 1)

    local arrow = label(
        head,
        "+",
        UDim2.new(1, -24, 0, 0),
        UDim2.fromOffset(20, 35),
        COLORS.PurpleLight,
        15,
        true
    )
    arrow.Parent = head
    arrow.ZIndex = 4
    arrow.TextXAlignment = Enum.TextXAlignment.Center

    local options = create("Frame", {
        Name = "ColorOptions",
        Position = UDim2.fromOffset(0, 39),
        Size = UDim2.new(1, 0, 0, 104),
        BackgroundColor3 = COLORS.Background,
        BorderSizePixel = 0,
        Visible = false,
        ZIndex = 3
    }, holder)

    round(options, 6)

    local entries = {}

    local function readableThemeText(color)
        local brightness =
            color.R * 0.299 +
            color.G * 0.587 +
            color.B * 0.114

        if brightness > 0.58 then
            return Color3.fromRGB(18, 16, 23)
        end

        return COLORS.White
    end

    for i, colorName in ipairs({
        "Vermelho", "Preto", "Roxo", "Branco"
    }) do
        local button = create("TextButton", {
            Name = colorName .. "Option",
            Position = UDim2.fromOffset(4, 3 + (i - 1) * 25),
            Size = UDim2.new(1, -8, 0, 22),
            BackgroundColor3 = COLORS.Element,
            Text = "",
            BorderSizePixel = 0,
            AutoButtonColor = true,
            ZIndex = 4
            }, options)

        round(button, 4)

        local swatchOption = create("Frame", {
            Position = UDim2.fromOffset(5, 3),
            Size = UDim2.fromOffset(16, 16),
            BackgroundColor3 = THEME_PALETTE[colorName],
            BorderSizePixel = 0,
            ZIndex = 5
        }, button)

        round(swatchOption, 3)

        label(
            button,
            colorName,
            UDim2.fromOffset(27, 0),
            UDim2.new(1, -70, 1, 0),
            readableThemeText(THEME_PALETTE[colorName]),
            9,
            false
        ).ZIndex = 5

        local status = label(
            button,
            "",
            UDim2.new(1, -43, 0, 0),
            UDim2.fromOffset(38, 22),
            COLORS.PurpleLight,
            8,
            true
        )
        status.TextXAlignment = Enum.TextXAlignment.Right
        status.ZIndex = 5

        entries[colorName] = {
            button = button,
            status = status
        }

        button.Activated:Connect(function()
            themeSelected[def.key] = colorName

            applyThemeColor(
                def.key,
                THEME_PALETTE[colorName]
            )

            for _, section in pairs(themeSections) do
                section.refresh()
            end

            themeStatus.Text = "Alteracao ainda nao salva."
            themeStatus.TextColor3 = COLORS.Gray
        end)
    end

    local section = {
        holder = holder,
        options = options,
        arrow = arrow,
        current = current,
        swatch = swatch
    }

    function section.refresh()
        local chosen = themeSelected[def.key]

        current.Text = "Atual: " .. chosen
        swatch.BackgroundColor3 = THEME_PALETTE[chosen]

        for colorName, entry in pairs(entries) do
            local active = colorName == chosen

            entry.status.Text = active and "ATIVO" or ""
            entry.button.BackgroundColor3 = active
                and Color3.fromRGB(65, 45, 80)
                or COLORS.Element
        end
    end

    themeSections[def.key] = section

    head.Activated:Connect(function()
        if expandedThemeKey == def.key then
            expandedThemeKey = nil
        else
            expandedThemeKey = def.key
        end

        updateThemeLayout()
    end)

    section.refresh()
end

for _, def in ipairs(themeDefinitions) do
    makeThemeSection(def)
end

-- Botao salvar
saveThemeButton = create("TextButton", {
    Name = "SaveThemeButton",
    Position = UDim2.fromOffset(0, 0),
    Size = UDim2.new(0.5, -3, 0, 22),
    BackgroundColor3 = Color3.fromRGB(65, 45, 80),
    Text = "SALVAR CORES",
    TextColor3 = COLORS.White,
    Font = Enum.Font.GothamBold,
    TextSize = 9,
    BorderSizePixel = 0,
    ZIndex = 4
}, themeScroll)

round(saveThemeButton, 6)

-- Botao resetar
resetThemeButton = create("TextButton", {
    Name = "ResetThemeButton",
    Position = UDim2.fromOffset(0, 0),
    Size = UDim2.new(0.5, -3, 0, 22),
    BackgroundColor3 = COLORS.Element,
    Text = "RESETAR CORES",
    TextColor3 = COLORS.White,
    Font = Enum.Font.GothamBold,
    TextSize = 9,
    BorderSizePixel = 0,
    ZIndex = 4
}, themeScroll)

round(resetThemeButton, 6)

saveThemeButton.Activated:Connect(function()
    local success, result = saveTheme()

    themeStatus.Text = result
    themeStatus.TextColor3 = success
        and COLORS.Green
        or COLORS.Red
end)

resetThemeButton.Activated:Connect(function()
    for key, colorName in pairs(THEME_DEFAULTS) do
        themeSelected[key] = colorName
    end

    applyAllThemeColors()

    themeStatus.Text = "Padrao restaurado. Salve para manter."
    themeStatus.TextColor3 = COLORS.Gray
end)

-- Aplicar as cores carregadas ao iniciar
applyAllThemeColors()
updateThemeLayout()

themeStatus.Text = themeWasLoaded
    and "Ultimas cores salvas carregadas."
    or "Tema padrao carregado."

--==================================================
-- PHANTOM V3 | CONTROLE DE TAMANHO
--==================================================


sizePanel = create("Frame", {
    Name = "WindowSizePanel",
    Position = UDim2.new(0, 0, 0, 160),
    Size = UDim2.new(1, 0, 0, 100),
    BackgroundTransparency = 1,
    Visible = true,
BackgroundColor3 = COLORS.Background,
BackgroundTransparency = 1,
BorderSizePixel = 0,
ZIndex = 3
}, themeScroll)

local sizeTitle = label(
    sizePanel,
    "TAMANHO DO MENU",
    UDim2.fromOffset(0, 0),
    UDim2.new(1, 0, 0, 20),
    COLORS.PurpleLight,
    12,
    true
)

local sizeValue = label(
    sizePanel,
    "100%",
    UDim2.fromOffset(0, 20),
    UDim2.new(1, 0, 0, 22),
    COLORS.White,
    16,
    true
)

local sizeTrack = create("Frame", {
    Name = "SizeTrack",
    Position = UDim2.new(0, 12, 0, 51),
    Size = UDim2.new(1, -24, 0, 6),
    BackgroundColor3 = COLORS.Element,
    BorderSizePixel = 0,
    ZIndex = 4
}, sizePanel)

round(sizeTrack, 4)

local sizeFill = create("Frame", {
    Name = "SizeFill",
    Size = UDim2.new(2 / 3, 0, 1, 0),
    BackgroundColor3 = COLORS.Purple,
    BorderSizePixel = 0,
    ZIndex = 5
}, sizeTrack)

round(sizeFill, 4)

local sizeKnob = create("TextButton", {
    Name = "SizeKnob",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(2 / 3, 0, 0.5, 0),
    Size = UDim2.fromOffset(18, 18),
    BackgroundColor3 = COLORS.White,
    Text = "",
    BorderSizePixel = 0,
    AutoButtonColor = false,
    ZIndex = 6
}, sizeTrack)

round(sizeKnob, 9)

local sizeSaveButton = create("TextButton", {
    Name = "SaveWindowSizeButton",
    Position = UDim2.fromOffset(0, 65),
    Size = UDim2.new(1, 0, 0, 26),
    BackgroundColor3 = Color3.fromRGB(65, 45, 80),
    Text = "SALVAR TAMANHO",
    TextColor3 = COLORS.White,
Font = Enum.Font.GothamBold,
    TextSize = 10,
    BorderSizePixel = 0,
    ZIndex = 4
}, sizePanel)

round(sizeSaveButton, 6)

--==================================================
-- PHANTOM V3 | LOGICA DO CONTROLE DE TAMANHO
--==================================================

local sizeDragging = false

local function updateSizeSlider(inputX)
    local trackX = sizeTrack.AbsolutePosition.X
    local trackWidth = sizeTrack.AbsoluteSize.X

    if trackWidth <= 0 then
        return
    end

    local alpha = math.clamp(
        (inputX - trackX) / trackWidth,
        0,
        1
    )

    local scale = 0.50 + alpha * 0.75
    scale = math.floor(scale * 100 + 0.5) / 100

    windowScale.Scale = scale
    sizeKnob.Position = UDim2.new(alpha, 0, 0.5, 0)
    sizeFill.Size = UDim2.new(alpha, 0, 1, 0)
    sizeValue.Text = tostring(math.floor(scale * 100 + 0.5)) .. "%"
end

local function beginSizeDrag(input)
    sizeDragging = true
    updateSizeSlider(input.Position.X)
end

sizeKnob.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        beginSizeDrag(input)
    end
end)

sizeTrack.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        beginSizeDrag(input)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if sizeDragging then
        if input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch then
            updateSizeSlider(input.Position.X)
        end
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        sizeDragging = false
    end
end)

-- Carregar o tamanho salvo na regua
do
    local scale = windowScale.Scale
    local alpha = (scale - 0.50) / 0.75

    sizeKnob.Position = UDim2.new(alpha, 0, 0.5, 0)
    sizeFill.Size = UDim2.new(alpha, 0, 1, 0)
    sizeValue.Text = tostring(math.floor(scale * 100 + 0.5)) .. "%"
end

-- Salvar tamanho escolhido
sizeSaveButton.Activated:Connect(function()
    local success = saveWindowScale(windowScale.Scale)

    if success then
        sizeValue.Text = "SALVO: "
            .. tostring(math.floor(windowScale.Scale * 100 + 0.5))
            .. "%"
    else
        sizeValue.Text = "ERRO AO SALVAR"
    end
end)


--==================================================
-- CONTROLE DE ABERTURA
-- Declarado antes dos eventos dos botoes
--==================================================

local function setMenuOpen(isOpen)
window.Visible = isOpen
openButton.Visible = not isOpen
end

-- TROCA DE PAGINA
local function showPage(name)
if not pages[name] then
return
end

currentPage = name  

for pageName, page in pairs(pages) do  
    page.Visible = (pageName == name)  
end  

for tabName, tab in pairs(tabs) do  
    local selected = (tabName == name)  
tab.Button.BackgroundColor3 = selected
    and Color3.fromRGB(57, 39, 81)
    or COLORS.Element

tab.Button.TextColor3 = selected
    and COLORS.PurpleLight
    or COLORS.Gray

tab.Indicator.Visible = selected
 
end

end

tabs.Principal.Button.Activated:Connect(function()
showPage("Principal")
end)

tabs.Ajustes.Button.Activated:Connect(function()
showPage("Ajustes")
end)

tabs.ESPVisual.Button.Activated:Connect(function()
    showPage("ESPVisual")
end)


closeButton.Activated:Connect(function()
setMenuOpen(false)
end)

--==================================================
-- ARRASTAR A MASCARA E ABRIR AO TOCAR
--==================================================

local buttonDragging = false
local buttonMoved = false
local buttonDragStart
local buttonStartPosition
local buttonDragInput

openButton.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.Touch
or input.UserInputType == Enum.UserInputType.MouseButton1 then

buttonDragging = true  
    buttonMoved = false  
    buttonDragStart = input.Position  
    buttonStartPosition = openButton.Position  
    buttonDragInput = input  
end

end)

UserInputService.InputChanged:Connect(function(input)
if not buttonDragging then
return
end

local isMouseMove =  
    input.UserInputType == Enum.UserInputType.MouseMovement  

local isTouchMove =  
    input.UserInputType == Enum.UserInputType.Touch  

if isMouseMove or isTouchMove then  
    local delta = input.Position - buttonDragStart  

    if delta.Magnitude > 7 then  
        buttonMoved = true  
    end  

    if buttonMoved then  
        openButton.Position = UDim2.new(  
            buttonStartPosition.X.Scale,  
            buttonStartPosition.X.Offset + delta.X,  
            buttonStartPosition.Y.Scale,  
            buttonStartPosition.Y.Offset + delta.Y  
        )  
    end  
end

end)

UserInputService.InputEnded:Connect(function(input)
local sameInput = input == buttonDragInput
local mouseReleased =
input.UserInputType == Enum.UserInputType.MouseButton1

if buttonDragging and (sameInput or mouseReleased) then  
    buttonDragging = false  
    buttonDragInput = nil  

    if not buttonMoved then  
        setMenuOpen(true)  
    end  

    buttonMoved = false  
end

end)

--==================================================
-- ARRASTAR A JANELA PELO CABECALHO
--==================================================

local windowDragging = false
local windowDragStart
local windowStartPosition
local windowDragInput

header.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.Touch
or input.UserInputType == Enum.UserInputType.MouseButton1 then

windowDragging = true  
    windowDragStart = input.Position  
    windowStartPosition = window.Position 
    windowDragInput = input  
end

end)

UserInputService.InputChanged:Connect(function(input)
if not windowDragging then
return
end

local isMouseMove =  
    input.UserInputType == Enum.UserInputType.MouseMovement  

local isTouchMove =  
    input.UserInputType == Enum.UserInputType.Touch  

if isMouseMove or isTouchMove then  
    local delta = input.Position - windowDragStart  

    window.Position = UDim2.new(  
        windowStartPosition.X.Scale,  
        windowStartPosition.X.Offset + delta.X,  
        windowStartPosition.Y.Scale,  
        windowStartPosition.Y.Offset + delta.Y  
    )  
end

end)

UserInputService.InputEnded:Connect(function(input)
if input == windowDragInput
or input.UserInputType == Enum.UserInputType.MouseButton1 then

windowDragging = false  
    windowDragInput = nil  
end

end)

--==================================================
-- INICIALIZACAO
--==================================================

showPage("Principal")
setMenuOpen(true)

print("[PHANTOM V3] Interface carregada.")
