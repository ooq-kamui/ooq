log.scrpt("p.shelf.lua")

p.Shelf = {}

-- static

function p.Shelf.cre(parent_gui)
	local p_Prt = p.Shelf
	local gui_prt = p.Prt.cre(p_Prt, parent_gui)
	return gui_prt
end

-- scrpt method

function p.Shelf.init(_s, parent_gui)

	_s._lb = "shelf"
	_s._itm_pitch   = 130
	_s._dsp_idx_max =   3
	_s._itm_scrl_dir = "h"
	
	extnd.init(_s, p.Prt, parent_gui)
	extnd.init(_s, p.Prt_itm_lst)
	extnd.init(_s, p.Prt_cursor)
	extnd._(_s, p.Shelf)

	_s:itm__6_ar({"anml", "flower", "dish"})
	_s._itm_txt = {"どうぶつ", "おはな", "りょうり", }
end

function p.Shelf.whel_i_nd__(_s, whel_idx, itm_idx)

	local nd_ar = _s:whel_i_nd_ar(whel_idx)

	nd.txt__(nd_ar[_s:lb("title")], _s._itm_txt[itm_idx])
end

-- method

function p.Shelf.opn(_s)
	
	_s:itm__plt()
	_s:cursor_pos__()
	_s:base_dsp__(_.t)
	_s:focus__(_.t)
	Se.pst_ply("forward")
end

function p.Shelf.restore(_s) -- use?
	_s:base_dsp__(_.t)
	_s:focus__(_.t)
end

function p.Shelf.decide(_s)

	_s._parent_gui:opn("zu_".._s:cursor_itm())
	
	Se.pst_ply("forward")
	_s:behind()
end
