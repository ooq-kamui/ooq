log.scrpt("p.snn_dtl.lua")

p.Snn_dtl = {}

-- static

function p.Snn_dtl.cre(parent_gui)
	local p_Prt = p.Snn_dtl
	local gui_prt = p.Prt.cre(p_Prt, parent_gui)
	return gui_prt
end

-- script method

function p.Snn_dtl.init(_s, parent_gui)

	_s._lb = "snn_dtl"
	_s._itm_pitch   = 350
	_s._dsp_idx_max =   1
	_s._itm_scrl_dir = "h"
	
	extnd.init(_s, p.Prt, parent_gui)
	extnd.init(_s, p.Prt_itm_lst)
	extnd.init(_s, p.Prt_cursor)
	extnd._(   _s, p.Snn_dtl)
	
	_s:nd__("title")

	_s:itm__6_ar({"page_1", "page_2"})
end

function p.Snn_dtl.whel_i_nd__(_s, whel_idx, itm_idx)

	local nd_ar = _s:whel_i_nd_ar(whel_idx)

	nd.txt__(nd_ar[_s:lb("itm")], _s._itm[itm_idx])
end

-- method

function p.Snn_dtl.opn(_s, prm)
	
	_s:itm__plt()
	_s:cursor_pos__()
	_s:base_dsp__(_.t)
	_s:focus__(_.t)
	Se.pst_ply("forward")

	nd.txt__(_s:nd("title"), prm.snn_no)
end

function p.Snn_dtl.decide(_s)
end
