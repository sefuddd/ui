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

    SidebarWidth = UDim2.new(0, 100, 1, 0), -- Largura da barra lateral
    SidebarColor = Color3.fromRGB(13, 13, 13),
    
    TabHeight = 40, -- Altura das abas
    TabTextColor = Color3.fromRGB(255, 255, 255),
    
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
UI.Tabs = {}
UI.CurrentTab = nil

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

    -- Criar Barra Lateral
    local Sidebar = Instance.new("Frame")
    Sidebar.Size = CONFIG.SidebarWidth
    Sidebar.Position = UDim2.new(0, 0, 0, 50)
    Sidebar.BackgroundColor3 = CONFIG.SidebarColor
    Sidebar.Parent = UI.MenuFrame

    -- Criar Corpo do Menu
    local BodyFrame = Instance.new("Frame")
    BodyFrame.Size = UDim2.new(1, -CONFIG.SidebarWidth.X.Offset, 1, -50)
    BodyFrame.Position = UDim2.new(0, CONFIG.SidebarWidth.X.Offset, 0, 50)
    BodyFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    BodyFrame.BackgroundTransparency = CONFIG.MenuBodyTransparency
    BodyFrame.Parent = UI.MenuFrame

    -- Criar aba padrão
    UI.CurrentTab = UI.criar_aba("Tab 1")
    UI.atualizar_conteudo(UI.CurrentTab)

    -- Tornar arrastável
    UI.makeDraggable(UI.MenuFrame)

    -- Atalho para restaurar a janela
    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == CONFIG.HotkeyToggle then
            UI.MenuFrame.Visible = not UI.MenuFrame.Visible
        end
    end)
end

-- Função para criar uma aba
function UI.criar_aba(nome)
    local Sidebar = UI.MenuFrame:FindFirstChildOfClass("Frame") -- Encontre a barra lateral
    local Tab = Instance.new("TextButton")
    Tab.Size = UDim2.new(1, 0, 0, CONFIG.TabHeight)
    Tab.Text = nome
    Tab.TextColor3 = CONFIG.TabTextColor
    Tab.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Tab.Parent = Sidebar

    Tab.MouseButton1Click:Connect(function()
        UI.atualizar_conteudo(Tab) -- Atualiza o conteúdo para a aba selecionada
    end)

    return Tab
end

-- Função para atualizar o conteúdo do corpo do menu com base na aba atual
function UI.atualizar_conteudo(tab)
    if UI.CurrentTab then
        UI.CurrentTab.BackgroundColor3 = Color3.fromRGB(40, 40, 40) -- Resetar a cor da aba anterior
    end

    UI.CurrentTab = tab
    UI.CurrentTab.BackgroundColor3 = Color3.fromRGB(60, 60, 60) -- Destaque a aba selecionada

    -- Limpar o corpo anterior
    for _, child in ipairs(UI.MenuFrame:GetChildren()) do
        if child:IsA("Frame") and child ~= UI.CurrentTab and child ~= UI.MenuFrame:FindFirstChildOfClass("Frame") then
            child:Destroy()
        end
    end

    -- Exibir o conteúdo da aba atual
    local BodyFrame = UI.MenuFrame:FindFirstChildOfClass("Frame")
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Size = UDim2.new(1, 0, 1, -50)
    ContentFrame.Position = UDim2.new(0, 0, 0, 50)
    ContentFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    ContentFrame.Parent = BodyFrame

    -- Adicionar um exemplo de botão na aba atual
    local ExampleButton = Instance.new("TextButton")
    ExampleButton.Size = UDim2.new(0.8, 0, 0, 50)
    ExampleButton.Position = UDim2.new(0.1, 0, 0, 10)
    ExampleButton.Text = "Botão Exemplo"
    ExampleButton.Parent = ContentFrame
end

-- Função para tornar a janela arrastável
function UI.makeDraggable(frame)
    local dragToggle = nil
    local dragSpeed = 0.1
    local dragInput
    local dragStart = nil
    local startPos = nil

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragToggle = true
            dragStart = input.Position
            startPos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragToggle = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragToggle then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- Inicializar a UI
UI.criar_janela()
