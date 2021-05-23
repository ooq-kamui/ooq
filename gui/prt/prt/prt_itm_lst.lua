log.scrpt("p.prt_itm_lst.lua")

p.Prt_itm_lst = {}

function p.Prt_itm_lst.init(_s)

	extnd.init(_s, p.Prt_itm)
	extnd._(   _s, p.Prt_itm_lst)

	_s._nd.tpl.itm = nd._(_s:lb("itm"))
	_s._tpl_itm_pos = nd.pos(_s._nd.tpl.itm)
	nd.enbl__(_s._nd.tpl.itm, _.f)

	_s._itm = {}
	_s._nd.itm = {}

	_s._dsp1_itm_idx = 1
	_s._dsp_idx_max  = 1
	_s:dsp1_itm_idx_max__()

	_s._itm_scrl_dir = "v"
end

function p.Prt_itm_lst.itm__by_ar(_s, p_ar)
	
	_s._itm = p_ar
	_s:dsp1_itm_idx_max__()
end

function p.Prt_itm_lst.itm__by_ar_lim(_s, p_ar)
	
	-- _s._itm = p_ar
	_s._itm = {}
	for idx, val in pairs(p_ar) do

		if idx > 10 then break end
		
		ar.add(_s._itm, val)
	end
	
	_s:dsp1_itm_idx_max__()
end

function p.Prt_itm_lst.itm__by_idx(_s, prefix, idx_max)

	for idx = 1, idx_max do
		ar.add(_s._itm, prefix..int.pad(idx))
	end
	
	_s:dsp1_itm_idx_max__()
end

function p.Prt_itm_lst.itm_idx_max(_s)

	return #_s._nd.itm
end

function p.Prt_itm_lst.itm_idx_max__(_s)

	_s._itm_idx_max = #_s._nd.itm
end

function p.Prt_itm_lst.itm_scrl(_s, inc_dir)
	-- log._("prt itm_scrl", _s._dsp1_itm_idx, _s._dsp1_itm_idx_max)

	if     inc_dir == "inc" then
		_s._dsp1_itm_idx = int.inc_stop(_s._dsp1_itm_idx, _s._dsp1_itm_idx_max)

	elseif inc_dir == "dec" then
		_s._dsp1_itm_idx = int.dec_stop(_s._dsp1_itm_idx, _s._dsp1_itm_idx_max)
	end

	_s:itm__plt_anm()
	Se.pst_ply("cursor__mv")
end

function p.Prt_itm_lst.itm_pos_by_dsp_idx(_s, dsp_idx)
	
	local x, y, t_pos
	
	if     _s._itm_scrl_dir == "v" then
		y = - u.x_by_itm_w(dsp_idx, _s._dsp_idx_max, _s._itm_pitch)
		t_pos = n.vec(_s._tpl_itm_pos.x,                 y)

	elseif _s._itm_scrl_dir == "h" then
		x =   u.x_by_itm_w(dsp_idx, _s._dsp_idx_max, _s._itm_pitch)
		t_pos = n.vec(                x, _s._tpl_itm_pos.y)
	end
	return t_pos
end

--

function p.Prt_itm_lst.itm__plt_anm(_s, dsp1_itm_idx)

	_s:itm__plt(dsp1_itm_idx)
end

function p.Prt_itm_lst.itm__plt(_s, dsp1_itm_idx)

	local dsp_idx

	if dsp1_itm_idx then
		dsp_idx = _s:dsp1_itm_idx__(dsp1_itm_idx)
	end

	for itm_idx, dmy in pairs(_s._nd.itm) do
		_s:itm__plt_by_idx(itm_idx)
	end

	return dsp_idx
end

-- dsp

function p.Prt_itm_lst.dspE_itm_idx(_s)

	local dspE_itm_idx = _s._dsp1_itm_idx + _s._dsp_idx_max - 1
	return dspE_itm_idx
end

function p.Prt_itm_lst.dsp_itm_rng(_s) -- use not ?

	local dsp_itm_rng = {_s._dsp1_itm_idx, _s:dspE_itm_idx()}
	return dsp_itm_rng
end

function p.Prt_itm_lst.dsp1_itm_idx_max(_s)

	return _s._dsp1_itm_idx_max
end

function p.Prt_itm_lst.dsp1_itm_idx_max__(_s)

	if not _s._itm then return end

	_s._dsp1_itm_idx_max = #_s._itm - _s._dsp_idx_max + 1
end

function p.Prt_itm_lst.is_dsp_itm_1(_s)

	local ret = _.f

	if _s._dsp1_itm_idx == 1 then
		ret = _.t
	end
	return ret
end

function p.Prt_itm_lst.is_dsp_itm_E(_s)

	local ret = _.f

	if _s._dsp1_itm_idx == _s._dsp1_itm_idx_max then
		ret = _.t
	end
	return ret
end

function p.Prt_itm_lst.dsp1_itm_idx__(_s, p_itm_idx)
	-- log._("p.Prt_itm_lst.dsp1_itm_idx__", p_itm_idx, _s._dsp1_itm_idx_max)

	local dsp_idx

	if p_itm_idx > _s._dsp1_itm_idx_max then

		dsp_idx = p_itm_idx - _s._dsp1_itm_idx_max + 1

		p_itm_idx = _s._dsp1_itm_idx_max
	else
		dsp_idx = 1
	end
	-- log._("p.Prt_itm_lst.dsp1_itm_idx__", p_itm_idx, _s._dsp1_itm_idx_max, dsp_idx)

	_s._dsp1_itm_idx = p_itm_idx

	return dsp_idx
end

-- itm dsp - alpha 0

function p.Prt_itm_lst.itm_dsp__x(_s)
	_s:itm_dsp__(_.t)
end

function p.Prt_itm_lst.itm_dsp__x(_s)
	_s:itm_dsp__(_.f)
end

function p.Prt_itm_lst.itm_dsp__(_s, val)
	
	for itm_idx, dmy in pairs(_s._nd.itm) do
		_s:itm_dsp__by_idx(itm_idx, val)
	end
end

-- use fr msg

function p.Prt_itm_lst.itm__add(_s, itm)

	ar.add(_s._itm, itm)
	local itm_nd_ar = _s:itm_clone()
	return itm_nd_ar
end

function p.Prt_itm_lst.itm__del_1(_s)

	local t_itm_nd = _s._nd.itm[1][_s:lb("itm")]
	
	local anm = {}
	anm[1] = function ()
		nd.anm.fade__o(t_itm_nd, nil, anm[2])
	end
	anm[2] = function ()
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

