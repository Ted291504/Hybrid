local HttpService = game:GetService("HttpService")

local key_info_link = "https://keysystem-s10c.onrender.com/keyinfo/"

_G.key_expiration = ""
_G.ip_address = ""
_G.Key = ""
_G.time_left = ""
_G.success = false
_G.blacklisted = false
_G.NoInfoFound = false
function get_info()
    local ipSuccess, ip = pcall(function()
        return game:HttpGet("https://api.ipify.org")
    end)

    if not ipSuccess or not ip or ip == "" then
        warn("Failed to get User Info. Please contact owner!")
        return false
    end

    local key_info_url = key_info_link .. HttpService:UrlEncode(ip)
    local success, response = pcall(function()
        return game:HttpGet(key_info_url)
    end)

    if not success or not response then
        warn("Failed to fetch key info. Please contact owner!")
        return false
    end

    local data
    local decodeSuccess, decodeResult = pcall(function()
        return HttpService:JSONDecode(response)
    end)

    if not decodeSuccess then
        warn("Failed to decode JSON response!")
        return false
    end

    data = decodeResult

    if data.blacklisted then
        _G.blacklisted = true
        return false
    end

    if data.success then
        _G.key_expiration = data.expiration or ""
        _G.ip_address = data.ip_address or ""
        _G.Key = data.key or ""
        _G.time_left = data.time_left or ""
        _G.success = true
        return true
    else
        _G.NoInfoFound = true
    end

    return false
end
