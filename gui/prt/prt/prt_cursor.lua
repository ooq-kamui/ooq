log.scrpt("p.prt_cursor.lua")

p.Prt_cursor = {}

function p.Prt_cursor.init(_s)

	_s._cursor_dsp_idx   = 1

	_s:nd__("cursor")
	_s._cursor_pos_df_itm = _s:nd_pos("cursor") - _s._tpl_itm_pos
	-- log._("_s._cursor_pos_df_itm", _s._lb, _s._cursor_pos_df_itm)

	_s:cursor_dsp__x()
end

-- method

function p.Prt_cursor.cursor_nd(_s)
	return _s._nd.cursor
end

function p.Prt_cursor.actv__(_s, val)
	_s:cursor_dsp__(val)
end

function p.Prt_cursor.is_cursor_mv(_s, arwHa)

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

function p.Prt_cursor.cursor_mv(_s, inc_dir, keyact)

	local cursor_edge, dsp_itm_edge

	if     inc_dir == "inc" then
		_s._cursor_dsp_idx, cursor_edge = u.inc_stop(_s._cursor_dsp_idx, _s._dsp_idx_max)
		dsp_itm_edge = _s:is_dsp_itm_E()

	elseif inc_dir == "dec" then
		_s._cursor_dsp_idx, cursor_edge = u.dec_stop(_s._cursor_dsp_idx, _s._dsp_idx_max)
		dsp_itm_edge = _s:is_dsp_itm_1()
	end

	if     not cursor_edge then
		_s:cursor__plt_anm()

	elseif not dsp_itm_edge then
		_s:itm_scrl(inc_dir)

	elseif keyact == "p" then
		_s:cursor_mv_loop(inc_dir)
	end

	_s:cursor_mv_exe()
end

function p.Prt_cursor.cursor_mv_exe(_s)
	-- empty
end

function p.Prt_cursor.cursor_itm_opt_ch(_s, dir)
	-- empty
end

function p.Prt_cursor.cursor_mv_loop(_s, inc_dir)

	if     inc_dir == "dec" then
		_s._dsp1_itm_idx = _s._dsp1_itm_idx_max
		_s._cursor_dsp_idx = _s._dsp_idx_max

	elseif inc_dir == "inc" then
		_s._dsp1_itm_idx = 1
		_s._cursor_dsp_idx = 1
	end

	_s:itm__plt()
	_s:cursor_pos__()
	Se.pst_ply("cursor_mv")
end

function p.Prt_cursor.cursor__plt_anm(_s)

	local pos = _s:cursor_pos()
	local time = 0.1
	nd.anm.mv(_s._nd.cursor, pos, nil, time)
	Se.pst_ply("cursor_mv")
end

function p.Prt_cursor.cursor_pos__(_s)
	
	local pos = _s:cursor_pos()
	nd.pos__(_s._nd.cursor, pos)
end

function p.Prt_cursor.cursor_pos(_s)
	
	local pos = _s:itm_pos_by_dsp_idx(_s._cursor_dsp_idx)
	pos = pos + _s._cursor_pos_df_itm
	return pos
end

function p.Prt_cursor.cursor_dsp__(_s, val)
	_s:nd_dsp__("cursor", val)
end

function p.Prt_cursor.cursor_dsp__o(_s)
	_s:cursor_dsp__(_.t)
end

function p.Prt_cursor.cursor_dsp__x(_s)
	_s:cursor_dsp__(_.f)
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
end

function p.Prt_cursor.cursor_itm_poyon(_s, fin)
	local t_nd = _s:cursor_itm_nd("itm")
	nd.anm.poyon(t_nd, fin)
end
