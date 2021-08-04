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

function p.Prt_itm_lst.is_dsp_itm_edge_1(_s)

	local ret = _.f

	if _s:dsp1_itm_idx() == 1 then
		ret = _.t
	end
	return ret
end

function p.Prt_itm_lst.is_dsp_itm_edge_E(_s)

	local ret = _.f

	if _s:dsp1_itm_idx() == _s._dsp1_itm_idx_max then
		ret = _.t
	end
	return ret
end

-- dsp __ plt

function p.Prt_itm_lst.dsp__plt_anm(_s, dsp1_itm_idx)

	return _s:dsp__plt(dsp1_itm_idx)
end

function p.Prt_itm_lst.dsp__plt(_s, dsp1_itm_idx)

	local dsp_idx

	if dsp1_itm_idx then
		dsp_idx = _s:dsp1_itm_idx__(dsp1_itm_idx)
	end

	log._("dsp__plt 1")

	for idx = 1, _s:dsp_idx_max() do
		_s:dsp_i__plt(idx)
	end

	log._("dsp__plt 2")

	_s:dsp1o__plt()
	_s:dspEo__plt()

	return dsp_idx
end

-- dsp1 whel

function p.Prt_itm_lst.dsp1_whel_idx(_s)
	-- log._("p.Prt_itm_lst.dsp1_whel_idx", _s._dsp1_whel_idx)

	if _s._dsp1_whel_idx then return _s._dsp1_whel_idx end

	_s:dsp1_whel_idx__()

	return _s._dsp1_whel_idx
end

function p.Prt_itm_lst.dsp1_whel_idx__(_s)
	-- log._("dsp1_whel_idx__")

	local sct_idx
	local dsp1_itm_idx = _s:dsp1_itm_idx()
	_s._dsp1_whel_idx, sct_idx = _s:whel_idx_6_itm_idx(dsp1_itm_idx)

	_s:whel__()

	-- log.pp("p.Prt_itm_lst.dsp1_whel_idx__", _s._dsp1_whel_idx)
end

-- dsp1 itm

function p.Prt_itm_lst.dsp1_itm_idx_max(_s)
	-- log._("dsp1_itm_idx_max", _s._dsp1_itm_idx_max)

	if _s._dsp1_itm_idx_max then return _s._dsp1_itm_idx_max end

	_s:dsp1_itm_idx_max__()

	return _s._dsp1_itm_idx_max
end

function p.Prt_itm_lst.dsp1_itm_idx_max__(_s)

	-- log.pp("dsp1_itm_idx_max__", _s._itm)

	if not _s._itm then return 1 end

	_s._dsp1_itm_idx_max = _s:itm_idx_max() - _s._dsp_idx_max + 1

	if _s._dsp1_itm_idx_max <= 0 then
		_s._dsp1_itm_idx_max = 1
	end

	-- log._("dsp1_itm_idx_max__", _s._dsp1_itm_idx_max, #_s._itm, _s._dsp_idx_max)
end

function p.Prt_itm_lst.dsp1_itm_idx(_s)

	if _s._dsp1_itm_idx then return _s._dsp1_itm_idx end

	_s:dsp1_itm_idx__init()

	return _s._dsp1_itm_idx
end

function p.Prt_itm_lst.dsp1_itm_idx__(_s, itm_idx) -- mod call whel roll
	-- log._("dsp1_itm_idx__", itm_idx)

	local dsp_idx

	if itm_idx > _s._dsp1_itm_idx_max then

		dsp_idx = itm_idx - _s._dsp1_itm_idx_max + 1

		itm_idx = _s._dsp1_itm_idx_max
	else
		dsp_idx = 1
	end

	_s._dsp1_itm_idx = itm_idx

	_s:dsp1_whel_idx__()

	-- _s:log("dsp1_itm_idx__")
	return dsp_idx
end

function p.Prt_itm_lst.dsp1_itm_idx__init(_s)

	_s:dsp1_itm_idx__(1)
end

-- dsp1o

function p.Prt_itm_lst.dsp1o_whel_idx(_s)

	-- if _s:is_dsp_itm_edge_1() then return end

	local dsp1_whel_idx = _s:dsp1_whel_idx()
	local whel_idx_max  = _s:whel_idx_max()
	-- log._("p.Prt_itm_lst.dsp1o_whel_idx", dsp1_whel_idx, whel_idx_max)

	local dsp1o_whel_idx = int.dec_loop(_s:dsp1_whel_idx(), _s:whel_idx_max())
	return dsp1o_whel_idx
end

function p.Prt_itm_lst.dsp1o_itm_idx(_s)

	if _s:is_dsp_itm_edge_1() then return end

	local dsp1o_itm_idx = int.dec_stop(_s:dsp1_itm_idx(), _s:itm_idx_max())
	-- local dsp1o_itm_idx, edge = int.dec_stop(_s:dsp1_itm_idx(), _s:itm_idx_max())
	-- if edge then dsp1o_itm_idx = nil end

	return dsp1o_itm_idx
end

-- dspE whel

function p.Prt_itm_lst.dspE_whel_idx(_s)

	local dspE_whel_idx = int.__pls_loop(_s:dsp1_whel_idx(), _s:dsp_idx_max() - 1, _s:whel_idx_max())
	return dspE_whel_idx
end

-- dspE itm

function p.Prt_itm_lst.dspE_itm_idx(_s)

	local dspE_itm_idx = _s:dsp1_itm_idx() + _s._dsp_idx_max - 1
	return dspE_itm_idx
end

-- dspEo

function p.Prt_itm_lst.dspEo_whel_idx(_s)

	-- if _s:is_dsp_itm_edge_E() then return end

	local dspEo_whel_idx = int.inc_loop(_s:dspE_whel_idx(), _s:whel_idx_max())

	-- log._("dspEo_whel_idx", dspEo_whel_idx, _s:dspE_whel_idx(), _s:whel_idx_max())

	return dspEo_whel_idx
end

function p.Prt_itm_lst.dspEo_itm_idx(_s)

	if _s:is_dsp_itm_edge_E() then return end

	local dspEo_itm_idx = int.inc_stop(_s:dspE_itm_idx(), _s:itm_idx_max())

	-- local dspEo_itm_idx, edge = int.inc_stop(_s:dspE_itm_idx(), _s:itm_idx_max())
	-- if edge then dspEo_itm_idx = nil end

	return dspEo_itm_idx
end

-- dsp i

-- dsp i __ plt

function p.Prt_itm_lst.dsp_i__plt_anm(_s, dsp_idx)
	
	local whel_idx = _s:whel_idx_6_dsp_idx(dsp_idx)
	_s:whel_i__plt_anm(dsp_idx)
end

function p.Prt_itm_lst.dsp_i__plt(_s, dsp_idx)
	log._("dsp_i__plt", dsp_idx)

	local whel_idx = _s:whel_idx_6_dsp_idx(dsp_idx)
	-- log._("dsp_i__plt b", dsp_idx, whel_idx)

	_s:whel_i__plt(whel_idx)
end

function p.Prt_itm_lst.dsp1o__plt_anm(_s)

	local whel_idx = _s:dsp1o_whel_idx()
	log._("dsp1o__plt_anm", whel_idx)

	_s:whel_i__plt_anm(whel_idx)
end

function p.Prt_itm_lst.dsp1o__plt(_s)

	local whel_idx = _s:dsp1o_whel_idx()
	log._("dsp1o__plt", whel_idx)

	_s:whel_i__plt(whel_idx)
end

function p.Prt_itm_lst.dspEo__plt_anm(_s)

	local whel_idx = _s:dspEo_whel_idx()
	log._("dspEo__plt_anm", whel_idx)

	_s:whel_i__plt_anm(whel_idx)
end

function p.Prt_itm_lst.dspEo__plt(_s)

	local whel_idx = _s:dspEo_whel_idx()
	log._("dspEo__plt", whel_idx)

	_s:whel_i__plt(whel_idx)
end

--
-- use not, need not
--

--[[
function p.Prt_itm_lst.is_dsp_6_itm_idx(_s, itm_idx) -- need ?

	local ret = _.f

	if int.is_rng(itm_idx, {_s:dsp1_itm_idx(), _s:dspE_itm_idx()}) then
		ret = _.t
	end
	return ret
end

function p.Prt_itm_lst.dsp_idx_6_itm_idx(_s, itm_idx) -- use not, need not

	local whel_idx = _s:whel_idx_6_itm_idx(itm_idx)

	if not _s:is_dsp_6_itm_idx(itm_idx) then return end
	
	local dsp_idx = itm_idx - _s:dsp1_itm_idx() + 1
	return dsp_idx
end
--]]

