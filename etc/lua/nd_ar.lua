log.script("nd.ar.lua")

nd.ar = {}

function nd.ar.enbl__(p_nd_ar, val)
	
	for key, t_nd in pairs(p_nd_ar) do
		nd.enbl__(t_nd, val)
	end
end

function nd.ar.del(p_nd_ar)
	
	for key, t_nd in pairs(p_nd_ar) do
		nd.del(t_nd)
	end
end
