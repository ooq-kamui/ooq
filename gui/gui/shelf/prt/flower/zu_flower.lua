log.scrpt("p.zu_flower.lua")

p.Zu_flower = {}

-- static

function p.Zu_flower.cre(parent_gui)
	local p_Prt = p.Zu_flower
	local gui_prt = p.Prt.cre(p_Prt, parent_gui)
	return gui_prt
end

-- script method

function p.Zu_flower.init(_s, parent_gui)

	_s._lb = "zu_flower"
	_s._itm_pitch   = 51
	_s._dsp_idx_max =  8
	
	extnd.init(_s, p.Prt, parent_gui)
	extnd.init(_s, p.Prt_itm_lst)
	extnd.init(_s, p.Prt_cursor)
	extnd._(   _s, p.Zu_flower)

	_s:itm__6_num("flower", Flower.name_idx_max)
	_s:whel__init()
end

function p.Zu_flower.whel_i_nd__(_s, whel_idx, itm_idx)

	local nd_ar = _s:whel_i_nd_ar(whel_idx)
	local name  = _s:itm_i(itm_idx)
	local val   = Ply_data.zu._zu.flower[name]

	nd.txt__(nd_ar[_s:lb("txt")], int.pad(itm_idx))
	local nd_icn = nd_ar[_s:lb("icn")]
	if val then
		nd.txtr__(nd_icn, "flower")
		nd.anm__( nd_icn, name)
	else
		nd.txtr__(nd_icn, "noimg")
		nd.anm__( nd_icn, "noimg")
	end
end

-- method

function p.Zu_flower.opn(_s, prm)
	
	_s:itm__plt()
	_s:cursor_pos__()
	_s:base_dsp__(_.t)
	_s:focus__(_.t)
end

function p.Zu_flower.decide(_s)
end

