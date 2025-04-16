-- CleanUILib
local Library = {}
Library.__index = Library

function Library:Create()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "CleanUILibrary"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("CoreGui")
    
    self._gui = ScreenGui
    return setmetatable({}, Library)
end
function Library:ApplyColorTo(element, color)
	if typeof(element) == "Instance" and element:IsA("GuiObject") then
		element.BackgroundColor3 = color
		for _, child in pairs(element:GetDescendants()) do
			if child:IsA("GuiObject") then
				child.BackgroundColor3 = color
			end
		end
	end
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
    function win:AddSwitch(label, default, callback)
        local Toggle = Instance.new("TextButton")
        Toggle.Size = UDim2.new(1, -10, 0, 30)
        Toggle.BackgroundColor3 = default and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(80, 80, 80)
        Toggle.BorderSizePixel = 0
        Toggle.Text = (default and "[ON] " or "[OFF] ") .. label
        Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
        Toggle.Font = Enum.Font.Gotham
        Toggle.TextSize = 14
        Toggle.Parent = Scrolling

        local state = default
        Toggle.MouseButton1Click:Connect(function()
            state = not state
            Toggle.BackgroundColor3 = state and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(80, 80, 80)
            Toggle.Text = (state and "[ON] " or "[OFF] ") .. label
            pcall(callback, state)
        end)

        Scrolling.CanvasSize = UDim2.new(0, 0, 0, UIList.AbsoluteContentSize.Y + 10)
    end
    function win:AddButton(name, callback)
        local Button = Instance.new("TextButton")
        Button.Size = UDim2.new(1, -10, 0, 30)
        Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        Button.BorderSizePixel = 0
        Button.Text = name or "Button"
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.Font = Enum.Font.Gotham
        Button.TextSize = 14
        Button.Parent = Scrolling
        Button.MouseButton1Click:Connect(function()
            pcall(callback)
        end)
        Scrolling.CanvasSize = UDim2.new(0, 0, 0, UIList.AbsoluteContentSize.Y + 10)
    end
    return win
end

return Library
