log.scrpt("p.doorwrp.lua")

p.Doorwrp = {}

-- static

function p.Doorwrp.cre(parent_gui)
	local p_Prt = p.Doorwrp
	local gui_prt = p.Prt.cre(p_Prt, parent_gui)
	return gui_prt
end

-- script method

function p.Doorwrp.init(_s, parent_gui)

	_s._lb = "doorwrp"
	_s._itm_pitch   = 100
	_s._dsp_idx_max = #Map.obj["doorwrp"] or 0
	_s._itm_scrl_dir = "h"
	
	extnd.init(_s, p.Prt, parent_gui)
	extnd.init(_s, p.Prt_itm_lst)
	extnd.init(_s, p.Prt_cursor)
	extnd._(   _s, p.Doorwrp)

	-- _s:whel__init()

	_s:itm__6_ar(Map.obj["doorwrp"])
	_s._itm_txt = Map.obj["doorwrp"] -- {}
end

function p.Doorwrp.whel_i_nd__(_s, whel_idx, itm_idx)

	local nd_ar = _s:whel_i_nd_ar(whel_idx)

	nd.txt__(nd_ar[_s:lb("txt")], "doorwrp"..int.pad(itm_idx))
end

-- method

function p.Doorwrp.opn(_s)
	
	_s:itm__plt()
	_s:cursor_pos__()
	_s:base_dsp__(_.t)
	_s:focus__(_.t)
	Se.pst_ply("forward")

	-- _s:slfobj__()
end

function p.Doorwrp.decide(_s)

	local doorwrp_id = _s:cursor_itm()
	-- log._("p.Doorwrp.decide", doorwrp_id)

	if u.eq(doorwrp_id, _s._parent_gui._slfobj_id) then
		_s:cursor_itm_iyaiya()
		return
	end

	pst._("#script", "to_doorwrp", {doorwrp_id = doorwrp_id})
	-- _s._parent_gui._slfobj_id = doorwrp_id

	_s:clz()
end

function p.Doorwrp.slfobj__(_s)

	local itm_idx = ar.srch_idx(_s._itm, _s._parent_gui._slfobj_id)

	log._("p.Doorwrp.slfobj__", _s._cursor_dsp_idx, _s._lb)

	_s:cursor__itm_idx(itm_idx)
end

