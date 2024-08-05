local DrawingLibrary = {}

function DrawingLibrary.new(type)
    if type == "Line" then
        return {
            create = function(parent, startPos, endPos, color, thickness)
                local line = Instance.new("Frame")
                line.BorderSizePixel = 0
                line.BackgroundColor3 = color
                line.AnchorPoint = Vector2.new(0.5, 0.5)

                local distance = (startPos - endPos).Magnitude
                line.Size = UDim2.new(0, distance, 0, thickness)

                local midpoint = (startPos + endPos) / 2
                line.Position = UDim2.new(0, midpoint.X, 0, midpoint.Y)

                local angle = math.atan2(endPos.Y - startPos.Y, endPos.X - startPos.X)
                line.Rotation = math.deg(angle)

                line.Parent = parent
                return line
            end
        }
    elseif type == "Square" then
        return {
            create = function(parent, centerPos, width, height, color, strokeColor, strokeThickness)
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
                textLabel.Size = UDim2.new(0, 100, 0, 12) -- Slightly larger size for the text label
                textLabel.AnchorPoint = Vector2.new(0.5, 1)
                textLabel.Position = UDim2.new(0, position.X, 0, position.Y) -- Positioned directly below the box
                textLabel.BackgroundTransparency = 1
                textLabel.TextColor3 = color
                textLabel.TextStrokeTransparency = 1 -- Remove the black stroke
                textLabel.TextScaled = true
                textLabel.Parent = parent
                return textLabel
            end
        }
    elseif type == "Circle" then
        return {
            create = function(parent, centerPos, radius, color, strokeColor, strokeThickness)
                local circle = Instance.new("Frame")
                circle.BorderSizePixel = 0
                circle.BackgroundColor3 = color
                circle.BackgroundTransparency = 1
                circle.Size = UDim2.new(0, radius * 2, 0, radius * 2)
                circle.AnchorPoint = Vector2.new(0.5, 0.5)
                circle.Position = UDim2.new(0, centerPos.X, 0, centerPos.Y)

                local uiCorner = Instance.new("UICorner")
                uiCorner.CornerRadius = UDim.new(0.5, 0) -- This makes the frame a circle
                uiCorner.Parent = circle

                local stroke = Instance.new("UIStroke")
                stroke.Color = strokeColor
                stroke.Thickness = strokeThickness
                stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                stroke.Parent = circle

                circle.Parent = parent
                return circle
            end
        }
    end
end

return DrawingLibrary
