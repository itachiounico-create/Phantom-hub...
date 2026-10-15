

--[[
    PHANTOM UI
    Versao 0.1.0
    Interface visual
]]

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Configuracao
local PURPLE = Color3.fromRGB(155, 85, 255)
local BG = Color3.fromRGB(17, 15, 24)
local PANEL = Color3.fromRGB(27, 24, 37)
local WHITE = Color3.fromRGB(245, 242, 255)
local MUTED = Color3.fromRGB(165, 158, 180)

-- Evita duplicar a interface
local old = playerGui:FindFirstChild("PhantomUI")
if old then
    old:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "PhantomUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = false
gui.DisplayOrder = 20
gui.Parent = playerGui

local function create(class, props, parent)
    local obj = Instance.new(class)
    for key, value in pairs(props) do
        obj[key] = value
    end
    obj.Parent = parent
    return obj
end

local function round(parent, radius)
    create("UICorner", {
        CornerRadius = UDim.new(0, radius)
    }, parent)
end

local function outline(parent, color, thickness)
    create("UIStroke", {
        Color = color,
        Thickness = thickness or 1,
        Transparency = 0.15
    }, parent)
end

-- Janela principal
local window = create("Frame", {
    Name = "Window",
    Size = UDim2.fromOffset(320, 300),
    Position = UDim2.new(0.5, -160, 0.5, -150),
    BackgroundColor3 = BG,
    BorderSizePixel = 0,
    Visible = false
}, gui)
round(window, 14)
outline(window, PURPLE, 1.5)

-- Cabecalho
local header = create("Frame", {
    Name = "Header",
    Size = UDim2.new(1, 0, 0, 52),
    BackgroundColor3 = PANEL,
    BorderSizePixel = 0
}, window)
round(header, 14)

create("Frame", {
    Size = UDim2.new(1, 0, 0, 14),
    Position = UDim2.new(0, 0, 1, -14),
    BackgroundColor3 = PANEL,
    BorderSizePixel = 0
}, header)

create("TextLabel", {
    Position = UDim2.fromOffset(15, 5),
    Size = UDim2.new(1, -65, 0, 25),
    BackgroundTransparency = 1,
    Text = "PHANTOM",
    TextColor3 = WHITE,
    Font = Enum.Font.GothamBold,
    TextSize = 19,
    TextXAlignment = Enum.TextXAlignment.Left
}, header)

create("TextLabel", {
    Position = UDim2.fromOffset(16, 29),
    Size = UDim2.new(1, -70, 0, 15),
    BackgroundTransparency = 1,
    Text = "INTERFACE  /  V0.1.0",
    TextColor3 = MUTED,
    Font = Enum.Font.Code,
    TextSize = 9,
    TextXAlignment = Enum.TextXAlignment.Left
}, header)

local close = create("TextButton", {
    Size = UDim2.fromOffset(30, 30),
    Position = UDim2.new(1, -40, 0, 10),
    BackgroundColor3 = Color3.fromRGB(53, 35, 68),
    Text = "X",
    TextColor3 = WHITE,
    Font = Enum.Font.GothamBold,
    TextSize = 14,
    BorderSizePixel = 0
}, header)
round(close, 8)

-- Barra lateral
local sidebar = create("Frame", {
    Position = UDim2.fromOffset(10, 63),
    Size = UDim2.new(0, 92, 1, -73),
    BackgroundColor3 = PANEL,
    BorderSizePixel = 0
}, window)
round(sidebar, 10)

-- Area de conteudo
local content = create("Frame", {
    Position = UDim2.fromOffset(112, 63),
    Size = UDim2.new(1, -122, 1, -73),
    BackgroundTransparency = 1,
    BorderSizePixel = 0
}, window)

local function label(parent, text, position, size, fontSize, color)
    return create("TextLabel", {
        Position = position,
        Size = size,
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = color or WHITE,
        Font = Enum.Font.Gotham,
        TextSize = fontSize or 12,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center
    }, parent)
end

label(content, "PRINCIPAL", UDim2.fromOffset(2, 3),
    UDim2.new(1, -4, 0, 25), 15, PURPLE)

label(content, "Bem-vindo ao Phantom.",
    UDim2.fromOffset(2, 32),
    UDim2.new(1, -4, 0, 34), 11, MUTED)

local status = create("Frame", {
    Position = UDim2.fromOffset(2, 76),
    Size = UDim2.new(1, -4, 0, 55),
    BackgroundColor3 = PANEL,
    BorderSizePixel = 0
}, content)
round(status, 9)

label(status, "STATUS", UDim2.fromOffset(10, 5),
    UDim2.new(1, -20, 0, 18), 10, MUTED)

label(status, "Interface carregada",
    UDim2.fromOffset(10, 24),
    UDim2.new(1, -20, 0, 22), 11, WHITE)

local pages = {}

local function clearContent()
    for _, child in ipairs(content:GetChildren()) do
        if child.Name == "PageContent" then
            child:Destroy()
        end
    end
end

local function showPage(pageName)
    clearContent()

    local page = create("Frame", {
        Name = "PageContent",
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1
    }, content)

    label(page, pageName:upper(),
        UDim2.fromOffset(2, 3),
        UDim2.new(1, -4, 0, 25), 15, PURPLE)

    if pageName == "Principal" then
        label(page, "Bem-vindo ao Phantom.",
            UDim2.fromOffset(2, 32),
            UDim2.new(1, -4, 0, 40), 11, MUTED)

        label(page, "Menu visual pronto para personalizacao.",
            UDim2.fromOffset(2, 77),
            UDim2.new(1, -4, 0, 50), 11, WHITE)
    else
        label(page, "Tema: Roxo",
            UDim2.fromOffset(2, 38),
            UDim2.new(1, -4, 0, 25), 12, WHITE)

        label(page, "Versao: 0.1.0",
            UDim2.fromOffset(2, 68),
            UDim2.new(1, -4, 0, 25), 12, MUTED)
    end
end

local function makeTab(text, y, pageName)
    local button = create("TextButton", {
        Position = UDim2.fromOffset(6, y),
        Size = UDim2.new(1, -12, 0, 36),
        BackgroundColor3 = BG,
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = MUTED,
        Font = Enum.Font.GothamMedium,
        TextSize = 11,
        BorderSizePixel = 0
    }, sidebar)
    round(button, 7)

    button.Activated:Connect(function()
        for _, item in ipairs(sidebar:GetChildren()) do
            if item:IsA("TextButton") then
                item.BackgroundTransparency = 1
                item.TextColor3 = MUTED
            end
        end

        button.BackgroundTransparency = 0
        button.BackgroundColor3 = Color3.fromRGB(52, 34, 72)
        button.TextColor3 = WHITE
        showPage(pageName)
    end)

    return button
end

local homeTab = makeTab("Principal", 9, "Principal")
makeTab("Ajustes", 51, "Ajustes")

-- Botao flutuante para abrir
local openButton = create("TextButton", {
    Name = "OpenButton",
    Size = UDim2.fromOffset(52, 52),
    Position = UDim2.new(0, 18, 0.5, -26),
    BackgroundColor3 = PANEL,
    Text = "P",
    TextColor3 = WHITE,
    Font = Enum.Font.GothamBold,
    TextSize = 24,
    BorderSizePixel = 0,
    Visible = true
}, gui)
round(openButton, 16)
outline(openButton, PURPLE, 2)

-- Abrir e fechar
local function setOpen(value)
    window.Visible = value
    openButton.Visible = not value
end

openButton.Activated:Connect(function()
    setOpen(true)
end)

close.Activated:Connect(function()
    setOpen(false)
end)

-- Arrastar janela pelo cabecalho
local dragging = false
local dragInput
local dragStart
local startPosition

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPosition = window.Position
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then
        local delta = input.Position - dragStart
        window.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input == dragInput then
        dragging = false
        dragInput = nil
    end
end)

-- Pagina inicial
showPage("Principal")

-- Marca a aba selecionada
homeTab.BackgroundTransparency = 0
homeTab.BackgroundColor3 = Color3.fromRGB(52, 34, 72)
homeTab.TextColor3 = WHITE

print("[PHANTOM] Interface criada.")
