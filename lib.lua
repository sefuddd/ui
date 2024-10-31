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
            Label.Parent = TabContent  -- Adicionando o Label ao TabContent
        
            -- Ajustar alinhamento do texto
            if config.Posicao == "centro" then
                Label.TextXAlignment = Enum.TextXAlignment.Center
            elseif config.Posicao == "direita" then
                Label.TextXAlignment = Enum.TextXAlignment.Right
            else
                Label.TextXAlignment = Enum.TextXAlignment.Left  -- Por padrão, ou se for "esquerda"
            end

            return Label
        end

        function UIlib:TextBox(config)
            local TextBox = Instance.new("TextBox")
            TextBox.Size = UDim2.new(1, -10, 0, 40)  -- Tamanho do TextBox
            TextBox.Position = UDim2.new(0, 5, 0, #TabContent:GetChildren() * 45)  -- Posição vertical
            TextBox.Text = config.Text or ""  -- Texto inicial do TextBox
            TextBox.Font = Enum.Font.Roboto  -- Fonte do texto
            TextBox.TextSize = 14  -- Tamanho do texto
            TextBox.TextColor3 = Color3.new(0, 0, 0)  -- Cor do texto (preto)
            TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)  -- Fundo branco
            TextBox.BackgroundTransparency = 0  -- Definindo a transparência do fundo como 0 (opaco)
            TextBox.Parent = TabContent  -- Adicionando o TextBox ao TabContent
        
            local Conteudo = TextBox.Text  -- Variável para armazenar o conteúdo
        
            -- Atualizar a variável Conteudo sempre que o texto mudar
            TextBox:GetPropertyChangedSignal("Text"):Connect(function()
                Conteudo = TextBox.Text
            end)
        
        
            return TextBox, function() return Conteudo end  -- Retornar o TextBox e uma função para acessar Conteudo
        end

        -- Slider
        local UserInputService = game:GetService("UserInputService")

        function UIlib:Slider(config)
            local SliderFrame = Instance.new("Frame")
            SliderFrame.Size = UDim2.new(1, -10, 0, 50)  -- Tamanho do Frame
            SliderFrame.Position = UDim2.new(0, 5, 0, #TabContent:GetChildren() * 45)  -- Posição vertical
            SliderFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)  -- Fundo branco
            SliderFrame.BackgroundTransparency = 0  -- Opaco
            SliderFrame.Parent = TabContent
        
            -- Canto arredondado
            local UICorner = Instance.new("UICorner")
            UICorner.CornerRadius = UDim.new(0, 10)  -- Arredondar os cantos
            UICorner.Parent = SliderFrame
        
            -- Texto do Slider
            local TitleLabel = Instance.new("TextLabel")
            TitleLabel.Size = UDim2.new(1, 0, 0, 20)  -- Tamanho do texto
            TitleLabel.Position = UDim2.new(0, 0, 0, 0)  -- Posição
            TitleLabel.Text = config.Title or "Slider"  -- Título do slider
            TitleLabel.Font = Enum.Font.Roboto
            TitleLabel.TextSize = 14
            TitleLabel.TextColor3 = Color3.new(0, 0, 0)  -- Cor do texto (preto)
            TitleLabel.BackgroundTransparency = 1  -- Transparente
            TitleLabel.Parent = SliderFrame
        
            -- Valor do Slider
            local ValueLabel = Instance.new("TextLabel")
            ValueLabel.Size = UDim2.new(0, 50, 0, 20)  -- Tamanho do valor
            ValueLabel.Position = UDim2.new(0.5, -25, 0.5, -10)  -- Centralizado
            ValueLabel.Text = tostring(config.Min)  -- Valor inicial
            ValueLabel.Font = Enum.Font.Roboto
            ValueLabel.TextSize = 14
            ValueLabel.TextColor3 = Color3.new(0, 0, 0)  -- Cor do texto (preto)
            ValueLabel.BackgroundTransparency = 1  -- Transparente
            ValueLabel.Parent = SliderFrame
        
            -- Slider Background
            local SliderBackground = Instance.new("Frame")
            SliderBackground.Size = UDim2.new(1, 0, 0, 10)  -- Tamanho do fundo do slider
            SliderBackground.Position = UDim2.new(0, 0, 0.5, -5)  -- Centralizado verticalmente
            SliderBackground.BackgroundColor3 = Color3.fromRGB(220, 220, 220)  -- Cor do fundo
            SliderBackground.Parent = SliderFrame
        
            -- Slider Handle
            local SliderHandle = Instance.new("Frame")
            SliderHandle.Size = UDim2.new(0, 20, 0, 20)  -- Tamanho do handle
            SliderHandle.Position = UDim2.new(0, 0, 0, -5)  -- Posição do handle
            SliderHandle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)  -- Cor do handle
            SliderHandle.Parent = SliderBackground
        
            -- Canto arredondado para o handle
            local UICornerHandle = Instance.new("UICorner")
            UICornerHandle.CornerRadius = UDim.new(1, 0)  -- Arredondar completamente
            UICornerHandle.Parent = SliderHandle
        
            -- Definindo limites do slider
            local MinValue = config.Min or 0
            local MaxValue = config.Max or 100
            local CurrentValue = MinValue
        
            -- Função para atualizar o valor
            local function updateValue()
                ValueLabel.Text = tostring(CurrentValue)
                SliderHandle.Position = UDim2.new((CurrentValue - MinValue) / (MaxValue - MinValue), -10, 0, -5)  -- Atualiza a posição do handle
            end
        
            -- Evento de arrastar o slider
            local dragging = false
        
            SliderHandle.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                    UserInputService.InputChanged:Connect(function(input)
                        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                            local mouseX = input.Position.X
                            local sliderX = SliderBackground.AbsolutePosition.X
                            local sliderWidth = SliderBackground.AbsoluteSize.X
        
                            -- Calcula o novo valor com base na posição do mouse
                            local newValue = MinValue + (MaxValue - MinValue) * ((mouseX - sliderX) / sliderWidth)
                            CurrentValue = math.clamp(newValue, MinValue, MaxValue)  -- Garante que o valor esteja dentro dos limites
                            updateValue()
                        end
                    end)
                end
            end)
        
            SliderHandle.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                    -- Chama a função de callback apenas ao soltar o slider
                    if config.Callback then
                        config.Callback(CurrentValue)
                    end
                end
            end)
        
            updateValue()  -- Atualiza o valor inicial
        
            print("Slider criado: " .. TitleLabel.Text)  -- Mensagem para verificar a criação do Slider
        
            return SliderFrame  -- Retornar o Frame do Slider
        end


        -- Dropdown
        function UIlib:Dropdown(config)
            local DropdownFrame = Instance.new("Frame")
            DropdownFrame.Size = UDim2.new(1, -10, 0, 40)  -- Tamanho do Dropdown
            DropdownFrame.Position = UDim2.new(0, 5, 0, #TabContent:GetChildren() * 45)  -- Posição vertical
            DropdownFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)  -- Cor de fundo
            DropdownFrame.Parent = TabContent
        
            local SelectedLabel = Instance.new("TextLabel")
            SelectedLabel.Size = UDim2.new(1, -40, 1, 0)  -- Tamanho do label de seleção
            SelectedLabel.Text = "Selecione opções"
            SelectedLabel.Font = Enum.Font.Roboto
            SelectedLabel.TextSize = 14
            SelectedLabel.TextColor3 = Color3.new(1, 1, 1)
            SelectedLabel.BackgroundTransparency = 1
            SelectedLabel.Parent = DropdownFrame
        
            local DropdownButton = Instance.new("TextButton")
            DropdownButton.Size = UDim2.new(0, 30, 1, 0)  -- Tamanho do botão de dropdown
            DropdownButton.Position = UDim2.new(1, -5, 0, 0)  -- Posiciona ao lado do label
            DropdownButton.Text = "▼"
            DropdownButton.Font = Enum.Font.Roboto
            DropdownButton.TextSize = 14
            DropdownButton.TextColor3 = Color3.new(1, 1, 1)
            DropdownButton.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
            DropdownButton.Parent = DropdownFrame
        
            -- Lista de opções
            local OptionsList = Instance.new("Frame")
            OptionsList.Size = UDim2.new(1, 0, 0, 0)  -- Tamanho inicial (0 para escondido)
            OptionsList.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            OptionsList.Position = UDim2.new(0, 0, 1, 0)  -- Abaixo do DropdownFrame
            OptionsList.Visible = false  -- Esconder inicialmente
            OptionsList.Parent = DropdownFrame
        
            local selectedOptions = {}  -- Armazena as opções selecionadas
        
            -- Criar as opções
            for index, option in ipairs(config.Options) do
                local OptionButton = Instance.new("TextButton")
                OptionButton.Size = UDim2.new(1, 0, 0, 30)  -- Tamanho de cada opção
                OptionButton.Text = option
                OptionButton.Font = Enum.Font.Roboto
                OptionButton.TextSize = 14
                OptionButton.TextColor3 = Color3.new(1, 1, 1)
                OptionButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
                OptionButton.Position = UDim2.new(0, 0, 0, (index - 1) * 30)  -- Ajusta a posição vertical da opção
                OptionButton.Parent = OptionsList
        
                OptionButton.MouseButton1Click:Connect(function()
                    -- Verifica se a opção já está selecionada
                    local isSelected = selectedOptions[option]
        
                    if isSelected then
                        -- Desmarca a opção se já estiver selecionada
                        selectedOptions[option] = nil
                        OptionButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)  -- Cor padrão
                    else
                        -- Se não estiver selecionada, verifica o limite
                        if #selectedOptions < (config.MaxSelections or #config.Options) then
                            selectedOptions[option] = true
                            OptionButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)  -- Cor para selecionada
                        else
                            -- Exibe uma mensagem de aviso ou feedback ao usuário
                            print("Máximo de seleções atingido!")  -- Aqui pode-se usar um sistema de notificações
                        end
                    end
        
                    -- Atualiza o texto do label com as opções selecionadas
                    local selectedText = {}
                    for k in pairs(selectedOptions) do
                        table.insert(selectedText, k)
                    end
        
                    SelectedLabel.Text = #selectedText > 0 and table.concat(selectedText, ", ") or "Selecione opções"
                    
                    -- Esconde a lista
                    OptionsList.Visible = false
                    if config.Callback then
                        config.Callback(selectedText)  -- Chama o callback com as opções selecionadas
                    end
                end)
            end
        
            -- Exibir/ocultar a lista de opções ao clicar no botão
            DropdownButton.MouseButton1Click:Connect(function()
                OptionsList.Visible = not OptionsList.Visible
        
                -- Atualiza o tamanho do dropdown com base na visibilidade da lista
                if OptionsList.Visible then
                    OptionsList.Size = UDim2.new(1, 0, 0, #config.Options * 30)  -- Aumenta o tamanho conforme necessário
                else
                    OptionsList.Size = UDim2.new(1, 0, 0, 0)  -- Reseta para tamanho escondido
                end
            end)
        
            return DropdownFrame  -- Retorna o frame do dropdown
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
