local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Parâmetros de Configuração
local CONFIG = {
    MenuSize = UDim2.new(0, 400, 0, 500),
    MenuPosition = UDim2.new(0.5, 0, 0.5, 0),
    MenuColor = Color3.fromRGB(23, 23, 23),
    MenuShadowTransparency = 0.7,
    MenuBodyTransparency = 0.7,

    TopBarSize = UDim2.new(1, 0, 0, 50),
    TopBarColor = Color3.fromRGB(33, 33, 33),
    TopBarBorderSize = 0,
    TopBarBorderBottomSize = 1,
    TopBarBorderColor = Color3.fromRGB(40, 40, 40),

    TitleText = "VoidCodex",
    TitleTextColor = Color3.fromRGB(255, 255, 255),
    TitleTextSize = 18,
    TitleFont = Enum.Font.Roboto,

    CloseButtonSize = UDim2.new(0, 30, 0, 30),
    CloseButtonImage = "rbxassetid://7072725342",
    CloseButtonColor = Color3.fromRGB(255, 255, 255),

    MinimizeButtonSize = UDim2.new(0, 30, 0, 30),
    MinimizeButtonImage = "rbxassetid://7072719338",
    MinimizeButtonColor = Color3.fromRGB(255, 255, 255),

    HotkeyToggle = Enum.KeyCode.V
}

local function createWindow()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local MenuFrame = Instance.new("Frame")
    MenuFrame.Size = CONFIG.MenuSize
    MenuFrame.Position = CONFIG.MenuPosition
    MenuFrame.BackgroundColor3 = CONFIG.MenuColor
    MenuFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MenuFrame.Parent = ScreenGui
    MenuFrame.Visible = true

    -- Sombra do Menu
    local Shadow = Instance.new("ImageLabel")
    Shadow.Size = UDim2.new(1, 20, 1, 20)
    Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    Shadow.Image = "rbxassetid://1316045217"
    Shadow.ImageTransparency = CONFIG.MenuShadowTransparency
    Shadow.BackgroundTransparency = 1
    Shadow.ZIndex = 0
    Shadow.Parent = MenuFrame

    -- Criar TopBar
    local TopBar = Instance.new("Frame")
    TopBar.Size = CONFIG.TopBarSize
    TopBar.BackgroundColor3 = CONFIG.TopBarColor
    TopBar.BorderSizePixel = CONFIG.TopBarBorderSize
    TopBar.Parent = MenuFrame

    -- Borda Inferior
    local BottomBorder = Instance.new("Frame")
    BottomBorder.Size = UDim2.new(1, 0, 0, CONFIG.TopBarBorderBottomSize)
    BottomBorder.Position = UDim2.new(0, 0, 1, 0) -- Na parte inferior da barra
    BottomBorder.BackgroundColor3 = CONFIG.TopBarBorderColor
    BottomBorder.BorderSizePixel = 0
    BottomBorder.Parent = TopBar

    -- Título
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -100, 1, 0)
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.Text = CONFIG.TitleText
    Title.TextColor3 = CONFIG.TitleTextColor
    Title.TextSize = CONFIG.TitleTextSize
    Title.Font = CONFIG.TitleFont
    Title.BackgroundTransparency = 1
    Title.Parent = TopBar

    -- Botão Fechar
    local CloseButton = Instance.new("ImageButton")
    CloseButton.Size = CONFIG.CloseButtonSize
    CloseButton.Position = UDim2.new(1, -40, 0.5, -CONFIG.CloseButtonSize.Y.Offset / 2)
    CloseButton.Image = CONFIG.CloseButtonImage
    CloseButton.BackgroundTransparency = 1
    CloseButton.Parent = TopBar

    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()  -- Fecha o menu
    end)

    -- Efeito do botão fechar
    CloseButton.MouseEnter:Connect(function()
        local tween = TweenService:Create(CloseButton, TweenInfo.new(0.5, Enum.EasingStyle.Bounce), {Rotation = 360})
        tween:Play()
    end)

    CloseButton.MouseLeave:Connect(function()
        CloseButton.Rotation = 0
    end)

    -- Botão Minimizar
    local MinimizeButton = Instance.new("ImageButton")
    MinimizeButton.Size = CONFIG.MinimizeButtonSize
    MinimizeButton.Position = UDim2.new(1, -80, 0.5, -CONFIG.MinimizeButtonSize.Y.Offset / 2)
    MinimizeButton.Image = CONFIG.MinimizeButtonImage
    MinimizeButton.BackgroundTransparency = 1
    MinimizeButton.Parent = TopBar

    MinimizeButton.MouseButton1Click:Connect(function()
        MenuFrame.Visible = false  -- Oculta o menu
    end)

    -- Efeito do botão minimizar
    MinimizeButton.MouseEnter:Connect(function()
        local tween = TweenService:Create(MinimizeButton, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {Position = UDim2.new(1, -80, 0.5, -15)})
        tween:Play()
    end)

    MinimizeButton.MouseLeave:Connect(function()
        local tween = TweenService:Create(MinimizeButton, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {Position = UDim2.new(1, -80, 0.5, -CONFIG.MinimizeButtonSize.Y.Offset / 2)})
        tween:Play()
    end)

    -- Criação da barra lateral
    local Sidebar = Instance.new("Frame")
    Sidebar.Size = UDim2.new(0, 150, 1, -50)
    Sidebar.Position = UDim2.new(0, 0, 0, 50) -- Abaixo da barra superior
    Sidebar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Sidebar.Parent = MenuFrame

    return MenuFrame, Sidebar
end

local function createTab(sidebar, title)
    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(1, 0, 0, 30)
    TabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    TabButton.Text = title
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.Parent = sidebar

    return TabButton
end

local function makeDraggable(frame)
    local dragging = false
    local dragInput, mousePos, framePos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            mousePos = input.Position
            framePos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            frame.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
        end
    end)
end

local function init()
    local MenuFrame, Sidebar = createWindow()
    makeDraggable(MenuFrame)
    return MenuFrame, Sidebar
end

return {
    init = init,
    createTab = createTab,
}
