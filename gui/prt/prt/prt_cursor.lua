log.scrpt("p.prt_cursor.lua")

p.Prt_cursor = {}

function p.Prt_cursor.init(_s)

	_s:cursor_dsp_idx__(1)

	_s:nd__("cursor")
	_s._cursor_pos_df_itm = _s:nd_pos("cursor") - _s._tpl_itm_pos

	_s:cursor_dsp__x()
end

-- method

function p.Prt_cursor.is_cursor__mv(_s, arwHa)

	local ret = _.f

	local inc_dir
	if     _s._itm_scrl_dir == "v" then

		if     ha.eq(arwHa, "arw_u") then
			ret = _.t
			inc_dir = "dec"
		elseif ha.eq(arwHa, "arw_d") then
			ret = _.t
			inc_dir = "inc"
		end
	elseif _s._itm_scrl_dir == "h" then

		if     ha.eq(arwHa, "arw_l") then
			ret = _.t
			inc_dir = "dec"
		elseif ha.eq(arwHa, "arw_r") then
			ret = _.t
			inc_dir = "inc"
		end
	end
	return ret, inc_dir
end

function p.Prt_cursor.is_cursor_dsp_1(_s)

	local ret = _.f
	if _s:cursor_dsp_idx() == 1 then
		ret = _.t
	end
	return ret
end

function p.Prt_cursor.is_cursor_dsp_E(_s)

	local ret = _.f
	-- if _s:cursor_dsp_idx() == _s:dsp_idx_max() then ret = _.t end
	if _s:cursor_dsp_idx() == _s:cursor_dsp_idx_max() then
		ret = _.t
	end
	return ret
end

function p.Prt_cursor.cursor_dsp_idx_max(_s)
	-- log._("cursor_dsp_idx_max")

	 if _s._cursor_dsp_idx_max then return _s._cursor_dsp_idx_max end

	_s:cursor_dsp_idx_max__()

	return _s._cursor_dsp_idx_max
end

function p.Prt_cursor.cursor_dsp_idx_max__(_s)
	-- log._("cursor_dsp_idx_max__")

	_s._cursor_dsp_idx_max = int.min(_s:dsp_idx_max(), _s:itm_idx_max())
end

function p.Prt_cursor.is_cursor_dsp_edge(_s, inc_dir)

	local ret = _.f

	if inc_dir then
		if     inc_dir == "inc" and _s:is_cursor_dsp_E() then ret = _.t
		elseif inc_dir == "dec" and _s:is_cursor_dsp_1() then ret = _.t
		end
	else
		if _s:is_cursor_dsp_1() or _s:is_cursor_dsp_E() then ret = _.t
		end
	end
	-- log._("is_cursor_dsp_edge", ret, inc_dir)
	return ret
end


function p.Prt_cursor.cursor_dsp_idx__dir(_s, inc_dir)

	local n_cursor_dsp_idx

	if     inc_dir == "inc" then
		n_cursor_dsp_idx = int.inc_stop(_s:cursor_dsp_idx(), _s:dsp_idx_max())

	elseif inc_dir == "dec" then
		n_cursor_dsp_idx = int.dec_stop(_s:cursor_dsp_idx(), _s:dsp_idx_max())
	end

	-- log._("cursor__mv", n_cursor_dsp_idx)

	_s:cursor__mv_6_dsp_idx(n_cursor_dsp_idx)
end


function p.Prt_cursor.cursor__mv(_s, inc_dir, keyact)
	-- log._("cursor__mv start", inc_dir)

	if     not _s:is_cursor_dsp_edge(inc_dir) then
		-- log._("cursor__mv a", inc_dir)
		_s:cursor_dsp_idx__dir(inc_dir)

	elseif not _s:is_dsp_itm_edge(inc_dir) then
		-- log._("cursor__mv b", inc_dir)
		_s:itm__scrl(inc_dir)

	elseif keyact == "p" then
		_s:cursor__mv_loop(inc_dir)
	end

	_s:cursor__mv_exe()
end

function p.Prt_cursor.cursor__mv_exe(_s)
	-- empty
end

function p.Prt_cursor.cursor_itm_opt_ch(_s, dir)
	-- empty
end

function p.Prt_cursor.cursor__mv_loop(_s, inc_dir)
	-- log._("cursor__mv_loop", inc_dir)

	if     inc_dir == "dec" then
		_s:cursor__mv_itmE()

	elseif inc_dir == "inc" then
		_s:cursor__mv_itm1()
	end
end

function p.Prt_cursor.cursor__mv_itm1(_s)
	-- _s:log("p.Prt_cursor.cursor__mv_itm1")

	_s:dsp1_itm_idx__(1)
	_s:itm__plt()
	-- _s:itm__plt_6_dsp1_itm_idx()

	local t_dsp_idx = 1
	_s:cursor_dsp_idx__(     t_dsp_idx)
	_s:cursor_pos__6_dsp_idx(t_dsp_idx)

	Se.pst_ply("cursor__mv")
end

function p.Prt_cursor.cursor__mv_itmE(_s)
	-- _s:log("p.Prt_cursor.cursor__mv_itmE start")

	local t_dsp1_itm_idx_max = _s:dsp1_itm_idx_max()
	_s:dsp1_itm_idx__(t_dsp1_itm_idx_max)
	_s:itm__plt()

	local t_dsp_idx = _s:cursor_dsp_idx_max()
	-- local t_dsp_idx = _s:dsp_idx_max()

	_s:cursor_dsp_idx__(     t_dsp_idx)
	_s:cursor_pos__6_dsp_idx(t_dsp_idx)

	Se.pst_ply("cursor__mv")

	-- _s:log("p.Prt_cursor.cursor__mv_itmE end")
end

function p.Prt_cursor.cursor__mv_6_pos(_s, p_pos)

	_s:cursor_pos__anm(p_pos)
end

function p.Prt_cursor.cursor_pos__anm(_s, p_pos)

	if not p_pos then return end

	local time = 0.1
	nd.anm.mv(_s._nd.cursor, p_pos, nil, time)
	Se.pst_ply("cursor__mv")
end

function p.Prt_cursor.cursor_pos_6_dsp_idx(_s, dsp_idx)
	
	dsp_idx = dsp_idx or _s._cursor_dsp_idx
	-- log._("p.Prt_cursor.cursor_pos_6_dsp_idx", dsp_idx, _s._cursor_dsp_idx, _s._lb)

	local t_pos = _s:dsp_pos(dsp_idx)

	t_pos = t_pos + _s._cursor_pos_df_itm

	return t_pos
end

function p.Prt_cursor.cursor_pos__6_dsp_idx(_s, dsp_idx)

	dsp_idx = dsp_idx or _s._cursor_dsp_idx

	local t_pos = _s:cursor_pos_6_dsp_idx(dsp_idx)
	_s:cursor_pos__(t_pos)
end

function p.Prt_cursor.cursor_pos__(_s, p_pos)
	
	p_pos = p_pos or _s:cursor_pos_6_dsp_idx()

	nd.pos__(_s._nd.cursor, p_pos)
end

function p.Prt_cursor.cursor_dsp__o(_s)
	_s:cursor_dsp__(_.t)
end

function p.Prt_cursor.cursor_dsp__x(_s)
	_s:cursor_dsp__(_.f)
end

function p.Prt_cursor.cursor_dsp__(_s, val)
	_s:nd_dsp__("cursor", val)
end

-- cursor dsp idx

function p.Prt_cursor.cursor__mv_6_dsp_idx(_s, dsp_idx)

	local t_pos = _s:cursor_pos_6_dsp_idx(dsp_idx)

	_s:cursor__mv_6_pos(t_pos)

	_s:cursor_dsp_idx__(dsp_idx)

	-- log._("cursor__mv_6_dsp_idx", dsp_idx)
end

function p.Prt_cursor.cursor_dsp_idx(_s)

	return _s._cursor_dsp_idx
end

function p.Prt_cursor.cursor_dsp_idx__(_s, dsp_idx)

	_s._cursor_dsp_idx = dsp_idx
end

-- cursor itm idx

function p.Prt_cursor.cursor_itm_idx(_s)
	-- log._("cursor_itm_idx", _s:dsp1_itm_idx(), _s._cursor_dsp_idx)

	local cursor_itm_idx = _s:dsp1_itm_idx() + _s._cursor_dsp_idx - 1
	return cursor_itm_idx
end

function p.Prt_cursor.cursor_itm(_s)

	local cursor_itm_idx = _s:cursor_itm_idx()

	local itm = _s._itm[cursor_itm_idx]

	if u.is_emp(itm) then return end

	return itm
end

function p.Prt_cursor.cursor__itm_idx(_s, itm_idx)

	local dsp_idx = _s:itm__plt(itm_idx)
	-- log._("p.Prt_cursor.cursor__itm_idx", dsp_idx, itm_idx)

	_s:cursor_dsp_idx__(dsp_idx)
	_s:cursor_pos__6_dsp_idx()
	-- _s:cursor_pos__6_dsp_idx(dsp_idx)
end

function p.Prt_cursor.cursor_itm_nd_ar(_s)

	local cursor_itm_idx = _s:cursor_itm_idx()
	local t_nd_ar = _s._nd.itm[cursor_itm_idx]
	return t_nd_ar
end

function p.Prt_cursor.cursor_itm_nd(_s, nd_id)

	local t_nd_ar = _s:cursor_itm_nd_ar()
	local t_nd = t_nd_ar[_s:lb(nd_id)]
	return t_nd
end

function p.Prt_cursor.cursor_itm_iyaiya(_s)

	local t_nd = _s:cursor_itm_nd("itm")
	nd.anm.iyaiya(t_nd)

	Se.pst_ply("back")
end

function p.Prt_cursor.cursor_itm_poyon(_s, fin)

	local t_nd = _s:cursor_itm_nd("itm")
	nd.anm.poyon(t_nd, fin)
end

-- nd

function p.Prt_cursor.cursor_nd(_s)
	return _s._nd.cursor
end

function p.Prt_cursor.actv__(_s, val)
	_s:cursor_dsp__(val)
end

