-- DrawingsModule.lua
local Drawings = {}

local function createSquare(properties)
    local square = Instance.new("Frame")
    square.BackgroundColor3 = properties.Color
    square.BackgroundTransparency = properties.BackgroundTransparency
    square.Size = UDim2.new(0, properties.Size.X, 0, properties.Size.Y)
    square.AnchorPoint = properties.AnchorPoint
    square.Position = UDim2.new(0, properties.Position.X, 0, properties.Position.Y)
    square.Rotation = properties.Rotation
    square.ClipsDescendants = properties.ClipsDescendants
    square.Visible = properties.Visible

    local stroke = Instance.new("UIStroke")
    stroke.Color = properties.StrokeColor
    stroke.Thickness = properties.StrokeThickness
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = square

    return square
end

function Drawings.new(type)
    local instance = {}
    local properties = {
        Color = Color3.fromRGB(255, 255, 255),
        Position = Vector2.new(0, 0),
        Size = Vector2.new(100, 100),
        StrokeColor = Color3.fromRGB(0, 0, 0),
        StrokeThickness = 1,
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Rotation = 0,
        ClipsDescendants = true,
        Visible = true,
        Parent = nil,
        BorderColor = Color3.fromRGB(0, 0, 0),
        BorderSize = 1,
        Transparency = 0,
        ZIndex = 1
    }

    if type == "Square" then
        local mt = {
            __index = function(tbl, key)
                return properties[key]
            end,
            __newindex = function(tbl, key, value)
                if properties[key] ~= nil then
                    properties[key] = value
                    if key == "Parent" and properties[key] then
                        local frame = createSquare(properties)
                        frame.Parent = properties[key]
                        tbl.Frame = frame
                    elseif tbl.Frame then
                        local frame = tbl.Frame
                        if key == "Color" then
                            frame.BackgroundColor3 = value
                        elseif key == "Position" then
                            frame.Position = UDim2.new(0, value.X, 0, value.Y)
                        elseif key == "Size" then
                            frame.Size = UDim2.new(0, value.X, 0, value.Y)
                        elseif key == "StrokeColor" then
                            local stroke = frame:FindFirstChildOfClass("UIStroke")
                            if stroke then
                                stroke.Color = value
                            end
                        elseif key == "StrokeThickness" then
                            local stroke = frame:FindFirstChildOfClass("UIStroke")
                            if stroke then
                                stroke.Thickness = value
                            end
                        elseif key == "AnchorPoint" then
                            frame.AnchorPoint = value
                        elseif key == "BackgroundTransparency" then
                            frame.BackgroundTransparency = value
                        elseif key == "Rotation" then
                            frame.Rotation = value
                        elseif key == "ClipsDescendants" then
                            frame.ClipsDescendants = value
                        elseif key == "Visible" then
                            frame.Visible = value
                        elseif key == "Transparency" then
                            frame.BackgroundTransparency = value
                        elseif key == "ZIndex" then
                            frame.ZIndex = value
                        end
                    end
                end
            end
        }
        setmetatable(instance, mt)
    end

    return instance
end

return Drawings
