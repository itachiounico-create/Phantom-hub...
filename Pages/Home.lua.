
local Home = {}

function Home.Create(ui)
    local content = ui.Content
    local config = ui.Config
    local components = ui.Components

    local title = components.Label(
        content,
        "PHANTOM MENU",
        22,
        config.Theme.White
    )

    title.Position = UDim2.fromOffset(20, 18)
    title.Size = UDim2.new(1, -40, 0, 32)

    local description = components.Label(
        content,
        "Painel principal",
        13,
        config.Theme.TextSecondary
    )

    description.Position = UDim2.fromOffset(20, 52)
    description.Size = UDim2.new(1, -40, 0, 24)

    local card = Instance.new("Frame")
    card.Name = "WelcomeCard"
    card.Position = UDim2.fromOffset(20, 92)
    card.Size = UDim2.new(1, -40, 0, 130)
    card.BackgroundColor3 = config.Theme.Secondary
    card.BorderSizePixel = 0
    card.Parent = content

    components.Round(card, 10)
    components.Outline(card, config.Theme.Border, 1)

    local welcome = components.Label(
        card,
        "BEM-VINDO AO PHANTOM",
        18,
        config.Theme.PurpleLight
    )

    welcome.Position = UDim2.fromOffset(16, 18)
    welcome.Size = UDim2.new(1, -32, 0, 28)

    local detail = components.Label(
        card,
        "Sua interface. Seu estilo.",
        13,
        config.Theme.TextSecondary
    )

    detail.Position = UDim2.fromOffset(16, 54)
    detail.Size = UDim2.new(1, -32, 0, 24)

    return content
end

return Home
