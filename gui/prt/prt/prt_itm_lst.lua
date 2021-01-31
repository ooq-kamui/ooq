log.scrpt("p.prt_itm_lst.lua")

p.Prt_itm_lst = {}

function p.Prt_itm_lst.init(_s)

	extend.init(_s, p.Prt_itm)
	extend._(_s, p.Prt_itm_lst)

	-- default
	_s._itm_scrl_dir = "v"
end

function p.Prt_itm_lst.itm_scrl(_s, inc_dir)
	-- log._("prt itm_scrl", _s._dsp1_itm_idx, _s._dsp1_itm_idx_max)

	if     inc_dir == "inc" then
		_s._dsp1_itm_idx = u.inc_stop(_s._dsp1_itm_idx, _s._dsp1_itm_idx_max)

	elseif inc_dir == "dec" then
		_s._dsp1_itm_idx = u.dec_stop(_s._dsp1_itm_idx, _s._dsp1_itm_idx_max)
	end

	_s:itm__plt_anm()
	Se.pst_ply("cursor_mv")
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
