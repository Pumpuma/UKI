-- DrawingModule.lua
local Drawing = {}

function Drawing.new(type)
    local shape

    if type == "Line" then
        local line = Instance.new("Frame")
        line.BorderSizePixel = 0
        line.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        line.AnchorPoint = Vector2.new(0.5, 0.5)
        line.Size = UDim2.new(0, 0, 0, 2)
        line.Position = UDim2.new(0, 0, 0, 0)
        line.Rotation = 0
        line.Visible = true
        line.ZIndex = 1
        line.BackgroundTransparency = 0
        
        shape = {
            Instance = line,
            Thickness = 2,
            From = Vector2.new(0, 0),
            To = Vector2.new(200, 200),
            Color = Color3.fromRGB(255, 255, 255),
            Transparency = 0,
            Visible = true,
            ZIndex = 1
        }

        function shape:SetVisible(visible)
            self.Visible = visible
            self.Instance.Visible = visible
            return self
        end

        function shape:SetColor(color)
            self.Color = color
            self.Instance.BackgroundColor3 = color
            return self
        end

        function shape:SetThickness(thickness)
            self.Thickness = thickness
            return self
        end

        function shape:SetTransparency(transparency)
            self.Transparency = transparency
            self.Instance.BackgroundTransparency = transparency
            return self
        end

        function shape:SetZIndex(index)
            self.ZIndex = index
            self.Instance.ZIndex = index
            return self
        end

        function shape:SetFrom(from)
            self.From = from
            return self
        end

        function shape:SetTo(to)
            self.To = to
            return self
        end

        function shape:Update()
            self.Instance.Size = UDim2.new(0, (self.From - self.To).Magnitude, 0, self.Thickness)
            self.Instance.Position = UDim2.new(0, (self.From + self.To).X / 2, 0, (self.From + self.To).Y / 2)
            self.Instance.Rotation = math.deg(math.atan2(self.To.Y - self.From.Y, self.To.X - self.From.X))
            self.Instance.BackgroundColor3 = self.Color
            self.Instance.BackgroundTransparency = self.Transparency
            self.Instance.Visible = self.Visible
            self.Instance.ZIndex = self.ZIndex
            return self
        end

        function shape:Remove()
            self.Instance:Destroy()
        end

    elseif type == "Text" then
        local textLabel = Instance.new("TextLabel")
        textLabel.Text = ""
        textLabel.Size = UDim2.new(0, 100, 0, 12)
        textLabel.AnchorPoint = Vector2.new(0.5, 1)
        textLabel.Position = UDim2.new(0, 0, 0, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        textLabel.TextStrokeTransparency = 1
        textLabel.TextScaled = true
        textLabel.RichText = true
        
        shape = {
            Instance = textLabel,
            Text = "",
            Size = 14,
            Center = true,
            Outline = false,
            OutlineColor = Color3.fromRGB(0, 0, 0),
            Position = Vector2.new(0, 0),
            Font = Enum.Font.SourceSans
        }

        function shape:SetText(text)
            self.Text = text
            self.Instance.Text = text
            return self
        end

        function shape:SetSize(size)
            self.Size = size
            self.Instance.TextSize = size
            return self
        end

        function shape:SetCenter(center)
            self.Center = center
            self.Instance.AnchorPoint = center and Vector2.new(0.5, 1) or Vector2.new(0, 0)
            return self
        end

        function shape:SetOutline(outline)
            self.Outline = outline
            self.Instance.TextStrokeTransparency = outline and 0 or 1
            return self
        end

        function shape:SetOutlineColor(color)
            self.OutlineColor = color
            self.Instance.TextStrokeColor3 = color
            return self
        end

        function shape:SetPosition(position)
            self.Position = position
            self.Instance.Position = UDim2.new(0, position.X, 0, position.Y)
            return self
        end

        function shape:SetFont(font)
            self.Font = font
            self.Instance.Font = font
            return self
        end

        function shape:Update()
            self.Instance.Text = self.Text
            self.Instance.TextSize = self.Size
            self.Instance.AnchorPoint = self.Center and Vector2.new(0.5, 1) or Vector2.new(0, 0)
            self.Instance.TextStrokeTransparency = self.Outline and 0 or 1
            self.Instance.TextStrokeColor3 = self.Outline and self.OutlineColor or Color3.fromRGB(0, 0, 0)
            self.Instance.Position = UDim2.new(0, self.Position.X, 0, self.Position.Y)
            self.Instance.Font = self.Font
            return self
        end

        function shape:Remove()
            self.Instance:Destroy()
        end

    elseif type == "Circle" then
        local circle = Instance.new("Frame")
        circle.BorderSizePixel = 0
        circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        circle.AnchorPoint = Vector2.new(0.5, 0.5)
        circle.Size = UDim2.new(0, 100, 0, 100)
        circle.Position = UDim2.new(0, 0, 0, 0)
        circle.BackgroundTransparency = 0
        circle.ClipsDescendants = true
        
        local cornerRadius = Instance.new("UICorner")
        cornerRadius.CornerRadius = UDim.new(0.5, 0)
        cornerRadius.Parent = circle
        
        shape = {
            Instance = circle,
            Radius = 50,
            Thickness = 1,
            Filled = true,
            Position = Vector2.new(0, 0)
        }

        function shape:SetThickness(thickness)
            self.Thickness = thickness
            return self
        end

        function shape:SetRadius(radius)
            self.Radius = radius
            return self
        end

        function shape:SetFilled(filled)
            self.Filled = filled
            self.Instance.BackgroundTransparency = filled and 0 or 1
            return self
        end

        function shape:SetPosition(position)
            self.Position = position
            self.Instance.Position = UDim2.new(0, position.X, 0, position.Y)
            return self
        end

        function shape:Update()
            self.Instance.Size = UDim2.new(0, self.Radius * 2, 0, self.Radius * 2)
            self.Instance.Position = UDim2.new(0, self.Position.X, 0, self.Position.Y)
            self.Instance.BorderSizePixel = self.Thickness
            self.Instance.BackgroundTransparency = self.Filled and 0 or 1
            return self
        end

        function shape:Remove()
            self.Instance:Destroy()
        end

    elseif type == "Square" then
        local square = Instance.new("Frame")
        square.BorderSizePixel = 0
        square.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        square.AnchorPoint = Vector2.new(0.5, 0.5)
        square.Size = UDim2.new(0, 100, 0, 100)
        square.Position = UDim2.new(0, 0, 0, 0)
        square.BackgroundTransparency = 0
        
        shape = {
            Instance = square,
            Size = Vector2.new(100, 100),
            Thickness = 1,
            Position = Vector2.new(0, 0),
            Filled = true
        }

        function shape:SetThickness(thickness)
            self.Thickness = thickness
            return self
        end

        function shape:SetSize(size)
            self.Size = size
            return self
        end

        function shape:SetPosition(position)
            self.Position = position
            return self
        end

        function shape:SetFilled(filled)
            self.Filled = filled
            self.Instance.BackgroundTransparency = filled and 0 or 1
            return self
        end

        function shape:Update()
            self.Instance.Size = UDim2.new(0, self.Size.X, 0, self.Size.Y)
            self.Instance.Position = UDim2.new(0, self.Position.X, 0, self.Position.Y)
            self.Instance.BorderSizePixel = self.Thickness
            self.Instance.BackgroundTransparency = self.Filled and 0 or 1
            return self
        end

        function shape:Remove()
            self.Instance:Destroy()
        end

    end

    return shape
end

return Drawing
