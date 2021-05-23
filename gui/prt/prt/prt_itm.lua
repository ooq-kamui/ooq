log.scrpt("p.prt_itm.lua")

p.Prt_itm = {}

function p.Prt_itm.init(_s)

	--[[
	_s._nd.tpl.itm = nd._(_s:lb("itm"))
	_s._tpl_itm_pos = nd.pos(_s._nd.tpl.itm)
	nd.enbl__(_s._nd.tpl.itm, _.f)
	
	_s._itm = {}
	_s._nd.itm = {}

	_s._dsp1_itm_idx = 1
	_s._dsp_idx_max  = 1
	_s:dsp1_itm_idx_max__()
	--]]
end

-- method

function p.Prt_itm.itm_clone(_s)
	
	local itm_nd_ar = nd.clone(_s._nd.tpl.itm)
	nd.ar.enbl__(itm_nd_ar, _.t)
	ar.add(_s._nd.itm, itm_nd_ar)
	return itm_nd_ar
end

-- itm

function p.Prt_itm.itm_idx_2_dsp_idx(_s, itm_idx)

	if not _s:is_itm_dsp_by_idx(itm_idx) then return end
	
	local dsp_idx = itm_idx - _s._dsp1_itm_idx + 1
	return dsp_idx
end

function p.Prt_itm.itmE_nd(_s)

	local idxE = #_s._nd.itm
	local itmE_nd = _s._nd.itm[idxE]
	return itmE_nd
end

function p.Prt_itm.itm(_s, itm_idx)

	if not _s._itm or not _s._itm[itm_idx] then return end

	return _s._itm[itm_idx]
end

function p.Prt_itm.itm_nd(_s, itm_idx)

	local t_itm_nd = _s._nd.itm[itm_idx][_s:lb("itm")]
	return t_itm_nd
end

-- itm  plt

function p.Prt_itm.itm__plt_by_idx(_s, itm_idx)
	
	if _s:is_itm_dsp_by_idx(itm_idx) then
		
		_s:itm_pos__by_idx(itm_idx)
		nd.enbl__(_s:itm_nd(itm_idx), _.t)
	else
		nd.enbl__(_s:itm_nd(itm_idx), _.f)
		_s:itm_pos__tpl_by_idx(itm_idx)
	end
end

function p.Prt_itm.itm__plt_anm_by_idx(_s, itm_idx)
	
	if _s:is_itm_dsp_by_idx(itm_idx) then
		
		_s:itm_pos__anm_by_idx(itm_idx)
		nd.enbl__(_s:itm_nd(itm_idx), _.t)
	else
		nd.enbl__(_s:itm_nd(itm_idx), _.f)
		_s:itm_pos__tpl_by_idx(itm_idx)
	end
end

function p.Prt_itm.itm_pos__by_idx(_s, itm_idx)

	local dsp_idx = _s:itm_idx_2_dsp_idx(itm_idx)
	
	local t_pos   = _s:itm_pos_by_dsp_idx(dsp_idx)
	nd.pos__(_s:itm_nd(itm_idx), t_pos)
end

function p.Prt_itm.itm_pos__anm_by_idx(_s, itm_idx)

	local dsp_idx = _s:itm_idx_2_dsp_idx(itm_idx)
	
	local t_pos   = _s:itm_pos_by_dsp_idx(dsp_idx)

	local time = 0.7
	nd.anm.mv(_s:itm_nd(itm_idx), t_pos, nil, time)
	-- nd.pos__anm(_s:itm_nd(itm_idx), t_pos)
end

function p.Prt_itm.itm_pos__tpl_by_idx(_s, itm_idx)
	nd.pos__(_s:itm_nd(itm_idx), _s._tpl_itm_pos)
end

-- dsp

function p.Prt_itm.is_itm_dsp_by_idx(_s, itm_idx)

	local ret = _.f

	if int.is_rng(itm_idx, {_s._dsp1_itm_idx, _s:dspE_itm_idx()}) then
		ret = _.t
	end
	return ret
end

-- itm dsp - alpha 0

function p.Prt_itm.itm_dsp__by_idx(_s, itm_idx, val)
	nd.dsp__(_s:itm_nd(itm_idx), val)
end

