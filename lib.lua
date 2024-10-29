local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Parâmetros de Configuração
local CONFIG = {
    MenuSize = UDim2.new(0, 400, 0, 500), -- largura, altura
    MenuPosition = UDim2.new(0.5, 0, 0.5, 0),
    MenuColor = Color3.fromRGB(23, 23, 23),
    MenuShadowTransparency = 0.7,
    MenuBodyTransparency = 0.7, -- Ajuste para um maior nível de transparência

    TopBarSize = UDim2.new(1, 0, 0, 50),
    TopBarColor = Color3.fromRGB(33, 33, 33),
    TopBarBorderSize = 0, -- Sem borda superior
    TopBarBorderBottomSize = 1, -- Borda inferior mais fina
    TopBarBorderColor = Color3.fromRGB(40, 40, 40), -- Cor da borda inferior

    TitleText = "VoidCodex",
    TitleTextColor = Color3.fromRGB(255, 255, 255),
    TitleTextSize = 18,
    TitleFont = Enum.Font.Roboto, -- Adicionando a fonte Roboto

    CloseButtonSize = UDim2.new(0, 30, 0, 30),
    CloseButtonImage = "rbxassetid://7072725342", -- Imagem para o botão de fechar
    CloseButtonColor = Color3.fromRGB(255, 255, 255), -- Botão transparente

    MinimizeButtonSize = UDim2.new(0, 30, 0, 30),
    MinimizeButtonImage = "rbxassetid://7072719338", -- Imagem para o botão de minimizar
    MinimizeButtonColor = Color3.fromRGB(255, 255, 255), -- Botão transparente

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
    Title.Font = CONFIG.TitleFont -- Definindo a fonte Roboto
    Title.BackgroundTransparency = 1
    Title.Parent = TopBar

    -- Botão Fechar
    local CloseButton = Instance.new("ImageButton")
    CloseButton.Size = CONFIG.CloseButtonSize
    CloseButton.Position = UDim2.new(1, -40, 0.5, -CONFIG.CloseButtonSize.Y.Offset / 2)
    CloseButton.Image = CONFIG.CloseButtonImage
    CloseButton.BackgroundTransparency = 1 -- Fundo totalmente transparente
    CloseButton.Parent = TopBar

    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()  -- Fecha o menu
    end)

    -- Efeito do botão fechar (estrelinha)
    CloseButton.MouseEnter:Connect(function()
        local tween = TweenService:Create(CloseButton, TweenInfo.new(0.5, Enum.EasingStyle.Bounce), {Rotation = 360})
        tween:Play()
    end)

    CloseButton.MouseLeave:Connect(function()
        CloseButton.Rotation = 0 -- Reseta a rotação ao sair
    end)

    -- Botão Minimizar
    local MinimizeButton = Instance.new("ImageButton")
    MinimizeButton.Size = CONFIG.MinimizeButtonSize
    MinimizeButton.Position = UDim2.new(1, -80, 0.5, -CONFIG.MinimizeButtonSize.Y.Offset / 2)
    MinimizeButton.Image = CONFIG.MinimizeButtonImage
    MinimizeButton.BackgroundTransparency = 1 -- Fundo totalmente transparente
    MinimizeButton.Parent = TopBar

    MinimizeButton.MouseButton1Click:Connect(function()
        MenuFrame.Visible = false  -- Oculta o menu
    end)

    -- Efeito do botão minimizar (subida)
    MinimizeButton.MouseEnter:Connect(function()
        local tween = TweenService:Create(MinimizeButton, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {Position = UDim2.new(1, -80, 0.5, -15)})
        tween:Play()
    end)

    MinimizeButton.MouseLeave:Connect(function()
        local tween = TweenService:Create(MinimizeButton, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {Position = UDim2.new(1, -80, 0.5, -CONFIG.MinimizeButtonSize.Y.Offset / 2)})
        tween:Play()
    end)

    return MenuFrame
end

local function createTab(parent, title)
    local TabFrame = Instance.new("Frame")
    TabFrame.Size = UDim2.new(1, 0, 1, -50)
    TabFrame.Position = UDim2.new(0, 0, 0, 50)
    TabFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TabFrame.BackgroundTransparency = CONFIG.MenuBodyTransparency -- Ajustar transparência do corpo
    TabFrame.Parent = parent

    -- Título da aba
    local TabTitle = Instance.new("TextLabel")
    TabTitle.Size = UDim2.new(1, 0, 0, 30)
    TabTitle.Position = UDim2.new(0, 0, 0, 0)
    TabTitle.Text = title
    TabTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabTitle.BackgroundTransparency = 1
    TabTitle.Parent = TabFrame

    return TabFrame
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
    local MenuFrame = createWindow()
    makeDraggable(MenuFrame)
    return MenuFrame
end

return {
    init = init,
    createTab = createTab,
}
