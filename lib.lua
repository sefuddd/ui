local UI = {}

-- Cores
local COR_TOPBAR = Color3.fromRGB(30, 30, 30)
local COR_SIDEBAR = Color3.fromRGB(13, 13, 13)
local COR_CONTENT = Color3.fromRGB(40, 40, 40)
local COR_BOTAO = Color3.fromRGB(25, 25, 25)
local COR_TEXTO_BOTAO = Color3.fromRGB(255, 255, 255)

-- Criar a janela principal com topbar e sidebar
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
    TopBar.BackgroundColor3 = COR_TOPBAR
    TopBar.Parent = MenuFrame

    -- Adicionar texto à topbar
    local TopBarText = Instance.new("TextLabel")
    TopBarText.Size = UDim2.new(1, 0, 1, 0)
    TopBarText.Text = "Título do Menu"
    TopBarText.TextColor3 = Color3.fromRGB(255, 255, 255)
    TopBarText.BackgroundTransparency = 1
    TopBarText.Parent = TopBar

    -- Criar a barra lateral
    local SideBar = Instance.new("Frame")
    SideBar.Size = UDim2.new(0.2, 0, 1, 0)
    SideBar.BackgroundColor3 = COR_SIDEBAR
    SideBar.Position = UDim2.new(0, 0, 0, 0)
    SideBar.Parent = MenuFrame

    -- Criar o conteúdo principal
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Size = UDim2.new(0.8, 0, 0.9, 0)
    ContentFrame.Position = UDim2.new(0.2, 0, 0.1, 0)
    ContentFrame.BackgroundColor3 = COR_CONTENT
    ContentFrame.Parent = MenuFrame

    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    return ContentFrame, SideBar
end

-- Criar um botão na barra lateral
function UI.criar_botao(nome, funcao)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0.8, 0, 0, 50)
    Button.Text = nome
    Button.BackgroundColor3 = COR_BOTAO
    Button.TextColor3 = COR_TEXTO_BOTAO
    Button.Parent = UI.SideBar -- Referência à barra lateral
    Button.MouseButton1Click:Connect(funcao)

    -- Posicionar o botão abaixo dos outros
    Button.Position = UDim2.new(0, 0, #UI.SideBar:GetChildren() * 0.1, 0)
end

return UI
