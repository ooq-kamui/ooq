log.script("p.snn_lst.lua")

p.Snn_lst = {}

-- static

function p.Snn_lst.cre(parent_gui)
	local p_Prt = p.Snn_lst
	local gui_prt = p.Prt.cre(p_Prt, parent_gui)
	return gui_prt
end

-- script method

function p.Snn_lst.init(_s, parent_gui)

	_s._lb = "snn_lst"
	
	extend.init(_s, p.Prt, parent_gui)
	extend.init(_s, p.Prt_itm_lst)
	extend.init(_s, p.Prt_cursor)
	extend._(_s, p.Snn_lst)
	
	_s._itm_pitch = 50
	_s._dsp_idx_max = 2
	
	_s:itm__by_ar({"snn_dtl_1", "snn_dtl_2"})
	
	local node
	for idx, itm in pairs(_s._itm) do
		node = _s:itm_clone()
		nd.txt__(node[_s:lb("itm")], _s._itm[idx])
	end
end

-- method

function p.Snn_lst.opn(_s, prm)
	
	_s:itm__plt()
	_s:cursor_pos__()
	_s:base_dsp__(_.t)
	_s:focus__(_.t)
	Se.pst_ply("forward")
end

function p.Snn_lst.decide(_s)
	_s._parent_gui:opn("snn_dtl", {snn_no = _s:cursor_itm()})
	_s:behind()
end
