


--==================================================
-- PHANTOM | MENU V2
-- Interface visual com páginas selecionáveis
--==================================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Remove uma interface anterior do mesmo nome
local previous = playerGui:FindFirstChild("PhantomUI")
if previous then
    previous:Destroy()
end

-- CONFIGURAÇÃO
local COLORS = {
    Background = Color3.fromRGB(15, 15, 22),
    Panel = Color3.fromRGB(23, 23, 34),
    Element = Color3.fromRGB(32, 30, 46),
    Purple = Color3.fromRGB(155, 90, 255),
    White = Color3.fromRGB(240, 240, 250),
    Gray = Color3.fromRGB(155, 155, 175),
    Green = Color3.fromRGB(100, 230, 160)
}

-- FUNÇÕES VISUAIS
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
    create("UIStroke", {
        Color = color or COLORS.Purple,
        Thickness = thickness or 1,
        Transparency = 0.15
    }, object)
end

local function makeLabel(parent, text, position, size, color, textSize)
    return create("TextLabel", {
        BackgroundTransparency = 1,
        Position = position,
        Size = size,
        Font = Enum.Font.Gotham,
        Text = text,
        TextColor3 = color or COLORS.White,
        TextSize = textSize or 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center
    }, parent)
end

-- GUI PRINCIPAL
local gui = create("ScreenGui", {
    Name = "PhantomUI",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling
}, playerGui)


-- BOTÃO FLUTUANTE PHANTOM
local openButton = create("ImageButton", {
    Name = "OpenButton",
    Size = UDim2.fromOffset(48, 48),
    Position = UDim2.new(0, 18, 0.5, -24),
    BackgroundColor3 = COLORS.Background,
    Image = "",
    Visible = false,
    AutoButtonColor = true
}, gui)

round(openButton, 16)
outline(openButton, COLORS.Purple, 2)


-- MÁSCARA PHANTOM CYBER | NEON ROXO

-- Halo neon por trás da máscara
local halo = create("Frame", {
    Name = "PhantomHalo",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.48),
    Size = UDim2.fromOffset(36, 38),
    BackgroundColor3 = COLORS.Purple,
    BackgroundTransparency = 0.52,
    BorderSizePixel = 0,
    ZIndex = 1
}, openButton)

round(halo, 13)

-- Máscara principal
local mask = create("Frame", {
    Name = "PhantomMask",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.47),
    Size = UDim2.fromOffset(27, 29),
    BackgroundColor3 = Color3.fromRGB(242, 238, 255),
    BorderSizePixel = 0,
    ZIndex = 2
}, openButton)

round(mask, 10)
outline(mask, Color3.fromRGB(190, 135, 255), 1.5)

-- Parte inferior estilizada
local maskBase = create("Frame", {
    Name = "MaskBase",
    Position = UDim2.new(0, 2, 1, -8),
    Size = UDim2.new(1, -4, 0, 7),
    BackgroundColor3 = Color3.fromRGB(242, 238, 255),
    BorderSizePixel = 0,
    ZIndex = 2
}, mask)

round(maskBase, 3)

-- Olhos arredondados com fundo neon
for _, x in ipairs({5, 17}) do
    local eyeGlow = create("Frame", {
        Position = UDim2.fromOffset(x - 2, 9),
        Size = UDim2.fromOffset(9, 11),
        BackgroundColor3 = COLORS.Purple,
        BackgroundTransparency = 0.2,
        BorderSizePixel = 0,
        ZIndex = 3
    }, mask)

    round(eyeGlow, 6)

    local eye = create("Frame", {
        Position = UDim2.fromOffset(x, 11),
        Size = UDim2.fromOffset(5, 7),
        BackgroundColor3 = Color3.fromRGB(35, 12, 65),
        BorderSizePixel = 0,
        ZIndex = 4
    }, mask)

    round(eye, 4)
end

-- Boca pequena e misteriosa
local mouth = create("Frame", {
    Name = "MaskMouth",
    AnchorPoint = Vector2.new(0.5, 0),
    Position = UDim2.new(0.5, 0, 0, 22),
    Size = UDim2.fromOffset(6, 3),
    BackgroundColor3 = COLORS.Purple,
    BorderSizePixel = 0,
    ZIndex = 4
}, mask)

round(mouth, 3)



-- JANELA
local window = create("Frame", {
    Name = "MainWindow",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(320, 300),
    BackgroundColor3 = COLORS.Background,
    BorderSizePixel = 0,
    Visible = true,
    ClipsDescendants = true
}, gui)

round(window, 14)
outline(window, COLORS.Purple, 1.5)


-- CABEÇALHO PHANTOM V2 | VISUAL REFINADO

local header = create("Frame", {
    Name = "Header",
    Size = UDim2.new(1, 0, 0, 43),
    BackgroundColor3 = Color3.fromRGB(24, 21, 36),
    BorderSizePixel = 0
}, window)

-- Linha neon inferior
local headerLine = create("Frame", {
    Name = "HeaderLine",
    Position = UDim2.new(0, 12, 1, -1),
    Size = UDim2.new(1, -24, 0, 1),
    BackgroundColor3 = COLORS.Purple,
    BackgroundTransparency = 0.2,
    BorderSizePixel = 0
}, header)

-- Nome do projeto
local titleLabel = makeLabel(
    header,
    "◈  PHANTOM",
    UDim2.fromOffset(13, 0),
    UDim2.new(1, -90, 1, 0),
    COLORS.White,
    16
)

titleLabel.Font = Enum.Font.GothamBold

-- Pequeno subtítulo
local subtitle = makeLabel(
    header,
    "V2  •  INTERFACE",
    UDim2.fromOffset(108, 4),
    UDim2.new(1, -155, 0, 34),
    Color3.fromRGB(177, 151, 220),
    8
)

subtitle.TextXAlignment = Enum.TextXAlignment.Left

-- Botão fechar
local closeButton = create("TextButton", {
    Name = "CloseButton",
    Position = UDim2.new(1, -37, 0, 7),
    Size = UDim2.fromOffset(28, 28),
    BackgroundColor3 = Color3.fromRGB(48, 32, 61),
    Text = "×",
    TextColor3 = Color3.fromRGB(225, 204, 255),
    TextSize = 20,
    Font = Enum.Font.GothamBold,
    AutoButtonColor = true
}, header)

round(closeButton, 8)
outline(closeButton, COLORS.Purple, 1)

-- BARRA LATERAL
local sidebar = create("Frame", {
    Name = "Sidebar",
    Position = UDim2.fromOffset(0, 43),
    Size = UDim2.new(0, 92, 1, -43),
    BackgroundColor3 = COLORS.Panel,
    BorderSizePixel = 0
}, window)

-- ÁREA EXCLUSIVA DAS PÁGINAS
local pageHost = create("Frame", {
    Name = "PageHost",
    Position = UDim2.fromOffset(102, 53),
    Size = UDim2.new(1, -112, 1, -63),
    BackgroundTransparency = 1,
    ClipsDescendants = true
}, window)

-- PÁGINAS: criadas uma única vez
local pages = {}
local tabButtons = {}
local currentPage = nil

local function createPage(name)
    local page = create("Frame", {
        Name = name,
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        Visible = false
    }, pageHost)

    pages[name] = page
    return page
end

-- BOTÕES DE NAVEGAÇÃO
local function createTab(name, text, yPosition)
    local button = create("TextButton", {
        Name = name .. "Tab",
        Position = UDim2.fromOffset(7, yPosition),
        Size = UDim2.new(1, -14, 0, 38),
        BackgroundColor3 = COLORS.Element,
        Text = text,
        TextColor3 = COLORS.Gray,
        TextSize = 12,
        Font = Enum.Font.GothamMedium,
        AutoButtonColor = true
    }, sidebar)

    round(button, 8)
    tabButtons[name] = button
    return button
end

createTab("Principal", "⌂  Principal", 13)
createTab("Ajustes", "⚙  Ajustes", 57)

-- PÁGINA PRINCIPAL
local home = createPage("Principal")

makeLabel(
    home,
    "PAINEL PRINCIPAL",
    UDim2.fromOffset(0, 3),
    UDim2.new(1, 0, 0, 24),
    COLORS.Purple,
    12
).Font = Enum.Font.GothamBold

local welcome = create("Frame", {
    Position = UDim2.fromOffset(0, 34),
    Size = UDim2.new(1, 0, 0, 67),
    BackgroundColor3 = COLORS.Panel,
    BorderSizePixel = 0
}, home)

round(welcome, 9)

makeLabel(
    welcome,
    "Bem-vindo ao PHANTOM",
    UDim2.fromOffset(10, 7),
    UDim2.new(1, -20, 0, 22),
    COLORS.White,
    12
).Font = Enum.Font.GothamBold

makeLabel(
    welcome,
    "Interface visual • V2",
    UDim2.fromOffset(10, 32),
    UDim2.new(1, -20, 0, 20),
    COLORS.Gray,
    10
)

local statusCard = create("Frame", {
    Position = UDim2.fromOffset(0, 111),
    Size = UDim2.new(1, 0, 0, 62),
    BackgroundColor3 = COLORS.Panel,
    BorderSizePixel = 0
}, home)

round(statusCard, 9)

makeLabel(
    statusCard,
    "STATUS",
    UDim2.fromOffset(10, 5),
    UDim2.new(1, -20, 0, 20),
    COLORS.Gray,
    10
)

local statusLabel = makeLabel(
    statusCard,
    "●  Interface ativa",
    UDim2.fromOffset(10, 27),
    UDim2.new(1, -20, 0, 23),
    COLORS.Green,
    12
)

makeLabel(
    home,
    "Selecione uma página na lateral.",
    UDim2.fromOffset(0, 185),
    UDim2.new(1, 0, 0, 35),
    COLORS.Gray,
    10
)

-- PÁGINA AJUSTES
local settings = createPage("Ajustes")

makeLabel(
    settings,
    "AJUSTES",
    UDim2.fromOffset(0, 3),
    UDim2.new(1, 0, 0, 24),
    COLORS.Purple,
    12
).Font = Enum.Font.GothamBold

local infoCard = create("Frame", {
    Position = UDim2.fromOffset(0, 34),
    Size = UDim2.new(1, 0, 0, 91),
    BackgroundColor3 = COLORS.Panel,
    BorderSizePixel = 0
}, settings)

round(infoCard, 9)

makeLabel(
    infoCard,
    "Versão",
    UDim2.fromOffset(10, 8),
    UDim2.new(1, -20, 0, 20),
    COLORS.Gray,
    11
)

makeLabel(
    infoCard,
    "PHANTOM 0.2.0",
    UDim2.fromOffset(10, 30),
    UDim2.new(1, -20, 0, 23),
    COLORS.White,
    13
).Font = Enum.Font.GothamBold

makeLabel(
    infoCard,
    "Interface em desenvolvimento",
    UDim2.fromOffset(10, 58),
    UDim2.new(1, -20, 0, 20),
    COLORS.Gray,
    10
)

-- TROCA DE PÁGINA
-- As páginas não são recriadas a cada clique.
-- Somente a página escolhida fica visível.
local function showPage(name)
    if not pages[name] then
        return
    end

    currentPage = name

    for pageName, page in pairs(pages) do
        page.Visible = (pageName == name)
    end

    for tabName, button in pairs(tabButtons) do
        local selected = (tabName == name)

        button.BackgroundColor3 = selected
            and COLORS.Purple
            or COLORS.Element

        button.TextColor3 = selected
            and COLORS.White
            or COLORS.Gray
    end
end

tabButtons.Principal.Activated:Connect(function()
    showPage("Principal")
end)

tabButtons.Ajustes.Activated:Connect(function()
    showPage("Ajustes")
end)

-- ARRASTAR O BOTÃO DA MÁSCARA NO CELULAR
local buttonDragging = false
local buttonDragStart
local buttonStartPosition
local buttonDragInput
local buttonMoved = false

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

        if delta.Magnitude > 5 then
            buttonMoved = true
        end

        openButton.Position = UDim2.new(
            buttonStartPosition.X.Scale,
            buttonStartPosition.X.Offset + delta.X,
            buttonStartPosition.Y.Scale,
            buttonStartPosition.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input == buttonDragInput
        or input.UserInputType == Enum.UserInputType.MouseButton1 then

        buttonDragging = false
        buttonDragInput = nil
    end
end)

openButton.Activated:Connect(function()
    if buttonMoved then
        buttonMoved = false
        return
    end

    setMenuOpen(true)
end)

-- ABRIR E FECHAR
local function setMenuOpen(isOpen)
    window.Visible = isOpen
    openButton.Visible = not isOpen
end

closeButton.Activated:Connect(function()
    setMenuOpen(false)
end)

-- ARRASTAR PELO CABEÇALHO (TOQUE OU MOUSE)
local dragging = false
local dragStart
local startPosition
local dragInput

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        dragging = true
        dragStart = input.Position
        startPosition = window.Position
        dragInput = input

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
                dragInput = nil
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if not dragging then
        return
    end

    local isMouseMove =
        input.UserInputType == Enum.UserInputType.MouseMovement

    local isTouchMove =
        input.UserInputType == Enum.UserInputType.Touch
        and dragInput ~= nil

    if isMouseMove or isTouchMove then
        local delta = input.Position - dragStart

        window.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

-- INICIALIZAÇÃO
showPage("Principal")
setMenuOpen(true)

print("[PHANTOM] Menu V2 carregado.")
