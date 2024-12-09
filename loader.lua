local http = game:GetService("HttpService")
local key = "" -- This should be provided by the user or script execution context

-- Discord webhook URL
local webhook_url = "https://discord.com/api/webhooks/1315519394700464149/NQDBoAYSWFeKh8b9HpCaYvEk3sz5sOWEtCRp6UlfgoYee8OfvJm3Nb-jN9wSLmy37-Gl"

-- List of valid keys (add more keys as needed)
local validKeys = {
    "key1",
    "key2",
    "key3"
}

-- Function to validate key
local function isKeyValid(userKey)
    for _, validKey in pairs(validKeys) do
        if validKey == userKey then
            return true
        end
    end
    return false
end

-- Function to send webhook data
local function sendToWebhook(key, hwid)
    local data = {
        content = nil,
        embeds = {
            {
                description = "User has loaded the script. Here is the key and HWID:\n```" .. key .. "``` \nHWID: " .. hwid,
                color = 6554885,
                author = {
                    name = "Loader"
                }
            }
        }
    }

    local jsonData = http:JSONEncode(data)
    
    -- Send the data to the webhook
    http:PostAsync(webhook_url, jsonData, Enum.HttpContentType.ApplicationJson)
end

-- Main logic
if isKeyValid(key) then
    print("hi") -- Print "hi" if the key is valid
    local hwid = game:GetService("RbxAnalyticsService"):GetClientId()
    sendToWebhook(key, hwid) -- Send the key and HWID to the webhook
else
    print("invalid") -- Print "invalid" if the key is invalid
end
