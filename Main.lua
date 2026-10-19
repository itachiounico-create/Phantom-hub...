
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local Modules = script.Parent.Modules
local Pages = script.Parent.Pages

local PhantomUI = require(Modules.PhantomUI)
local Home = require(Pages.Home)
local Settings = require(Pages.Settings)

local ui = PhantomUI.Create(playerGui)

local homePage = Home.Create(ui)
local settingsPage = Settings.Create(ui)

settingsPage.Visible = false

local function createTab(name, order, callback)
    local button = ui.Components.Button(
        ui.Sidebar,
        name,
        ui.Config
    )

    button.LayoutOrder = order
    button.Size = UDim2.new(1, 0, 0, 40)
    button.Activated:Connect(callback)

    return button
end

createTab("⌂  Início", 1, function()
    homePage.Visible = true
    settingsPage.Visible = false
end)

createTab("⚙  Configurações", 2, function()
    homePage.Visible = false
    settingsPage.Visible = true
end)

-- Controle de abrir e fechar o menu
local main = ui.Main
local isOpen = true

local function setMenuOpen(open)
    isOpen = open
    main.Visible = open
end

-- Deixa o menu visível inicialmente
setMenuOpen(true)

-- Permite que outros scripts controlem o menu
local menuController = Instance.new("BindableFunction")
menuController.Name = "PhantomMenuController"
menuController.Parent = ui.ScreenGui

menuController.OnInvoke = function(action)
    if action == "Toggle" then
        setMenuOpen(not isOpen)
    elseif action == "Open" then
        setMenuOpen(true)
    elseif action == "Close" then
        setMenuOpen(false)
    end

    return isOpen
end

print("Phantom Menu carregado!")
--==================================================
-- PHANTOM MENU - BOTÃO ORBITAL V1
--==================================================

local TweenService = game:GetService("TweenService")

local screenGui = ui.ScreenGui
local main = ui.Main

-- Botão independente do painel principal
local openButton = Instance.new("ImageButton")
openButton.Name = "PhantomOrbitalButton"
openButton.Size = UDim2.fromOffset(48, 48)
openButton.Position = UDim2.new(0, 18, 0.5, -24)
openButton.BackgroundColor3 = Color3.fromRGB(5, 4, 10)
openButton.Image = ""
openButton.AutoButtonColor = false
openButton.Visible = true
openButton.ZIndex = 20
openButton.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(1, 0)
corner.Parent = openButton

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(155, 70, 255)
stroke.Thickness = 1.5
stroke.Parent = openButton

-- Halo roxo
local halo = Instance.new("Frame")
halo.Name = "PurpleHalo"
halo.AnchorPoint = Vector2.new(0.5, 0.5)
halo.Position = UDim2.fromScale(0.5, 0.5)
halo.Size = UDim2.fromOffset(42, 42)
halo.BackgroundColor3 = Color3.fromRGB(130, 35, 255)
halo.BackgroundTransparency = 0.65
halo.BorderSizePixel = 0
halo.ZIndex = 20
halo.Parent = openButton

local haloCorner = Instance.new("UICorner")
haloCorner.CornerRadius = UDim.new(1, 0)
haloCorner.Parent = halo

-- Núcleo do buraco negro
local core = Instance.new("Frame")
core.Name = "BlackHoleCore"
core.AnchorPoint = Vector2.new(0.5, 0.5)
core.Position = UDim2.fromScale(0.5, 0.5)
core.Size = UDim2.fromOffset(24, 24)
core.BackgroundColor3 = Color3.fromRGB(3, 2, 8)
core.BorderSizePixel = 0
core.ZIndex = 22
core.Parent = openButton

local coreCorner = Instance.new("UICorner")
coreCorner.CornerRadius = UDim.new(1, 0)
coreCorner.Parent = core

local coreStroke = Instance.new("UIStroke")
coreStroke.Color = Color3.fromRGB(115, 53, 220)
coreStroke.Thickness = 1.2
coreStroke.Parent = core

-- Órbita externa
local orbit = Instance.new("Frame")
orbit.Name = "OrbitalRing"
orbit.AnchorPoint = Vector2.new(0.5, 0.5)
orbit.Position = UDim2.fromScale(0.5, 0.5)
orbit.Size = UDim2.fromOffset(43, 17)
orbit.BackgroundTransparency = 1
orbit.BorderSizePixel = 0
orbit.Rotation = -25
orbit.ZIndex = 23
orbit.Parent = openButton

local orbitCorner = Instance.new("UICorner")
orbitCorner.CornerRadius = UDim.new(1, 0)
orbitCorner.Parent = orbit

local orbitStroke = Instance.new("UIStroke")
orbitStroke.Color = Color3.fromRGB(190, 120, 255)
orbitStroke.Thickness = 1.5
orbitStroke.Parent = orbit

-- Órbita interna
local orbit2 = Instance.new("Frame")
orbit2.Name = "SecondaryOrbit"
orbit2.AnchorPoint = Vector2.new(0.5, 0.5)
orbit2.Position = UDim2.fromScale(0.5, 0.5)
orbit2.Size = UDim2.fromOffset(36, 13)
orbit2.BackgroundTransparency = 1
orbit2.BorderSizePixel = 0
orbit2.Rotation = 55
orbit2.ZIndex = 21
orbit2.Parent = openButton

local orbit2Corner = Instance.new("UICorner")
orbit2Corner.CornerRadius = UDim.new(1, 0)
orbit2Corner.Parent = orbit2

local orbit2Stroke = Instance.new("UIStroke")
orbit2Stroke.Color = Color3.fromRGB(125, 45, 230)
orbit2Stroke.Thickness = 1.2
orbit2Stroke.Parent = orbit2

-- Ponto de energia
local energy = Instance.new("Frame")
energy.Name = "EnergyPoint"
energy.AnchorPoint = Vector2.new(0.5, 0.5)
energy.Position = UDim2.fromScale(0.5, 0.5)
energy.Size = UDim2.fromOffset(4, 4)
energy.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
energy.BorderSizePixel = 0
energy.ZIndex = 24
energy.Parent = openButton

local energyCorner = Instance.new("UICorner")
energyCorner.CornerRadius = UDim.new(1, 0)
energyCorner.Parent = energy

-- Animações
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

TweenService:Create(
    halo,
    TweenInfo.new(1.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
    {
        BackgroundTransparency = 0.45,
        Size = UDim2.fromOffset(46, 46)
    }
):Play()

-- Abrir e fechar o menu
openButton.Activated:Connect(function()
    main.Visible = not main.Visible
end)

-- O menu começa aberto
main.Visible = true
