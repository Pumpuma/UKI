-- DrawingModule.lua
local Drawing = {}

function Drawing.new(type)
    local strokeColor = Color3.fromRGB(0, 0, 0) -- Black stroke
    local strokeThickness = 2 -- Adjust as needed

    if type == "Line" then
        return {
            create = function(parent, startPos, endPos, color, thickness)
                local line = Instance.new("Frame")
                line.BorderSizePixel = 0
                line.BackgroundColor3 = color
                line.AnchorPoint = Vector2.new(0.5, 0.5)
                line.Size = UDim2.new(0, (startPos - endPos).Magnitude, 0, thickness)
                line.Position = UDim2.new(0, (startPos + endPos).X / 2, 0, (startPos + endPos).Y / 2)
                line.Rotation = math.deg(math.atan2(endPos.Y - startPos.Y, endPos.X - startPos.X))
                
                local stroke = Instance.new("UIStroke")
                stroke.Color = strokeColor
                stroke.Thickness = strokeThickness
                stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                stroke.Parent = line
                
                line.Parent = parent
                return line
            end
        }
    elseif type == "Square" then
        return {
            create = function(parent, centerPos, width, height, color, strokeThickness)
                local square = Instance.new("Frame")
                square.BorderSizePixel = 0
                square.BackgroundColor3 = color
                square.BackgroundTransparency = 1
                square.Size = UDim2.new(0, width, 0, height)
                square.AnchorPoint = Vector2.new(0.5, 0.5)
                square.Position = UDim2.new(0, centerPos.X, 0, centerPos.Y)
                
                local stroke = Instance.new("UIStroke")
                stroke.Color = strokeColor
                stroke.Thickness = strokeThickness
                stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                stroke.Parent = square

                square.Parent = parent
                return square
            end
        }
    elseif type == "Text" then
        return {
            create = function(parent, position, text, color)
                local textLabel = Instance.new("TextLabel")
                textLabel.Text = text
                textLabel.Size = UDim2.new(0, 100, 0, 12)
                textLabel.AnchorPoint = Vector2.new(0.5, 1)
                textLabel.Position = UDim2.new(0, position.X, 0, position.Y)
                textLabel.BackgroundTransparency = 1
                textLabel.TextColor3 = color
                textLabel.TextStrokeColor3 = strokeColor -- Black stroke color
                textLabel.TextStrokeTransparency = 0.5 -- Adjust transparency as needed
                textLabel.TextScaled = true
                textLabel.Parent = parent
                return textLabel
            end
        }
    elseif type == "Circle" then
        return {
            create = function(parent, centerPos, diameter, color, strokeThickness)
                local circle = Instance.new("Frame")
                circle.BorderSizePixel = 0
                circle.BackgroundColor3 = color
                circle.BackgroundTransparency = 1
                circle.Size = UDim2.new(0, diameter, 0, diameter)
                circle.AnchorPoint = Vector2.new(0.5, 0.5)
                circle.Position = UDim2.new(0, centerPos.X, 0, centerPos.Y)
                circle.ClipsDescendants = true

                local stroke = Instance.new("UIStroke")
                stroke.Color = strokeColor
                stroke.Thickness = strokeThickness
                stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                stroke.Parent = circle

                local cornerRadius = Instance.new("UICorner")
                cornerRadius.CornerRadius = UDim.new(0.5, 0)
                cornerRadius.Parent = circle

                circle.Parent = parent
                return circle
            end
        }
    end
end

return Drawing
