if (shared.cdrawingLib) then
    return shared.cdrawingLib
end

local RunService = game:GetService('RunService')
local TweenService = game:GetService('TweenService')
local UserInputService = game:GetService('UserInputService')

local cdrawingLib = {}
local cdrawingLibPrivate = {}
local screenGUIs = {}

local Maid = loadstring(game:HttpGet('https://raw.githubusercontent.com/Aztup/Aztup-Hub-V3-Utils/main/Maid.lua'))()
local Signal = loadstring(game:HttpGet('https://raw.githubusercontent.com/Aztup/Aztup-Hub-V3-Utils/main/Signal.lua'))()

cdrawingLib.cdrawingLib = true

do -- // Utils
    function cdrawingLib:ConvertToOffset(childSize, parentSize)
        local scaleX = childSize.X.Scale
        local scaleY = childSize.Y.Scale

        local x = scaleX == 0 and childSize.X.Offset or scaleX * parentSize.X.Offset + childSize.X.Offset
        local y = scaleY == 0 and childSize.Y.Offset or scaleY * parentSize.Y.Offset + childSize.Y.Offset

        return Vector2.new(x, y)
    end

    function cdrawingLib:ConvertToDarkColor(color)
        local h, s, v = Color3.toHSV(color)
        v = math.clamp(v - 0.1, 0, 1)

        return Color3.fromHSV(h, s, v)
    end

    function cdrawingLib:ConvertToLightColor(color)
        local h, s, v = Color3.toHSV(color)
        v = math.clamp(v + 0.1, 0, 1)

        return Color3.fromHSV(h, s, v)
    end
end

do -- // Validations
    cdrawingLib.Validations = {}

    function cdrawingLib.Validations:Parent(value)
        if (typeof(value) ~= 'Instance' and value ~= nil and value ~= self) then
            return string.format('invalid argument #1 (Instance expected, got %s)', typeof(value))
        end

        if (value) then
            if (not table.find(value._childrens, self)) then
                table.insert(value._childrens, self)
            end
        elseif (self._props.Parent) then
            table.remove(self._props.Parent._childrens, table.find(self._props.Parent._childrens, self))
        end

        if (not self:IsA('ScreenGui')) then
            self._drawing.Visible = not not value
        end
    end

    function cdrawingLib.Validations:Visible(value)
        if (typeof(value) ~= 'boolean') then
            return string.format('invalid argument #1 (boolean expected, got %s)', typeof(value))
        end
    end

    function cdrawingLib.Validations:Size(value)
        if (typeof(value) ~= 'UDim2') then
            return string.format('invalid argument #1 (UDim2 expected, got %s)', typeof(value))
        end

        local parentSize = self._props.Parent and self._props.Parent.AbsoluteSize
        if (not parentSize) then return end

        local mySize = cdrawingLib:ConvertToOffset(value, UDim2.new(0, parentSize.X, 0, parentSize.Y))

        self._drawing.Size = mySize
        self._props.AbsoluteSize = mySize
    end

    function cdrawingLib.Validations:BackgroundColor3(value)
        if (typeof(value) ~= 'Color3') then
            return string.format('invalid argument #1 (Color3 expected, got %s)', typeof(value))
        end

        self._drawing.Color = value
    end

    function cdrawingLib.Validations:BackgroundTransparency(value)
        if (typeof(value) ~= 'number') then
            return string.format('invalid argument #1 (number expected, got %s)', typeof(value))
        end

        self._drawing.Transparency = 1 - value
    end

    function cdrawingLib.Validations:Position(value)
        if (typeof(value) ~= 'UDim2') then
            return string.format('invalid argument #1 (UDim2 expected, got %s)', typeof(value))
        end

        local parentSize = self._props.Parent and self._props.Parent.AbsoluteSize
        if (not parentSize) then return end

        local myPosition = cdrawingLib:ConvertToOffset(value, UDim2.new(0, parentSize.X, 0, parentSize.Y))
        local mySize = self._props.AbsoluteSize

        local anchorPoint = self._props.AnchorPoint
        myPosition = Vector2.new(myPosition.X - mySize.X * (1 - (1 - anchorPoint.X)), myPosition.Y - mySize.Y * (1 - (1 - anchorPoint.Y)))
        myPosition = myPosition + self._props.Parent.AbsolutePosition

        self._drawing.Position = myPosition
        self._props.AbsolutePosition = myPosition

        local borderSize = Vector2.new(self._props.BorderSizePixel, self._props.BorderSizePixel)

        self._border.Position = myPosition - borderSize / 2
        self._border.Size = self._props.AbsoluteSize + borderSize

        if (self:IsA('TextLabel') or self:IsA('TextButton') or self:IsA('TextBox')) then
            local alignmentX = self._props.TextXAlignment
            local alignmentY = self._props.TextYAlignment

            local textSize = self._text.TextBounds
            local frameSize = self._props.AbsoluteSize
            local textPosition = myPosition

            if (alignmentX == Enum.TextXAlignment.Center) then
                textPosition = textPosition + frameSize / 2 - Vector2.new(0, textSize.Y / 2)
            elseif (alignmentX == Enum.TextXAlignment.Right) then
                textPosition = textPosition + Vector2.new(frameSize.X, frameSize.Y / 2) - textSize / 2
            elseif (alignmentX == Enum.TextXAlignment.Left) then
                textPosition = textPosition + Vector2.new(0, frameSize.Y / 2) - textSize / 2
            end

            -- Add alignment for Y as needed
            if (alignmentY == Enum.TextYAlignment.Center) then
                textPosition = textPosition + Vector2.new(textSize.X / 2, 0) - Vector2.new(textSize.X / 2, textSize.Y / 2)
            elseif (alignmentY == Enum.TextYAlignment.Bottom) then
                textPosition = textPosition + Vector2.new(0, frameSize.Y) - textSize
            end

            self._text.Position = textPosition
        end
    end
end

-- Additional implementation details for drawing elements go here

shared.cdrawingLib = cdrawingLib
return cdrawingLib
