
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

print("Phantom Menu carregado!")
