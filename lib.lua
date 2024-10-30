local UIlib = {}

-- Função principal para criar a Janela
function UIlib:Janela()
    -- Criar tela principal
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    -- Janela Principal
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 400, 0, 500)
    MainFrame.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
    MainFrame.BorderSizePixel = 0
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.Parent = ScreenGui

    -- Sombras
    local Shadow = Instance.new("Frame")
    Shadow.Size = UDim2.new(1, 8, 1, 8)
    Shadow.BackgroundColor3 = Color3.fromRGB(13, 13, 13)
    Shadow.BorderSizePixel = 0
    Shadow.Position = UDim2.new(0, -4, 0, -4)
    Shadow.Parent = MainFrame

    -- Topbar
    local Topbar = Instance.new("Frame")
    Topbar.Size = UDim2.new(1, 0, 0, 30)
    Topbar.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
    Topbar.BorderSizePixel = 0
    Topbar.Parent = MainFrame

    -- Título
    local Title = Instance.new("TextLabel")
    Title.Text = "VoidCodex"
    Title.Font = Enum.Font.Roboto
    Title.TextSize = 18
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(0, 100, 1, 0)
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.Parent = Topbar

    -- Botão de Fechar
    local CloseButton = Instance.new("ImageButton")
    CloseButton.Image = "rbxassetid://7072725342"
    CloseButton.Size = UDim2.new(0, 20, 0, 20)
    CloseButton.Position = UDim2.new(1, -30, 0, 5)
    CloseButton.BackgroundTransparency = 1
    CloseButton.Parent = Topbar
    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    -- Botão de Minimizar
    local MinimizeButton = Instance.new("ImageButton")
    MinimizeButton.Image = "rbxassetid://7072719338"
    MinimizeButton.Size = UDim2.new(0, 20, 0, 20)
    MinimizeButton.Position = UDim2.new(1, -60, 0, 5)
    MinimizeButton.BackgroundTransparency = 1
    MinimizeButton.Parent = Topbar

    -- Alternar minimização
    MinimizeButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)

    -- Reexibir janela ao pressionar "V"
    game:GetService("UserInputService").InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.V then
            MainFrame.Visible = not MainFrame.Visible
        end
    end)

    -- Função para arrastar a janela
    local dragging, dragInput, startPos, startInputPos
    Topbar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            startPos = MainFrame.Position
            startInputPos = input.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    Topbar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - startInputPos
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    -- Menu de Tabs na lateral
    local Menu = Instance.new("Frame")
    Menu.Size = UDim2.new(0, 100, 1, -30)
    Menu.Position = UDim2.new(0, 0, 0, 30)
    Menu.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
    Menu.BorderSizePixel = 0
    Menu.Parent = MainFrame

    -- Espaço para Widgets
    local Body = Instance.new("Frame")
    Body.Size = UDim2.new(1, -100, 1, -30)
    Body.Position = UDim2.new(0, 100, 0, 30)
    Body.BackgroundTransparency = 1
    Body.Parent = MainFrame

        -- Texto padrão no Body
    local DefaultText = Instance.new("TextLabel")
    DefaultText.Text = "Acesse nosso servidor Discord"
    DefaultText.Font = Enum.Font.Roboto
    DefaultText.TextSize = 16
    DefaultText.TextColor3 = Color3.new(1, 1, 1)
    DefaultText.BackgroundTransparency = 1
    DefaultText.Size = UDim2.new(0, 200, 0, 50)  -- Define o tamanho do texto
    DefaultText.AnchorPoint = Vector2.new(0.5, 0.5)  -- Centraliza o ponto de ancoragem
    DefaultText.Position = UDim2.new(0.5, 0, 0.4, 0)  -- Posiciona no centro superior do Body
    DefaultText.Parent = Body

    -- Botão de convite do Discord centralizado abaixo do texto
    local DiscordButton = Instance.new("TextButton")
    DiscordButton.Text = "Entrar no Discord"
    DiscordButton.Font = Enum.Font.Roboto
    DiscordButton.TextSize = 14
    DiscordButton.TextColor3 = Color3.new(1, 1, 1)
    DiscordButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    DiscordButton.Size = UDim2.new(0, 150, 0, 40)  -- Define o tamanho do botão
    DiscordButton.AnchorPoint = Vector2.new(0.5, 0.5)  -- Centraliza o ponto de ancoragem
    DiscordButton.Position = UDim2.new(0.5, 0, 0.6, 0)  -- Posiciona abaixo do texto no centro do Body
    DiscordButton.Parent = Body

    DiscordButton.MouseButton1Click:Connect(function()
        -- Abre o link do Discord
        local url = "https://discord.gg/n3kE8gMkjx"
        game:GetService("GuiService"):OpenBrowserWindow(url)
    end)

    -- Função para criar Tabs
    function UIlib:Menu(nome)
        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(1, 0, 0, 40)
        TabButton.Text = nome
        TabButton.Font = Enum.Font.Roboto
        TabButton.TextSize = 14
        TabButton.BackgroundTransparency = 0.1
        TabButton.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
        TabButton.TextColor3 = Color3.new(1, 1, 1)
        TabButton.Position = UDim2.new(0, 0, 0, #Menu:GetChildren() * 40) -- Adicionada para ajustar a posição de cada TabButton
        TabButton.Parent = Menu

        local TabContent = Instance.new("Frame")
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.BackgroundTransparency = 1
        TabContent.Visible = false
        TabContent.Parent = Body
        
        TabButton.MouseButton1Click:Connect(function()
            for _, child in ipairs(Body:GetChildren()) do
                child.Visible = false
            end
            TabContent.Visible = true
        end)

        -- Função para adicionar Botão na Tab
        function UIlib:Botao(config)
            local Button = Instance.new("TextButton")
            Button.Size = UDim2.new(1, -10, 0, 40)  -- Ocupa toda a largura do espaço disponível
            Button.Position = UDim2.new(0, 5, 0, #TabContent:GetChildren() * 45)  -- Posicionamento vertical para evitar sobreposição
            Button.Text = config.Nome or "Botão"
            Button.Font = Enum.Font.Roboto
            Button.TextSize = 14
            Button.TextColor3 = Color3.new(1, 1, 1)
            Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Button.Parent = TabContent

            if config.Callback then
                Button.MouseButton1Click:Connect(config.Callback)
            end

            return Button
        end

        -- Função para adicionar um Label na Tab
        function UIlib:Label(config)
            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(1, -10, 0, 40)  -- Tamanho do Label
            Label.Position = UDim2.new(0, 5, 0, #TabContent:GetChildren() * 45)  -- Posição vertical
            Label.Text = config.Text or "Label"  -- Texto do Label
            Label.Font = Enum.Font.Roboto  -- Fonte do texto
            Label.TextSize = 14  -- Tamanho do texto
            Label.TextColor3 = Color3.new(0, 0, 0)  -- Cor do texto (preto)
            Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)  -- Fundo branco
            Label.BackgroundTransparency = 0  -- Definindo a transparência do fundo como 0 (opaco)
            Label.Parent = Body
        
            print("Label criado: " .. Label.Text)  -- Mensagem para verificar a criação do Label
        
            return Label
        end


        
        -- Função para adicionar Switch na Tab
        function UIlib:Switch(config)
            local Switch = Instance.new("TextButton")
            Switch.Size = UDim2.new(1, -10, 0, 40)  -- Ocupa toda a largura do espaço disponível
            Switch.Position = UDim2.new(0, 5, 0, #TabContent:GetChildren() * 45)  -- Posicionamento vertical para evitar sobreposição
            Switch.Text = config.Nome or "Switch"
            Switch.Font = Enum.Font.Roboto
            Switch.TextSize = 14
            Switch.TextColor3 = Color3.new(1, 1, 1)
            Switch.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Switch.Parent = TabContent

            local isActive = false
            Switch.MouseButton1Click:Connect(function()
                isActive = not isActive
                Switch.Text = isActive and (config.Nome .. " (Ativo)") or (config.Nome .. " (Inativo)")
                if config.Callback then
                    config.Callback(isActive)
                end
            end)

            return Switch
        end

        return UIlib
    end

    return UIlib
end

return UIlib
