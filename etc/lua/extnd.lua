log.scrpt("extnd.lua")

extnd = {}

function extnd._(obj, Cls)
	for key, func in pairs(Cls) do
		if type(func) == "function" then
			obj[key] = func
		end
	end
end

function extnd.init(_s, Cls, ...)
	extnd._(_s, Cls)
	_s:init(...)
end
