log.scrpt("p.snn_lst.lua")

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
	_s._itm_pitch   = 50
	_s._dsp_idx_max =  2
	
	extnd.init(_s, p.Prt, parent_gui)
	extnd.init(_s, p.Prt_itm_lst)
	extnd.init(_s, p.Prt_cursor)
	extnd._(   _s, p.Snn_lst)
	
	_s:itm__6_ar({"snn_dtl_1", "snn_dtl_2"})
	_s:whel__init()
end

function p.Snn_lst.whel_i_nd__(_s, whel_idx, itm_idx)

	local nd_ar = _s:whel_i_nd_ar(whel_idx)
	local itm_i = _s:itm_i(itm_idx)

	nd.txt__(nd_ar[_s:lb("itm")], itm_i)
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

