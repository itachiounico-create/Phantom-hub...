
local Settings = {}

function Settings.Create(ui)
    local content = ui.Content
    local config = ui.Config
    local components = ui.Components

    local title = components.Label(
        content,
        "CONFIGURAÇÕES",
        22,
        config.Theme.White
    )

    title.Position = UDim2.fromOffset(20, 18)
    title.Size = UDim2.new(1, -40, 0, 32)

    local themeLabel = components.Label(
        content,
        "Tema: Phantom Roxo",
        14,
        config.Theme.TextSecondary
    )

    themeLabel.Position = UDim2.fromOffset(20, 65)
    themeLabel.Size = UDim2.new(1, -40, 0, 28)

    local reset = components.Button(
        content,
        "Restaurar padrão",
        config
    )

    reset.Position = UDim2.fromOffset(20, 110)
    reset.Size = UDim2.fromOffset(180, 38)

    reset.Activated:Connect(function()
        themeLabel.Text = "Tema: Phantom Roxo"
    end)

    return content
end

return Settings
