log.scrpt("p.ply_data.lua")

p.Ply_data = {}

-- static

function p.Ply_data.cre(parent_gui)
	local p_Prt = p.Ply_data
	local gui_prt = p.Prt.cre(p_Prt, parent_gui)
	return gui_prt
end

-- script method

function p.Ply_data.init(_s, parent_gui)
	log._("p.Ply_data.init")

	_s._lb = "ply_data"
	_s._itm_pitch   = 70
	_s._dsp_idx_max =  3
	
	extnd.init(_s, p.Prt, parent_gui)
	extnd.init(_s, p.Prt_itm_lst)
	extnd.init(_s, p.Prt_cursor)
	extnd._(   _s, p.Ply_data)
	
	_s:nd__("title")

	_s:itm__6_num("", file.ply_data.file_idx_max)
end

function p.Ply_data.opn(_s, prm)
	log._("p.ply_data.opn")

	if prm and prm.ply_slt_idx then
		_s._ply_slt_idx = prm.ply_slt_idx
	end
	
	if not _s._ply_slt_idx then log._("ply_slt_idx nil") return end
	
	_s:itm__()
	-- _s:whel__init()

	_s:itm__plt()
	_s:cursor_pos__()
	_s:base_dsp__(_.t)
	_s:focus__(_.t)

	nd.txt__(_s._nd.title, "load")
end

function p.Ply_data.itm__(_s, prm)

	_s:ply_data_thmb__load()

	local ply_data_file_idx

	for itm_idx, val in pairs(_s._itm) do
		
		ply_data_file_idx = _s:ply_data_file_idx_6_itm_idx(itm_idx)
		_s._itm[itm_idx]  = _s._ply_data_thmb[ply_data_file_idx]
	end
end

function p.Ply_data.ply_data_file_idx_6_itm_idx(_s, itm_idx)

	local ply_data_file_idx_ltst = _s:ply_data_file_idx_ltst()
	local d = itm_idx - 1
	local ply_data_file_idx = int.__sub_loop( ply_data_file_idx_ltst, d, #_s._itm)
	return ply_data_file_idx
end

function p.Ply_data.whel_i_nd__(_s, whel_idx, itm_idx)

	local itm_nd_ar = _s:whel_i_nd_ar(whel_idx)

	nd.txt__(itm_nd_ar[_s:lb("no")], itm_idx)
	
	local ply_data_file_idx = _s:ply_data_file_idx_6_itm_idx(itm_idx)
	local ts_str = _s._ply_data_thmb[ply_data_file_idx]["ts_str"]
		  or "-- -- -- -- -- --"
	nd.txt__(itm_nd_ar[_s:lb("ts_str"  )], ts_str)
	nd.txt__(itm_nd_ar[_s:lb("data_idx")], int.pad(ply_data_file_idx, 2))
end

function p.Ply_data.ply_slt_idx__(_s, ply_slt_idx)
	_s._ply_slt_idx = ply_slt_idx
end

function p.Ply_data.ply_slt_idx(_s)
	return _s._ply_slt_idx
end

function p.Ply_data.ply_data_thmb__load(_s)

	if not _s._ply_slt_idx then return end

	if not _s._ply_data_thmb then
		_s._ply_data_thmb = {}
	else
		ar.clr(_s._ply_data_thmb)
	end

	for file_idx = 1, file.ply_data.file_idx_max do
		_s._ply_data_thmb[file_idx] = file.ply_data.thmb.load(_s._ply_slt_idx, file_idx)
	end
end

function p.Ply_data.ply_data_file_idx_ltst__load(_s)

	if not _s._ply_slt_idx then return end
	
	local file_idx_ltst = file.ply_data.ltst.file_idx(_s._ply_slt_idx)
	
	if not file_idx_ltst then
		_s._ply_data_file_idx_ltst = file.ply_data.file_idx_max
	else
		_s._ply_data_file_idx_ltst = file_idx_ltst
	end
end

function p.Ply_data.ply_data_file_idx_ltst(_s)

	if _s._ply_data_file_idx_ltst then return _s._ply_data_file_idx_ltst end

	_s:ply_data_file_idx_ltst__load()
	return _s._ply_data_file_idx_ltst
end

function p.Ply_data.cursor_ply_data_thmb_idx(_s)

	local idx = _s:itm_idx_2_ply_data_thmb_idx(_s:cursor_itm_idx())
	return idx
end

function p.Ply_data.cursor_ply_data_thmb(_s)

	local idx = _s:cursor_ply_data_thmb_idx()
	local data = _s:ply_data_thmb(idx)
	return data
end

function p.Ply_data.is_emp_cursor_ply_data_thmb(_s)

	local data = _s:cursor_ply_data_thmb()
	return ar.is_emp(data)
end

function p.Ply_data.ply_data_thmb(_s, idx)

	local data = _s._ply_data_thmb[idx]
	return data
end

function p.Ply_data.itm_idx_2_ply_data_thmb_idx(_s, itm_idx)

	local ply_data_thmb_idx = int.__sub_loop(_s:ply_data_file_idx_ltst(), itm_idx - 1, file.ply_data.file_idx_max)
	return ply_data_thmb_idx
end

function p.Ply_data.cursor_data(_s)

	local data_idx = _s:cursor_ply_data_thmb_idx()
	local data = _s:data__load(data_idx)
	return data
end

-- method

function p.Ply_data.decide(_s)

	local itm_idx = _s:cursor_itm_idx()

	if _s:is_emp_cursor_ply_data_thmb() then
		_s:cursor_itm_iyaiya()
	else
		Se.pst_ply("forward")

		local anm = {}
		anm[1] = function ()
			nd.anm.poyon(_s._nd.itm[itm_idx][_s:lb("itm")], anm[2])
		end
		anm[2] = function ()
			_s:behind()
			_s:exe__(function () _s:game_continue() end)
			_s:confirm_opn()
		end
		anm[3] = function ()
		end
		anm[1]()
	end
end

function p.Ply_data.game_continue(_s)
	_s:parent_gui_del()
	pst.scrpt(Sys.id, "game_continue", {ply_slt_idx = _s._ply_slt_idx, ply_data_file_idx = _s:cursor_ply_data_thmb_idx()})
end

