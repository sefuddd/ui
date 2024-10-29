local UIlib = {}

-- Função principal para criar a Janela
function UIlib:Janela()
    -- Espaçamento padrão para todos os elementos
    local padding = 10  -- Espaçamento geral para bordas e entre widgets
    local widgetHeight = 40  -- Altura padrão dos widgets

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

    -- Sombra
    local Shadow = Instance.new("Frame")
    Shadow.Size = UDim2.new(1, 8, 1, 8)
    Shadow.BackgroundColor3 = Color3.fromRGB(13, 13, 13)
    Shadow.BorderSizePixel = 0
    Shadow.Position = UDim2.new(0, -4, 0, -4)
    Shadow.Parent = MainFrame

    -- Topbar
    local Topbar = Instance.new("Frame")
    Topbar.Size = UDim2.new(1, -2 * padding, 0, 30)
    Topbar.Position = UDim2.new(0, padding, 0, padding)
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
    Menu.Size = UDim2.new(0, 100 - padding, 1, -2 * padding - Topbar.Size.Y.Offset)
    Menu.Position = UDim2.new(0, padding, 0, Topbar.Size.Y.Offset + padding)
    Menu.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
    Menu.BorderSizePixel = 0
    Menu.Parent = MainFrame

    -- Espaço para Widgets
    local Body = Instance.new("Frame")
    Body.Size = UDim2.new(1, -Menu.Size.X.Offset - 3 * padding, 1, -Topbar.Size.Y.Offset - 3 * padding)
    Body.Position = UDim2.new(0, Menu.Size.X.Offset + 2 * padding, 0, Topbar.Size.Y.Offset + padding)
    Body.BackgroundTransparency = 1
    Body.Parent = MainFrame

    -- Função para criar Tabs
    function UIlib:Menu(nome)
        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(1, -padding, 0, 40)
        TabButton.Position = UDim2.new(0, padding / 2, 0, (#Menu:GetChildren() - 1) * (widgetHeight + padding))
        TabButton.Text = nome
        TabButton.Font = Enum.Font.Roboto
        TabButton.TextSize = 14
        TabButton.BackgroundTransparency = 0.1
        TabButton.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
        TabButton.TextColor3 = Color3.new(1, 1, 1)
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
            Button.Size = UDim2.new(1, -2 * padding, 0, widgetHeight)
            Button.Position = UDim2.new(0, padding, 0, (#TabContent:GetChildren() * (widgetHeight + padding)))
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

        -- Função para adicionar Switch na Tab
        function UIlib:Switch(config)
            local Switch = Instance.new("TextButton")
            Switch.Size = UDim2.new(1, -2 * padding, 0, widgetHeight)
            Switch.Position = UDim2.new(0, padding, 0, (#TabContent:GetChildren() * (widgetHeight + padding)))
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
