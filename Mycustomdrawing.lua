local Drawing = {}

-- Helper function to create a UIElement
local function createElement(type, parent, properties)
    local element = Instance.new(type)
    for property, value in pairs(properties) do
        element[property] = value
    end
    element.Parent = parent
    return element
end

-- Directly create a ScreenGui and assign it to a variable
local coreGui = game:GetService("CoreGui")
local screenGui = coreGui:FindFirstChild("DrawingScreenGui") or Instance.new("ScreenGui")
screenGui.Name = "DrawingScreenGui"
screenGui.Parent = coreGui

function Drawing.new(type)
    if type == "Line" then
        return {
            create = function(startPos, endPos, color, thickness, transparency, zIndex, rotation, strokeColor, strokeThickness)
                local line = createElement("Frame", screenGui, {
                    BorderSizePixel = 0,
                    BackgroundColor3 = color,
                    BackgroundTransparency = transparency or 0,
                    Size = UDim2.new(0, (startPos - endPos).Magnitude, 0, thickness),
                    Position = UDim2.new(0, (startPos + endPos).X / 2, 0, (startPos + endPos).Y / 2),
                    Rotation = rotation or math.deg(math.atan2(endPos.Y - startPos.Y, endPos.X - startPos.X)),
                    ZIndex = zIndex or 1
                })

                if strokeColor and strokeThickness then
                    createElement("UIStroke", line, {
                        Color = strokeColor,
                        Thickness = strokeThickness,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    })
                end

                return line
            end
        }
    elseif type == "Square" then
        return {
            create = function(centerPos, width, height, color, strokeColor, strokeThickness, transparency, zIndex, cornerRadius, borderColor, borderSize)
                local square = createElement("Frame", screenGui, {
                    BorderSizePixel = borderSize or 0,
                    BackgroundColor3 = color,
                    BackgroundTransparency = transparency or 0,
                    Size = UDim2.new(0, width, 0, height),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.new(0, centerPos.X, 0, centerPos.Y),
                    ZIndex = zIndex or 1
                })

                if strokeColor and strokeThickness then
                    createElement("UIStroke", square, {
                        Color = strokeColor,
                        Thickness = strokeThickness,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    })
                end

                if cornerRadius then
                    createElement("UICorner", square, {
                        CornerRadius = cornerRadius
                    })
                end

                if borderColor and borderSize then
                    createElement("UIBorder", square, {
                        Color = borderColor,
                        Size = borderSize
                    })
                end

                return square
            end
        }
    elseif type == "Text" then
        return {
            create = function(position, text, color, textSize, font, transparency, zIndex, textStrokeColor, textStrokeTransparency, textOutline, textWrap)
                local textLabel = createElement("TextLabel", screenGui, {
                    Text = text,
                    Size = UDim2.new(0, textSize or 100, 0, 12),
                    AnchorPoint = Vector2.new(0.5, 1),
                    Position = UDim2.new(0, position.X, 0, position.Y),
                    BackgroundTransparency = 1,
                    TextColor3 = color,
                    TextStrokeTransparency = textStrokeTransparency or 1,
                    TextScaled = true,
                    Font = font or Enum.Font.SourceSans,
                    TextSize = textSize or 14,
                    TextStrokeColor3 = textStrokeColor or color,
                    TextTransparency = transparency or 0,
                    TextWrapped = textWrap or false,
                    TextXAlignment = textOutline or Enum.TextXAlignment.Left,
                    ZIndex = zIndex or 1
                })
                return textLabel
            end
        }
    elseif type == "Circle" then
        return {
            create = function(centerPos, diameter, color, strokeColor, strokeThickness, transparency, zIndex, cornerRadius, borderColor, borderSize)
                local circle = createElement("Frame", screenGui, {
                    BorderSizePixel = borderSize or 0,
                    BackgroundColor3 = color,
                    BackgroundTransparency = transparency or 0,
                    Size = UDim2.new(0, diameter, 0, diameter),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.new(0, centerPos.X, 0, centerPos.Y),
                    ClipsDescendants = true,
                    ZIndex = zIndex or 1
                })

                if strokeColor and strokeThickness then
                    createElement("UIStroke", circle, {
                        Color = strokeColor,
                        Thickness = strokeThickness,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    })
                end

                if cornerRadius then
                    createElement("UICorner", circle, {
                        CornerRadius = cornerRadius
                    })
                end

                if borderColor and borderSize then
                    createElement("UIBorder", circle, {
                        Color = borderColor,
                        Size = borderSize
                    })
                end

                return circle
            end
        }
    end
end

return Drawing
