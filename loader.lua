local http = game:GetService("HttpService")
local key = getgenv().key -- Fetch the assigned key from getgenv()
local userHwid = game:GetService("Players").LocalPlayer.UserId -- Example of HWID, you can replace it with actual HWID logic
local webhook_url = "https://discord.com/api/webhooks/1315519394700464149/NQDBoAYSWFeKh8b9HpCaYvEk3sz5sOWEtCRp6UlfgoYee8OfvJm3Nb-jN9wSLmy37-Gl"

-- List of valid keys
local validKeys = {
    "key1",
    "key2",
    "key3"
}

-- Function to validate if the key is valid
local function isKeyValid(userKey)
    for _, validKey in pairs(validKeys) do
        if validKey == userKey then
            return true
        end
    end
    return false
end

-- Function to send data to the Discord webhook
local function sendToWebhook(key, hwid)
    local data = {
        content = nil,
        embeds = {
            {
                description = "User has loaded the script. Here is the key and HWID:\n```" .. key .. "``` \nHWID: " .. hwid,
                color = 6554885,
                author = {
                    name = "Whitelisted User"
                }
            }
        },
        attachments = {}
    }
    
    local jsonData = http:JSONEncode(data)
    http:PostAsync(webhook_url, jsonData, Enum.HttpContentType.ApplicationJson)
end

-- Validate the key and proceed
if isKeyValid(key) then
    print("Hi, the key is valid.")
    sendToWebhook(key, userHwid) -- Send the key and HWID to the webhook
else
    print("Invalid key.")
end
