-- DrawingModule.lua
local Drawing = {}

function Drawing.new(type)
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
                line.Parent = parent
                return line
            end
        }
    elseif type == "Square" then
        return {
            create = function(parent, centerPos, width, height, color, strokeColor, strokeThickness, filled)
                local square = Instance.new("Frame")
                square.BackgroundColor3 = color
                square.BackgroundTransparency = filled and 0 or 1
                square.Size = UDim2.new(0, width, 0, height)
                square.AnchorPoint = Vector2.new(0.5, 0.5)
                square.Position = UDim2.new(0, centerPos.X, 0, centerPos.Y)

                if strokeColor and strokeThickness then
                    local border = Instance.new("Frame")
                    border.BorderSizePixel = strokeThickness
                    border.BorderColor3 = strokeColor
                    border.Size = UDim2.new(1, 0, 1, 0)
                    border.Position = UDim2.new(0, -strokeThickness / 2, 0, -strokeThickness / 2)
                    border.Parent = square
                end

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
                textLabel.TextStrokeTransparency = 1
                textLabel.TextScaled = true
                textLabel.RichText = true -- Enable rich text
                textLabel.Parent = parent
                return textLabel
            end
        }
    elseif type == "Circle" then
        return {
            create = function(parent, centerPos, diameter, color, strokeColor, strokeThickness, filled)
                local circle = Instance.new("Frame")
                circle.BackgroundColor3 = color
                circle.BackgroundTransparency = filled and 0 or 1
                circle.Size = UDim2.new(0, diameter, 0, diameter)
                circle.AnchorPoint = Vector2.new(0.5, 0.5)
                circle.Position = UDim2.new(0, centerPos.X, 0, centerPos.Y)
                circle.ClipsDescendants = true

                if strokeColor and strokeThickness then
                    local border = Instance.new("Frame")
                    border.BorderSizePixel = strokeThickness
                    border.BorderColor3 = strokeColor
                    border.Size = UDim2.new(1, 0, 1, 0)
                    border.Position = UDim2.new(0, -strokeThickness / 2, 0, -strokeThickness / 2)
                    border.Parent = circle
                end

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
