log.scrpt("p.pc.lua")

p.Pc = {}

-- static

function p.Pc.cre(parent_gui)
	local p_Prt = p.Pc
	local gui_prt = p.Prt.cre(p_Prt, parent_gui)
	return gui_prt
end

-- scrpt method

function p.Pc.init(_s, parent_gui)

	_s._lb = "pc"
	_s._itm_pitch   = 50
	_s._dsp_idx_max =  4
	
	extnd.init(_s, p.Prt, parent_gui)
	extnd.init(_s, p.Prt_itm_lst)
	extnd.init(_s, p.Prt_cursor)
	extnd._(   _s, p.Pc)
	
	_s:itm__6_ar({"shop", "kzn", "snn_lst", "cfg"})
	_s._itm_txt = {"おみせ", "きずな", "しなん", "せってい"}
end

function p.Pc.whel_i_nd__(_s, whel_idx, itm_idx)

	local nd_ar = _s:whel_i_nd_ar(whel_idx)

	nd.txt__(nd_ar[_s:lb("itm")], _s._itm_txt[itm_idx])
end

-- method

function p.Pc.opn(_s)
	
	_s:itm__plt()
	_s:cursor_pos__()
	_s:base_dsp__(_.t)
	_s:focus__(_.t)
	Se.pst_ply("forward")
end

function p.Pc.decide(_s)
	_s:behind(fin)
	_s._parent_gui:opn(_s:cursor_itm())
end

