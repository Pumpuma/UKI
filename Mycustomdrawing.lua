-- DrawingModule.lua
local Drawing = {}

function Drawing.new(type)
    if type == "Line" then
        return {
            create = function(parent, startPos, endPos, color, thickness, dashLength)
                local line = Instance.new("Frame")
                line.BorderSizePixel = 0
                line.BackgroundColor3 = color
                line.AnchorPoint = Vector2.new(0.5, 0.5)
                line.Size = UDim2.new(0, (startPos - endPos).Magnitude, 0, thickness)
                line.Position = UDim2.new(0, (startPos + endPos).X / 2, 0, (startPos + endPos).Y / 2)
                line.Rotation = math.deg(math.atan2(endPos.Y - startPos.Y, endPos.X - startPos.X))
                line.Parent = parent
                return {
                    line = line,
                    update = function(self, startPos, endPos, color, thickness, dashLength)
                        self.line.BackgroundColor3 = color
                        self.line.Size = UDim2.new(0, (startPos - endPos).Magnitude, 0, thickness)
                        self.line.Position = UDim2.new(0, (startPos + endPos).X / 2, 0, (startPos + endPos).Y / 2)
                        self.line.Rotation = math.deg(math.atan2(endPos.Y - startPos.Y, endPos.X - startPos.X))
                        -- Note: Dash length is not implemented in Roblox, but you can simulate dashes by using multiple lines.
                    end
                }
            end
        }
    elseif type == "Square" then
        return {
            create = function(parent, centerPos, width, height, fillColor, fillTransparency, borderColor, borderThickness, borderTransparency, cornerRadius)
                local square = Instance.new("Frame")
                square.BackgroundColor3 = fillColor
                square.BackgroundTransparency = fillTransparency
                square.Size = UDim2.new(0, width, 0, height)
                square.AnchorPoint = Vector2.new(0.5, 0.5)
                square.Position = UDim2.new(0, centerPos.X, 0, centerPos.Y)
                
                local stroke = Instance.new("UIStroke")
                stroke.Color = borderColor or Color3.new(0, 0, 0)
                stroke.Thickness = borderThickness or 1
                stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                stroke.Transparency = borderTransparency or 0
                stroke.Parent = square

                local corner = Instance.new("UICorner")
                corner.CornerRadius = UDim.new(cornerRadius or 0, 0)
                corner.Parent = square

                square.Parent = parent
                return {
                    square = square,
                    update = function(self, centerPos, width, height, fillColor, fillTransparency, borderColor, borderThickness, borderTransparency, cornerRadius)
                        self.square.BackgroundColor3 = fillColor
                        self.square.BackgroundTransparency = fillTransparency
                        self.square.Size = UDim2.new(0, width, 0, height)
                        self.square.Position = UDim2.new(0, centerPos.X, 0, centerPos.Y)
                        local stroke = self.square:FindFirstChildOfClass("UIStroke")
                        if stroke then
                            stroke.Color = borderColor or stroke.Color
                            stroke.Thickness = borderThickness or stroke.Thickness
                            stroke.Transparency = borderTransparency or stroke.Transparency
                        end
                        local corner = self.square:FindFirstChildOfClass("UICorner")
                        if corner then
                            corner.CornerRadius = UDim.new(cornerRadius or 0, 0)
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
                    textLabel = textLabel,
                    update = function(self, position, text, textColor, textSize, textStrokeColor, textStrokeTransparency, textFont, textBold, textItalic)
                        self.textLabel.Text = text
                        self.textLabel.Size = UDim2.new(0, self.textLabel.TextBounds.X, 0, textSize)
                        self.textLabel.Position = UDim2.new(0, position.X, 0, position.Y)
                        self.textLabel.TextColor3 = textColor
                        self.textLabel.TextStrokeColor3 = textStrokeColor or self.textLabel.TextStrokeColor3
                        self.textLabel.TextStrokeTransparency = textStrokeTransparency or self.textLabel.TextStrokeTransparency
                        self.textLabel.TextFont = textFont or self.textLabel.TextFont
                        self.textLabel.TextBold = textBold or self.textLabel.TextBold
                        self.textLabel.TextItalic = textItalic or self.textLabel.TextItalic
                    end
                }
            end
        }
    elseif type == "Circle" then
        return {
            create = function(parent, centerPos, diameter, fillColor, fillTransparency, borderColor, borderThickness, borderTransparency, rotation)
                local circle = Instance.new("Frame")
                circle.BackgroundColor3 = fillColor
                circle.BackgroundTransparency = fillTransparency
                circle.Size = UDim2.new(0, diameter, 0, diameter)
                circle.AnchorPoint = Vector2.new(0.5, 0.5)
                circle.Position = UDim2.new(0, centerPos.X, 0, centerPos.Y)
                circle.ClipsDescendants = true
                circle.Rotation = rotation or 0

                local cornerRadius = Instance.new("UICorner")
                cornerRadius.CornerRadius = UDim.new(0.5, 0)
                cornerRadius.Parent = circle

                local stroke = Instance.new("UIStroke")
                stroke.Color = borderColor or Color3.new(0, 0, 0)
                stroke.Thickness = borderThickness or 1
                stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                stroke.Transparency = borderTransparency or 0
                stroke.Parent = circle

                circle.Parent = parent
                return {
                    circle = circle,
                    update = function(self, centerPos, diameter, fillColor, fillTransparency, borderColor, borderThickness, borderTransparency, rotation)
                        self.circle.BackgroundColor3 = fillColor
                        self.circle.BackgroundTransparency = fillTransparency
                        self.circle.Size = UDim2.new(0, diameter, 0, diameter)
                        self.circle.Position = UDim2.new(0, centerPos.X, 0, centerPos.Y)
                        local stroke = self.circle:FindFirstChildOfClass("UIStroke")
                        if stroke then
                            stroke.Color = borderColor or stroke.Color
                            stroke.Thickness = borderThickness or stroke.Thickness
                            stroke.Transparency = borderTransparency or stroke.Transparency
                        end
                        self.circle.Rotation = rotation or self.circle.Rotation
                    end
                }
            end
        }
    end
end

return Drawing
