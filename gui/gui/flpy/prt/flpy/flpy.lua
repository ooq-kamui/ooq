log.scrpt("p.flpy.lua")

p.Flpy = {}

-- static

function p.Flpy.cre(parent_gui)
	local p_Prt = p.Flpy
	local gui_prt = p.Prt.cre(p_Prt, parent_gui)
	return gui_prt
end

-- script method

function p.Flpy.init(_s, parent_gui)

	_s._lb = "flpy"
	
	extend.init(_s, p.Prt, parent_gui)
	extend.init(_s, p.Prt_itm_lst)
	extend.init(_s, p.Prt_cursor)
	extend._(_s, p.Flpy)
	
	_s._itm_pitch = 80
	_s._dsp_idx_max = 3
	_s._itm_scrl_dir = "v"

	_s:itm__by_ar({"save", "load", "back to title"})
	
	local node
	for idx, txt in pairs(_s._itm) do
		node = _s:itm_clone()
		nd.txt__(node[_s:lb("txt")], txt)
	end
end

-- method

function p.Flpy.opn(_s, prm)
	-- log._("p.flpy.opn")
	
	_s:cursor_pos__()
	_s:itm__plt()
	_s:base_dsp__(_.t)
	_s:focus__(_.t)
	-- Se.pst_ply("forward")
end

function p.Flpy.decide(_s)
	
	Se.pst_ply("forward")

	local fin
	if     _s:cursor_itm() == "save" then
		_s:behind()
		_s:exe__(function () _s:save() end)
		_s:confirm_opn()

	elseif _s:cursor_itm() == "load" then
		_s:behind()
		_s._parent_gui:opn("ply_data", {ply_slt_idx = _s._parent_gui._ply_slt_idx})
		
	elseif _s:cursor_itm() == "back to title" then
		_s:behind()
		_s:exe__(function () _s:back_to_title() end)
		_s:confirm_opn()
	end
end

function p.Flpy.back_to_title(_s)
	
	-- Se.pst_ply("forward")
	pst.scrpt(Sys.id, "title")
	_s:parent_gui_del()
end

function p.Flpy.save(_s)
	pst._(".", "save")
	_s:parent_gui_del()
end

