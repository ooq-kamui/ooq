log.scrpt("p.ply_slt.lua")

p.Ply_slt = {}

-- static

function p.Ply_slt.cre(parent_gui)
	local p_Prt = p.Ply_slt
	local gui_prt = p.Prt.cre(p_Prt, parent_gui)
	return gui_prt
end

-- script method

function p.Ply_slt.init(_s, parent_gui)

	_s._lb = "ply_slt"
	_s._itm_pitch   = 70
	_s._dsp_idx_max =  4
	
	extnd.init(_s, p.Prt, parent_gui)
	extnd.init(_s, p.Prt_itm_lst)
	extnd.init(_s, p.Prt_cursor)
	extnd.init(_s, p.Prt_itm_menu)
	extnd._(   _s, p.Ply_slt)

	_s:itm__init()
	_s:whel__init()

	_s._itm_menu = {"delete"} -- {"delete", "itm_menu1", "itm_menu2"}
	_s:nd_itm_menu__()
	_s:itm_menu_actv__x()
end

function p.Ply_slt.itm__init(_s)
	
	local data
	for idx = 1, file.ply_slt.idx_max do
		_s:itm__load(idx)
	end
	_s:dsp1_itm_idx_max__()
end

function p.Ply_slt.itm__load(_s, ply_slt_idx)
	
	local data = file.ply_data.ltst.thmb(ply_slt_idx)
	_s._itm[ply_slt_idx] = data
end

function p.Ply_slt.whel_i_nd__(_s, whel_idx, itm_idx)
	
	local lb, thmb
	
	nd.txt__(_s._nd.itm[whel_idx][_s:lb("no")], int._2_str(itm_idx))

	local itm_i = _s:itm_i(itm_idx)
	if ar.is_emp(itm_i) then
		lb = "new"
	else
		lb = itm_i["ts_str"]
	end
	nd.txt__(_s._nd.itm[whel_idx][_s:lb("txt")], lb)
end

-- method

function p.Ply_slt.opn(_s, prm)

	_s:itm__plt()
	_s:cursor_pos__()
	_s:base_dsp__(_.t)
	_s:focus__(_.t)

	_s:itm_menu_icn_dsp__auto()
end

function p.Ply_slt.cursor__mv(_s, inp_dir, itm_scrl_dir, keyact)
	-- log._("ply_slt_gui cursor__mv")

	p.Prt_cursor.cursor__mv(_s, inp_dir, itm_scrl_dir, keyact)

	_s:itm_menu_icn_dsp__auto()
end

function p.Ply_slt.decide(_s)

	if not _s:cursor_itm() then
		_s:behind()
		_s:exe__(function () _s:game_new() end)
		_s:confirm_opn()
	else
		_s:behind()
		_s._parent_gui:opn("ply_data", {ply_slt_idx = _s:cursor_itm_idx()})
	end
	
	Se.pst_ply("forward")
	
	local anm = {}
	anm[1] = function ()
		nd.anm.poyon(_s:cursor_itm_nd("itm"), anm[2])
	end
	anm[2] = function ()
	end
	anm[1]()
end

function p.Ply_slt.game_new(_s)
	pst.scrpt(Sys.id, "game_new", {ply_slt_idx = _s:cursor_itm_idx()})
	_s:parent_gui_del()
end

-- inner_focus

function p.Ply_slt.inner_focus(_s)
	return _s._inner_focus
end

function p.Ply_slt.inner_focus__(_s, inner_focus)
	
	inner_focus = inner_focus or "itm"
	
	_s._inner_focus = inner_focus
end

function p.Ply_slt.is_inner_focus(_s, inner_focus)
	local ret = _.f
	if _s._inner_focus == inner_focus then ret = _.t end
	return ret
end

--

function p.Ply_slt.clr(_s, ply_slt_idx) -- todo refactoring fnc locale, loop logic
	
	for file_idx = 1, file.ply_data.file_idx_max do
		file.ply_data.thmb.del(ply_slt_idx, file_idx)
		file.ply_data.del(     ply_slt_idx, file_idx)
	end
	file.ply_data.ltst.del(ply_slt_idx)

	-- map del
	local dstrct = n.vec()
	local dstrct_x, dstrct_y, file_idx
	for dstrct_y = - Map.dstrct_max.y, Map.dstrct_max.y do
		for dstrct_x = - Map.dstrct_max.x, Map.dstrct_max.x do
			dstrct.x = dstrct_x
			dstrct.y = dstrct_y
			for file_idx = 1, file.map.file_idx_max do
				file.map.del(ply_slt_idx, dstrct, file_idx)
			end
			file.map.ltst.del(ply_slt_idx, dstrct, file_idx)
		end
	end
	
	-- Se.pst_ply("exe")
end

