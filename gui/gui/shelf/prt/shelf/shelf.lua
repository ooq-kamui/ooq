log.script("p.shelf.lua")

p.Shelf = {}

-- static

function p.Shelf.cre(parent_gui)
	local p_Prt = p.Shelf
	local gui_prt = p.Prt.cre(p_Prt, parent_gui)
	return gui_prt
end

-- script method

function p.Shelf.init(_s, parent_gui)

	_s._lb = "shelf"
	
	extend.init(_s, p.Prt, parent_gui)
	extend.init(_s, p.Prt_itm_lst)
	extend.init(_s, p.Prt_cursor)
	extend._(_s, p.Shelf)
	
	_s._itm_pitch = 130
	_s._dsp_idx_max = 3
	_s._itm_scrl_dir = "h"

	_s:itm__by_ar({"animal", "flower", "dish"})
	
	local node
	for idx, title in pairs(_s._itm) do
		node = _s:itm_clone()
		nd.txt__(node[_s:lb("title")], title)
	end
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
