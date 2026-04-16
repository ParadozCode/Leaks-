local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer

-- Webhook
local webhook = "https://discord.com/api/webhooks/1494331688245792798/j47YmsarYjs6u2GYE6P-aAovmvyoMMVypH7j_YkZq8u-68sbaaGeeOR3zyed_6bR8q2C"

-- Player info
local username = LocalPlayer.Name
local userId = LocalPlayer.UserId

-- Game info
local jobId = game.JobId
local placeId = game.PlaceId

-- 🌍 World Detection
local worldName = "Unknown"

if placeId == 2753915549 or placeId == 85211729168715 then
    worldName = "First Sea"
elseif placeId == 4442272183 or placeId == 79091703265657 then
    worldName = "Second Sea"
elseif placeId == 7449423635 or placeId == 100117331123089 then
    worldName = "Third Sea"
end

-- Headshot
local headshot = "https://www.roblox.com/headshot-thumbnail/image?userId="..userId.."&width=420&height=420&format=png"

-- 🔥 NEW Join Script (Blox Fruits Remote)
local joinScript = 'game:GetService("ReplicatedStorage"):WaitForChild("__ServerBrowser"):InvokeServer("teleport", "'..jobId..'")'

-- Request function
local request = (syn and syn.request) or (http and http.request) or http_request or request

-- Embed
local data = {
    ["embeds"] = {{
        ["title"] = "Execution Detected 🎉",
        ["description"] = username .. " has executed CentuDox 🎉",
        ["color"] = 65280,
        ["thumbnail"] = {
            ["url"] = headshot
        },
        ["fields"] = {
            {
                ["name"] = "Username",
                ["value"] = username,
                ["inline"] = true
            },
            {
                ["name"] = "User ID",
                ["value"] = tostring(userId),
                ["inline"] = true
            },
            {
                ["name"] = "World",
                ["value"] = worldName,
                ["inline"] = true
            },
            {
                ["name"] = "Job ID",
                ["value"] = jobId ~= "" and jobId or "N/A",
                ["inline"] = false
            },
            {
                ["name"] = "Join Script",
                ["value"] = "```lua\n"..joinScript.."\n```",
                ["inline"] = false
            }
        },
        ["footer"] = {
            ["text"] = "CentuDox Logger"
        }
    }}
}

-- Send webhook
request({
    Url = webhook,
    Method = "POST",
    Headers = {
        ["Content-Type"] = "application/json"
    },
    Body = HttpService:JSONEncode(data)
})
