log.scrpt("p.cfg.lua")

p.Cfg = {}

-- static

function p.Cfg.cre(parent_gui)
	local p_Prt = p.Cfg
	local gui_prt = p.Prt.cre(p_Prt, parent_gui)
	return gui_prt
end

-- script method

function p.Cfg.init(_s, parent_gui)

	_s._lb = "cfg"
	_s._itm_pitch   = 50
	_s._dsp_idx_max =  2
	
	extnd.init(_s, p.Prt, parent_gui)
	extnd.init(_s, p.Prt_itm_lst)
	extnd.init(_s, p.Prt_cursor)
	extnd._(   _s, p.Cfg)
	
	_s:itm__6_ar({"cfg_1", "cfg_2"})
	_s._itm_txt = {"setting 1", "setting 2"}
end

function p.Cfg.whel_i_nd__(_s, whel_idx, itm_idx)

	local nd_ar = _s:whel_i_nd_ar(whel_idx)

	nd.txt__(nd_ar[_s:lb("txt")], _s._itm_txt[itm_idx])
end

-- method

function p.Cfg.opn(_s)

	_s:itm__plt()
	_s:cursor_pos__()
	_s:base_dsp__(_.t)
	_s:focus__(_.t)
	Se.pst_ply("forward")
end

function p.Cfg.decide(_s)
end

