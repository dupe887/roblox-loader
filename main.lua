-- ===== LOADER =====
local WHITELIST = {
    ["Itay"] = "2077-12-31",
    ["Player2"] = "2026-01-01"
}

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local player = Players.LocalPlayer

local function isAllowed()
    local expire = WHITELIST[player.Name]
    if not expire then return false end

    local y, m, d = expire:match("(%d+)-(%d+)-(%d+)")
    if not y then return false end

    return os.time() <= os.time({
        year = tonumber(y),
        month = tonumber(m),
        day = tonumber(d)
    })
end

if not isAllowed() then
    warn("❌ You are not whitelisted or access expired")
    return
end

-- ===== LOAD FROM GITHUB =====
local GITHUB_RAW = "https://raw.githubusercontent.com/USERNAME/REPO/main/main.lua"

local ok, err = pcall(function()
    local source = game:HttpGet(GITHUB_RAW)
    loadstring(source)()
end)

if not ok then
    warn("❌ Failed to load main script:", err)
end
