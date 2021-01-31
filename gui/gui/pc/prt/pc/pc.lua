log.scrpt("p.pc.lua")

p.Pc = {}

-- static

function p.Pc.cre(parent_gui)
	local p_Prt = p.Pc
	local gui_prt = p.Prt.cre(p_Prt, parent_gui)
	return gui_prt
end

-- script method

function p.Pc.init(_s, parent_gui)

	_s._lb = "pc"
	
	extend.init(_s, p.Prt, parent_gui)
	extend.init(_s, p.Prt_itm_lst)
	extend.init(_s, p.Prt_cursor)
	extend._(_s, p.Pc)
	
	_s._itm_pitch = 50
	_s._dsp_idx_max = 4
	
	_s:itm__by_ar({"shop", "kzn", "snn_lst", "cfg"})
	_s._itm_txt = {"おみせ", "きずな", "しなん", "せってい"}
	
	local node
	for idx, item in pairs(_s._itm) do
		node = _s:itm_clone()
		nd.txt__(node[_s:lb("itm")], _s._itm_txt[idx])
	end
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
