local HttpService = game:GetService("HttpService")

local key_info_link = "https://keysystem-s10c.onrender.com/keyinfo/"

_G.key_expiration = ""
_G.ip_address = ""
_G.Key = ""
_G.time_left = ""
_G.success = false

function get_info()
    local ipSuccess, ip = pcall(function()
		return game:HttpGet("https://api.ipify.org")
	end)

    if not ipSuccess or not ip or ip == "" then
		print("Failed to get User Info. Please contact owner!")
		return false
	end

    local key_info = key_info_link .. HttpService:UrlEncode(ip)
    
    local success, response = pcall(function()
        return game:HttpGet(key_info)
    end)

    if success and response then
		local data = HttpService:JSONDecode(response)
		if data.success == true then
			_G.key_expiration = data.expiration
            _G.ip_address = data.ip_address
            _G.Key = data.key
            _G.time_left = data.time_left
            _G.success = data.success
			return true
		else
			print("Failed to get Data. Please contact owner!")
		end
	else
		print("Failed to access Data. Please contact owner!")
	end

	return false
end

get_info()
