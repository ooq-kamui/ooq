log.script("p.prt_base.lua")

p.Prt_base = {}

function p.Prt_base.init(_s)

	_s:nd__("base")

	_s:base_dsp_0s__x()
	_s:base_pos__center()
end

function p.Prt_base.base_pos__center(_s)
	local t_pos = Disp.center
	_s:base_pos__(t_pos)
end

function p.Prt_base.base_pos__(_s, p_pos)
	p_pos = p_pos or n.vec()
	nd.pos__(_s._nd.base, p_pos)
end

function p.Prt_base.base_dsp__o(_s, time)
	_s:base_dsp__(_.t, nil, time)
end

function p.Prt_base.base_dsp__x(_s, time)
	_s:base_dsp__(_.f, nil, time)
end

function p.Prt_base.base_dsp__(_s, val, fin, time)
	_s:nd_dsp__("base", val, fin, time)
end

function p.Prt_base.base_dsp_0s__o(_s)
	_s:base_dsp_0s__(_.t)
end

function p.Prt_base.base_dsp_0s__x(_s)
	_s:base_dsp_0s__(_.f)
end

function p.Prt_base.base_dsp_0s__(_s, val)
	_s:nd_dsp_0s__("base", val)
end
