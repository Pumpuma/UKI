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
                line.Position = UDim2.new(0, (startPos.X + endPos.X) / 2, 0, (startPos.Y + endPos.Y) / 2)
                line.Rotation = math.deg(math.atan2(endPos.Y - startPos.Y, endPos.X - startPos.X))
                line.Parent = parent
                return {
                    update = function(newStartPos, newEndPos, newColor, newThickness)
                        line.BackgroundColor3 = newColor or line.BackgroundColor3
                        line.Size = UDim2.new(0, (newStartPos - newEndPos).Magnitude, 0, newThickness or thickness)
                        line.Position = UDim2.new(0, (newStartPos.X + newEndPos.X) / 2, 0, (newStartPos.Y + newEndPos.Y) / 2)
                        line.Rotation = math.deg(math.atan2(newEndPos.Y - newStartPos.Y, newEndPos.X - newStartPos.X))
                    end
                }
            end
        }
    elseif type == "Square" then
        return {
            create = function(parent, centerPos, width, height, fillColor, fillTransparency, borderColor, borderThickness, cornerRadius)
                local square = Instance.new("Frame")
                square.BackgroundColor3 = fillColor
                square.BackgroundTransparency = fillTransparency or 0
                square.Size = UDim2.new(0, width, 0, height)
                square.AnchorPoint = Vector2.new(0.5, 0.5)
                square.Position = UDim2.new(0, centerPos.X, 0, centerPos.Y)
                
                local stroke = Instance.new("UIStroke")
                stroke.Color = borderColor or Color3.new(0, 0, 0)
                stroke.Thickness = borderThickness or 1
                stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                stroke.Parent = square

                if cornerRadius and cornerRadius > 0 then
                    local corner = Instance.new("UICorner")
                    corner.CornerRadius = UDim.new(cornerRadius, 0)
                    corner.Parent = square
                end

                square.Parent = parent
                return {
                    update = function(newCenterPos, newWidth, newHeight, newFillColor, newFillTransparency, newBorderColor, newBorderThickness, newCornerRadius)
                        square.BackgroundColor3 = newFillColor or square.BackgroundColor3
                        square.BackgroundTransparency = newFillTransparency or square.BackgroundTransparency
                        square.Size = UDim2.new(0, newWidth or width, 0, newHeight or height)
                        square.Position = UDim2.new(0, newCenterPos.X or centerPos.X, 0, newCenterPos.Y or centerPos.Y)
                        
                        local stroke = square:FindFirstChildOfClass("UIStroke")
                        if stroke then
                            stroke.Color = newBorderColor or stroke.Color
                            stroke.Thickness = newBorderThickness or stroke.Thickness
                        end

                        local corner = square:FindFirstChildOfClass("UICorner")
                        if corner and newCornerRadius then
                            corner.CornerRadius = UDim.new(newCornerRadius, 0)
                        end
                    end
                }
            end
        }
    elseif type == "Circle" then
        return {
            create = function(parent, centerPos, diameter, fillColor, fillTransparency, borderColor, borderThickness, rotation)
                local circle = Instance.new("Frame")
                circle.BackgroundColor3 = fillColor
                circle.BackgroundTransparency = fillTransparency or 0
                circle.Size = UDim2.new(0, diameter, 0, diameter)
                circle.AnchorPoint = Vector2.new(0.5, 0.5)
                circle.Position = UDim2.new(0, centerPos.X, 0, centerPos.Y)
                circle.Rotation = rotation or 0

                local corner = Instance.new("UICorner")
                corner.CornerRadius = UDim.new(0.5, 0)
                corner.Parent = circle

                local stroke = Instance.new("UIStroke")
                stroke.Color = borderColor or Color3.new(0, 0, 0)
                stroke.Thickness = borderThickness or 1
                stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                stroke.Parent = circle

                circle.Parent = parent
                return {
                    update = function(newCenterPos, newDiameter, newFillColor, newFillTransparency, newBorderColor, newBorderThickness, newRotation)
                        circle.BackgroundColor3 = newFillColor or circle.BackgroundColor3
                        circle.BackgroundTransparency = newFillTransparency or circle.BackgroundTransparency
                        circle.Size = UDim2.new(0, newDiameter or diameter, 0, newDiameter or diameter)
                        circle.Position = UDim2.new(0, newCenterPos.X or centerPos.X, 0, newCenterPos.Y or centerPos.Y)
                        circle.Rotation = newRotation or circle.Rotation

                        local stroke = circle:FindFirstChildOfClass("UIStroke")
                        if stroke then
                            stroke.Color = newBorderColor or stroke.Color
                            stroke.Thickness = newBorderThickness or stroke.Thickness
                        end
                    end
                }
            end
        }
    elseif type == "Text" then
        return {
            create = function(parent, position, text, textColor, textSize, textStrokeColor, textStrokeTransparency, textFont, textBold, textItalic)
                local textLabel = Instance.new("TextLabel")
                textLabel.Text = text
                textLabel.Size = UDim2.new(0, 100, 0, textSize)
                textLabel.AnchorPoint = Vector2.new(0.5, 1)
                textLabel.Position = UDim2.new(0, position.X, 0, position.Y)
                textLabel.BackgroundTransparency = 1
                textLabel.TextColor3 = textColor
                textLabel.TextStrokeColor3 = textStrokeColor or Color3.new(0, 0, 0)
                textLabel.TextStrokeTransparency = textStrokeTransparency or 0
                textLabel.TextScaled = true
                textLabel.RichText = true
                textLabel.TextFont = textFont or Enum.Font.SourceSans
                textLabel.TextBold = textBold or false
                textLabel.TextItalic = textItalic or false
                textLabel.Parent = parent
                return {
                    update = function(newPosition, newText, newTextColor, newTextSize, newTextStrokeColor, newTextStrokeTransparency, newTextFont, newTextBold, newTextItalic)
                        textLabel.Text = newText or textLabel.Text
                        textLabel.Size = UDim2.new(0, textLabel.TextBounds.X, 0, newTextSize or textSize)
                        textLabel.Position = UDim2.new(0, newPosition.X or position.X, 0, newPosition.Y or position.Y)
                        textLabel.TextColor3 = newTextColor or textLabel.TextColor3
                        textLabel.TextStrokeColor3 = newTextStrokeColor or textLabel.TextStrokeColor3
                        textLabel.TextStrokeTransparency = newTextStrokeTransparency or textLabel.TextStrokeTransparency
                        textLabel.TextFont = newTextFont or textLabel.TextFont
                        textLabel.TextBold = newTextBold or textLabel.TextBold
                        textLabel.TextItalic = newTextItalic or textLabel.TextItalic
                    end
                }
            end
        }
    end
end

return Drawing
