
local Components = {}

function Components.Round(instance, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 8)
    corner.Parent = instance
    return corner
end

function Components.Outline(instance, color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color
    stroke.Thickness = thickness or 1
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = instance
    return stroke
end

function Components.Label(parent, text, size, color)
    local label = Instance.new("TextLabel")

    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = color
    label.TextSize = size or 14
    label.Font = Enum.Font.GothamMedium
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = parent

    return label
end

function Components.Button(parent, text, config)
    local button = Instance.new("TextButton")

    button.Text = text
    button.TextSize = 14
    button.Font = Enum.Font.GothamMedium
    button.TextColor3 = config.Theme.White
    button.BackgroundColor3 = config.Theme.Secondary
    button.AutoButtonColor = false

    Components.Round(button, 8)
    Components.Outline(
        button,
        config.Theme.Border,
        1
    )

    button.Parent = parent
    return button
end

return Components

