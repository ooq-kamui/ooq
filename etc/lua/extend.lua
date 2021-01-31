log.scrpt("extend.lua")

extend = {}

function extend._(obj, Cls)
	for key, func in pairs(Cls) do
		if type(func) == "function" then
			obj[key] = func
		end
	end
end

function extend.init(_s, Cls, ...)
	extend._(_s, Cls)
	_s:init(...)
end
