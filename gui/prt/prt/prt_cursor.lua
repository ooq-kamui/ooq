log.scrpt("p.prt_cursor.lua")

p.Prt_cursor = {}

function p.Prt_cursor.init(_s)

	_s:cursor_dsp_idx__(1)

	_s:nd__("cursor")
	_s._cursor_pos_df_itm = _s:nd_pos("cursor") - _s._tpl_itm_pos

	-- _s:cursor_pos__init()
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

function p.Prt_cursor.cursor__mv(_s, inc_dir, keyact)

	local t_dsp_idx, cursor_edge, dsp_itm_edge

	if     inc_dir == "inc" then
		t_dsp_idx, cursor_edge = int.inc_stop(_s._cursor_dsp_idx, _s._dsp_idx_max)
		dsp_itm_edge = _s:is_dsp_itm_E()

	elseif inc_dir == "dec" then
		t_dsp_idx, cursor_edge = int.dec_stop(_s._cursor_dsp_idx, _s._dsp_idx_max)
		dsp_itm_edge = _s:is_dsp_itm_1()
	end
	-- log._("cursor__mv", t_dsp_idx, cursor_edge)

	if     not cursor_edge then
		_s:cursor__mv_by_dsp_idx(t_dsp_idx)

	elseif not dsp_itm_edge then
		_s:itm_scrl(inc_dir)

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
	log._("cursor__mv_loop t_dsp_idx", t_dsp_idx)

	local t_dsp_idx

	if     inc_dir == "dec" then
		_s._dsp1_itm_idx = _s._dsp1_itm_idx_max
		t_dsp_idx        = _s._dsp_idx_max

	elseif inc_dir == "inc" then
		_s._dsp1_itm_idx = 1
		t_dsp_idx        = 1
	end
	-- log._("cursor__mv_loop t_dsp_idx", t_dsp_idx)

	_s:itm__plt()
	_s:cursor_dsp_idx__(t_dsp_idx)
	_s:cursor_pos__by_dsp_idx(t_dsp_idx)
	Se.pst_ply("cursor__mv")
end

function p.Prt_cursor.cursor__mv_by_pos(_s, p_pos)

	_s:cursor_pos__anm(p_pos)
end

function p.Prt_cursor.cursor_pos__anm(_s, p_pos)

	if not p_pos then return end

	local time = 0.1
	nd.anm.mv(_s._nd.cursor, p_pos, nil, time)
	Se.pst_ply("cursor__mv")
end

function p.Prt_cursor.cursor_pos_by_dsp_idx(_s, dsp_idx)
	
	-- if not dsp_idx then return end
	dsp_idx = dsp_idx or _s._cursor_dsp_idx

	local t_pos = _s:itm_pos_by_dsp_idx(dsp_idx)

	t_pos = t_pos + _s._cursor_pos_df_itm

	return t_pos
end

function p.Prt_cursor.cursor_pos__by_dsp_idx(_s, dsp_idx)

	local t_pos = _s:cursor_pos_by_dsp_idx(dsp_idx)
	_s:cursor_pos__(t_pos)
end

--[[
function p.Prt_cursor.cursor_pos__init(_s, dsp_idx)
	
	dsp_idx = dsp_idx or _s._cursor_dsp_idx

	local t_pos = _s:cursor_pos_by_dsp_idx(dsp_idx)
	_s:cursor_pos__(t_pos)
end
--]]

function p.Prt_cursor.cursor_pos__(_s, p_pos)
	
	-- if not p_pos then return end
	p_pos = p_pos or _s:cursor_pos_by_dsp_idx()

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

--

function p.Prt_cursor.cursor__by_itm_idx(_s, itm_idx)

end

function p.Prt_cursor.cursor__mv_by_dsp_idx(_s, dsp_idx)

	local t_pos = _s:cursor_pos_by_dsp_idx(dsp_idx)

	_s:cursor__mv_by_pos(t_pos)

	_s:cursor_dsp_idx__(dsp_idx)

	log._("cursor__mv_by_dsp_idx", dsp_idx)
end

function p.Prt_cursor.cursor_dsp_idx__(_s, dsp_idx)

	_s._cursor_dsp_idx = dsp_idx
end

-- cursor itm

function p.Prt_cursor.cursor_itm_idx(_s)

	return _s._dsp1_itm_idx + _s._cursor_dsp_idx - 1
end

function p.Prt_cursor.cursor_itm(_s)

	local itm = _s._itm[_s:cursor_itm_idx()]
	if u.is_emp(itm) then return end

	return itm
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

