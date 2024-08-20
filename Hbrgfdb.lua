local Spawn = {}

local function createBaseDrawingElement(elementType, properties)
    local element = {}

    for property, value in pairs(properties) do
        element[property] = value
    end

    element._frame = Instance.new("Frame")
    element._frame.Parent = element.parent
    element._frame.AnchorPoint = Vector2.new(0.5, 0.5)
    element._frame.BorderSizePixel = 0

    element._stroke = Instance.new("UIStroke")
    element._stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    element._stroke.Parent = element._frame

    -- Handle property changes and auto-update
    setmetatable(element, {
        __index = function(tbl, key)
            return rawget(tbl, key) or tbl._frame[key]
        end,
        __newindex = function(tbl, key, value)
            rawset(tbl, key, value)

            if key == "startPos" or key == "endPos" then
                tbl._frame.Size = UDim2.new(0, (tbl.startPos - tbl.endPos).Magnitude, 0, tbl.thickness)
                tbl._frame.Position = UDim2.new(0, (tbl.startPos + tbl.endPos).X / 2, 0, (tbl.startPos + tbl.endPos).Y / 2)
                tbl._frame.Rotation = math.deg(math.atan2(tbl.endPos.Y - tbl.startPos.Y, tbl.endPos.X - tbl.startPos.X))
            elseif key == "centerPos" then
                tbl._frame.Position = UDim2.new(0, tbl.centerPos.X, 0, tbl.centerPos.Y)
            elseif key == "width" or key == "height" or key == "diameter" then
                tbl._frame.Size = UDim2.new(0, tbl.width or tbl.diameter, 0, tbl.height or tbl.diameter)
            elseif key == "color" then
                tbl._frame.BackgroundColor3 = tbl.color
            elseif key == "backgroundTransparency" then
                tbl._frame.BackgroundTransparency = tbl.backgroundTransparency
            elseif key == "strokeColor" then
                tbl._stroke.Color = tbl.strokeColor
            elseif key == "strokeThickness" then
                tbl._stroke.Thickness = tbl.strokeThickness
            elseif key == "strokeEnabled" then
                tbl._stroke.Enabled = tbl.strokeEnabled
            elseif key == "cornerRadius" then
                if tbl._cornerRadius then
                    tbl._cornerRadius.CornerRadius = UDim.new(tbl.cornerRadius, 0)
                end
            end
        end
    })

    return element
end

function Spawn.new(type)
    if type == "Line" then
        return createBaseDrawingElement("Line", {
            startPos = Vector2.new(),
            endPos = Vector2.new(),
            thickness = 1,
            color = Color3.new(1, 1, 1),
            backgroundTransparency = 0,
            strokeColor = Color3.new(1, 1, 1),
            strokeThickness = 1,
            strokeEnabled = true,
            parent = nil
        })
    elseif type == "Square" then
        return createBaseDrawingElement("Square", {
            centerPos = Vector2.new(),
            width = 100,
            height = 100,
            color = Color3.new(1, 1, 1),
            backgroundTransparency = 0,
            strokeColor = Color3.new(0, 0, 0),
            strokeThickness = 1,
            strokeEnabled = true,
            parent = nil
        })
    elseif type == "Text" then
        local textElement = createBaseDrawingElement("Text", {
            position = Vector2.new(),
            text = "",
            color = Color3.new(1, 1, 1),
            parent = nil
        })
        textElement._frame = Instance.new("TextLabel")
        textElement._frame.BackgroundTransparency = 1
        textElement._frame.TextScaled = true
        textElement._frame.TextWrapped = true
        textElement._frame.AnchorPoint = Vector2.new(0.5, 1)
        return textElement
    elseif type == "Circle" then
        local circleElement = createBaseDrawingElement("Circle", {
            centerPos = Vector2.new(),
            diameter = 100,
            color = Color3.new(1, 1, 1),
            backgroundTransparency = 0,
            strokeColor = Color3.new(0, 0, 0),
            strokeThickness = 1,
            strokeEnabled = true,
            cornerRadius = 0.5,
            parent = nil
        })
        local cornerRadius = Instance.new("UICorner")
        cornerRadius.CornerRadius = UDim.new(0.5, 0)
        cornerRadius.Parent = circleElement._frame
        circleElement._cornerRadius = cornerRadius
        return circleElement
    end
end

return Spawn
