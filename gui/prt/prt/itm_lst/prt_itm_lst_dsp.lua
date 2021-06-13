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

-- dsp whel

function p.Prt_itm_lst.dsp1_whel_idx(_s)

	return _s._dsp1_whel_idx
end

function p.Prt_itm_lst.dsp1_whel_idx__(_s, whel_idx)

	_s._dsp1_whel_idx = whel_idx
end

function p.Prt_itm_lst.is_whel_i_dsp(_s, whel_idx)

	local ret = _.f

	local itm_idx = _s:itm_idx_6_whel_idx(whel_idx)

	if int.is_rng(itm_idx, _s:dsp_itm_rng()) then
		ret = _.t
	end
	return ret
end

-- dsp itm

function p.Prt_itm_lst.dsp1_itm_idx_max(_s)

	return _s._dsp1_itm_idx_max
end

function p.Prt_itm_lst.dsp1_itm_idx_max__(_s)

	if not _s._itm then return end

	_s._dsp1_itm_idx_max = #_s._itm - _s._dsp_idx_max + 1
end

function p.Prt_itm_lst.dsp1_itm_idx(_s)

	local dsp1_whel_idx = _s:dsp1_whel_idx()

	local dsp1_itm_idx  = _s:itm_idx_6_whel_idx(dsp1_whel_idx)

	log.if_(not dsp1_itm_idx, "p.Prt_itm_lst.dsp1_itm_idx", dsp1_itm_idx, dsp1_whel_idx, _s._lb)

	return dsp1_itm_idx
end

function p.Prt_itm_lst.dsp1_itm_idx__(_s, itm_idx) -- mod ins whel

	local dsp_idx

	if itm_idx > _s._dsp1_itm_idx_max then

		dsp_idx = itm_idx - _s._dsp1_itm_idx_max + 1

		itm_idx = _s._dsp1_itm_idx_max
	else
		dsp_idx = 1
	end

	_s._dsp1_itm_idx = itm_idx

	return dsp_idx
end

function p.Prt_itm_lst.dspE_itm_idx(_s)

	local dspE_itm_idx = _s:dsp1_itm_idx() + _s._dsp_idx_max - 1
	return dspE_itm_idx
end

function p.Prt_itm_lst.dsp_itm_rng(_s)

	if not _s._dsp_itm_rng then _s._dsp_itm_rng = {} end

	_s._dsp_itm_rng[1] = _s:dsp1_itm_idx()
	_s._dsp_itm_rng[2] = _s:dspE_itm_idx()

	return _s._dsp_itm_rng
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

-- use not, need not

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

