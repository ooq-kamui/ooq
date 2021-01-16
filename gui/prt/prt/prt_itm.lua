log.script("p.prt_itm.lua")

p.Prt_itm = {}

function p.Prt_itm.init(_s)

	_s._nd.tpl.itm = nd._(_s:lb("itm"))
	_s._tpl_itm_pos = nd.pos(_s._nd.tpl.itm)
	nd.enbl__(_s._nd.tpl.itm, _.f)
	
	_s._itm = {}
	_s._nd.itm = {}

	_s._dsp1_itm_idx = 1
	_s._dsp_idx_max  = 1
	_s:dsp1_itm_idx_max__()
end

-- method

function p.Prt_itm.itm__by_ar(_s, p_ar)
	
	_s._itm = p_ar
	_s:dsp1_itm_idx_max__()
end

function p.Prt_itm.itm__by_ar_lim(_s, p_ar)
	
	-- _s._itm = p_ar
	_s._itm = {}
	for idx, val in pairs(p_ar) do

		if idx > 10 then break end
		
		ar.add(_s._itm, val)
	end
	
	_s:dsp1_itm_idx_max__()
end

function p.Prt_itm.itm__by_idx(_s, prefix, idx_max)

	for idx = 1, idx_max do
		ar.add(_s._itm, prefix..int.pad(idx))
	end
	
	_s:dsp1_itm_idx_max__()
end

function p.Prt_itm.itm_clone(_s)
	
	local itm_nd_ar = nd.clone(_s._nd.tpl.itm)
	nd.ar.enbl__(itm_nd_ar, _.t)
	ar.add(_s._nd.itm, itm_nd_ar)
	return itm_nd_ar
end

-- itm

function p.Prt_itm.itm__add(_s, itm)
	-- log._("prt_itm itm__add", itm)

	ar.add(_s._itm, itm)
	local itm_nd_ar = _s:itm_clone()
	return itm_nd_ar
end

function p.Prt_itm.itm__del_1(_s)
	log.pp("prt itm itm del_1 _s._nd.itm", _s._nd.itm)

	local t_itm_nd = _s._nd.itm[1][_s:lb("itm")]
	
	local anm = {}
	anm[1] = function ()
		-- log._("anm 1")
		nd.anm.fade__o(t_itm_nd, nil, anm[2])
	end
	anm[2] = function ()
		-- log._("anm 2")
		nd.del(t_itm_nd)
		ar.del_1(_s._nd.itm)
		ar.del_1(_s._itm)
		
		if #_s._itm == 0 then
			_s:clz()
		else
			_s:itm__plt_anm()
		end
	end
	anm[1]()
end

function p.Prt_itm.dsp_idx_by_itm_idx(_s, itm_idx) -- alias
	_s:itm_idx_2_dsp_idx(itm_idx)
end

function p.Prt_itm.itm_idx_2_dsp_idx(_s, itm_idx)

	if not _s:is_itm_dsp_by_idx(itm_idx) then return end
	
	local dsp_idx = itm_idx - _s._dsp1_itm_idx + 1
	return dsp_idx
end

function p.Prt_itm.itm_idx_max(_s)
	return #_s._nd.itm
end

function p.Prt_itm.itm_idx_max__(_s)
	_s._itm_idx_max = #_s._nd.itm
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
	-- log._("itm_nd", itm_idx)
	local t_itm_nd = _s._nd.itm[itm_idx][_s:lb("itm")]
	return t_itm_nd
end

-- itm  plt

function p.Prt_itm.itm__plt_anm(_s)
	_s:itm__plt()
end

function p.Prt_itm.itm__plt(_s)

	for itm_idx, dmy in pairs(_s._nd.itm) do
		_s:itm__plt_by_idx(itm_idx)
	end
end

function p.Prt_itm.itm__plt_by_idx(_s, itm_idx)
	
	if _s:is_itm_dsp_by_idx(itm_idx) then
		
		_s:itm_pos__by_idx(itm_idx)
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

function p.Prt_itm.itm_pos__tpl_by_idx(_s, itm_idx)
	nd.pos__(_s:itm_nd(itm_idx), _s._tpl_itm_pos)
end

-- dsp

function p.Prt_itm.dspE_itm_idx(_s)
	local dspE_itm_idx = _s._dsp1_itm_idx + _s._dsp_idx_max - 1
	return dspE_itm_idx
end

function p.Prt_itm.dsp_itm_rng(_s)
	local dsp_itm_rng = {_s._dsp1_itm_idx, _s:dspE_itm_idx()}
	return dsp_itm_rng
end

function p.Prt_itm.is_itm_dsp_by_idx(_s, itm_idx)
	local ret = _.f
	if int.is_rng(itm_idx, {_s._dsp1_itm_idx, _s:dspE_itm_idx()}) then
		ret = _.t
	end
	-- log._("prt itm is_itm_dsp_by_idx", itm_idx, ret)
	return ret
end

function p.Prt_itm.dsp1_itm_idx_max__(_s)

	if not _s._itm then return end

	_s._dsp1_itm_idx_max = #_s._itm - _s._dsp_idx_max + 1
end

function p.Prt_itm.is_dsp_itm_1(_s)
	local ret = _.f
	if _s._dsp1_itm_idx == 1 then
		ret = _.t
	end
	return ret
end

function p.Prt_itm.is_dsp_itm_E(_s)
	local ret = _.f
	if _s._dsp1_itm_idx == _s._dsp1_itm_idx_max then
		ret = _.t
	end
	return ret
end

-- itm dsp - alpha 0

function p.Prt_itm.itm_dsp__x(_s)
	_s:itm_dsp__(_.t)
end

function p.Prt_itm.itm_dsp__x(_s)
	_s:itm_dsp__(_.f)
end

function p.Prt_itm.itm_dsp__(_s, val)
	
	for itm_idx, dmy in pairs(_s._nd.itm) do
		_s:itm_dsp__by_idx(itm_idx, val)
	end
end

function p.Prt_itm.itm_dsp__by_idx(_s, itm_idx, val)
	nd.dsp__(_s:itm_nd(itm_idx), val)
end
