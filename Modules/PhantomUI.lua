
local Config = require(script.Parent.Config)
local Components = require(script.Parent.Components)

local PhantomUI = {}

function PhantomUI.Create(playerGui)
    local gui = Instance.new("ScreenGui")
    gui.Name = "PhantomMenu"
    gui.ResetOnSpawn = false
    gui.DisplayOrder = 20
    gui.Parent = playerGui

    local main = Instance.new("Frame")
    main.Name = "Main"
    main.Size = UDim2.fromOffset(
        Config.Window.Width,
        Config.Window.Height
    )
    main.Position = UDim2.new(0.5, -360, 0.5, -220)
    main.BackgroundColor3 = Config.Theme.Background
    main.BorderSizePixel = 0
    main.ClipsDescendants = true
    main.Parent = gui

    Components.Round(main, Config.Window.CornerRadius)
    Components.Outline(
        main,
        Config.Theme.Purple,
        1.5
    )

    local header = Instance.new("Frame")
    header.Name = "Header"
    header.Size = UDim2.new(1, 0, 0, 68)
    header.BackgroundColor3 = Config.Theme.Panel
    header.BorderSizePixel = 0
    header.Parent = main

    Components.Label(
        header,
        "PHANTOM  /  MENU",
        23,
        Config.Theme.PurpleLight
    ).Position = UDim2.fromOffset(22, 10)

    local subtitle = Components.Label(
        header,
        "PLAY DIFFERENT",
        10,
        Config.Theme.TextSecondary
    )
    subtitle.Position = UDim2.fromOffset(24, 39)

    local sidebar = Instance.new("Frame")
    sidebar.Name = "Sidebar"
    sidebar.Position = UDim2.fromOffset(12, 78)
    sidebar.Size = UDim2.new(0, 170, 1, -90)
    sidebar.BackgroundColor3 = Config.Theme.Panel
    sidebar.BorderSizePixel = 0
    sidebar.Parent = main

    Components.Round(sidebar, 10)

    local sidebarLayout = Instance.new("UIListLayout")
    sidebarLayout.Padding = UDim.new(0, 8)
    sidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
    sidebarLayout.Parent = sidebar

    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, 12)
    padding.PaddingLeft = UDim.new(0, 10)
    padding.PaddingRight = UDim.new(0, 10)
    padding.Parent = sidebar

    local content = Instance.new("Frame")
    content.Name = "Content"
    content.Position = UDim2.fromOffset(194, 80)
    content.Size = UDim2.new(1, -208, 1, -94)
    content.BackgroundColor3 = Config.Theme.Panel
    content.BorderSizePixel = 0
    content.Parent = main

    Components.Round(content, 10)
    Components.Outline(content, Config.Theme.Border, 1)

    return {
        ScreenGui = gui,
        Main = main,
        Sidebar = sidebar,
        Content = content,
        Config = Config,
        Components = Components,
    }
end

return PhantomUI
