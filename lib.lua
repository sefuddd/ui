local UI = {}

function UI.criar_janela()
    -- Criar a janela principal
    local ScreenGui = Instance.new("ScreenGui")
    local MenuFrame = Instance.new("Frame")
    MenuFrame.Size = UDim2.new(0.5, 0, 0.5, 0)
    MenuFrame.Position = UDim2.new(0.25, 0, 0.25, 0)
    MenuFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    MenuFrame.Parent = ScreenGui

    -- Criar a topbar
    local TopBar = Instance.new("Frame")
    TopBar.Size = UDim2.new(1, 0, 0, 50)
    TopBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TopBar.Parent = MenuFrame

    -- Criar a barra lateral
    local SideBar = Instance.new("Frame")
    SideBar.Size = UDim2.new(0.2, 0, 1, 0)
    SideBar.BackgroundColor3 = Color3.fromRGB(13, 13, 13)
    SideBar.Position = UDim2.new(0, 0, 0, 0)
    SideBar.Parent = MenuFrame

    -- Criar o conteúdo principal
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Size = UDim2.new(0.8, 0, 0.9, 0)
    ContentFrame.Position = UDim2.new(0.2, 0, 0.1, 0)
    ContentFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    ContentFrame.Parent = MenuFrame

    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    return ContentFrame, SideBar
end

function UI.criar_botao(nome, funcao)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0.8, 0, 0, 50)
    Button.Text = nome
    Button.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Button.Parent = UI.SideBar -- Referência à barra lateral
    Button.MouseButton1Click:Connect(funcao)
end

return UI
