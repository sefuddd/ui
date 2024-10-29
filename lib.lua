local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Parâmetros de Configuração
local CONFIG = {
    MenuSize = UDim2.new(0, 400, 0, 500), -- largura, altura
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
    MinimizeButtonSize = UDim2.new(0, 30, 0, 30),
    MinimizeButtonImage = "rbxassetid://7072719338",
    HotkeyToggle = Enum.KeyCode.V,
}

-- Biblioteca UI
local UI = {}
UI.MenuFrame = nil

-- Função para criar a janela do menu
function UI.criar_janela()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    -- Janela Principal
    UI.MenuFrame = Instance.new("Frame")
    UI.MenuFrame.Size = CONFIG.MenuSize
    UI.MenuFrame.Position = CONFIG.MenuPosition
    UI.MenuFrame.BackgroundColor3 = CONFIG.MenuColor
    UI.MenuFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    UI.MenuFrame.Parent = ScreenGui
    UI.MenuFrame.Visible = true

    -- Sombra do Menu
    local Shadow = Instance.new("ImageLabel")
    Shadow.Size = UDim2.new(1, 20, 1, 20)
    Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    Shadow.Image = "rbxassetid://1316045217"
    Shadow.ImageTransparency = CONFIG.MenuShadowTransparency
    Shadow.BackgroundTransparency = 1
    Shadow.ZIndex = 0
    Shadow.Parent = UI.MenuFrame

    -- Criar TopBar
    local TopBar = Instance.new("Frame")
    TopBar.Size = CONFIG.TopBarSize
    TopBar.BackgroundColor3 = CONFIG.TopBarColor
    TopBar.BorderSizePixel = CONFIG.TopBarBorderSize
    TopBar.Parent = UI.MenuFrame

    -- Borda Inferior
    local BottomBorder = Instance.new("Frame")
    BottomBorder.Size = UDim2.new(1, 0, 0, CONFIG.TopBarBorderBottomSize)
    BottomBorder.Position = UDim2.new(0, 0, 1, 0)
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
        ScreenGui:Destroy()
    end)

    -- Botão Minimizar
    local MinimizeButton = Instance.new("ImageButton")
    MinimizeButton.Size = CONFIG.MinimizeButtonSize
    MinimizeButton.Position = UDim2.new(1, -80, 0.5, -CONFIG.MinimizeButtonSize.Y.Offset / 2)
    MinimizeButton.Image = CONFIG.MinimizeButtonImage
    MinimizeButton.BackgroundTransparency = 1
    MinimizeButton.Parent = TopBar

    MinimizeButton.MouseButton1Click:Connect(function()
        UI.MenuFrame.Visible = false
    end)

    -- Criar Corpo do Menu
    local BodyFrame = Instance.new("Frame")
    BodyFrame.Size = UDim2.new(1, 0, 1, -50)
    BodyFrame.Position = UDim2.new(0, 0, 0, 50)
    BodyFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    BodyFrame.BackgroundTransparency = CONFIG.MenuBodyTransparency
    BodyFrame.Parent = UI.MenuFrame

    -- Tornar arrastável
    UI.makeDraggable(UI.MenuFrame)

    -- Atalho para restaurar a janela
    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == CONFIG.HotkeyToggle then
            UI.MenuFrame.Visible = not UI.MenuFrame.Visible
        end
    end)
end

-- Função para criar um botão no corpo do menu
function UI.criar_botao(nome, callback)
    if not UI.MenuFrame then
        error("Você precisa criar a janela primeiro usando criar_janela().")
    end

    local BodyFrame = UI.MenuFrame:FindFirstChildOfClass("Frame")
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0.8, 0, 0, 50)
    Button.Position = UDim2.new(0.1, 0, #BodyFrame:GetChildren() * 0.1, 0) -- Adiciona espaçamento entre botões
    Button.Text = nome
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Button.Parent = BodyFrame

    Button.MouseButton1Click:Connect(callback)

    return Button
end

-- Função para tornar o menu arrastável
function UI.makeDraggable(frame)
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

return UI
