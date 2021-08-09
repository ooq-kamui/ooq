log.scrpt("p.zu_anml.lua")

p.Zu_anml = {}

-- static

function p.Zu_anml.cre(parent_gui)
	local p_Prt = p.Zu_anml
	local gui_prt = p.Prt.cre(p_Prt, parent_gui)
	return gui_prt
end

function p.Zu_anml.is_favo(name, o_cls, o_name)
	local ret = _.f
	local favo = p.Zu_anml.favo[name]
	if not favo[o_cls] then return ret end
	ret = ar.in_(o_name, favo[o_cls])
	return ret
end

function p.Zu_anml.anml__o(name)
	Ply_data.zu._zu.anml[name] = _.t
end

-- script method

function p.Zu_anml.init(_s, parent_gui)

	_s._lb = "zu_anml"
	_s._itm_pitch   = 51
	_s._dsp_idx_max =  8
	
	extnd.init(_s, p.Prt, parent_gui)
	extnd.init(_s, p.Prt_itm_lst)
	extnd.init(_s, p.Prt_cursor)
	extnd._(_s, p.Zu_anml)
	
	_s:itm__6_ar(Anml.anml)
end

function p.Zu_anml.whel_i_nd__(_s, whel_idx, itm_idx)

	local nd_ar = _s:whel_i_nd_ar(whel_idx)
	local name  = _s:itm_i(itm_idx)
	local val   = Ply_data.zu._zu.anml[name]

	nd.txt__(nd_ar[_s:lb("txt")], int.pad(itm_idx))
	local icn = nd_ar[_s:lb("icn")]
	if val then
		nd.txtr__(icn, name  )
		nd.anm__( icn, "walk")
	else
		nd.txtr__(icn, "noimg")
		nd.anm__( icn, "noimg")
	end
end

-- method

function p.Zu_anml.opn(_s, prm)
	
	_s:itm__plt()
	_s:cursor_pos__()
	_s:base_dsp__(_.t)
	_s:focus__(_.t)
end

function p.Zu_anml.decide(_s)
end

