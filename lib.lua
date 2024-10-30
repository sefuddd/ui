local UserInputService = game:GetService("UserInputService")

function UIlib:Dropdown(config)
    local DropdownFrame = Instance.new("Frame")
    DropdownFrame.Size = UDim2.new(1, -10, 0, 60)  -- Aumentar altura para acomodar título e botão
    DropdownFrame.Position = UDim2.new(0, 5, 0, #TabContent:GetChildren() * 45)  -- Posição vertical
    DropdownFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)  -- Fundo branco
    DropdownFrame.BackgroundTransparency = 0  -- Opaco
    DropdownFrame.Parent = TabContent

    -- Canto arredondado
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)  -- Arredondar os cantos
    UICorner.Parent = DropdownFrame

    -- Texto do Dropdown
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, 0, 0, 20)  -- Tamanho do texto
    TitleLabel.Position = UDim2.new(0, 0, 0, 0)  -- Posição
    TitleLabel.Text = config.Title or "Dropdown"  -- Título do dropdown
    TitleLabel.Font = Enum.Font.Roboto
    TitleLabel.TextSize = 14
    TitleLabel.TextColor3 = Color3.new(0, 0, 0)  -- Cor do texto (preto)
    TitleLabel.BackgroundTransparency = 1  -- Transparente
    TitleLabel.Parent = DropdownFrame

    -- Dropdown Button
    local DropdownButton = Instance.new("TextButton")
    DropdownButton.Size = UDim2.new(1, 0, 0, 30)  -- Tamanho do botão
    DropdownButton.Position = UDim2.new(0, 0, 0.3, 0)  -- Posiciona abaixo do título
    DropdownButton.Text = "Selecione uma opção"  -- Texto do botão
    DropdownButton.Font = Enum.Font.Roboto
    DropdownButton.TextSize = 14
    DropdownButton.TextColor3 = Color3.new(0, 0, 0)  -- Cor do texto (preto)
    DropdownButton.BackgroundColor3 = Color3.fromRGB(220, 220, 220)  -- Cor do fundo
    DropdownButton.Parent = DropdownFrame

    -- Dropdown Content (Lista de opções)
    local DropdownContent = Instance.new("Frame")
    DropdownContent.Size = UDim2.new(1, 0, 0, #config.Options * 30)  -- Altura para acomodar todas as opções
    DropdownContent.Position = UDim2.new(0, 0, 1, 0)  -- Abaixo do botão
    DropdownContent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)  -- Fundo branco
    DropdownContent.Visible = false  -- Ocultar inicialmente
    DropdownContent.Parent = DropdownFrame

    -- Canto arredondado para o conteúdo do dropdown
    local UICornerContent = Instance.new("UICorner")
    UICornerContent.CornerRadius = UDim.new(0, 10)
    UICornerContent.Parent = DropdownContent

    -- Função para atualizar o botão com os itens selecionados
    local function updateButton()
        local selectedCount = 0
        local selectedNames = {}

        for item in pairs(selectedItems) do
            if selectedItems[item] then
                table.insert(selectedNames, item)
                selectedCount = selectedCount + 1
            end
        end

        if selectedCount > 0 then
            DropdownButton.Text = "Selecionado: " .. table.concat(selectedNames, ", ")
        else
            DropdownButton.Text = "Selecione uma opção"
        end
    end

    -- Variável para armazenar as seleções
    local selectedItems = {}

    -- Adiciona as opções ao dropdown
    for index, option in ipairs(config.Options) do
        local OptionButton = Instance.new("TextButton")
        OptionButton.Size = UDim2.new(1, 0, 0, 30)  -- Tamanho do botão de opção
        OptionButton.Position = UDim2.new(0, 0, (index - 1) * (30 / DropdownContent.Size.Y.Scale), 0)  -- Define a posição correta para cada opção
        OptionButton.Text = option  -- Texto da opção
        OptionButton.Font = Enum.Font.Roboto
        OptionButton.TextSize = 14
        OptionButton.TextColor3 = Color3.new(0, 0, 0)  -- Cor do texto (preto)
        OptionButton.BackgroundColor3 = Color3.fromRGB(240, 240, 240)  -- Cor do fundo
        OptionButton.Parent = DropdownContent

        -- Canto arredondado para os botões de opção
        local UICornerOption = Instance.new("UICorner")
        UICornerOption.CornerRadius = UDim.new(0, 5)
        UICornerOption.Parent = OptionButton

        -- Evento de seleção de opção
        OptionButton.MouseButton1Click:Connect(function()
            if selectedItems[option] then
                -- Remove a seleção se já estiver selecionado
                selectedItems[option] = nil
            else
                -- Adiciona a seleção se não estiver selecionado
                if config.MaxSelections and table.count(selectedItems) < config.MaxSelections then
                    selectedItems[option] = true
                end
            end
            updateButton()  -- Atualiza o botão com as seleções
        end)
    end

    -- Abrir e fechar o dropdown
    DropdownButton.MouseButton1Click:Connect(function()
        DropdownContent.Visible = not DropdownContent.Visible
    end)

    -- Atualiza o botão ao inicializar
    updateButton()

    print("Dropdown criado: " .. TitleLabel.Text)  -- Mensagem para verificar a criação do Dropdown

    return selectedItems  -- Retorna a tabela de itens selecionados
end
