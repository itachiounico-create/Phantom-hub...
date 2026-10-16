

--==================================================
-- PHANTOM V3 | MOBILE UI
-- Interface visual completa
-- Tema: Dark / Purple Cyber
--==================================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

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
Purple = Color3.fromRGB(157, 91, 255),
PurpleLight = Color3.fromRGB(194, 151, 255),
White = Color3.fromRGB(242, 239, 250),
Gray = Color3.fromRGB(155, 151, 176),
Green = Color3.fromRGB(103, 230, 166),
Red = Color3.fromRGB(255, 105, 125)
}

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
    "◈  PHANTOM",
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
Text = "×",
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
BackgroundTransparency = 1,
ClipsDescendants = true,
ZIndex = 2
}, window)

--==================================================
-- NAVEGACAO
--==================================================

local pages = {}
local tabs = {}
local currentPage

local function createPage(name)
local page = create("Frame", {
Name = name,
Size = UDim2.fromScale(1, 1),
BackgroundTransparency = 1,
Visible = false,
ZIndex = 2
}, pageHost)

pages[name] = page  
return page

end

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

createTab("Principal", "⌂  Principal", 34)
createTab("Ajustes", "⚙  Ajustes", 77)

--==================================================
-- PAGINA PRINCIPAL
--==================================================

local home = createPage("Principal")

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
    Position = UDim2.fromOffset(0, 27),
    Size = UDim2.new(1, 0, 0, 42),
    BackgroundTransparency = 1,
    BorderSizePixel = 0
}, home)

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

-- Atualização periódica dos valores
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
home,
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
home,
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
"●  Interface carregada",
UDim2.fromOffset(10, 27),
UDim2.new(1, -20, 0, 22),
COLORS.Green,
11,
true
)

local infoCard = card(
home,
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
home,
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

local appearanceCard = card(
settings,
"AppearanceCard",
UDim2.fromOffset(0, 31),
UDim2.new(1, 0, 0, 76)
)

label(
appearanceCard,
"APARENCIA",
UDim2.fromOffset(10, 7),
UDim2.new(1, -20, 0, 18),
COLORS.White,
11,
true
)

label(
appearanceCard,
"Tema escuro / roxo neon",
UDim2.fromOffset(10, 32),
UDim2.new(1, -20, 0, 19),
COLORS.Gray,
9,
false
)

local versionCard = card(
settings,
"VersionCard",
UDim2.fromOffset(0, 117),
UDim2.new(1, 0, 0, 76)
)

label(
versionCard,
"INFORMACOES",
UDim2.fromOffset(10, 7),
UDim2.new(1, -20, 0, 18),
COLORS.White,
11,
true
)

label(
versionCard,
"PHANTOM V3.0",
UDim2.fromOffset(10, 31),
UDim2.new(1, -20, 0, 18),
COLORS.PurpleLight,
11,
true
)

label(
versionCard,
"Interface visual para celular",
UDim2.fromOffset(10, 51),
UDim2.new(1, -20, 0, 17),
COLORS.Gray,
9,
false
)

label(
settings,
"As opcoes serao configuradas depois.",
UDim2.fromOffset(0, 207),
UDim2.new(1, 0, 0, 30),
COLORS.Gray,
9,
false
)

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
