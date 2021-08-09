log.scrpt("p.zu_dish.lua")

p.Zu_dish = {}

-- static

function p.Zu_dish.cre(parent_gui)
	local p_Prt = p.Zu_dish
	local gui_prt = p.Prt.cre(p_Prt, parent_gui)
	return gui_prt
end

-- script method

function p.Zu_dish.init(_s, parent_gui)

	_s._lb = "zu_dish"
	_s._itm_pitch   = 51
	_s._dsp_idx_max =  8
	
	extnd.init(_s, p.Prt, parent_gui)
	extnd.init(_s, p.Prt_itm_lst)
	extnd.init(_s, p.Prt_cursor)
	extnd._(_s, p.Zu_dish)
	
	_s:itm__6_num("dish", Dish.name_idx_max)
end

function p.Zu_dish.whel_i_nd__(_s, whel_idx, itm_idx)

	local nd_ar = _s:whel_i_nd_ar(whel_idx)
	local name  = _s:itm_i(itm_idx)
	local val   = Ply_data.zu._zu.dish[name]

	nd.txt__(nd_ar[_s:lb("txt")], int.pad(itm_idx))
	local icn = nd_ar[_s:lb("icn")]
	if val then
		nd.txtr__(icn, "dish")
		nd.anm__( icn, name)
	else
		nd.txtr__(icn, "noimg")
		nd.anm__( icn, "noimg")
	end
end

-- method

function p.Zu_dish.opn(_s, prm)

	_s:itm__plt()
	_s:cursor_pos__()
	_s:base_dsp__(_.t)
	_s:focus__(_.t)
end

function p.Zu_dish.decide(_s)
end

