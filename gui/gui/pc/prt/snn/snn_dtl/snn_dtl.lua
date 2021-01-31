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
	
	extend.init(_s, p.Prt, parent_gui)
	extend.init(_s, p.Prt_itm_lst)
	extend.init(_s, p.Prt_cursor)
	extend._(_s, p.Snn_dtl)

	_s._itm_pitch = 350
	_s._itm_scrl_dir = "h"
	
	_s:itm__by_ar({"page_1", "page_2"})

	_s:nd__("title")
	
	local node
	for idx, itm in pairs(_s._itm) do
		node = _s:itm_clone()
		nd.txt__(node[_s:lb("itm")], _s._itm[idx])
	end
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
