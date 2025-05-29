local HttpService = game:GetService("HttpService")

local key_info_link = "https://keysystem-s10c.onrender.com/keyinfo/"

_G.key_expiration = ""
_G.ip_address = ""
_G.Key = ""
_G.time_left = ""
_G.success = false
_G.blacklisted = false
_G.NoInfoFound = false
_G.system_online = false

function get_info()
	local ipSuccess, ip = pcall(function()
		return game:HttpGet("https://api.ipify.org")
	end)

	if not ipSuccess or not ip or ip == "" then
		warn("Failed to get IP.")
		return false
	end

	local key_info_url = key_info_link .. HttpService:UrlEncode(ip)
	local success, response = pcall(function()
		return game:HttpGet(key_info_url)
	end)

	if not success or not response then
		warn("Failed to fetch key info.")
		return false
	end

	local decodeSuccess, data = pcall(function()
		return HttpService:JSONDecode(response)
	end)

	if not decodeSuccess then
		warn("Failed to decode JSON.")
		return false
	end

	if data.message == "Key system is offline" then
		warn("Key system is offline!")
		_G.system_online = false
		_G.success = false
		return false
	else
		_G.system_online = true
	end

	if data.blacklisted then
		_G.blacklisted = true
		_G.success = false
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
		_G.success = false
	end

	return false
end
