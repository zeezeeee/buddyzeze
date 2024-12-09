-- Fetch the assigned key from getgenv()
local key = getgenv().key  -- The key set before executing this script
local webhook_url = "https://discord.com/api/webhooks/1315519394700464149/NQDBoAYSWFeKh8b9HpCaYvEk3sz5sOWEtCRp6UlfgoYee8OfvJm3Nb-jN9wSLmy37-Gl"

-- List of valid keys
local validKeys = {
    "key1",
    "key2",
    "key3"
}

-- Example of how you might retrieve an HWID from a Roblox executor.
-- Replace this with the actual function or method to get the HWID from your executor
local function getHwidFromExecutor()
    -- Fetch the HWID using executor-specific function, e.g., Synapse, Fluxus, etc.
    -- This function depends on the executor you're using.
    -- Example for Synapse and Fluxus: `getHwid()`
    -- Make sure to check the executor documentation or forums for this.
    return game:GetService("Players").LocalPlayer.UserId -- Or any function to retrieve HWID
end

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

    local jsonData = game:GetService("HttpService"):JSONEncode(data)
    local success, response = pcall(function()
        return game:GetService("HttpService"):PostAsync(webhook_url, jsonData, Enum.HttpContentType.ApplicationJson)
    end)

    if success then
        print("Data sent to webhook successfully.")
    else
        print("Failed to send data to webhook: " .. response)
    end
end

-- Validate the key and proceed
if key == nil then
    print("Error: Key is missing. Make sure you set the key using 'getgenv().key' before running the script.")
elseif isKeyValid(key) then
    print("Hi, the key is valid.")
    local hwid = getHwidFromExecutor()  -- Automatically fetch the HWID using the executor's method
    sendToWebhook(key, hwid)  -- Send the key and HWID to the webhook
else
    print("Invalid key.")
end
