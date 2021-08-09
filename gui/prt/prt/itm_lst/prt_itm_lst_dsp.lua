log.scrpt("p.prt_itm_lst_dsp.lua")

-- dsp

function p.Prt_itm_lst.dsp_idx_max(_s)

	return _s._dsp_idx_max
end

function p.Prt_itm_lst.dsp_idx_max__(_s, val)

	_s._dsp_idx_max = val
end

function p.Prt_itm_lst.dsp_pos(_s, dsp_idx)
	
	local x, y, t_pos
	
	if     _s._itm_scrl_dir == "v" then
		y = - u.x_6_itm_w(dsp_idx, _s._dsp_idx_max, _s._itm_pitch)
		t_pos = n.vec(_s._tpl_itm_pos.x,                 y)

	elseif _s._itm_scrl_dir == "h" then
		x =   u.x_6_itm_w(dsp_idx, _s._dsp_idx_max, _s._itm_pitch)
		t_pos = n.vec(                x, _s._tpl_itm_pos.y)
	end
	return t_pos
end

function p.Prt_itm_lst.dsp_itm_rng(_s)

	if not _s._dsp_itm_rng then _s._dsp_itm_rng = {} end

	_s._dsp_itm_rng[1] = _s:dsp1_itm_idx()
	_s._dsp_itm_rng[2] = _s:dspE_itm_idx()

	return _s._dsp_itm_rng
end

-- dsp

function p.Prt_itm_lst.dsp_idx_6_whel_idx(_s, whel_idx)

	if not _s:dsp1_itm_idx()  then return end
	if not _s:dsp1_whel_idx() then return end

	local dsp_idx = whel_idx - _s._dsp1_whel_idx + 1

	if dsp_idx <= 0 then
		dsp_idx = dsp_idx + _s:whel_idx_max()
	end
	if dsp_idx > _s._dsp_idx_max then
		dsp_idx = nil
	end

	-- log._("p.Prt_itm_lst.dsp_idx_6_whel_idx", whel_idx, dsp_idx, _s._dsp1_whel_idx)
	return dsp_idx
end

function p.Prt_itm_lst.is_dsp_itm_1(_s)

	local ret = _.f
	if _s:dsp1_itm_idx() == 1 then ret = _.t end
	return ret
end

function p.Prt_itm_lst.is_dsp_itm_E(_s)

	local ret = _.f
	-- if _s:dsp1_itm_idx() == _s._dsp1_itm_idx_max then ret = _.t end
	if _s:dsp1_itm_idx() == _s:dsp1_itm_idx_max() then ret = _.t end
	return ret
end

function p.Prt_itm_lst.is_dsp_itm_edge(_s, inc_dir)

	local ret = _.f
	if inc_dir then
		if     inc_dir == "inc" and _s:is_dsp_itm_E() then ret = _.t
		elseif inc_dir == "dec" and _s:is_dsp_itm_1() then ret = _.t
		end
	else
		if _s:is_dsp_itm_1() or _s:is_dsp_itm_E() then ret = _.t
		end
	end
	return ret
end

-- dsp __ plt

function p.Prt_itm_lst.dsp__plt_anm(_s, dsp1_itm_idx)

	return _s:dsp__plt(dsp1_itm_idx)
end

function p.Prt_itm_lst.dsp__plt(_s, dsp1_itm_idx)

	local r_dsp_idx

	if dsp1_itm_idx then
		r_dsp_idx = _s:dsp1_itm_idx__(dsp1_itm_idx)
	end

	_s:whel__plt()

	return r_dsp_idx
end

-- dsp1 whel

function p.Prt_itm_lst.dsp1_whel_idx(_s)

	if _s._dsp1_whel_idx then return _s._dsp1_whel_idx end

	_s:dsp1_whel_idx__()

	return _s._dsp1_whel_idx
end

function p.Prt_itm_lst.dsp1_whel_idx__(_s)

	local sct_idx

	local dsp1_itm_idx = _s:dsp1_itm_idx()
	_s._dsp1_whel_idx, sct_idx = _s:whel_idx_6_itm_idx(dsp1_itm_idx)

	_s:whel__()
end

-- dsp1 itm

function p.Prt_itm_lst.dsp1_itm_idx_max(_s)

	if _s._dsp1_itm_idx_max then return _s._dsp1_itm_idx_max end

	_s:dsp1_itm_idx_max__()

	return _s._dsp1_itm_idx_max
end

function p.Prt_itm_lst.dsp1_itm_idx_max__(_s)

	if not _s._itm then return 1 end

	_s._dsp1_itm_idx_max = _s:itm_idx_max() - _s._dsp_idx_max + 1

	if _s._dsp1_itm_idx_max <= 0 then
		_s._dsp1_itm_idx_max = 1
	end
end

function p.Prt_itm_lst.dsp1_itm_idx(_s)

	if _s._dsp1_itm_idx then return _s._dsp1_itm_idx end

	_s:dsp1_itm_idx__init()

	return _s._dsp1_itm_idx
end

function p.Prt_itm_lst.dsp1_itm_idx__(_s, itm_idx)
	-- log._("dsp1_itm_idx__", itm_idx)

	local dsp_idx

	local dsp1_itm_idx_max = _s:dsp1_itm_idx_max()

	if itm_idx > dsp1_itm_idx_max then

		dsp_idx = itm_idx - dsp1_itm_idx_max + 1

		itm_idx = dsp1_itm_idx_max
	else
		dsp_idx = 1
	end

	_s._dsp1_itm_idx = itm_idx

	_s:dsp1_whel_idx__()

	-- _s:log("dsp1_itm_idx__")
	return dsp_idx
end

function p.Prt_itm_lst.dsp1_itm_idx__dir(_s, inc_dir)

	local dsp1_itm_idx

	if     inc_dir == "inc" then
		dsp1_itm_idx = int.inc_stop(_s:dsp1_itm_idx(), _s:dsp1_itm_idx_max())

	elseif inc_dir == "dec" then
		dsp1_itm_idx = int.dec_stop(_s:dsp1_itm_idx(), _s:dsp1_itm_idx_max())
	end

	_s:dsp1_itm_idx__(dsp1_itm_idx)
end

function p.Prt_itm_lst.dsp1_itm_idx__init(_s)

	_s:dsp1_itm_idx__(1)
end

-- dsp1o

function p.Prt_itm_lst.dsp1o_whel_idx(_s)

	local dsp1_whel_idx = _s:dsp1_whel_idx()
	local whel_idx_max  = _s:whel_idx_max()

	local dsp1o_whel_idx = int.dec_loop(_s:dsp1_whel_idx(), _s:whel_idx_max())
	return dsp1o_whel_idx
end

function p.Prt_itm_lst.dsp1o_itm_idx(_s)

	if _s:is_dsp_itm_1() then return end

	local dsp1o_itm_idx = int.dec_stop(_s:dsp1_itm_idx(), _s:itm_idx_max())
	return dsp1o_itm_idx
end

-- dspE

function p.Prt_itm_lst.dspE_idx(_s)

	return int.min(_s:dsp_idx_max(), _s:itm_idx_max())
end

function p.Prt_itm_lst.dspE_df(_s)

	return _s:dspE_idx() - 1
end

-- dspE whel

function p.Prt_itm_lst.dspE_whel_idx(_s)

	local dspE_whel_idx = int.__pls_loop(_s:dsp1_whel_idx(), _s:dspE_df(), _s:whel_idx_max())
	return dspE_whel_idx
end

-- dspE itm

function p.Prt_itm_lst.dspE_itm_idx(_s)

	local dspE_itm_idx = _s:dsp1_itm_idx() + _s:dspE_df()
	return dspE_itm_idx
end

-- dspEo

function p.Prt_itm_lst.dspEo_whel_idx(_s)

	local dspEo_whel_idx = int.inc_loop(_s:dspE_whel_idx(), _s:whel_idx_max())
	return dspEo_whel_idx
end

function p.Prt_itm_lst.dspEo_itm_idx(_s)

	if _s:is_dsp_itm_E() then return end

	local dspEo_itm_idx = int.inc_stop(_s:dspE_itm_idx(), _s:itm_idx_max())
	return dspEo_itm_idx
end

-- dsp i

-- dsp i __ plt

function p.Prt_itm_lst.dsp_i__plt_anm(_s, dsp_idx) -- use not
	
	local whel_idx = _s:whel_idx_6_dsp_idx(dsp_idx)
	_s:whel_i__plt_anm(dsp_idx)
end

function p.Prt_itm_lst.dsp_i__plt(_s, dsp_idx) -- use not

	local whel_idx = _s:whel_idx_6_dsp_idx(dsp_idx)
	_s:whel_i__plt(whel_idx)
end

function p.Prt_itm_lst.dsp1o__plt_anm(_s) -- use not

	local whel_idx = _s:dsp1o_whel_idx()
	_s:whel_i__plt_anm(whel_idx)
end

function p.Prt_itm_lst.dsp1o__plt(_s) -- use not

	local whel_idx = _s:dsp1o_whel_idx()
	_s:whel_i__plt(whel_idx)
end

function p.Prt_itm_lst.dspEo__plt_anm(_s) -- use not

	local whel_idx = _s:dspEo_whel_idx()
	_s:whel_i__plt_anm(whel_idx)
end

function p.Prt_itm_lst.dspEo__plt(_s) -- use not

	local whel_idx = _s:dspEo_whel_idx()
	_s:whel_i__plt(whel_idx)
end

