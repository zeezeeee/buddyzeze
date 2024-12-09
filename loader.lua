-- Get the key passed in the loader
local key = getgenv().key  -- The key provided by the user in the main script

-- List of valid keys
local validKeys = {
    "key1", "key2", "key3"  -- Replace with your valid keys
}

-- Function to check if the provided key is valid
function isValidKey(key)
    for _, validKey in ipairs(validKeys) do
        if key == validKey then
            return true
        end
    end
    return false
end

-- Check if the key is valid
if isValidKey(key) then
    print("Hi")  -- If valid, print "Hi"
    -- Insert the rest of your loader script here (after validation)
    -- Example: load the full script that the loader would execute
    -- loadstring(game:HttpGet("https://some-script-url.com"))()
else
    print("No")  -- If invalid, print "No"
end
