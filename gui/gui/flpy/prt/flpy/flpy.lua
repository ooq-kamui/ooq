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
	_s._itm_pitch   = 80
	_s._dsp_idx_max =  3
	
	extnd.init(_s, p.Prt, parent_gui)
	extnd.init(_s, p.Prt_itm_lst)
	extnd.init(_s, p.Prt_cursor)
	extnd._(_s, p.Flpy)
	
	_s._itm_scrl_dir = "v"

	_s:itm__6_ar({"save", "load", "back to title"})
	_s:whel__init()
end

function p.Flpy.whel_i_nd__(_s, whel_idx, itm_idx)

	local nd_ar = _s:whel_i_nd_ar(whel_idx)

	local txt = _s:itm_i(itm_idx)
	nd.txt__(nd_ar[_s:lb("txt")], txt)
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

