-- CleanUILib
local Library = {}
Library.__index = Library

function Library:Create()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "CleanUILibrary"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    
    self._gui = ScreenGui
    return setmetatable({}, Library)
end

function Library:CreateWindow(title)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0.6, 0, 0.7, 0)
    Frame.Position = UDim2.new(0.2, 0, 0.15, 0)
    Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Frame.BorderSizePixel = 0
    Frame.Parent = self._gui

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Title.Text = title or "Window"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 16
    Title.Parent = Frame

    local Scrolling = Instance.new("ScrollingFrame")
    Scrolling.Size = UDim2.new(1, 0, 1, -30)
    Scrolling.Position = UDim2.new(0, 0, 0, 30)
    Scrolling.CanvasSize = UDim2.new(0, 0, 0, 0)
    Scrolling.ScrollBarThickness = 4
    Scrolling.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Scrolling.BorderSizePixel = 0
    Scrolling.Parent = Frame

    local UIList = Instance.new("UIListLayout")
    UIList.Padding = UDim.new(0, 6)
    UIList.Parent = Scrolling

    local win = {}

    function win:AddSection(title, text)
        local Section = Instance.new("TextLabel")
        Section.Size = UDim2.new(1, -10, 0, 100)
        Section.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        Section.BorderSizePixel = 0
        Section.Text = (title and (title .. "\n") or "") .. text
        Section.TextColor3 = Color3.fromRGB(200, 200, 200)
        Section.Font = Enum.Font.Code
        Section.TextSize = 14
        Section.TextWrapped = true
        Section.TextXAlignment = Enum.TextXAlignment.Left
        Section.TextYAlignment = Enum.TextYAlignment.Top
        Section.Parent = Scrolling

        Scrolling.CanvasSize = UDim2.new(0, 0, 0, UIList.AbsoluteContentSize.Y + 10)
    end

    return win
end

return Library
